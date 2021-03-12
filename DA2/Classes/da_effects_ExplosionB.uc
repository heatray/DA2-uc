// ============================================================================
// Effects by: Czar
// Coded by: aBsOlUt
// Spawns explosion effect after a HumanGrenade detonates (AIR ONLY).
// ============================================================================

class da_effects_ExplosionB extends Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=ExplosionEmitter
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         Opacity=0.500000
         MaxParticles=3
         SpinsPerSecondRange=(X=(Min=-0.025000,Max=0.025000))
         StartSizeRange=(X=(Min=125.000000,Max=125.000000))
         InitialParticlesPerSecond=3.000000
         Texture=Texture'da2effects2.EmitterTextures.ExploParticleTex'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.200000,Max=0.200000)
     End Object
     Emitters(0)=SpriteEmitter'DA2.da_effects_ExplosionB.ExplosionEmitter'

     Begin Object Class=SpriteEmitter Name=Explosion2
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         Opacity=0.750000
         MaxParticles=1
         SpinsPerSecondRange=(X=(Min=-0.150000,Max=0.150000))
         Texture=Texture'DA2Effects.Blast_4Frame'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=0.150000,Max=0.150000)
     End Object
     Emitters(1)=SpriteEmitter'DA2.da_effects_ExplosionB.Explosion2'

     Begin Object Class=SpriteEmitter Name=ExplosionSmoke
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=25.000000)
         ColorScale(0)=(Color=(B=31,G=31,R=31,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=85,G=91,R=91,A=255))
         Opacity=0.800000
         FadeOutStartTime=1.000000
         FadeInEndTime=0.100000
         MaxParticles=25
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=-100.000000,Max=100.000000)
         SpinsPerSecondRange=(X=(Min=-0.250000,Max=0.250000))
         StartSizeRange=(X=(Min=50.000000,Max=50.000000))
         InitialParticlesPerSecond=1000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'Effects_Tex.explosions.DSmoke_2'
         LifetimeRange=(Min=1.250000,Max=3.000000)
         InitialDelayRange=(Min=0.250000,Max=0.250000)
     End Object
     Emitters(2)=SpriteEmitter'DA2.da_effects_ExplosionB.ExplosionSmoke'

     bNoDelete=False
}
