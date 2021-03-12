class da_damtypes_CrusherTurret extends KFWeaponDamageType;

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
     DeathString="%k > Crusher Turret > %o"
     FemaleSuicide="Fatal Error > Crusher Turret"
     MaleSuicide="Fatal Error > Crusher Turret"
     bLocationalHit=False
     bDetonatesGoop=True
     bDelayedDamage=True
     bThrowRagdoll=True
     bExtraMomentumZ=True
     GibPerterbation=0.150000
     KDamageImpulse=3000.000000
     KDeathVel=300.000000
     KDeathUpKick=250.000000
}
