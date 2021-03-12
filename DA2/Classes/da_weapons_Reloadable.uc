//-----------------------------------------------------------
// Basic DA2 Weapon that can be reloaded.
// Coded by Dante
// Edited/Updated by aBsOlUt.
//-----------------------------------------------------------
class da_weapons_Reloadable extends Weapon;

var() xEmitter          ShellCaseEmitter; //To spawn shells after you shoot

//Animations
var() name preReloadAnim;  //The animation before actual reload starts.
var() name postReloadAnim; // The animation after reload is complete.
var() name reloadAnim; // The actual reload animation to play.
var() name reloadEmptyAnim; //The actual reload_EMPTY animation to play (Ammo==0)
var() name reloadStartAnim; // For shotgun and other related weapons reloading.
var() name Idle1; //Idle animation 1 (Fidgit1)
var() name Idle2; //Idle animation 2 (Fidgit2)
var() name ThrowAnimGrenade; //Let them rain...

//Sounds
var() sound preReloadSound; // Sound before actual reload starts.
var() sound postReloadSound; // Sound after reload is complete.
var() sound reloadSound; //Actual reload sound to play.
var() sound reloadEmptySound; // Actual reload_EMPTY sound to play (Ammo==0)

//Time
var() float tweenTime;
var float   minIdleTime, minIdleWait; // For Idle anims

//Animation Rates
var() float reloadAnimRate, reloadEmptyAnimRate, preReloadAnimRate, postReloadAnimRate;
var() float  reloadTime;  //Total Reload Time
var() float  reloadEmptyTime; //Total Reload_EMPTY Time

// Checks / Bools
var bool    bAutoReload; //Start reload when gun is empty and player tries to fire.
//var bool  bWeaponReady;  // Ready to fire/reload/... doesn't take firemodes into account (use isWeaponReady() for that)
var bool    bWeaponReadyWhileReloading; //False when reload begins.
var bool    bGrenadeHack;
var bool 	bIsReloading;
var bool 	bRequestInteruption;
var bool	bMeleeHack;

var      bool        bInitializedScope;    // Set to true when the scope has been initialized

replication
{
    reliable if (ROLE < ROLE_Authority)
    ServerStartReload, ServerEndingReload;
	
	reliable if(Role == ROLE_Authority)
	ClientStartReload;
}

// Implemented in subclasses
simulated function PreTravelCleanUp(){}

function karmathrowWeapon() {
    local actor weaponKarma;
    local KarmaParams wkparams;
    local da_weapons_WeaponAttachment dww;
    local rotator adjust;

  dww=da_weapons_weaponAttachment(ThirdPersonActor);

  if (dww == none) {
    warn(ThirdPersonActor@"is not da da_weapons_weaponAttachment");
    return;
  }

    adjust.Yaw=16384;
    weaponKarma=Spawn(class'da_Weapons_Karma', self,,, instigator.rotation+adjust);

// Because of nice UT code doing weird and I mean WEIRD things I now replicate this
//   weaponKarma.remoteRole = ROLE_None;
     if (weaponKarma != none)
     {
        weaponKarma.SetStaticMesh(dww.KarmaDrop);
        wkparams=KarmaParams(weaponKarma.KParams);
        wkparams.KStartLinVel = Instigator.velocity + VRand()*75 + vect(0,0,1)*150;
        wkparams.KStartAngVel = vrand()*(vsize(instigator.velocity)+10);

        weaponKarma.SetPhysics(PHYS_Karma);
        weaponKarma.KSetBlockKarma(true);
        weaponKarma.KWake();
     }
}

simulated event RenderOverlays(Canvas Canvas)
{
  local PlayerController PC;

    if( !bInitializedScope )
    {
        if (Instigator == None)
            return;

        // Lets avoid having to do multiple casts every tick - Ramm
      PC = PlayerController(Instigator.Controller);

      if(PC == None)
        return;

        if(!bInitializedScope && PC != none )
      {
            attachScreens();
        }
    }

    super.RenderOverlays(Canvas);
}


// COPIED FROM UT CODE TO REMOVE NO AMMO CHECK

simulated function Weapon WeaponChange( byte F, bool bSilent )
{
    if ( InventoryGroup == F )
    {
    return self;
    }
    else if ( Inventory == None )
        return None;
    else
        return Inventory.WeaponChange(F,bSilent);
}

simulated function Weapon PrevWeapon(Weapon CurrentChoice, Weapon CurrentWeapon)
{
  if ( (CurrentChoice == None) )
  {
    if ( CurrentWeapon != self )
      CurrentChoice = self;
  }
  else if ( InventoryGroup == CurrentWeapon.InventoryGroup )
  {
    if ( (GroupOffset < CurrentWeapon.GroupOffset)
      && ((CurrentChoice.InventoryGroup != InventoryGroup) || (GroupOffset > CurrentChoice.GroupOffset)) )
      CurrentChoice = self;
  }
  else if ( InventoryGroup == CurrentChoice.InventoryGroup )
  {
    if ( GroupOffset > CurrentChoice.GroupOffset )
      CurrentChoice = self;
  }
  else if ( InventoryGroup > CurrentChoice.InventoryGroup )
  {
    if ( (InventoryGroup < CurrentWeapon.InventoryGroup)
      || (CurrentChoice.InventoryGroup > CurrentWeapon.InventoryGroup) )
      CurrentChoice = self;
  }
  else if ( (CurrentChoice.InventoryGroup > CurrentWeapon.InventoryGroup)
      && (InventoryGroup < CurrentWeapon.InventoryGroup) )
    CurrentChoice = self;
    if ( Inventory == None )
        return CurrentChoice;
    else
        return Inventory.PrevWeapon(CurrentChoice,CurrentWeapon);
}

simulated function Weapon NextWeapon(Weapon CurrentChoice, Weapon CurrentWeapon)
{
  if ( (CurrentChoice == None) )
  {
    if ( CurrentWeapon != self )
      CurrentChoice = self;
  }
  else if ( InventoryGroup == CurrentWeapon.InventoryGroup )
  {
    if ( (GroupOffset > CurrentWeapon.GroupOffset)
      && ((CurrentChoice.InventoryGroup != InventoryGroup) || (GroupOffset < CurrentChoice.GroupOffset)) )
      CurrentChoice = self;
  }
  else if ( InventoryGroup == CurrentChoice.InventoryGroup )
  {
    if ( GroupOffset < CurrentChoice.GroupOffset )
      CurrentChoice = self;
  }

  else if ( InventoryGroup < CurrentChoice.InventoryGroup )
  {
    if ( (InventoryGroup > CurrentWeapon.InventoryGroup)
      || (CurrentChoice.InventoryGroup < CurrentWeapon.InventoryGroup) )
      CurrentChoice = self;
  }
  else if ( (CurrentChoice.InventoryGroup < CurrentWeapon.InventoryGroup)
      && (InventoryGroup > CurrentWeapon.InventoryGroup) )
    CurrentChoice = self;

  if ( Inventory == None )
        return CurrentChoice;
    else
        return Inventory.NextWeapon(CurrentChoice,CurrentWeapon);
}
// END COPY

// Most DA weapons are useful for bots with primary fire only
function byte BestMode() {
    return 0;
}

simulated function vector GetEffectStart()
{
    if (Instigator.IsFirstPerson())
    {
         return GetBoneCoords('Muzzle').Origin;
    }
    else
    {
        super.GetEffectStart();
    }
}


simulated function PostBeginPlay()
{
    local da_players_PRI DAPRI;
    Super.PostBeginPlay();

    attachScreens();

    if ( Level.NetMode == NM_DedicatedServer ||
        Level.GetLocalPlayerController() == none ||
        Level.GetLocalPlayerController().GameReplicationInfo == none ||
        Level.GetLocalPlayerController().PlayerReplicationInfo == none)
    {
        return;
    }

    DAPRI=da_players_PRI( Level.GetLocalPlayerController().PlayerReplicationInfo );


    //Dedicated servers NEED NOT to load skins.

     if (DAPRI.Team != none) //Spectator AN fix.
     {
        switch (DAPRI.Team.TeamIndex)
        {
           case 0:
                self.Skins[1] = material'Bracer_Jungle_Final';
                self.Skins[2] = material'Clothing_Jungle';
                break;
           case 1:
                self.Skins[1] = material'Bracer_Urban_Final';
                self.Skins[2] = material'Clothing_Urban';
                break;
       }
     }
   self.Skins[0] = material'hand';   // Default
}

simulated function ClientForceAmmoUpdate(int Mode, int NewAmount);

simulated function attachScreens(){}

// Thank you Mr. UT developer guy to place a "no timer running with clientstate"
// in NATIVE code for weapons to distract us mod authors...
simulated function Timer() {

//If he is not moving or doing anything weapon related play idle anims
    if (ClientState == WS_ReadyToFire && isWeaponReady() && VSize(Instigator.Velocity) == 0) {
        if (frand() < 0.5 && hasAnim(Idle1))
            playAnim(Idle1, reloadAnimRate, tweenTime);
        else if (hasAnim(Idle2))
            playAnim(Idle2, reloadAnimRate, tweenTime);
        setTimer(25 + frand() * 5, false);
    } else if (ClientState == WS_PutDown)
        setTimer(0.2, false);
    else
        setTimer(0, false);

    if (allowDirectPutDown()) {
        super.Timer();
    }
}

simulated function bool allowDirectPutDown()
{
    return !( (FireMode[0].bIsFiring) || (FireMode[1].bIsFiring) ||
        (!IsInState(name) && !isInState('Hidden'))) || ClientState == WS_BringUp;
}

//Checks
simulated function bool isWeaponReady()
{
  return !(!allowDirectPutDown() || bGrenadeHack || bIsReloading || bMeleeHack ||
			ClientState != WS_ReadyToFire && Level.netMode == NM_Client);
}

simulated function bool readyToReload()
{
    return isWeaponReady() && !bisReloading && 
	( (getAmmoObject(0) != none && getAmmoObject(0).canReload()) ||
      (getAmmoObject(1) != none && getAmmoObject(1).canReload()) );
}

simulated function bool ReadyToFire(int mode)
{
    return super.ReadyToFire(mode) && isWeaponReady();
}

simulated function da_weapons_Ammo getAmmoObject(int num)
{
  if(num >= 0 && num < NUM_FIRE_MODES)
  {
    return da_weapons_Ammo(Ammo[num]);
  }
  log("getAmmoObject: index wrong:"@num@"length is"@NUM_FIRE_MODES);
  return none;
}

simulated function bool HasAmmo() {
  local da_weapons_ammo daammo;
  
	daammo = da_weapons_Ammo(Ammo[0]);
	if ( (daAmmo!= None && FireMode[0] != None && daAmmo.allAmmo() >= FireMode[0].AmmoPerFire) )
		return true;

	daammo = da_weapons_Ammo(Ammo[1]);
	if ( (daAmmo!= None && FireMode[1] != None && daAmmo.allAmmo() >= FireMode[1].AmmoPerFire) )
	return true;
	  return false;
}

simulated function bool HasLowAmmo() {
  local da_weapons_ammo daammo;
	
	daammo = da_weapons_Ammo(Ammo[0]);  
	if ( daAmmo!= None && FireMode[0] != None && daammo.allammo() < daAmmo.maxammo * 2 && !daammo.IsA('da_weapons_MS25Ammo') && !daammo.IsA('da_weapons_MR40Ammo'))
		return true;
	else if ( daAmmo!= None && FireMode[0] != None && daammo.allammo() < 3 && daammo.IsA('da_weapons_MS25Ammo'))
		return true;
	else if ( daAmmo!= None && FireMode[0] != None && daammo.allammo() < 75 && daammo.IsA('da_weapons_MR40Ammo'))
		return true;

	daammo = da_weapons_Ammo(Ammo[1]);
	if ( daAmmo!= None && FireMode[1] != None && daammo.allammo() < daAmmo.maxammo * 2 && !daammo.IsA('da_weapons_MS25Ammo') && !daammo.IsA('da_weapons_MR40Ammo'))
		return true;
	else if ( daAmmo!= None && FireMode[1] != None && daammo.allammo() < 3 && daammo.IsA('da_weapons_MS25Ammo'))
		return true;
	else if ( daAmmo!= None && FireMode[1] != None && daammo.allammo() < 75 && daammo.IsA('da_weapons_MR40Ammo'))
		return true;
		
	return false;
}

simulated function bool isGunEmpty() {
  return (Ammo[0] == None || Ammo[0].ammoAmount == 0) &&
    (Ammo[1] == none || Ammo[1].ammoAmount == 0);
}

simulated function checkReload() {
//    log("CheckReload"@bAutoReload@readyToReload());
    if (isGunEmpty() && bAutoReload && HasAmmo() && readyToReload()) {
      ServerStartReload();
      ClientStartReload();
  }
}
//END Checks


simulated function reloadingFinished();


simulated function bool PutDown() {
    if (allowDirectPutDown())
        return super.putDown();
    else if (ClientState == WS_BringUp || ClientState == WS_ReadyToFire) {
        clientState = WS_PutDown;
        setTimer(0.1, true);
    }

    return true;
}

simulated function BringUp(optional Weapon PrevWeapon) {

	local da_weapons_ammo daammo;
	local da_players_PlayerController Player;
	local int Mode;

    if ( ClientState == WS_Hidden )
    {
		PlayOwnedSound(SelectSound,SLOT_Interact, 1.25);
        //PlayOwnedSound(SelectSound, SLOT_Interact,,,,, false);
		ClientPlayForceFeedback(SelectForce);  // jdf

        if ( Instigator.IsLocallyControlled() )
        {
            if ( (Mesh!=None) && HasAnim(SelectAnim) )
                PlayAnim(SelectAnim, SelectAnimRate, 0.0);
        }

        ClientState = WS_BringUp;
        SetTimer(BringUpTime, false);
    }
    for (Mode = 0; Mode < NUM_FIRE_MODES; Mode++)
	{
		FireMode[Mode].bIsFiring = false;
		FireMode[Mode].HoldTime = 0.0;
		FireMode[Mode].bServerDelayStartFire = false;
		FireMode[Mode].bServerDelayStopFire = false;
		FireMode[Mode].bInstantStop = false;
	}
	
	if ( (PrevWeapon != None) && PrevWeapon.HasAmmo() && !PrevWeapon.bNoVoluntarySwitch )
		OldWeapon = PrevWeapon;
	else
		OldWeapon = None;

	daammo = da_weapons_Ammo(Ammo[0]);
	
	if ( da_players_PRI(instigator.PlayerReplicationInfo) != none )
	{
        da_players_PRI(instigator.PlayerReplicationInfo).weaponInfo.ammo = daAmmo.allAmmo();
        da_players_PRI(instigator.PlayerReplicationInfo).weaponInfo.maxAmmo = daAmmo.AmmoAmount + daAmmo.default.ammoLeft;
		
		ReloadAnimRate = (da_players_PRI(instigator.PlayerReplicationInfo).ReloadSpeed/100); 
		reloadEmptyAnimRate = (da_players_PRI(instigator.PlayerReplicationInfo).ReloadSpeed/100); 
		preReloadAnimRate = (da_players_PRI(instigator.PlayerReplicationInfo).ReloadSpeed/100); 
		postReloadAnimRate = (da_players_PRI(instigator.PlayerReplicationInfo).ReloadSpeed/100); 
    }

    // Hint check
	Player = da_players_PlayerController(Instigator.Controller);

	if ( Player != none )
	{
		if ( class == class'da_weapons_MS25RocketLauncher' )
		{
			Player.CheckForHint(17);
		}
		else if ( class == class'da_weapons_rifles_SniperRifle' )
		{
			Player.CheckForHint(16);
		}
	}
}



simulated function OutOfAmmo()
{
    if ( Instigator == None || !Instigator.IsLocallyControlled() || !isGunEmpty() )
        return;

    FireMode[0].bIsFiring = false;
    FireMode[0].bInstantStop = true;
    ServerStartReload();
    ClientStartReload();
}



simulated exec event reload() {
  if (readyToReload()) {
    ServerStartReload();
    ClientStartReload();
  }
}
//End Reloading

simulated function bool StartFire(int Mode)
{
  if (!readyToFire(mode))
  {
    if (readyToReload())
      checkReload();
    return false;
  }
	return super.startFire(mode);
}

//Execs
simulated event MeleeAttack() 
{
	if (isWeaponReady()) {
		super(da_Weapons_BasicGun).MeleeAttack();
	}
}
//End Execs

//Our own state.
simulated state BusyState {
// This will prevent some strange UT2004 weapon code to play idle stuff and kill
// finishAnim. (Dante wrote this)
    simulated function AnimEnd(int channel) {
    }
}

//Reloading - Client/Server
function ServerStartReload() {

    if (readyToReload())
        StartReload();

}

simulated function ClientStartReload() {
  if (ROLE < ROLE_Authority)
        StartReload();
}

simulated function StartReload()
{
  gotoState('preReloading', 'Begin');
}

// For things to be done before the actual reloading begins
simulated state preReloading extends BusyState {
  simulated function bool isWeaponReady() {
    return false;
  }

Begin:
	bIsReloading = true;

    if (preReloadSound != none)
        playOwnedSound(preReloadSound);

    if (hasAnim(preReloadAnim))
    {
        playAnim(preReloadAnim, preReloadAnimRate, tweenTime);
        finishAnim();
    }

    gotoState('Reloading');
}

// Well maybe at last simulated states aren't that bad ;) (Dante)
simulated state Reloading extends BusyState {

    simulated function reloadStep() {
        if (ammo[0] != none)
            da_weapons_ammo(Ammo[0]).reload();

        if (ammo[1] != none)
            da_weapons_ammo(Ammo[1]).reload();
    }

    simulated function doReloading()
    {
        local float AnimTimer;

        local da_players_ClassPlayer p;
		
        p = da_players_classPlayer(Owner);
        if ((ammo[0] != none && da_weapons_Ammo(Ammo[0]).canReload()) ||
            (ammo[1] != none && da_weapons_Ammo(Ammo[1]).canReload()))
        {
            if (isGunEmpty() && hasAnim(reloadEmptyAnim))
            {
                // playOwnedSound(reloadSound,SLOT_None, 1.5); //USE NOTIFIES

                // Set a timer, just in case the anim notify never happens or gets interrupted
                playAnim(reloadEmptyAnim, reloadEmptyAnimRate, tweenTime);
                AnimTimer = GetAnimDuration(reloadEmptyAnim, reloadEmptyAnimRate) + tweenTime;
            	if( Level.NetMode == NM_DedicatedServer || (Level.NetMode == NM_ListenServer && !Instigator.IsLocallyControlled()))
            		SetTimer(AnimTimer - (AnimTimer * 0.1),false);
            	else
            		SetTimer(AnimTimer,false);

                p.PlayerReload();
            }
            else if (hasAnim(reloadAnim))
            {
                // playOwnedSound(reloadEmptySound,SLOT_None, 1.5);
                playAnim(reloadAnim, reloadAnimRate, tweenTime);

                // Set a timer, just in case the anim notify never happens or gets interrupted
                AnimTimer = GetAnimDuration(reloadAnim, reloadAnimRate) + tweenTime;
            	if( Level.NetMode == NM_DedicatedServer || (Level.NetMode == NM_ListenServer && !Instigator.IsLocallyControlled()))
            		SetTimer(AnimTimer - (AnimTimer * 0.1),false);
            	else
            		SetTimer(AnimTimer,false);
                p.PlayerReload();
            }
            else
            {
                warn("NO RELOADING ANIMATION FOUND!");
                ServerEndingReload();
				ClientEndingReload();
            }
        }
        else
        {
            ServerEndingReload();
			ClientEndingReload();
        }
    }

    // Force the reload to end!!!
    simulated function Timer()
    {
        AnimEnd(0);
    }

    simulated function AnimEnd(int channel)
    {
        reloadStep();
        doReloading();
		
		if (bRequestInteruption) DisturbReloading();
    }

	simulated function bool StartFire(int Mode) {
		if (bWeaponReadyWhileReloading && !isGunEmpty() && bIsReloading)
			bRequestInteruption = true;
			return false; 
	}

Begin:
    doReloading();
}

simulated function DisturbReloading() {
    ServerEndingReload();
	ClientEndingReload();
	bRequestInteruption = false;
}

simulated function ClientEndingReload(){
gotoState('postReloading');
}

function ServerEndingReload(){
gotoState('postReloading');
bIsReloading = false;
}

simulated state postReloading extends BusyState {

  simulated function EndState() {
        reloadingFinished();
        super.endState();
    }

Begin:
    if (postReloadSound != none)
        playOwnedSound(postReloadSound);

    if (hasAnim(postReloadAnim)) {
        playAnim(postReloadAnim, postReloadAnimRate, tweenTime);
        finishAnim();
    }
	bIsReloading = false;
    gotoState('Hidden');	
}

defaultproperties
{
     preReloadAnim="Reload_Start"
     postReloadAnim="Reload_End"
     ReloadAnim="Reload"
     reloadEmptyAnim="reload_empty"
     Idle1="Fidgit1"
     Idle2="Fidgit2"
     ThrowAnimGrenade="Grenade"
     TweenTime=0.150000
     minIdleWait=15.000000
     ReloadAnimRate=1.000000
     reloadEmptyAnimRate=1.000000
     preReloadAnimRate=1.000000
     postReloadAnimRate=1.000000
     reloadTime=1.000000
     reloadEmptyTime=1.000000
     bAutoReload=True
     PutDownAnim="PutDown"
     PutDownTime=0.800000
     BringUpTime=0.800000
     bCanThrow=False
     bNoAmmoInstances=False
     Priority=10
}
