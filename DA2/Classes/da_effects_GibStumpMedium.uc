class da_effects_GibStumpMedium extends Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseCollision=True
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         DampRotation=True
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ExtentMultiplier=(X=0.500000,Y=0.500000,Z=0.500000)
         DampingFactorRange=(X=(Min=0.400000,Max=0.400000),Y=(Min=0.400000,Max=0.400000),Z=(Min=0.400000,Max=0.400000))
         ColorScale(0)=(Color=(B=10,G=25,R=150,A=128))
         ColorScale(1)=(RelativeTime=0.050000,Color=(B=10,G=25,R=150,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=10,G=25,R=150))
         ColorMultiplierRange=(Z=(Min=0.800000))
         CoordinateSystem=PTCS_Relative
         MaxParticles=6
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=2.000000,Max=3.000000)
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-0.020000,Max=0.020000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         RotationDampingFactorRange=(X=(Min=0.300000,Max=0.300000),Y=(Min=0.300000,Max=0.300000),Z=(Min=0.300000,Max=0.300000))
         StartSizeRange=(X=(Min=3.000000,Max=5.000000))
         ScaleSizeByVelocityMultiplier=(Y=0.010000)
         InitialParticlesPerSecond=100.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'da2effects2.EmitterTextures.MatDirtParticleTex'
         TextureUSubdivisions=16
         TextureVSubdivisions=16
         LifetimeRange=(Min=6.000000,Max=9.000000)
     End Object
     Emitters(0)=SpriteEmitter'DA2.da_effects_GibStumpMedium.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ScaleSizeYByVelocity=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-100.000000)
         ColorScale(0)=(Color=(B=10,G=20,R=214,A=255))
         ColorScale(1)=(RelativeTime=0.300000,Color=(B=10,G=20,R=214,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=10,G=20,R=214))
         ColorMultiplierRange=(Z=(Min=0.800000))
         MaxParticles=40
         UseRotationFrom=PTRS_Actor
         SizeScale(0)=(RelativeSize=0.800000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.800000)
         StartSizeRange=(X=(Min=1.000000,Max=3.500000),Y=(Min=50.000000,Max=50.000000),Z=(Min=50.000000,Max=50.000000))
         ScaleSizeByVelocityMultiplier=(Y=0.020000)
         InitialParticlesPerSecond=16.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'da2effects2.EmitterTextures.MatDirtParticleTex'
         TextureUSubdivisions=16
         TextureVSubdivisions=16
         LifetimeRange=(Min=0.200000,Max=0.700000)
         InitialDelayRange=(Min=0.100000,Max=0.200000)
         StartVelocityRange=(X=(Min=150.000000,Max=250.000000),Y=(Min=-30.000000,Max=30.000000),Z=(Min=-30.000000,Max=30.000000))
         VelocityLossRange=(X=(Min=4.000000,Max=4.000000),Y=(Min=4.000000,Max=4.000000),Z=(Min=4.000000,Max=4.000000))
     End Object
     Emitters(1)=SpriteEmitter'DA2.da_effects_GibStumpMedium.SpriteEmitter1'

     AutoDestroy=True
     CullDistance=3000.000000
     bNoDelete=False
     bHardAttach=True
}
