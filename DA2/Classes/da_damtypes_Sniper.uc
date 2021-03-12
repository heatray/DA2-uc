class da_damtypes_Sniper extends daWeaponDamageType
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
     bSniperWeapon=True
     WeaponClass=Class'DA2.da_weapons_rifles_SniperRifle'
     DeathString="%k > R86 Sniper Rifle > %o"
     FemaleSuicide="%o > R86 Sniper Rifle > herself."
     MaleSuicide="%o > R86 Sniper Rifle > himself."
     bBulletHit=True
     FlashFog=(X=1500.000000)
     KDamageImpulse=2250.000000
     KDeathVel=115.000000
     KDeathUpKick=5.000000
     VehicleDamageScaling=0.200000
}
