// ============================================================================
// Effects by: aBsOlUt
// Coded by: aBsOlUt
// Spawns explosion effect after a Human Dropship is destroyed.
// ============================================================================

class da_effects_ExplosionG extends Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=ExplosionFlash
         RespawnDeadParticles=False
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.500000
         MaxParticles=1
         StartSizeRange=(X=(Min=425.000000,Max=425.000000))
         DrawStyle=PTDS_Brighten
         Texture=None
         LifetimeRange=(Min=0.150000,Max=0.150000)
     End Object
     Emitters(0)=SpriteEmitter'DA2.da_effects_ExplosionG.ExplosionFlash'

     Begin Object Class=SpriteEmitter Name=WallFrames
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.750000
         MaxParticles=1
         SpinsPerSecondRange=(X=(Min=-0.150000,Max=0.150000))
         StartSizeRange=(X=(Min=500.000000,Max=500.000000),Y=(Min=600.000000,Max=600.000000),Z=(Min=600.000000,Max=600.000000))
         Texture=Texture'da2effects2.EmitterTextures.MuzParticleTex'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.250000,Max=0.250000)
     End Object
     Emitters(1)=SpriteEmitter'DA2.da_effects_ExplosionG.WallFrames'

     Begin Object Class=SpriteEmitter Name=ExplosionSmoke
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=25.000000)
         ColorScale(0)=(Color=(B=49,G=49,R=49,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=114,G=114,R=114,A=255))
         Opacity=0.750000
         FadeOutStartTime=1.000000
         FadeInEndTime=0.100000
         MaxParticles=25
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=-75.000000,Max=75.000000)
         SpinsPerSecondRange=(X=(Min=-0.250000,Max=0.250000))
         StartSizeRange=(X=(Min=50.000000,Max=50.000000))
         InitialParticlesPerSecond=1000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'DA2Effects.Weapon.SmokePanels2'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=1.250000,Max=3.000000)
         InitialDelayRange=(Min=0.300000,Max=0.300000)
     End Object
     Emitters(2)=SpriteEmitter'DA2.da_effects_ExplosionG.ExplosionSmoke'

     Begin Object Class=SpriteEmitter Name=Chunks
         UseCollision=True
         FadeOut=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-500.000000)
         DampingFactorRange=(X=(Min=0.750000,Max=0.750000),Y=(Min=0.750000,Max=0.750000),Z=(Min=0.400000,Max=0.400000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.750000
         FadeOutStartTime=2.000000
         MaxParticles=500
         StartSizeRange=(X=(Min=4.000000,Max=4.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'Effects_Tex.BulletHits.stonechunksfinal'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=2.500000,Max=3.000000)
         StartVelocityRange=(X=(Min=-400.000000,Max=400.000000),Y=(Min=-400.000000,Max=400.000000),Z=(Min=-50.000000,Max=500.000000))
     End Object
     Emitters(3)=SpriteEmitter'DA2.da_effects_ExplosionG.Chunks'

     AutoDestroy=True
     bNoDelete=False
}
