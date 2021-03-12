// ============================================================================
// Effects by: aBsOlUt
// Coded by: aBsOlUt
// Effect for dropship engine, a modified redemeer engine to fit DA2.
// ============================================================================

class da_effects_EngineA extends Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=EngineFire
         UseColorScale=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(1)=(RelativeTime=0.200000,Color=(B=255,G=255,R=255))
         ColorScale(2)=(RelativeTime=0.800000,Color=(B=255,G=255,R=255))
         ColorScale(3)=(RelativeTime=1.000000)
         CoordinateSystem=PTCS_Relative
         MaxParticles=20
         EffectAxis=PTEA_PositiveZ
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.250000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=45.000000,Max=75.000000))
         Texture=Texture'da2effects2.EmitterTextures.ExploParticleTex'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.250000,Max=0.100000)
         StartVelocityRange=(X=(Min=-300.000000,Max=-300.000000))
     End Object
     Emitters(0)=SpriteEmitter'DA2.da_effects_EngineA.EngineFire'

     Begin Object Class=SpriteEmitter Name=EngineSmoke
         UseColorScale=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=255,G=255,R=255))
         ColorScale(1)=(RelativeTime=0.050000,Color=(B=255,G=255,R=255,A=128))
         ColorScale(2)=(RelativeTime=0.800000,Color=(B=128,G=128,R=128,A=128))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128))
         MaxParticles=350
         StartLocationOffset=(X=-16.000000)
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=1.000000,Max=4.000000)
         UseRotationFrom=PTRS_Actor
         StartSpinRange=(X=(Min=0.550000,Max=0.450000))
         SizeScale(0)=(RelativeSize=0.800000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=55.000000,Max=55.000000))
         ParticlesPerSecond=200.000000
         InitialParticlesPerSecond=200.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'DA2Effects.Weapon.SmokePanels2'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=1.000000,Max=1.500000)
     End Object
     Emitters(1)=SpriteEmitter'DA2.da_effects_EngineA.EngineSmoke'

     AutoDestroy=True
     bNoDelete=False
     bHardAttach=True
}
