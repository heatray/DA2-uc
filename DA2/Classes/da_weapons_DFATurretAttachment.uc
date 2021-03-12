class da_weapons_DFATurretAttachment extends WA_Turret_Minigun;

var class<Emitter> daMuzFlashClass;
var Emitter daMuzFlash;

var sound StartSound;

simulated function Destroyed()
{
    if (daMuzFlash != None)
        daMuzFlash.Destroy();

	Super.Destroyed();
}

simulated event ThirdPersonEffects()
{
	local rotator	R;

    if ( (Level.NetMode == NM_DedicatedServer) || (Instigator == None) )
        return;

    if ( FlashCount > 0 )
	{
		LastFireTime = Level.TimeSeconds;

		if ( !bFiring || (GetStateName() != 'Firing') )
			StartFiring();

        // Muzzle Flash spawning
        if ( daMuzFlash == None )
        {
            daMuzFlash = Spawn( daMuzFlashClass,,, Instigator.GetBoneCoords('Muzzle').Origin, Instigator.Rotation );
            if ( daMuzFlash != None )
                daMuzFlash.SetBase( Instigator );
        }
        else
        {   // Update location/rotation
            daMuzFlash.SetBase( none );
            daMuzFlash.SetLocation( Instigator.GetBoneCoords('Muzzle').Origin );
            daMuzFlash.SetRotation( Instigator.Rotation );
            daMuzFlash.SetBase( Instigator );
        }

        // Muzzle flash update
        if ( daMuzFlash != None )
        {
            daMuzFlash.SpawnParticle(1);
            R.roll = Rand(65536);
            daMuzFlash.SetRelativeRotation( R );

            // Dynamic Light
            //mMuzFlash3rd.bDynamicLight = true;
            SetTimer(0.14, false);
        }

		// Shell case spawning
		if ( Level.DetailMode != DM_Low )
		{
			if ( mShellCaseEmitter == None )
			{
				mShellCaseEmitter = Spawn( mShellCaseEmitterClass,,, GetFireStart( mShellEmitterOffset ), Instigator.Rotation );
				if ( mShellCaseEmitter != None )
				{
					mShellCaseEmitter.bHardAttach	= true;
					mShellCaseEmitter.SetBase( Instigator );
					mShellCaseEmitter.SetRelativeRotation( Rot(0,-16384,0) );
				}
			}
			else
			{	// Update location/rotation
				mShellCaseEmitter.SetBase( None );
				mShellCaseEmitter.SetLocation( GetFireStart( mShellEmitterOffset ) );
				mShellCaseEmitter.SetRotation( Instigator.Rotation );
				mShellCaseEmitter.SetBase( Instigator );
				mShellCaseEmitter.SetRelativeRotation( Rot(0,-16384,0) );
			}

			// Shellcase update
			if ( mShellCaseEmitter != None )
				mShellCaseEmitter.mStartParticles++;
		}

		// Tracer FX
		UpdateTracer();
	}
	else
		StopFiring();

	super(xWeaponAttachment).ThirdPersonEffects();
}

simulated function UpdateTracer()
{
    local float		hitDist;
	//local rotator	RelRot;
	local vector	SpawnLoc, SpawnDir, SpawnVel;

    if ( Level.NetMode == NM_DedicatedServer )
        return;

	// Spawn Tracer effect
    if ( mTracer == None )
    {
        mTracer = Spawn( mTracerClass,,, Instigator.GetBoneCoords('Muzzle').Origin, Instigator.Rotation );
    }

	if ( Level.bDropDetail || Level.DetailMode == DM_Low )
		mTracerInterval = 2 * default.mTracerInterval;
	else
		mTracerInterval = default.mTracerInterval;

    if ( mTracer != None && Level.TimeSeconds >= mLastTracerTime + mTracerInterval)
    {
		SpawnLoc = ASVehicle(Instigator).GetFireStart();
		mTracer.SetLocation( SpawnLoc );

		hitDist = VSize( mHitLocation - SpawnLoc ) - mTracerPullback;

		// If the hit location is exactly the same as last time, we assume it isn't correct so we just use the gun rotation instead.
		if ( mHitLocation == mOldHitLocation )
			SpawnDir = vector( Instigator.Rotation ) + VRand()*FRand()*0.015;//0.015 = old class'FM_Turret_Minigun_Fire'.default.Spread ;
		else
			SpawnDir = Normal( mHitLocation - SpawnLoc );

		mOldHitLocation = mHitLocation;

		if(hitDist > mTracerMinDistance)
		{
			SpawnVel = SpawnDir * mTracerSpeed;

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

		mLastTracerTime = Level.TimeSeconds;
    }
}

simulated event StartFiring()
{
	bFiring	= true;
	if ( Instigator != None )
	    Instigator.PlaySound( StartSound,SLOT_None, 2,, 200);

	GotoState('Firing');
}

simulated event StopFiring()
{
	if ( !bFiring )
		return;

	bFiring	= false;
	if ( Instigator != None )
		Instigator.PlaySound( WindingSound,SLOT_None, 2,, 200);
}

defaultproperties
{
     daMuzFlashClass=Class'DA2.da_effects_DFAmuzzle'
     StartSound=Sound'DA2_WeaponSounds.Misc.TurretFireStart'
     RollSpeedAcc=60000
     mShellEmitterOffset=(X=10.000000,Y=-5.000000,Z=10.000000)
     mTracerClass=Class'DA2.da_effects_TraceMakerB'
     mTracerInterval=0.000000
     mTracerPullback=0.000000
     mTracerSpeed=9000.000000
     Spread=0.000000
     FiringSound=Sound'DA2_WeaponSounds.Gunshots.TurretFire'
     WindingSound=Sound'DA2_WeaponSounds.Misc.TurretFireEnd'
     DrawScale=0.800000
}
