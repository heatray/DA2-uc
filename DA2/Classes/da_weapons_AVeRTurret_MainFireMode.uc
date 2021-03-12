class da_weapons_AVeRTurret_MainFireMode extends da_weapons_BasicFire;

var bool leftside;
var int rocketbarrage;

function projectile SpawnProjectile(Vector Start, Rotator Dir)
{
    local da_proj_avrocket p;
    local vector hn;
    local actor enemy;

    if(instigator==none) return none;

    if(leftside) p=Weapon.Spawn(class'da2.da_proj_avrocket',,, instigator.GetBoneCoords('muzzle01').Origin, Dir);
    else p=Weapon.Spawn(class'da2.da_proj_avrocket',,, instigator.GetBoneCoords('muzzle02').Origin, Dir);

    if(p!=none) {
        if(instigator.Controller!=none && aicontroller(instigator.controller)!=none && aicontroller(instigator.controller).Enemy!=none) {
            enemy=aicontroller(instigator.controller).Enemy;
            p.targetloc=Enemy.location+Enemy.velocity*(vsize(Enemy.Location-instigator.location)/2000);
        }
        else enemy=Trace(p.targetloc, hn, instigator.location+vector(instigator.GetViewRotation())*20000, instigator.Location, true);

        p.hasTarget=da_turrets_turret(enemy)!=none || da_objective_destroyable(enemy)!=none;
    }

    leftside=!leftside;
    return p;
}

function DoFireEffect()
{
    local rotator R;

    Instigator.MakeNoise(1.0);

    r=Instigator.GetViewRotation();

    if(playercontroller(instigator.controller)==none)
    {
        R.Yaw+=Spread*(FRand()-0.5);
        R.Pitch+=Spread*(FRand()-0.5);
        R.Roll+=Spread*(FRand()-0.5);
    }

    SpawnProjectile(Instigator.Location, R);
}

event ModeDoFire()
{
    if (!AllowFire())
        return;

    if (MaxHoldTime > 0.0)
        HoldTime = FMin(HoldTime, MaxHoldTime);

    // server
    if (Weapon.Role == ROLE_Authority)
    {
        Weapon.ConsumeAmmo(ThisModeNum, Load);
        DoFireEffect();
		HoldTime = 0;	// if bot decides to stop firing, HoldTime must be reset first
        if ( (Instigator == None) || (Instigator.Controller == None) )
			return;

        if ( AIController(Instigator.Controller) != None )
            AIController(Instigator.Controller).WeaponFireAgain(BotRefireRate, true);

        Instigator.DeactivateSpawnProtection();
    }

    // client
    if (Instigator.IsLocallyControlled())
    {
        ShakeView();
        PlayFiring();
        FlashMuzzleFlash();
        StartMuzzleSmoke();
    }
    else // server
    {
        ServerPlayFiring();
    }

    Weapon.IncrementFlashCount(ThisModeNum);

    if(rocketbarrage++>4) {
        NextFireTime += FireRate*9;
        NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
        rocketbarrage=0;
    }
    else {
        NextFireTime += FireRate;
        NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
    }

    Load = AmmoPerFire;
    HoldTime = 0;

    if (Instigator.PendingWeapon != Weapon && Instigator.PendingWeapon != None)
    {
        bIsFiring = false;
        Weapon.PutDown();
    }
}

function ServerPlayFiring()
{
    super.serverplayFiring();
    if(rocketbarrage>4)
        Weapon.PlayOwnedSound(Sound'DA2_WeaponSounds.AVeRReload',SLOT_None,1.8,,200);
}

function PlayFiring()
{
	super.playFiring();
    if(rocketbarrage>4)
        Weapon.PlayOwnedSound(Sound'DA2_WeaponSounds.AVeRReload',SLOT_None,1.8,,200);
}


simulated function vector GetFireStart(vector X, vector Y, vector Z)
{
    return Instigator.Location;
}

defaultproperties
{
     FireSoundFar=Sound'DA2_WeaponSounds.Gunshots.AVeRFireFar'
     FireSoundRand=0.200000
     TransientSoundVolume=2.200000
     TransientSoundRadius=400.000000
     FireLoopAnim=
     FireEndAnim=
     FireSound=Sound'DA2_WeaponSounds.Gunshots.AVeRFire'
     FireForce="TranslocatorFire"
     FireRate=0.250000
     AmmoClass=Class'ROEngine.Ammo_Dummy'
     ShakeRotMag=(X=5.000000)
     ShakeRotRate=(X=2000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=1.500000)
     ShakeOffsetRate=(X=-200.000000)
     ShakeOffsetTime=6.000000
     BotRefireRate=0.990000
     WarnTargetPct=0.150000
     aimerror=0.000000
     Spread=900.000000
}
