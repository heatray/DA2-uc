//-----------------------------------------------------------
//
//-----------------------------------------------------------
class da_effects_FlareTrailGreen extends da_effects_FlareTrailGray;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter10
         UseColorScale=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=30.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.214286,Color=(B=176,G=210,R=167,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=90,G=140,R=106))
         FadeOutStartTime=4.000000
         FadeInEndTime=0.160000
         MaxParticles=250
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-0.200000,Max=0.200000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.400000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=0.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=10.000000,Max=40.000000),Y=(Min=10.000000,Max=40.000000),Z=(Min=10.000000,Max=40.000000))
         InitialParticlesPerSecond=100.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'DA2Effects.Weapon.SmokePanels2'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=2.000000)
         StartVelocityRange=(X=(Min=-400.000000,Max=-300.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=-10.000000,Max=10.000000))
         VelocityLossRange=(X=(Min=3.000000,Max=3.000000),Y=(Min=3.000000,Max=3.000000),Z=(Min=3.000000,Max=3.000000))
     End Object
     Emitters(0)=SpriteEmitter'DA2.da_effects_FlareTrailGreen.SpriteEmitter10'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter33
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ColorMultiplierRange=(X=(Min=0.800000,Max=0.800000),Z=(Min=0.800000,Max=0.800000))
         Opacity=0.250000
         FadeOutStartTime=0.750000
         FadeInEndTime=0.750000
         MaxParticles=5
         StartLocationOffset=(X=400.000000)
         StartLocationRange=(X=(Min=-600.000000,Max=600.000000),Y=(Min=-600.000000,Max=600.000000))
         SphereRadiusRange=(Min=500.000000,Max=800.000000)
         UseRotationFrom=PTRS_Actor
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.400000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=0.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=400.000000,Max=600.000000),Y=(Min=400.000000,Max=600.000000),Z=(Min=400.000000,Max=600.000000))
         InitialParticlesPerSecond=2.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'DA2Effects.Weapon.SmokePanels2'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=1.500000,Max=1.500000)
         InitialDelayRange=(Min=2.000000,Max=2.000000)
     End Object
     Emitters(1)=SpriteEmitter'DA2.da_effects_FlareTrailGreen.SpriteEmitter33'

}
