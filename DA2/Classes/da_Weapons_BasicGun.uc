//-----------------------------------------------------------
//Coded by Dante
//Updated by aBsOlUt
//-----------------------------------------------------------
class da_Weapons_BasicGun extends da_weapons_Reloadable;

#EXEC OBJ LOAD FILE=DA2_WeaponSounds.uax
#EXEC OBJ LOAD FILE=DA2Crosshairs.utx

// Melee Variables
const MAXMELEETIMES = 4;
var float MeleeStartTime, MeleeMissTime, MeleeHitTime;
var  float MeleeTime[MAXMELEETIMES];
var int MeleeDamage[MAXMELEETIMES];
var name MeleeAnim;
var float MeleeAnimRate;
var float MeleeRange;
var float allMeleeTime;  // The time, the complete animation takes
var float tmpTime;  // for state internal
var name MeleeHit, MeleeMiss, MeleeStart;
var float aiMeleeRange;
var float aiMeleeRate;

//Crosshair
var Texture DACrosshair;

//References / Other
var Actor mOther;
var da_players_ClassPlayer p;
var Vector mHitLocation, mHitNormal;

//Recoil / Modes
var float LastRecoilTime;
var float Recoil, RecoilFactor;
var float RecoilAddPerSec, RecoilMax;
var float RecoilRegenPerSec, RecoilMoveMalus;

//Noobish math
var int mode;
var int numModes;
var int i;
var bool playAMIsound;

//Sounds
var sound meleeSounds[4];

replication {
    reliable if (ROLE < ROLE_Authority)
        ServerStartMelee;
		
	reliable if(Role == ROLE_Authority)	
		ClientStartMelee;
}

//Unrelated functions
simulated function Rotator AdjustAim(Vector Start, float InAimError)
{
        local rotator Aim, EnemyAim;

        if ( AIController(Instigator.Controller) != None )
        {
                Aim = Instigator.Rotation;
                if ( Instigator.Controller.Enemy != None )
                {
                        EnemyAim = rotator(Instigator.Controller.Enemy.Location - Start);
                        Aim.Pitch = EnemyAim.Pitch;
                }
                return Aim;
        }
        else
                return Instigator.Controller.Rotation;
}
//End unrelated

//Execs
simulated event MeleeAttack() 
{
        ServerStartMelee();
        ClientStartMelee();
}
//End Execs

//Modes and Recoil
simulated function ToggleMode() {
    setMode((mode + 1) % numModes);
}

function bool BotFire(bool bFinished, optional name FiringMode) {
    local Controller c;
    c = instigator.controller;

    if (c != none && c.target != none &&
        vsize(c.target.location - instigator.location) < aiMeleeRange &&
        frand() < aiMeleeRate && da_players_ClassPlayer(c.target) != none) {
        if (firemode[botmode].isFiring())
            stopFire(botMode);
        if (c.actorReachable(c.target)) {
            c.moveTarget = c.target;
            serverStartMelee();
            return true;
        }
    }
  return super.botFire(bFinished, firingMode);
}

simulated function modeUpdated() {
}

simulated function bool canSwitchMode(int toMode) {
  return true;
}

simulated function setMode(int newMode) {
        if (mode == newMode || !canSwitchMode(newMode))
                return;
        mode = newMode;
        modeUpdated();
}

simulated function firedShot() {
    local rotator rot;
    local vector ShakeMag;
    local da_players_playercontroller PC;

    if(instigator.Controller.IsA('da_players_PlayerController'))
        PC=da_players_PlayerController(Instigator.Controller);
    else return;

    instigator=pc.Pawn;

  if(instigator==none || PC!=level.getLocalPlayerController())
    return;

    UpdateRecoil(true);
    ShakeMag=FireMode[0].ShakeOffsetMag;
    shakemag=FireMode[0].default.ShakeOffsetMag*RecoilFactor;

    rot=pc.rotation;
    if(rot.pitch>0 && rot.pitch<16380) rot.pitch=fmin(16380,rot.pitch-(shakemag.x*frand()*15)+shakemag.x*3);
    else if(rot.pitch>49160 && rot.pitch<65536) rot.pitch=fmax(49160,rot.pitch-(shakemag.x*frand()*15)+shakemag.x*3);
    rot.yaw+=(shakemag.y*frand()*12)-shakemag.y*4;

    pc.setrotation(rot);
	
	if(!hasAmmo()) da_players_PlayerController(Instigator.Owner).AMIAnnouncement(Sound'AMISounds.player.AmmoDepleted'); 

	if (hasLowAmmo() && playAMIsound) { da_players_PlayerController(Instigator.Owner).AMIAnnouncement(Sound'AMISounds.player.AmmoLow'); playAMIsound = false; }
	else if (!hasLowAmmo()  && !playAMIsound) playAMIsound = true;

    //USE for DEBUG
  //instigator.ClientMessage(recoil);
}

/*simulated event WeaponTick(float dt) {
    UpdateRecoil();
}*/

simulated function float UpdateRecoil(optional bool firedShot) {
    local float MoveMalus, MoveFactor;
    local vector dummy;
    local playercontroller PC;

    //Recoil=FMax(1, recoil-RecoilRegenPerSec*(Level.TimeSeconds-(LastRecoilTime+FireMode[0].FireRate)));
    //if(firemode[0].isFiring()) Recoil=FMin(recoilmax, recoil+RecoilAddPerSec*FireMode[0].FireRate);

    if(firedshot)
        Recoil=FMin(recoilmax, recoil+RecoilAddPerSec*FireMode[0].FireRate);
    Recoil=FMax(1, recoil-RecoilRegenPerSec*(level.timeseconds-LastRecoilTime));

    RecoilFactor=Recoil;

    //Zooming/Ironsights
    PC=level.getLocalPlayerController();
    if(PC.DesiredFOV!=PC.DefaultFOV) {
        RecoilFactor/=1.3;
        MoveMalus=RecoilMoveMalus*7;
    }
    else MoveMalus=RecoilMoveMalus;

    //Speed
    MoveFactor=1+MoveMalus*fmin(2,vsize(instigator.velocity)/instigator.GroundSpeed);

    //Crouching/Jumping/Falling
    if(instigator.bIsCrouched) MoveFactor/=2;
    else if(instigator.Physics==PHYS_Falling) MoveFactor*=2;

    RecoilFactor*=0.5+0.5*MoveFactor;

    //Supported position
    if(vsize(instigator.Velocity)<80 &&
        Trace(
        dummy, dummy,
        Instigator.Location+vector(instigator.GetViewRotation())*(instigator.CollisionRadius+30),
        Instigator.Location,
        true
    )!=none) RecoilFactor/=2.5;

    LastRecoilTime=Level.TimeSeconds;

    return RecoilFactor;
}

simulated function bool drawCrosshair() {
    return true;
}

//End Modes/Recoil


//MELEE
function ServerStartMelee() {
        gotoState('Melee', 'Begin');
}

simulated function ClientStartMelee() {
// Don't play Meleeing twice or make similar bad things
    if (ROLE < ROLE_Authority)
        gotoState('Melee', 'Begin');
}

function StopMelee() {
}


//Melee State
simulated state Melee extends BusyState  {
  simulated function Actor checkHit() {

    local Rotator Aim;
    local Vector StartTrace, EndTrace;
    local Actor other;

              //Inits
                StartTrace = Instigator.Location;
                Aim = AdjustAim(StartTrace, 0);
                EndTrace = StartTrace + MeleeRange * Vector(Aim);
                Other = Trace(mHitLocation, mHitNormal, EndTrace, StartTrace, true);

        if (Other != none && Other != Instigator)
      return Other;
    return None;
	
    }

Begin:
	bMeleeHack = true;
	
    p = da_players_classPlayer(Owner);
  tmpTime = 0;

  playAnim(MeleeAnim, MeleeAniMRate, tweenTime);
    p.PlayerMelee();
   mOther = checkHit();

    playOwnedSound(sound'DA2_WeaponSounds.Melee_Air', SLOT_Interact, 3.0);

  for (i = 0; i < MAXMELEETIMES; i++) {
    if (MeleeTime[i] <= tmpTime)
      break;
    sleep(MeleeTime[i] - tmpTime);
    tmpTime = MeleeTime[i];
    if (meleeDamage[i] > 0 && mOther != None) {
      if (ROLE == ROLE_Authority)
        mOther.TakeDamage(MeleeDamage[i], Instigator, mHitlocation, vect(0,0,0), class'da2.da_damtypes_Melee');
      if(!mOther.isa('pawn') && ThirdPersonActor != none)
                spawn(class'HitEffect'.static.GetHitEffect(mOther, mhitLocation, mhitNormal),,,mhitLocation, rotator(mhitNormal));
            //playSound(sound'DA2_WeaponSounds.Melee_HitObject', SLOT_Interact, 3.0);
            playSound(meleeSounds[rand(4)], SLOT_Interact, 3.0);
        }
  }

  //if (Level.NetMode == NM_DedicatedServer) {
  //  if (tmpTime < allMeleeTime)
 //     sleep(allMeleeTime - tmpTime);
  //} else
    finishAnim();
    StopMelee();
    global.AnimEnd(0);
    gotoState('doneMeleeing');	
}

simulated state doneMeleeing{

Begin:
	sleep(0.1);
	bMeleeHack = false;
	gotoState('');
}

defaultproperties
{
     MeleeTime(0)=0.010000
     MeleeDamage(0)=60
     MeleeAnim="melee"
     MeleeAnimRate=1.000000
     MeleeRange=90.000000
     allMeleeTime=2.000000
     aiMeleeRange=200.000000
     aiMeleeRate=0.300000
     DACrosshair=Texture'DA2Crosshairs.Weapon.assaultcross'
     RecoilAddPerSec=4.000000
     RecoilMax=6.000000
     RecoilRegenPerSec=4.000000
     RecoilMoveMalus=2.000000
     numModes=2
     meleeSounds(0)=Sound'DA2_WeaponSounds.Melee_Hit2'
     meleeSounds(1)=Sound'DA2_WeaponSounds.Melee_Hit3'
     meleeSounds(2)=Sound'DA2_WeaponSounds.Melee_Hit4'
     meleeSounds(3)=Sound'DA2_WeaponSounds.Melee_Hit5'
     SelectAnim="Raise"
     PutDownAnim="Lower"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=160
     LightBrightness=230.000000
     LightRadius=8.000000
     LightPeriod=3
}
