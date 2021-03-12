//-----------------------------------------------------------
//
//-----------------------------------------------------------
class da_weapons_P280Fire extends da_weapons_GunFire;

defaultproperties
{
     MuzEmitterClass=Class'DA2.da_effects_XD40Muzzle1st'
     FireSoundFar=Sound'DA2_WeaponSounds.Gunshots.P280_FireFar'
     DamageType=Class'DA2.da_damtypes_p280Pistol'
     DamageMin=35
     DamageMax=50
     Momentum=20000.000000
     TransientSoundVolume=2.200000
     FireSound=Sound'DA2_WeaponSounds.Gunshots.P280_Fire'
     FireRate=0.250000
     AmmoClass=Class'DA2.da_weapons_P280Ammo'
     ShakeRotMag=(X=75.000000,Y=75.000000,Z=400.000000)
     ShakeRotRate=(X=12500.000000,Y=12500.000000,Z=10000.000000)
     ShakeRotTime=3.500000
     ShakeOffsetMag=(X=-6.000000,Y=1.000000,Z=8.000000)
     ShakeOffsetRate=(X=1000.000000,Y=1000.000000)
     ShakeOffsetTime=2.500000
     BotRefireRate=0.200000
     Spread=0.012000
}
