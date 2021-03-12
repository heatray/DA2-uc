class da_damtypes_EMPGrenade extends DamageType
	abstract;

static function GetHitEffects(out class<xEmitter> HitEffects[4], int VictimHealth )
{
    HitEffects[0] = class'HitSmoke';
}

defaultproperties
{
     DeathString="%k > EMP Grenade > %o."
     FemaleSuicide="%o > EMP Grenade > herself."
     MaleSuicide="%o > EMP Grenade > himself."
     bDetonatesGoop=True
     bCauseConvulsions=True
     bCausesBlood=False
     bKUseOwnDeathVel=True
     bDelayedDamage=True
     bThrowRagdoll=True
     DamageOverlayTime=0.750000
     GibPerterbation=0.000000
     KDamageImpulse=250.000000
     KDeathVel=50.000000
     KDeathUpKick=10.000000
     VehicleDamageScaling=4.000000
}
