// ============================================================================
// Coded by: Leviathan
// High explosive shell
// ============================================================================
class da_proj_CrusherShell extends da_proj_Projectile;

defaultproperties
{
     ExplosionEmitter=Class'DA2.da_effects_HEDPExplosion'
     MaterialFX(1)=Class'DA2.da_effects_CrushRock'
     MaterialFX(2)=Class'DA2.da_effects_CrushDirt'
     MaterialFX(3)=Class'DA2.da_effects_CrushMetal'
     MaterialFX(4)=Class'DA2.da_effects_CrushRock'
     MaterialFX(5)=Class'DA2.da_effects_CrushDirt'
     MaterialFX(7)=Class'DA2.da_effects_CrushSnow'
     MaterialFX(8)=Class'DA2.da_effects_CrushSnow'
     MaterialFX(10)=Class'DA2.da_effects_CrushDirt'
     HitMetalSound=Sound'DA2_Various.explosions.CrushHitMetal'
     ExplosionSounds(0)=Sound'DA2_Various.explosions.CrushExp1'
     ExplosionSounds(1)=Sound'DA2_Various.explosions.CrushExp2'
     ExplosionSounds(2)=Sound'DA2_Various.explosions.CrushExp3'
     ExplosionSoundFar=Sound'DA2_Various.explosions.CrushExpFar'
     ExpSoundsNum=3
     Dispersion=50.000000
     ProjFX=Class'DA2.da_effects_CrusherShell'
     Damage=60.000000
     DamageRadius=250.000000
     MomentumTransfer=25000.000000
     MyDamageType=Class'DA2.da_damtypes_CrusherTurret'
     ExplosionDecal=Class'DA2.da_effects_CrusherDecal'
     TransientSoundVolume=2.600000
     TransientSoundRadius=300.000000
}
