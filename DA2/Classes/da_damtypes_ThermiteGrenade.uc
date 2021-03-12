class da_damtypes_ThermiteGrenade extends DamageType
	abstract;

static function GetHitEffects(out class<xEmitter> HitEffects[4], int VictimHealth )
{
    HitEffects[0] = class'HitSmoke';
}

defaultproperties
{
     DeathString="%k > Thermite Grenade > %o."
     FemaleSuicide="%o > Thermite Grenade > herself."
     MaleSuicide="%o > Thermite Grenade > himself."
     bDetonatesGoop=True
     bCausesBlood=False
     bKUseOwnDeathVel=True
     bDelayedDamage=True
     bThrowRagdoll=True
     GibPerterbation=0.000000
     KDamageImpulse=250.000000
     KDeathVel=50.000000
     KDeathUpKick=10.000000
     VehicleDamageScaling=0.400000
}
