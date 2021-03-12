class da_damtypes_PlasmaBomb extends KFWeaponDamageType
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
     DeathString="%k > Plasma Bomb > %o."
     FemaleSuicide="%o > Plasma Bomb > herself."
     MaleSuicide="%o > Plasma Bomb > himself."
     bLocationalHit=False
     bDetonatesGoop=True
     bDelayedDamage=True
     bThrowRagdoll=True
     bExtraMomentumZ=True
     DamageThreshold=1
     KDamageImpulse=4000.000000
     KDeathVel=300.000000
     KDeathUpKick=800.000000
     HumanObliterationThreshhold=600
}
