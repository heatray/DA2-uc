class da_weapons_A9Fire extends da_weapons_GunFire;

defaultproperties
{
     MuzEmitterClass=Class'DA2.da_effects_XD40Muzzle1st'
     FireSoundFar=Sound'DA2_WeaponSounds.Gunshots.A-9_FireFar'
     FireSoundRand=0.080000
     DamageType=Class'DA2.da_damtypes_A9SMG'
     DamageMax=18
     Momentum=1100.000000
     bWaitForRelease=False
     TransientSoundVolume=1.800000
     FireAnim="Fire_Loop"
     FireLoopAnim="Fire_Loop"
     FireEndAnim="Fire_End"
     FireSound=Sound'DA2_WeaponSounds.Gunshots.A-9_Fire'
     FireRate=0.100000
     AmmoClass=Class'DA2.da_weapons_A9Ammo'
     ShakeRotMag=(X=100.000000,Y=100.000000,Z=100.000000)
     ShakeRotRate=(X=5000.000000,Y=5000.000000,Z=5000.000000)
     ShakeRotTime=1.500000
     ShakeOffsetMag=(X=-6.000000,Y=2.000000,Z=6.000000)
     ShakeOffsetTime=1.000000
     BotRefireRate=0.990000
     aimerror=30.000000
     Spread=0.038000
}
