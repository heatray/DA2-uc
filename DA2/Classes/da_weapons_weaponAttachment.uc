class da_weapons_weaponAttachment extends xWeaponAttachment;

//Muzzle Flash Effects
var class<actor>     mMuzFlashClass;
var actor            mMuzFlash3rd;

//Shell Spewer Effects
var class<xEmitter>     mShellCaseEmitterClass;
var xEmitter            mShellCaseEmitter;
var() vector            mShellEmitterOffset;

//Tracer Effects
var class<Emitter>      mTracerClass;
var() editinline Emitter mTracer;
var() float				mTracerPullback;
var() float				mTracerMinDistance;
var() float				mTracerSpeed;
var   vector        	mOldHitLocation;
var   bool              bUseTraces;

var bool bLoopFire;
var bool bUseSpewer;

var StaticMesh KarmaDrop; //Weapon Static mesh to drop once dead

//3rd Person Anims to play
var() name PlayerIdleAnim; //How the player holds the gun
var() name PlayerIdleChatAnim; //When the player sends msgs to other players
var() name PlayerFireAnim; //Fire anim for each weapon
var() name PlayerReloadAnim; //Reload anim for each weapon
var() name PlayerMeleeAnim; //Melee anim for each weapon
//===========================


#exec OBJ LOAD FILE=..\DA2\Animations\DA2_Weapons.ukx

replication
{
 reliable if (ROLE == Role_Authority)
          PlayerIdleAnim, PlayerFireAnim, PlayerReloadAnim, PlayerMeleeAnim;
}

function UpdateHit(Actor HitActor, vector HitLocation, vector HitNormal) {
    mHitLocation = HitLocation;
}

simulated function Destroyed()
{
    if (mTracer != None)
        mTracer.Destroy();

    if (mMuzFlash3rd != None)
        mMuzFlash3rd.Destroy();

    if (mShellCaseEmitter != None)
        mShellCaseEmitter.Destroy();

	Super.Destroyed();
}

simulated function PostNetBeginPlay()
{
    local rotator r;

	super.postNetBeginPlay();

    r.pitch=-16384;
    SetBoneRotation('M_Flash', r, 0, 1.f);
}

simulated event ThirdPersonEffects()
{
   // local rotator r;    Cancel rotation.

   		if ( da_players_ClassPlayer(Instigator) == None )
			return;

    if ( Level.NetMode != NM_DedicatedServer && FlashCount > 0 )
	{
      if (FiringMode == 0)
      {

        //Muzzle Flash
        if (mMuzFlash3rd == None)
        {
                mMuzFlash3rd = Spawn(mMuzFlashClass);
                if (mMuzFlash3rd != none)
                   AttachToBone(mMuzFlash3rd, 'M_Flash');
        }

        if (emitter(mMuzFlash3rd) != none)
              emitter(mMuzFlash3rd).SpawnParticle(1);

        //Shell Case
		if ( Level.DetailMode != DM_Low )
		{
			if ( mShellCaseEmitter == None && bUseSpewer)
			{
				mShellCaseEmitter = Spawn( mShellCaseEmitterClass,,,,Instigator.Rotation );
				if ( mShellCaseEmitter != None )
      				AttachToBone(mShellCaseEmitter, 'Shell_E');
			}
			// Shellcase update
			if ( mShellCaseEmitter != None )
				mShellCaseEmitter.mStartParticles++;
		}

            WeaponLight();
            if(bUseTraces) UpdateTracer();

            if (FlashCount == 0)
            {
                        da_players_ClassPlayer(Instigator).StopFiring();
            }

            if (bLoopFire)
            {
                       da_players_ClassPlayer(Instigator).PlayerFire(true);
            }
            else
            {
                       da_players_ClassPlayer(Instigator).PlayerFire(false);
            }

        }
    }

}

//##LEVI - Tracer Effects
simulated function vector GetTracerStart()
{
    local Pawn p;
    local weapon w;
    local Vector X,Y,Z;


    if(pawn(owner)!=none && pawn(owner).weapon!=none)
    {
        p=pawn(owner);
        w=p.weapon;

        if (Level.TimeSeconds-LastRenderTime>1) {
            w.GetViewAxes(X, Y, Z);
            w.SetLocation(p.Location+p.eyeposition()-6*Z);
            return (p.Location+p.eyeposition()-6*Z);
        }
        else if(p.IsFirstPerson())
             return w.GetBoneCoords('M_Flash').origin;

          // 3rd person
         return GetBoneCoords('M_Flash').origin;
    }
    return location;
}

simulated function UpdateTracer()
{
    local vector SpawnLoc, SpawnDir, SpawnVel;
	local float hitDist;

    if (Level.NetMode == NM_DedicatedServer)
        return;

    if (mTracer == None)
    {
        mTracer = Spawn(mTracerClass);
        AttachToBone(mTracer, 'M_Flash');
    }

    if (mTracer!=None && mHitLocation!=vect(0,0,0))
    {
		SpawnLoc = GetTracerStart();
		mTracer.SetLocation(SpawnLoc);

		hitDist = VSize(mHitLocation - SpawnLoc) - mTracerPullback;

		// If we have a hit but the hit location has not changed
		/*if(mHitLocation == mOldHitLocation)
			SpawnDir = vector( Instigator.GetViewRotation() );
		else*/
			SpawnDir = Normal(mHitLocation - SpawnLoc);

		if(hitDist > mTracerMinDistance)
		{
			SpawnVel = SpawnDir * (mTracerSpeed*0.75+frand()*0.5);

			mTracer.Emitters[0].StartVelocityRange.X.Min = SpawnVel.X;
			mTracer.Emitters[0].StartVelocityRange.X.Max = SpawnVel.X;
			mTracer.Emitters[0].StartVelocityRange.Y.Min = SpawnVel.Y;
			mTracer.Emitters[0].StartVelocityRange.Y.Max = SpawnVel.Y;
			mTracer.Emitters[0].StartVelocityRange.Z.Min = SpawnVel.Z;
			mTracer.Emitters[0].StartVelocityRange.Z.Max = SpawnVel.Z;

			mTracer.Emitters[0].LifetimeRange.Min = hitDist / mTracerSpeed;
			mTracer.Emitters[0].LifetimeRange.Max = mTracer.Emitters[0].LifetimeRange.Min;

			mTracer.SpawnParticle(1);
		}

        //GotoState('TickTracer');
    }

	mOldHitLocation = mHitLocation;
}

simulated function WeaponLight()
{
    if ( (FlashCount > 0) && !Level.bDropDetail && (Instigator != None)
		&& ((Level.TimeSeconds - LastRenderTime < 0.2) || (PlayerController(Instigator.Controller) != None)) )
    {
		if ( Instigator.IsFirstPerson() )
		{
			LitWeapon = Instigator.Weapon;
			LitWeapon.LightBrightness=230+rand(50);
			LitWeapon.LightRadius=8+rand(5);
			LitWeapon.bDynamicLight=true;
		}
		else {
            LightBrightness=230+rand(60);
			LightRadius=8+rand(4);
			bDynamicLight = true;
		}

        SetTimer(0.1, false);
    }
    else
		Timer();
}

defaultproperties
{
     mShellCaseEmitterClass=Class'DA2.da_weapons_ShellSpewer'
     mShellEmitterOffset=(X=28.000000,Y=-40.000000,Z=62.000000)
     mTracerClass=Class'DA2.da_effects_TraceMaker'
     mTracerPullback=25.000000
     mTracerSpeed=7500.000000
     bUseTraces=True
     bUseSpewer=True
     KarmaDrop=StaticMesh'DA2KarmaStatics.mr56'
     PlayerIdleAnim="Idle_Rest"
     PlayerIdleChatAnim="Idle_Chat"
     PlayerFireAnim="Fire_Pistols"
     PlayerReloadAnim="Reload_Pistols"
     PlayerMeleeAnim="Melee_Pistols"
     LightType=LT_Steady
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=160
     LightBrightness=220.000000
     LightRadius=8.000000
     LightPeriod=3
     DrawScale=1.000000
}
