class da_damtypes_GK2Shotgun extends daWeaponDamageType
	abstract;

defaultproperties
{
     bIsPowerWeapon=True
     WeaponClass=Class'DA2.da_weapons_GK2Shotgun'
     DeathString="%k > Shotgun > %o"
     FemaleSuicide="%o > Shotgun > herself."
     MaleSuicide="%o > Shotgun > himself."
     bRagdollBullet=True
     bBulletHit=True
     FlashFog=(X=600.000000)
     KDamageImpulse=10000.000000
     KDeathVel=300.000000
     VehicleDamageScaling=0.220000
}
