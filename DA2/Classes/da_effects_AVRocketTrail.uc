class da_effects_AVRocketTrail extends Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter6
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=172,G=199,R=227,A=64))
         ColorScale(1)=(RelativeTime=0.300000,Color=(B=207,G=207,R=207,A=100))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=177,G=177,R=177))
         FadeOutStartTime=2.500000
         MaxParticles=50
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Max=3.000000)
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Max=0.200000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=0.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=4.000000,Max=16.000000),Y=(Max=150.000000),Z=(Max=200.000000))
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'DA2Effects.Weapon.SmokePanels2'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=1.500000,Max=2.000000)
         StartVelocityRange=(X=(Min=-300.000000,Max=-200.000000))
         VelocityLossRange=(X=(Min=2.500000,Max=3.000000),Y=(Min=2.500000,Max=3.000000),Z=(Min=2.500000,Max=3.000000))
     End Object
     Emitters(0)=SpriteEmitter'DA2.da_effects_AVRocketTrail.SpriteEmitter6'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter7
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeIn=True
         UseSizeScale=True
         UseRegularSizeScale=False
         ScaleSizeYByVelocity=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=50.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=64))
         ColorScale(1)=(RelativeTime=0.800000,Color=(B=63,G=107,R=201,A=255))
         ColorScale(2)=(RelativeTime=1.000000)
         FadeOutStartTime=0.500000
         FadeInEndTime=0.050000
         StartLocationOffset=(X=-40.000000)
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Max=3.000000)
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Max=0.200000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.400000)
         StartSizeRange=(X=(Min=6.000000,Max=12.000000),Y=(Min=80.000000,Max=80.000000),Z=(Min=20.000000,Max=20.000000))
         ScaleSizeByVelocityMultiplier=(Y=0.002500)
         InitialParticlesPerSecond=2000.000000
         Texture=Texture'da2effects2.EmitterTextures.SparkGlowTex'
         TextureUSubdivisions=1
         TextureVSubdivisions=1
         LifetimeRange=(Min=0.200000,Max=0.300000)
         InitialDelayRange=(Min=0.200000,Max=0.200000)
         StartVelocityRange=(X=(Min=-800.000000,Max=-200.000000),Y=(Min=-20.000000,Max=20.000000),Z=(Min=-20.000000,Max=20.000000))
         VelocityLossRange=(X=(Min=2.000000,Max=3.000000),Y=(Min=2.000000,Max=3.000000),Z=(Min=2.000000,Max=3.000000))
     End Object
     Emitters(1)=SpriteEmitter'DA2.da_effects_AVRocketTrail.SpriteEmitter7'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter8
         UseColorScale=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         UseRandomSubdivision=True
         Acceleration=(Z=30.000000)
         ColorScale(0)=(Color=(B=172,G=199,R=227,A=64))
         ColorScale(1)=(RelativeTime=0.300000,Color=(B=223,G=223,R=223,A=100))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=202,G=202,R=202))
         FadeOutStartTime=2.500000
         MaxParticles=30
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Max=3.000000)
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Max=0.200000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.400000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=0.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=10.000000,Max=40.000000))
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'DA2Effects.Weapon.SmokePanels2'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.400000,Max=1.200000)
         StartVelocityRange=(X=(Min=-400.000000,Max=-300.000000))
         VelocityLossRange=(X=(Min=2.500000,Max=3.000000),Y=(Min=2.500000,Max=3.000000),Z=(Min=2.500000,Max=3.000000))
     End Object
     Emitters(2)=SpriteEmitter'DA2.da_effects_AVRocketTrail.SpriteEmitter8'

     AutoDestroy=True
     bNoDelete=False
     Physics=PHYS_Trailer
     bHardAttach=True
}
