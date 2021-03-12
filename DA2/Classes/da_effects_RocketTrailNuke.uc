class da_effects_RocketTrailNuke extends Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=189,G=207,R=227,A=64))
         ColorScale(1)=(RelativeTime=0.221429,Color=(B=46,G=46,R=75,A=255))
         ColorScale(2)=(RelativeTime=0.496429,Color=(A=255))
         ColorScale(3)=(RelativeTime=0.789286,Color=(B=48,G=48,R=48,A=255))
         ColorScale(4)=(RelativeTime=1.000000,Color=(A=255))
         FadeOutStartTime=2.000000
         MaxParticles=100
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Max=3.000000)
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Max=0.200000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=0.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=6.000000,Max=12.000000),Z=(Max=150.000000))
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'DA2Effects.Weapon.SmokePanels2'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.850000,Max=1.200000)
         StartVelocityRange=(X=(Min=-300.000000,Max=-200.000000))
         VelocityLossRange=(X=(Min=2.500000,Max=3.000000),Y=(Min=2.500000,Max=3.000000),Z=(Min=2.500000,Max=3.000000))
     End Object
     Emitters(0)=SpriteEmitter'DA2.da_effects_RocketTrailNuke.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeIn=True
         UseSizeScale=True
         UseRegularSizeScale=False
         ScaleSizeYByVelocity=True
         UseRandomSubdivision=True
         Acceleration=(Z=-200.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=64))
         ColorScale(1)=(RelativeTime=0.800000,Color=(B=63,G=107,R=201,A=255))
         ColorScale(2)=(RelativeTime=1.000000)
         FadeOutStartTime=0.500000
         FadeInEndTime=0.050000
         MaxParticles=20
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Max=3.000000)
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Max=0.200000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=0.200000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.100000)
         StartSizeRange=(X=(Min=4.000000,Max=8.000000),Y=(Min=20.000000,Max=25.000000))
         ScaleSizeByVelocityMultiplier=(Y=0.003500)
         Texture=Texture'da2effects2.EmitterTextures.SparkGlowTex'
         TextureUSubdivisions=1
         TextureVSubdivisions=1
         LifetimeRange=(Min=0.200000,Max=0.700000)
         InitialDelayRange=(Min=0.200000,Max=0.200000)
         StartVelocityRange=(X=(Min=-750.000000,Max=-250.000000),Y=(Min=-60.000000,Max=60.000000),Z=(Min=-60.000000,Max=60.000000))
         VelocityLossRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(1)=SpriteEmitter'DA2.da_effects_RocketTrailNuke.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=255,G=255,R=255))
         ColorScale(1)=(RelativeTime=0.500000,Color=(B=119,G=182,R=227,A=255))
         ColorScale(2)=(RelativeTime=1.000000)
         MaxParticles=8
         StartLocationOffset=(X=-20.000000)
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-3.500000,Max=3.500000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.300000)
         SizeScale(1)=(RelativeTime=0.300000,RelativeSize=1.200000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.800000)
         StartSizeRange=(X=(Min=10.000000,Max=25.000000),Y=(Min=60.000000,Max=60.000000),Z=(Min=60.000000,Max=60.000000))
         InitialParticlesPerSecond=800.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'da2effects2.EmitterTextures.Part_explode2'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.150000,Max=0.300000)
         StartVelocityRange=(X=(Min=250.000000,Max=350.000000),Y=(Min=-75.000000,Max=75.000000),Z=(Min=-75.000000,Max=75.000000))
         VelocityLossRange=(X=(Min=2.000000,Max=2.000000),Y=(Min=2.000000,Max=2.000000),Z=(Min=2.000000,Max=2.000000))
     End Object
     Emitters(2)=SpriteEmitter'DA2.da_effects_RocketTrailNuke.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=128))
         ColorScale(1)=(RelativeTime=0.200000,Color=(B=200,G=200,R=200,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=32,G=32,R=32))
         FadeOutStartTime=2.000000
         MaxParticles=16
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Max=3.000000)
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Max=0.200000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=0.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=10.000000,Max=12.000000),Y=(Min=50.000000,Max=50.000000),Z=(Min=200.000000,Max=350.000000))
         Texture=Texture'KillingFloorTextures.LondonCommon.fire3'
         TextureUSubdivisions=4
         TextureVSubdivisions=1
         LifetimeRange=(Min=0.050000,Max=0.200000)
         StartVelocityRange=(X=(Min=-300.000000,Max=-200.000000))
         VelocityLossRange=(X=(Min=2.500000,Max=3.000000),Y=(Min=2.500000,Max=3.000000),Z=(Min=2.500000,Max=3.000000))
     End Object
     Emitters(3)=SpriteEmitter'DA2.da_effects_RocketTrailNuke.SpriteEmitter3'

     AutoDestroy=True
     bNoDelete=False
     Physics=PHYS_Trailer
     bHardAttach=True
}
