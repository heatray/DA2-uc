class da_effects_AAFire extends Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter7
         UseColorScale=True
         RespawnDeadParticles=False
         AutoDestroy=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ColorScale(1)=(RelativeTime=0.150000,Color=(B=181,G=218,R=251))
         ColorScale(2)=(RelativeTime=0.725000,Color=(B=16,G=87,R=194))
         ColorScale(3)=(RelativeTime=1.000000)
         MaxParticles=1
         StartLocationOffset=(X=-30.000000)
         UseRotationFrom=PTRS_Actor
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.750000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=1.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.200000)
         StartSizeRange=(X=(Min=300.000000,Max=400.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         InitialParticlesPerSecond=2000.000000
         Texture=Texture'da2effects2.EmitterTextures.hardspot'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.250000,Max=0.300000)
         StartVelocityRange=(X=(Min=300.000000,Max=500.000000))
         VelocityLossRange=(X=(Min=3.000000,Max=3.000000),Y=(Min=3.000000,Max=3.000000),Z=(Min=3.000000,Max=3.000000))
     End Object
     Emitters(0)=SpriteEmitter'DA2.da_effects_AAFire.SpriteEmitter7'

     Begin Object Class=MeshEmitter Name=MeshEmitter0
         StaticMesh=StaticMesh'DA2_EffectMeshes.Meshes.HackTracer'
         UseParticleColor=True
         UseColorScale=True
         RespawnDeadParticles=False
         DampRotation=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-100.000000)
         DampingFactorRange=(X=(Min=0.300000,Max=0.500000),Y=(Min=0.300000,Max=0.500000),Z=(Min=0.300000,Max=0.500000))
         ColorScale(0)=(Color=(B=100,G=100,R=100))
         ColorScale(1)=(RelativeTime=0.100000,Color=(B=100,G=100,R=100,A=255))
         ColorScale(2)=(RelativeTime=0.889286,Color=(B=100,G=100,R=100,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=100,G=100,R=100))
         FadeOutStartTime=4.000000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=-40.000000)
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Max=30.000000)
         SpinsPerSecondRange=(X=(Min=-2.000000,Max=2.000000),Y=(Min=-2.000000,Max=2.000000),Z=(Min=-2.000000,Max=2.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
         RotationDampingFactorRange=(X=(Min=0.400000,Max=0.800000),Y=(Min=0.400000,Max=0.800000),Z=(Min=0.400000,Max=0.800000))
         StartSizeRange=(X=(Min=4.000000,Max=5.000000),Y=(Min=4.000000,Max=5.000000),Z=(Min=4.000000,Max=5.000000))
         InitialParticlesPerSecond=2000.000000
         DrawStyle=PTDS_AlphaBlend
         LifetimeRange=(Min=5.000000,Max=6.000000)
         StartVelocityRange=(X=(Min=6000.000000,Max=7000.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Min=-50.000000,Max=50.000000))
         VelocityLossRange=(X=(Min=0.300000,Max=0.400000),Y=(Min=0.300000,Max=0.400000),Z=(Min=0.300000,Max=0.400000))
     End Object
     Emitters(1)=MeshEmitter'DA2.da_effects_AAFire.MeshEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter14
         UseColorScale=True
         RespawnDeadParticles=False
         AutoDestroy=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ColorScale(1)=(RelativeTime=0.150000,Color=(B=181,G=218,R=251))
         ColorScale(2)=(RelativeTime=0.725000,Color=(B=16,G=87,R=194))
         ColorScale(3)=(RelativeTime=1.000000)
         Opacity=0.500000
         MaxParticles=1
         StartLocationOffset=(X=-30.000000)
         UseRotationFrom=PTRS_Actor
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.750000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=1.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.200000)
         StartSizeRange=(X=(Min=600.000000,Max=800.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         InitialParticlesPerSecond=2000.000000
         Texture=Texture'da2effects2.EmitterTextures.hardspot'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.150000,Max=0.200000)
         StartVelocityRange=(X=(Min=300.000000,Max=500.000000))
         VelocityLossRange=(X=(Min=3.000000,Max=3.000000),Y=(Min=3.000000,Max=3.000000),Z=(Min=3.000000,Max=3.000000))
     End Object
     Emitters(2)=SpriteEmitter'DA2.da_effects_AAFire.SpriteEmitter14'

     AutoDestroy=True
     bNoDelete=False
}
