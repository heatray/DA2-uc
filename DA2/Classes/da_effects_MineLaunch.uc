class da_effects_MineLaunch extends Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         RespawnDeadParticles=False
         ScaleSizeXByVelocity=True
         AutomaticInitialSpawning=False
         UseVelocityScale=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.696429,Color=(B=77,G=120,R=210,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(A=255))
         FadeOutFactor=(Y=0.800000,Z=0.650000)
         FadeOutStartTime=0.160000
         MaxParticles=1
         StartLocationOffset=(X=2.000000)
         UseRotationFrom=PTRS_Actor
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=4.000000)
         StartSizeRange=(X=(Min=5.000000,Max=8.000000),Y=(Min=8.000000,Max=16.000000),Z=(Min=50.000000,Max=50.000000))
         ScaleSizeByVelocityMultiplier=(X=0.012000)
         InitialParticlesPerSecond=500.000000
         Texture=Texture'da2effects2.EmitterTextures.SparkSprayTex'
         LifetimeRange=(Min=0.120000,Max=0.160000)
         StartVelocityRange=(X=(Min=150.000000,Max=180.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=-10.000000,Max=10.000000))
         VelocityLossRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=1.000000,Max=1.000000))
         VelocityScale(0)=(RelativeVelocity=(X=1.000000,Y=1.000000,Z=1.000000))
         VelocityScale(1)=(RelativeTime=1.000000,RelativeVelocity=(X=0.050000,Y=0.050000,Z=0.050000))
     End Object
     Emitters(0)=SpriteEmitter'DA2.da_effects_MineLaunch.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         ProjectionNormal=(X=1.000000,Z=0.000000)
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.800000,Color=(B=75,G=115,R=197,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(A=255))
         FadeOutFactor=(Y=0.750000,Z=0.500000)
         FadeOutStartTime=0.160000
         MaxParticles=1
         StartLocationOffset=(X=2.000000)
         UseRotationFrom=PTRS_Actor
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.100000)
         StartSizeRange=(X=(Min=25.000000,Max=50.000000))
         InitialParticlesPerSecond=50.000000
         Texture=Texture'da2effects2.EmitterTextures.SparkGlowTex'
         LifetimeRange=(Min=0.080000,Max=0.120000)
     End Object
     Emitters(1)=SpriteEmitter'DA2.da_effects_MineLaunch.SpriteEmitter1'

     Begin Object Class=MeshEmitter Name=MeshEmitter0
         StaticMesh=StaticMesh'DA2_StaticMeshes.Grenades.APMine'
         RenderTwoSided=True
         UseParticleColor=True
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-250.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         MaxParticles=1
         UseRotationFrom=PTRS_Actor
         SpinCCWorCW=(Z=1.000000)
         SpinsPerSecondRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Min=2.000000,Max=2.000000))
         StartSizeRange=(X=(Min=1.500000,Max=1.500000),Y=(Min=1.500000,Max=1.500000),Z=(Min=1.500000,Max=1.500000))
         InitialParticlesPerSecond=100.000000
         DrawStyle=PTDS_Regular
         LifetimeRange=(Min=0.400000,Max=0.400000)
         StartVelocityRange=(X=(Min=400.000000,Max=400.000000))
         VelocityLossRange=(X=(Min=5.500000,Max=5.500000),Y=(Min=5.500000,Max=5.500000),Z=(Min=5.500000,Max=5.500000))
     End Object
     Emitters(2)=MeshEmitter'DA2.da_effects_MineLaunch.MeshEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         ProjectionNormal=(X=1.000000,Z=0.000000)
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-200.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.800000,Color=(B=75,G=115,R=197,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(A=255))
         FadeOutFactor=(Y=0.750000,Z=0.500000)
         FadeOutStartTime=0.160000
         MaxParticles=1
         StartLocationOffset=(X=2.000000)
         UseRotationFrom=PTRS_Actor
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.500000)
         StartSizeRange=(X=(Min=12.000000,Max=16.000000))
         InitialParticlesPerSecond=50.000000
         Texture=Texture'da2effects2.EmitterTextures.SparkGlowTex'
         LifetimeRange=(Min=0.400000,Max=0.400000)
         VelocityLossRange=(X=(Min=5.500000,Max=5.500000),Y=(Min=5.500000,Max=5.500000),Z=(Min=5.500000,Max=5.500000))
         AddVelocityFromOtherEmitter=2
     End Object
     Emitters(3)=SpriteEmitter'DA2.da_effects_MineLaunch.SpriteEmitter2'

     AutoDestroy=True
     CullDistance=1500.000000
     bNoDelete=False
}
