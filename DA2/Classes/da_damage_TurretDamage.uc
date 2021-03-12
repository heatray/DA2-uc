class da_damage_TurretDamage extends DamageType;

static function GetHitEffects(out class<xEmitter> HitEffects[4], int VictimHealth)
{
    HitEffects[0] = class'HitSmoke';

    if( VictimHealth <= 0 )
        HitEffects[1] = class'HitFlameBig';
    else if ( FRand() < 0.8 )
        HitEffects[1] = class'HitFlame';
}

defaultproperties
{
     DeathString="%k was mowed down by a DFA Turret"
     FemaleSuicide="%o has decided to suicide"
     MaleSuicide="%o has decided to suicide"
     bThrowRagdoll=True
     bBulletHit=True
     GibPerterbation=0.150000
}
