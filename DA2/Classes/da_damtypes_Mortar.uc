class da_damtypes_Mortar extends DamageType
	abstract;

static function GetHitEffects(out class<xEmitter> HitEffects[4], int VictimHealth )
{
    HitEffects[0] = class'HitSmoke';

    if( VictimHealth <= 0 )
        HitEffects[1] = class'HitFlameBig';
    else if ( FRand() < 0.8 )
        HitEffects[1] = class'HitFlame';
}

defaultproperties
{
     DeathString="Mortar > %o"
     FemaleSuicide="Mortar > %o"
     MaleSuicide="Mortar > %o"
     bDetonatesGoop=True
     bKUseOwnDeathVel=True
     bDelayedDamage=True
     bThrowRagdoll=True
     GibPerterbation=0.250000
     KDamageImpulse=35000.000000
     KDeathVel=350.000000
     KDeathUpKick=80.000000
     VehicleDamageScaling=0.500000
}
