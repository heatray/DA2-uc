class da_damtypes_LK2Shotgun extends daWeaponDamageType
	abstract;

defaultproperties
{
     bIsPowerWeapon=True
     WeaponClass=Class'DA2.da_weapons_LK2Shotgun'
     DeathString="%k > LK2 Shotgun > %o"
     FemaleSuicide="%o > LK2 Shotgun > herself."
     MaleSuicide="%o > LK2 Shotgun > himself."
     bRagdollBullet=True
     bBulletHit=True
     FlashFog=(X=600.000000)
     KDamageImpulse=10000.000000
     KDeathVel=300.000000
     VehicleDamageScaling=0.220000
}
