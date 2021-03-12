class da_damtypes_Melee extends KFWeaponDamageType
	abstract;

static function GetHitEffects(out class<xEmitter> HitEffects[4], int VictimHealth )
{
    HitEffects[0] = class'HitSmoke';
}

defaultproperties
{
     HeadShotDamageMult=1.250000
     bIsMeleeDamage=True
     DeathString="%k > Melee > %o."
     FemaleSuicide="%o > Melee > herself."
     MaleSuicide="%o > Melee > himself."
     bNeverSevers=True
     KDamageImpulse=2000.000000
     KDeathVel=100.000000
     KDeathUpKick=25.000000
     VehicleDamageScaling=0.250000
}
