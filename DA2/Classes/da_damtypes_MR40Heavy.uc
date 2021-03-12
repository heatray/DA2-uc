class da_damtypes_MR40Heavy extends daWeaponDamageType
	abstract;

defaultproperties
{
     WeaponClass=Class'DA2.da_weapons_rifles_MR40Heavy'
     DeathString="%k > MR-40 Machine Gun > %o"
     FemaleSuicide="%o > MR-40 Machine Gun > herself."
     MaleSuicide="%o > MR-40 Machine Gun > himself."
     bRagdollBullet=True
     bBulletHit=True
     FlashFog=(X=600.000000)
     KDamageImpulse=2000.000000
     KDeathVel=80.000000
     KDeathUpKick=8.000000
     VehicleDamageScaling=0.400000
}
