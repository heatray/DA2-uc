class da_weapons_DFATurret_MainFireMode extends da_weapons_BasicFire;

/*simulated function bool allowFire()
{
  if (Instigator != none && Instigator.IsInState('Stunned'))
     return false;

  return super.AllowFire();
}*/

function DoFireEffect()

{
    local Vector StartTrace;
    local Rotator R, Aim;

    if(Instigator==none)
       return;

    if(instigator.controller==none || playercontroller(instigator.controller)==none)
        spread=0.25;
    else spread=0.025;

    Instigator.MakeNoise(1.0);

    StartTrace = Instigator.GetBoneCoords('Muzzle').Origin;
    Aim = AdjustAim(StartTrace, AimError);
	R = rotator(vector(Aim) + VRand()*FRand()*Spread);
    DoTrace(StartTrace, R);
}

defaultproperties
{
     FireSoundFar=Sound'DA2_WeaponSounds.Gunshots.TurretFireFar'
     FireSoundRand=0.020000
     DamageType=Class'DA2.da_damtypes_DFATurret'
     DamageMin=18
     DamageMax=15
     TraceRange=13000.000000
     Momentum=2000.000000
     TransientSoundVolume=2.200000
     FireLoopAnim=
     FireEndAnim=
     FireSound=Sound'DA2_WeaponSounds.Gunshots.TurretFire'
     FireForce="TranslocatorFire"
     FireRate=0.110000
     AmmoClass=Class'ROEngine.Ammo_Dummy'
     ShakeRotMag=(X=40.000000)
     ShakeRotRate=(X=2000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=2.000000)
     ShakeOffsetRate=(X=-2000.000000)
     ShakeOffsetTime=3.000000
     BotRefireRate=0.990000
     WarnTargetPct=0.150000
     Spread=0.300000
     SpreadStyle=SS_Random
}
