// ============================================================================
// Effects by: Czar
// Coded by: aBsOlUt
// Spawns explosion effect after an AlienGrenade detonates.
// ============================================================================

class da_effects_DustExplosion extends Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=DustSmoke
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-40.000000)
         ColorScale(0)=(Color=(B=160,G=171,R=184,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=86,G=124,R=141,A=255))
         FadeOutStartTime=2.000000
         FadeInEndTime=0.100000
         MaxParticles=50
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=-75.000000,Max=75.000000)
         SpinsPerSecondRange=(X=(Min=-0.250000,Max=0.250000))
         StartSizeRange=(X=(Min=50.000000,Max=50.000000))
         InitialParticlesPerSecond=1000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'DA2Effects.Weapon.SmokePanels2'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=1.000000,Max=3.000000)
         InitialDelayRange=(Min=0.300000,Max=0.300000)
     End Object
     Emitters(0)=SpriteEmitter'DA2.da_effects_DustExplosion.DustSmoke'

     Begin Object Class=SpriteEmitter Name=ExplosionDebris
         UseCollision=True
         FadeOut=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-370.000000)
         DampingFactorRange=(X=(Min=0.750000,Max=0.750000),Y=(Min=0.750000,Max=0.750000),Z=(Min=0.400000,Max=0.400000))
         Opacity=0.750000
         FadeOutStartTime=2.000000
         MaxParticles=75
         StartSizeRange=(X=(Min=4.000000,Max=4.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'Effects_Tex.BulletHits.stonechunksfinal'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=2.500000,Max=3.000000)
         StartVelocityRange=(X=(Min=-100.000000,Max=100.000000),Y=(Min=-100.000000,Max=100.000000),Z=(Min=-50.000000,Max=500.000000))
     End Object
     Emitters(1)=SpriteEmitter'DA2.da_effects_DustExplosion.ExplosionDebris'

     AutoDestroy=True
     bNoDelete=False
}
