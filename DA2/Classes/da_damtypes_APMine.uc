class da_damtypes_APMine extends KFWeaponDamageType
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
     bIsExplosive=True
     bCheckForHeadShots=False
     DeathString="%k > AP-Mine > %o."
     FemaleSuicide="%o > AP-Mine > herself."
     MaleSuicide="%o > AP-Mine > himself."
     bLocationalHit=False
     bDetonatesGoop=True
     bDelayedDamage=True
     bThrowRagdoll=True
     bExtraMomentumZ=True
     KDamageImpulse=2500.000000
     KDeathVel=300.000000
     KDeathUpKick=200.000000
     VehicleDamageScaling=0.350000
}
