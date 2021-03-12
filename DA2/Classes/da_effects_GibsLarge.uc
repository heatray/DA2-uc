class da_effects_GibsLarge extends Emitter;

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
         Acceleration=(Z=-250.000000)
         ExtentMultiplier=(X=0.500000,Y=0.500000,Z=0.500000)
         DampingFactorRange=(X=(Min=0.400000,Max=0.400000),Y=(Min=0.400000,Max=0.400000),Z=(Min=0.400000,Max=0.400000))
         ColorScale(0)=(Color=(B=10,G=25,R=150,A=255))
         ColorScale(1)=(RelativeTime=0.500000,Color=(B=10,G=25,R=150,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=10,G=25,R=150))
         ColorMultiplierRange=(Z=(Min=0.800000))
         MaxParticles=8
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Max=10.000000)
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-0.500000,Max=0.500000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         RotationDampingFactorRange=(X=(Min=0.300000,Max=0.300000),Y=(Min=0.300000,Max=0.300000),Z=(Min=0.300000,Max=0.300000))
         StartSizeRange=(X=(Min=4.000000,Max=10.000000),Y=(Min=4.000000,Max=10.000000),Z=(Min=4.000000,Max=10.000000))
         ScaleSizeByVelocityMultiplier=(Y=0.010000)
         InitialParticlesPerSecond=2000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'da2effects2.EmitterTextures.MatDirtParticleTex'
         TextureUSubdivisions=16
         TextureVSubdivisions=16
         LifetimeRange=(Min=3.000000,Max=5.000000)
         StartVelocityRange=(X=(Min=20.000000,Max=200.000000),Y=(Min=-100.000000,Max=100.000000),Z=(Min=-100.000000,Max=100.000000))
         VelocityLossRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(0)=SpriteEmitter'DA2.da_effects_GibsLarge.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-50.000000)
         ColorScale(0)=(Color=(B=7,G=16,R=171,A=255))
         ColorScale(1)=(RelativeTime=0.400000,Color=(B=7,G=15,R=160,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=7,G=15,R=156))
         Opacity=0.750000
         MaxParticles=5
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Max=10.000000)
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-0.200000,Max=0.200000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=0.600000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.900000)
         StartSizeRange=(X=(Min=30.000000,Max=60.000000),Y=(Min=30.000000,Max=30.000000),Z=(Min=30.000000,Max=30.000000))
         InitialParticlesPerSecond=800.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'DA2Effects.Weapon.SmokePanels2'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.750000,Max=2.000000)
         StartVelocityRange=(X=(Min=20.000000,Max=180.000000),Y=(Min=-180.000000,Max=180.000000),Z=(Min=-180.000000,Max=180.000000))
         VelocityLossRange=(X=(Min=5.000000,Max=5.000000),Y=(Min=5.000000,Max=5.000000),Z=(Min=5.000000,Max=5.000000))
     End Object
     Emitters(1)=SpriteEmitter'DA2.da_effects_GibsLarge.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ScaleSizeYByVelocity=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-50.000000)
         ColorScale(0)=(Color=(B=9,G=18,R=189,A=255))
         ColorScale(1)=(RelativeTime=0.500000,Color=(B=9,G=18,R=189,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=9,G=18,R=189))
         ColorMultiplierRange=(Z=(Min=0.800000))
         MaxParticles=3
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Max=10.000000)
         UseRotationFrom=PTRS_Actor
         SizeScale(0)=(RelativeSize=0.050000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=8.000000,Max=15.000000),Y=(Min=70.000000,Max=70.000000),Z=(Min=70.000000,Max=70.000000))
         ScaleSizeByVelocityMultiplier=(Y=0.025000)
         InitialParticlesPerSecond=2000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'da2effects2.EmitterTextures.MatDirtParticleTex'
         TextureUSubdivisions=16
         TextureVSubdivisions=16
         LifetimeRange=(Min=0.150000,Max=0.250000)
         StartVelocityRange=(X=(Min=100.000000,Max=150.000000),Y=(Min=-150.000000,Max=150.000000),Z=(Min=-150.000000,Max=150.000000))
         VelocityLossRange=(X=(Min=2.000000,Max=2.000000),Y=(Min=2.000000,Max=2.000000),Z=(Min=2.000000,Max=2.000000))
     End Object
     Emitters(2)=SpriteEmitter'DA2.da_effects_GibsLarge.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-100.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.400000,Color=(B=255,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255))
         MaxParticles=1
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-0.300000,Max=0.300000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=0.700000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=30.000000,Max=40.000000),Y=(Min=30.000000,Max=30.000000),Z=(Min=30.000000,Max=30.000000))
         InitialParticlesPerSecond=800.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'Effects_Tex.GoreEmitters.BloodCircle'
         LifetimeRange=(Min=0.300000,Max=0.350000)
         VelocityLossRange=(X=(Min=3.000000,Max=3.000000),Y=(Min=3.000000,Max=3.000000),Z=(Min=3.000000,Max=3.000000))
     End Object
     Emitters(3)=SpriteEmitter'DA2.da_effects_GibsLarge.SpriteEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         UseCollision=True
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         DampRotation=True
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-250.000000)
         ExtentMultiplier=(X=0.500000,Y=0.500000,Z=0.500000)
         DampingFactorRange=(X=(Min=0.400000,Max=0.400000),Y=(Min=0.400000,Max=0.400000),Z=(Min=0.400000,Max=0.400000))
         ColorScale(0)=(Color=(B=130,G=135,R=242,A=255))
         ColorScale(1)=(RelativeTime=0.200000,Color=(B=149,G=158,R=247,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=155,G=159,R=244))
         ColorMultiplierRange=(Z=(Min=0.800000))
         MaxParticles=4
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-0.500000,Max=0.500000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         RotationDampingFactorRange=(X=(Min=0.300000,Max=0.300000),Y=(Min=0.300000,Max=0.300000),Z=(Min=0.300000,Max=0.300000))
         StartSizeRange=(X=(Min=3.000000,Max=8.000000),Y=(Min=3.000000,Max=8.000000),Z=(Min=3.000000,Max=8.000000))
         ScaleSizeByVelocityMultiplier=(Y=0.010000)
         InitialParticlesPerSecond=2000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'da2effects2.EmitterTextures.MatDirtParticleTex'
         TextureUSubdivisions=16
         TextureVSubdivisions=16
         LifetimeRange=(Min=3.000000,Max=5.000000)
         StartVelocityRange=(X=(Min=50.000000,Max=150.000000),Y=(Min=-100.000000,Max=100.000000),Z=(Min=-100.000000,Max=100.000000))
         VelocityLossRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(4)=SpriteEmitter'DA2.da_effects_GibsLarge.SpriteEmitter4'

     AutoDestroy=True
     CullDistance=3000.000000
     bNoDelete=False
}
