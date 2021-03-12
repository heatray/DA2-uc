class da_effects_CrushMetal extends Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter38
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-400.000000)
         ColorScale(0)=(Color=(B=221,G=236,R=251,A=255))
         ColorScale(1)=(RelativeTime=0.696429,Color=(B=50,G=73,R=141,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(A=255))
         FadeOutStartTime=1.800000
         MaxParticles=6
         StartLocationRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=10.000000,Max=10.000000),Z=(Min=10.000000,Max=10.000000))
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Max=10.000000)
         AlphaRef=2
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-1.000000,Max=1.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000)
         SizeScaleRepeats=1.000000
         StartSizeRange=(X=(Min=3.000000,Max=10.000000),Y=(Min=60.000000,Max=60.000000),Z=(Min=60.000000,Max=60.000000))
         InitialParticlesPerSecond=1000.000000
         Texture=Texture'da2effects2.EmitterTextures.SparkGlowTex'
         TextureUSubdivisions=1
         TextureVSubdivisions=1
         LifetimeRange=(Min=0.500000,Max=1.200000)
         StartVelocityRange=(X=(Min=300.000000,Max=800.000000),Y=(Min=-600.000000,Max=600.000000),Z=(Min=-600.000000,Max=600.000000))
         VelocityLossRange=(X=(Min=2.000000,Max=2.000000),Y=(Min=2.000000,Max=2.000000),Z=(Min=2.000000,Max=2.000000))
     End Object
     Emitters(0)=SpriteEmitter'DA2.da_effects_CrushMetal.SpriteEmitter38'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter39
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-300.000000)
         ColorScale(0)=(Color=(B=254,G=254,R=254,A=255))
         ColorScale(1)=(RelativeTime=0.514286,Color=(B=38,G=154,R=217,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(A=255))
         FadeOutStartTime=0.400000
         MaxParticles=1
         AlphaRef=4
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-0.100000,Max=0.100000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         SizeScaleRepeats=1.000000
         StartSizeRange=(X=(Min=150.000000,Max=200.000000))
         InitialParticlesPerSecond=100.000000
         Texture=Texture'da2effects2.EmitterTextures.SparkCloudTex'
         TextureUSubdivisions=1
         TextureVSubdivisions=1
         LifetimeRange=(Min=0.100000,Max=0.300000)
         StartVelocityRange=(X=(Min=200.000000,Max=600.000000),Y=(Min=-100.000000,Max=100.000000),Z=(Min=-100.000000,Max=100.000000))
         StartVelocityRadialRange=(Min=100.000000,Max=200.000000)
         VelocityLossRange=(X=(Min=4.000000,Max=6.000000),Y=(Min=4.000000,Max=6.000000),Z=(Min=4.000000,Max=6.000000))
     End Object
     Emitters(1)=SpriteEmitter'DA2.da_effects_CrushMetal.SpriteEmitter39'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter40
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         Acceleration=(Z=-400.000000)
         ColorScale(0)=(Color=(B=191,G=200,R=198,A=255))
         ColorScale(1)=(RelativeTime=0.114286,Color=(B=110,G=120,R=113,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=82,G=90,R=84,A=255))
         FadeOutStartTime=0.480000
         FadeInEndTime=0.040000
         MaxParticles=1
         AlphaRef=5
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-0.100000,Max=0.100000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=0.070000,RelativeSize=5.000000)
         SizeScale(2)=(RelativeTime=0.750000,RelativeSize=7.000000)
         SizeScale(3)=(RelativeTime=1.000000,RelativeSize=6.000000)
         StartSizeRange=(X=(Min=10.000000,Max=20.000000))
         InitialParticlesPerSecond=1000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'da2effects2.EmitterTextures.Part_explode2'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.200000,Max=0.300000)
         StartVelocityRange=(X=(Min=800.000000,Max=1000.000000),Y=(Min=-400.000000,Max=400.000000),Z=(Min=-400.000000,Max=400.000000))
         StartVelocityRadialRange=(Min=100.000000,Max=200.000000)
         VelocityLossRange=(X=(Min=4.000000,Max=4.000000),Y=(Min=4.000000,Max=4.000000),Z=(Min=4.000000,Max=4.000000))
     End Object
     Emitters(2)=SpriteEmitter'DA2.da_effects_CrushMetal.SpriteEmitter40'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter41
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         RespawnDeadParticles=False
         UseSizeScale=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-100.000000)
         ColorScale(0)=(Color=(B=221,G=236,R=251,A=255))
         ColorScale(1)=(RelativeTime=0.771429,Color=(B=54,G=105,R=175,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(A=255))
         FadeOutStartTime=1.800000
         StartLocationRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=10.000000,Max=10.000000),Z=(Min=10.000000,Max=10.000000))
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Max=10.000000)
         AlphaRef=3
         UseRotationFrom=PTRS_Actor
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000)
         SizeScaleRepeats=1.000000
         StartSizeRange=(X=(Min=2.000000,Max=6.000000),Y=(Min=30.000000,Max=40.000000),Z=(Min=30.000000,Max=40.000000))
         InitialParticlesPerSecond=1000.000000
         Texture=Texture'da2effects2.EmitterTextures.SparkGlowTex'
         TextureUSubdivisions=1
         TextureVSubdivisions=1
         LifetimeRange=(Min=0.100000,Max=0.300000)
         StartVelocityRange=(X=(Min=200.000000,Max=1200.000000),Y=(Min=-800.000000,Max=800.000000),Z=(Min=-800.000000,Max=800.000000))
         VelocityLossRange=(X=(Min=2.000000,Max=2.000000),Y=(Min=2.000000,Max=2.000000),Z=(Min=2.000000,Max=2.000000))
     End Object
     Emitters(3)=SpriteEmitter'DA2.da_effects_CrushMetal.SpriteEmitter41'

     AutoDestroy=True
     bNoDelete=False
}
