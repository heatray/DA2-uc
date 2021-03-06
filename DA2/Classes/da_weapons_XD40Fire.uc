//-----------------------------------------------------------
//
//-----------------------------------------------------------
class da_weapons_XD40Fire extends da_weapons_GunFire;

defaultproperties
{
     MuzEmitterClass=Class'DA2.da_effects_XD40Muzzle3rd'
     FireSoundFar=Sound'DA2_WeaponSounds.Gunshots.XD40_FireFar'
     DamageType=Class'DA2.da_damtypes_XD40Pistol'
     DamageMin=21
     DamageMax=29
     Momentum=10500.000000
     TransientSoundVolume=2.000000
     TransientSoundRadius=250.000000
     FireAnim="Fire2"
     FireAnimRate=1.750000
     FireSound=Sound'DA2_WeaponSounds.Gunshots.XD40_Fire'
     FireRate=0.175000
     AmmoClass=Class'DA2.da_weapons_XD40Ammo'
     ShakeRotMag=(X=75.000000,Y=75.000000,Z=250.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=3.000000
     ShakeOffsetMag=(X=-6.000000,Y=3.000000,Z=10.000000)
     ShakeOffsetRate=(X=1000.000000,Y=1000.000000)
     ShakeOffsetTime=2.000000
     BotRefireRate=0.350000
     Spread=0.015000
}
