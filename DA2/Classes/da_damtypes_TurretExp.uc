class da_damtypes_TurretExp extends KFWeaponDamageType;

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
     DeathString="%k > Turret Explosion > %o"
     FemaleSuicide="Turret Explosion > Turret"
     MaleSuicide="Turret Explosion > Turret"
     bLocationalHit=False
     bDetonatesGoop=True
     bThrowRagdoll=True
     bExtraMomentumZ=True
     GibPerterbation=0.150000
     KDamageImpulse=3000.000000
     KDeathVel=300.000000
     KDeathUpKick=250.000000
}
