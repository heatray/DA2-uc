// ============================================================================
// Effects by: Czar
// Coded by: aBsOlUt
// Spawns explosion effect after a HumanGrenade detonates.
// ============================================================================

class da_effects_WallExplosion extends Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=ExplosionEmitter
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         Opacity=0.500000
         MaxParticles=3
         SpinsPerSecondRange=(X=(Min=-0.025000,Max=0.025000))
         StartSizeRange=(X=(Min=200.000000,Max=200.000000))
         InitialParticlesPerSecond=3.000000
         Texture=Texture'da2effects2.EmitterTextures.ExploParticleTex'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.200000,Max=0.200000)
     End Object
     Emitters(0)=SpriteEmitter'DA2.da_effects_WallExplosion.ExplosionEmitter'

     Begin Object Class=SpriteEmitter Name=DirtEmitter
         FadeOut=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         UseVelocityScale=True
         Acceleration=(Y=-500.000000,Z=-800.000000)
         Opacity=0.250000
         FadeOutStartTime=2.000000
         MaxParticles=300
         StartLocationRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000))
         StartSizeRange=(X=(Min=50.000000,Max=50.000000))
         InitialParticlesPerSecond=1000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'Effects_Tex.BulletHits.dirtclouddark'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=1.000000,Max=5.000000)
         StartVelocityRange=(Z=(Min=250.000000,Max=1000.000000))
         StartVelocityRadialRange=(Min=250.000000,Max=250.000000)
         VelocityLossRange=(Z=(Min=0.250000,Max=0.250000))
         GetVelocityDirectionFrom=PTVD_AddRadial
         VelocityScale(0)=(RelativeTime=0.650000,RelativeVelocity=(X=0.025000,Y=0.025000,Z=0.050000))
     End Object
     Emitters(1)=SpriteEmitter'DA2.da_effects_WallExplosion.DirtEmitter'

     Begin Object Class=SpriteEmitter Name=ExplosionEmitter2
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         Opacity=0.750000
         MaxParticles=1
         SpinsPerSecondRange=(X=(Min=-0.150000,Max=0.150000))
         StartSizeRange=(X=(Min=110.000000,Max=110.000000))
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=0.150000,Max=0.150000)
     End Object
     Emitters(2)=SpriteEmitter'DA2.da_effects_WallExplosion.ExplosionEmitter2'

     Begin Object Class=SpriteEmitter Name=ExplosionSmoke
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Y=-80.000000,Z=25.000000)
         ColorScale(0)=(Color=(B=104,G=112,R=121,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=75,G=123,R=139,A=255))
         Opacity=0.800000
         FadeOutStartTime=1.000000
         FadeInEndTime=0.100000
         MaxParticles=25
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=-100.000000,Max=100.000000)
         SpinsPerSecondRange=(X=(Min=-0.250000,Max=0.250000))
         StartSizeRange=(X=(Min=110.000000,Max=110.000000))
         InitialParticlesPerSecond=1000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'Effects_Tex.explosions.DSmoke_2'
         LifetimeRange=(Min=1.250000,Max=3.000000)
         InitialDelayRange=(Min=0.250000,Max=0.250000)
     End Object
     Emitters(3)=SpriteEmitter'DA2.da_effects_WallExplosion.ExplosionSmoke'

     Begin Object Class=SpriteEmitter Name=ExplosionSmokeR
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(X=10.000000,Y=-80.000000,Z=25.000000)
         ColorScale(0)=(Color=(B=72,G=102,R=99,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=122,G=153,R=160,A=255))
         Opacity=0.800000
         FadeOutStartTime=1.000000
         FadeInEndTime=0.100000
         MaxParticles=25
         StartLocationOffset=(X=-250.000000,Z=-40.000000)
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=-100.000000,Max=100.000000)
         SpinsPerSecondRange=(X=(Min=-0.250000,Max=0.250000))
         StartSizeRange=(X=(Min=130.000000,Max=130.000000))
         InitialParticlesPerSecond=1000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'Effects_Tex.explosions.DSmoke_2'
         LifetimeRange=(Min=1.250000,Max=3.000000)
         InitialDelayRange=(Min=0.250000,Max=0.250000)
     End Object
     Emitters(4)=SpriteEmitter'DA2.da_effects_WallExplosion.ExplosionSmokeR'

     AutoDestroy=True
     bNoDelete=False
}
