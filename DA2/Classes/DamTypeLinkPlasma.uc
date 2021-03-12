class DamTypeLinkPlasma extends WeaponDamageType
	abstract;

static function GetHitEffects(out class<xEmitter> HitEffects[4], int VictemHealth )
{
    HitEffects[0] = class'HitSmoke';
}

defaultproperties
{
     DeathString="%o was served an extra helping of %k's plasma."
     FemaleSuicide="%o fried herself with her own plasma blast."
     MaleSuicide="%o fried himself with his own plasma blast."
     bDetonatesGoop=True
     bDelayedDamage=True
     FlashFog=(X=700.000000)
     DamageOverlayTime=0.500000
     VehicleDamageScaling=0.670000
}
