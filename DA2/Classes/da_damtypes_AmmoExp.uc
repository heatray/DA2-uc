class da_damtypes_AmmoExp extends DamageType;

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
     DeathString="%k > Ammobox Explosion > %o"
     FemaleSuicide="Ammobox Explosion > Ammobox"
     MaleSuicide="Ammobox Explosion > Ammobox"
     bDetonatesGoop=True
     bSuperWeapon=True
     bKUseOwnDeathVel=True
     bThrowRagdoll=True
     GibPerterbation=0.150000
     KDamageImpulse=30000.000000
     KDeathVel=400.000000
     KDeathUpKick=80.000000
}
