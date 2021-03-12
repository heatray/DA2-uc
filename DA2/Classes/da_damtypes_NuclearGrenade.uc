class da_damtypes_NuclearGrenade extends KFWeaponDamageType
	abstract;

static function GetHitEffects(out class<xEmitter> HitEffects[4], int VictimHealth )
{
    HitEffects[0] = class'HitSmoke';


    if( VictimHealth <= 0 )
        HitEffects[1] = class'HitFlameBig';
    else if ( FRand() < 0.5 )
        HitEffects[1] = class'HitFlame';
}

defaultproperties
{
     bIsExplosive=True
     bCheckForHeadShots=False
     DeathString="%k > Nuclear Grenade > %o."
     FemaleSuicide="%o > Nuclear Grenade > herself."
     MaleSuicide="%o > Nuclear Grenade > himself."
     bLocationalHit=False
     bDetonatesGoop=True
     bDelayedDamage=True
     bThrowRagdoll=True
     bExtraMomentumZ=True
     KDamageImpulse=3000.000000
     KDeathVel=300.000000
     KDeathUpKick=250.000000
     VehicleDamageScaling=0.700000
}
