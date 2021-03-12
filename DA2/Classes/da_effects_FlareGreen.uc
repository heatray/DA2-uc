//-----------------------------------------------------------
//
//-----------------------------------------------------------
class da_effects_FlareGreen extends da_effects_FlareGray;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter8
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.750000
         FadeOutStartTime=2.040000
         FadeInEndTime=0.400000
         CoordinateSystem=PTCS_Relative
         MaxParticles=3
         SpinsPerSecondRange=(X=(Min=-0.300000,Max=0.300000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=0.070000,RelativeSize=0.500000)
         SizeScale(2)=(RelativeTime=0.750000,RelativeSize=0.800000)
         SizeScale(3)=(RelativeTime=1.000000,RelativeSize=0.300000)
         StartSizeRange=(X=(Min=30.000000,Max=300.000000),Y=(Min=30.000000,Max=300.000000),Z=(Min=30.000000,Max=300.000000))
         InitialParticlesPerSecond=100.000000
         Texture=Texture'da2effects2.EmitterTextures.FlashStreakTex'
         LifetimeRange=(Min=3.000000,Max=6.000000)
     End Object
     Emitters(0)=SpriteEmitter'DA2.da_effects_FlareGreen.SpriteEmitter8'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter9
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorMultiplierRange=(X=(Min=0.600000,Max=0.600000),Z=(Min=0.600000,Max=0.600000))
         Opacity=0.500000
         FadeOutStartTime=4.750000
         FadeInEndTime=0.400000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         SpinsPerSecondRange=(X=(Min=-0.200000,Max=0.200000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.700000)
         StartSizeRange=(X=(Min=75.000000,Max=125.000000),Y=(Min=75.000000),Z=(Min=75.000000))
         InitialParticlesPerSecond=100.000000
         Texture=Texture'da2effects2.EmitterTextures.TriFlare'
         LifetimeRange=(Min=9.000000,Max=9.000000)
     End Object
     Emitters(1)=SpriteEmitter'DA2.da_effects_FlareGreen.SpriteEmitter9'

     LightHue=90
     LightSaturation=180
}
