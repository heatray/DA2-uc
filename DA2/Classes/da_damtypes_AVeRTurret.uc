class da_damtypes_AVeRTurret extends KFWeaponDamageType;

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
     DeathString="%k > AVeR Turret > %o"
     FemaleSuicide="Fatal Error > AVeR Turret"
     MaleSuicide="Fatal Error > AVeR Turret"
     bLocationalHit=False
     bDetonatesGoop=True
     bDelayedDamage=True
     bThrowRagdoll=True
     bExtraMomentumZ=True
     GibPerterbation=0.150000
     KDamageImpulse=2500.000000
     KDeathVel=300.000000
     KDeathUpKick=300.000000
     VehicleDamageScaling=2.000000
}
