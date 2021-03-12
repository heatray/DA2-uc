class da_damtypes_MS25RocketLauncher extends daWeaponDamageType
	abstract;

defaultproperties
{
     bIsExplosive=True
     bCheckForHeadShots=False
     WeaponClass=Class'DA2.da_weapons_MS25RocketLauncher'
     DeathString="%k > MS25 Rocket Launcher > %o"
     FemaleSuicide="%o > Rocket Launcher > herself."
     MaleSuicide="%o > MS25 Rocket Launcher > himself."
     bLocationalHit=False
     bDetonatesGoop=True
     bDelayedDamage=True
     bThrowRagdoll=True
     bExtraMomentumZ=True
     FlashFog=(X=400.000000)
     KDamageImpulse=2500.000000
     KDeathVel=300.000000
     KDeathUpKick=300.000000
     VehicleDamageScaling=2.200000
}
