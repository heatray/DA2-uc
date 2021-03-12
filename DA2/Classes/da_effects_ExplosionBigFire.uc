// ============================================================================
// Effects by: aBsOlUt
// Coded by: aBsOlUt
// Big Fire caused by an explosion
// ============================================================================

class da_effects_ExplosionBigFire extends Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=ExplosionFlash
         RespawnDeadParticles=False
         UniformSize=True
         Opacity=0.500000
         MaxParticles=1
         StartSizeRange=(X=(Min=425.000000,Max=425.000000))
         DrawStyle=PTDS_Brighten
         Texture=None
         LifetimeRange=(Min=0.150000,Max=0.150000)
     End Object
     Emitters(0)=SpriteEmitter'DA2.da_effects_ExplosionBigFire.ExplosionFlash'

     Begin Object Class=SpriteEmitter Name=explosion
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         Opacity=0.750000
         MaxParticles=1
         SpinsPerSecondRange=(X=(Min=-0.150000,Max=0.150000))
         StartSizeRange=(X=(Min=150.000000,Max=150.000000))
         Texture=Texture'da2effects2.EmitterTextures.MuzParticleTex'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.250000,Max=0.250000)
     End Object
     Emitters(1)=SpriteEmitter'DA2.da_effects_ExplosionBigFire.explosion'

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
     Emitters(2)=SpriteEmitter'DA2.da_effects_ExplosionBigFire.ExplosionSmoke'

     Begin Object Class=SpriteEmitter Name=BigSmoke
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         AddVelocityFromOwner=True
         LowDetailFactor=1.000000
         Acceleration=(Z=120.000000)
         ColorScale(1)=(RelativeTime=0.200000,Color=(B=25,G=25,R=25,A=255))
         ColorScale(2)=(RelativeTime=0.800000,Color=(B=64,G=64,R=64,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=64,G=64,R=64))
         MaxParticles=15
         StartSpinRange=(X=(Min=0.250000,Max=0.750000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=50.000000,Max=60.000000))
         ParticlesPerSecond=7.500000
         InitialParticlesPerSecond=7.500000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'DA2Effects.Weapon.SmokePanels2'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=2.000000,Max=2.000000)
         AddVelocityMultiplierRange=(Z=(Min=0.500000,Max=0.500000))
     End Object
     Emitters(3)=SpriteEmitter'DA2.da_effects_ExplosionBigFire.BigSmoke'

     Begin Object Class=SpriteEmitter Name=BigFire
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         AddVelocityFromOwner=True
         LowDetailFactor=1.000000
         Acceleration=(Z=120.000000)
         ColorScale(1)=(RelativeTime=0.200000,Color=(B=128,G=128,R=128,A=255))
         ColorScale(2)=(RelativeTime=0.800000,Color=(B=64,G=64,R=64,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=64,G=64,R=64))
         FadeOutFactor=(W=0.700000,X=0.700000,Y=0.700000,Z=0.700000)
         FadeOutStartTime=0.400000
         MaxParticles=30
         StartSpinRange=(X=(Min=0.250000,Max=0.750000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=50.000000,Max=60.000000))
         ParticlesPerSecond=6.800000
         InitialParticlesPerSecond=6.800000
         DrawStyle=PTDS_Brighten
         Texture=Texture'Effects_Tex.explosions.fire_16frame'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=2.000000,Max=2.000000)
         AddVelocityFromOtherEmitter=-2
         AddVelocityMultiplierRange=(Z=(Min=0.500000,Max=0.500000))
     End Object
     Emitters(4)=SpriteEmitter'DA2.da_effects_ExplosionBigFire.BigFire'

     Begin Object Class=SpriteEmitter Name=StartBigSmoke
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         AddVelocityFromOwner=True
         LowDetailFactor=1.000000
         ColorScale(1)=(RelativeTime=0.200000,Color=(B=128,G=128,R=128,A=255))
         ColorScale(2)=(RelativeTime=0.800000,Color=(B=64,G=64,R=64,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=64,G=64,R=64))
         MaxParticles=40
         UseRotationFrom=PTRS_Actor
         StartSpinRange=(X=(Min=0.250000,Max=0.750000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=50.000000,Max=60.000000))
         ParticlesPerSecond=7.500000
         InitialParticlesPerSecond=7.500000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'DA2Effects.Weapon.SmokePanels2'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=2.000000,Max=2.000000)
         AddVelocityMultiplierRange=(Z=(Min=0.500000,Max=0.500000))
     End Object
     Emitters(5)=SpriteEmitter'DA2.da_effects_ExplosionBigFire.StartBigSmoke'

     Begin Object Class=SpriteEmitter Name=StartBigFire
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UseRevolution=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         AddVelocityFromOwner=True
         LowDetailFactor=1.000000
         Acceleration=(Z=120.000000)
         ColorScale(1)=(RelativeTime=0.200000,Color=(B=128,G=128,R=128,A=255))
         ColorScale(2)=(RelativeTime=0.800000,Color=(B=64,G=64,R=64,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=64,G=64,R=64))
         FadeOutFactor=(W=0.700000,X=0.700000,Y=0.700000,Z=0.700000)
         FadeOutStartTime=0.400000
         MaxParticles=40
         StartSpinRange=(X=(Min=0.250000,Max=0.750000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=50.000000,Max=60.000000))
         ParticlesPerSecond=20.000000
         InitialParticlesPerSecond=100.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'Effects_Tex.explosions.fire_16frame'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=2.000000,Max=2.000000)
         AddVelocityFromOtherEmitter=-2
         AddVelocityMultiplierRange=(Z=(Min=0.500000,Max=0.500000))
     End Object
     Emitters(6)=SpriteEmitter'DA2.da_effects_ExplosionBigFire.StartBigFire'

     AutoDestroy=True
     bNoDelete=False
}
