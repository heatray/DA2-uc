class da_effects_FlareExpGreen extends da_effects_FlareExpGray;

simulated function PostBeginPlay()
{
	setTimer(0.25, false);
}

simulated function Timer()
{
  bDynamicLight=false;
  super.Timer();
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         AlphaTest=False
         UseRevolution=True
         SpinParticles=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         Acceleration=(Z=-300.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutFactor=(X=0.000000,Y=0.000000,Z=0.000000)
         FadeOutStartTime=0.300000
         FadeInFactor=(W=0.000000,X=0.000000,Y=0.000000,Z=0.000000)
         FadeInEndTime=1.000000
         MaxParticles=4
         StartLocationOffset=(X=10.000000)
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Max=20.000000)
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-0.200000,Max=0.200000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         StartSizeRange=(X=(Min=20.000000,Max=120.000000))
         InitialParticlesPerSecond=1050.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'da2effects2.EmitterTextures.Part_explode2'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.100000,Max=0.400000)
         StartVelocityRange=(X=(Min=-200.000000,Max=200.000000),Y=(Min=-200.000000,Max=200.000000),Z=(Min=-200.000000,Max=200.000000))
         StartVelocityRadialRange=(Min=10.000000,Max=10.000000)
         MaxAbsVelocity=(X=1.000000,Y=1.000000,Z=1.000000)
         VelocityLossRange=(X=(Max=3.000000),Y=(Max=3.000000),Z=(Max=3.000000))
         VelocityScale(0)=(RelativeTime=1.000000,RelativeVelocity=(X=0.200000,Y=0.200000,Z=0.200000))
     End Object
     Emitters(0)=SpriteEmitter'DA2.da_effects_FlareExpGreen.SpriteEmitter5'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter7
         UseColorScale=True
         RespawnDeadParticles=False
         UseRevolution=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         UseRandomSubdivision=True
         UseVelocityScale=True
         Acceleration=(Z=60.000000)
         ColorScale(0)=(Color=(B=169,G=181,R=157))
         ColorScale(1)=(RelativeTime=0.100000,Color=(B=102,G=180,R=89,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=39,G=70,R=43))
         Opacity=0.800000
         FadeOutStartTime=4.000000
         MaxParticles=6
         StartLocationOffset=(X=-5.000000)
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=10.000000,Max=40.000000)
         RevolutionsPerSecondRange=(X=(Max=0.050000))
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-0.100000,Max=0.100000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.400000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=0.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=20.000000,Max=120.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         InitialParticlesPerSecond=150.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'DA2Effects.Weapon.SmokePanels2'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=1.000000)
         StartVelocityRange=(X=(Min=-200.000000,Max=200.000000),Y=(Min=-200.000000,Max=200.000000),Z=(Min=-200.000000,Max=200.000000))
         StartVelocityRadialRange=(Min=200.000000,Max=200.000000)
         VelocityLossRange=(X=(Max=8.000000),Y=(Max=8.000000),Z=(Max=8.000000))
     End Object
     Emitters(1)=SpriteEmitter'DA2.da_effects_FlareExpGreen.SpriteEmitter7'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter8
         UseColorScale=True
         RespawnDeadParticles=False
         AutoDestroy=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ColorScale(1)=(RelativeTime=0.150000,Color=(B=255,G=255,R=255))
         ColorScale(2)=(RelativeTime=0.725000,Color=(B=126,G=210,R=112))
         ColorScale(3)=(RelativeTime=1.000000)
         Opacity=0.750000
         MaxParticles=1
         StartLocationOffset=(X=15.000000)
         SpinsPerSecondRange=(X=(Min=1.000000,Max=1.000000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.750000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=1.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.200000)
         StartSizeRange=(X=(Min=500.000000,Max=700.000000))
         InitialParticlesPerSecond=2000.000000
         Texture=Texture'da2effects2.EmitterTextures.hardspot'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.300000,Max=0.500000)
     End Object
     Emitters(2)=SpriteEmitter'DA2.da_effects_FlareExpGreen.SpriteEmitter8'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter9
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=198,G=255,R=181))
         ColorScale(1)=(RelativeTime=1.000000)
         MaxParticles=3
         StartLocationOffset=(X=15.000000)
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Max=10.000000)
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=5.000000)
         StartSizeRange=(X=(Min=60.000000,Max=80.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'da2effects2.EmitterTextures.plasmastar'
         TextureUSubdivisions=1
         TextureVSubdivisions=1
         LifetimeRange=(Min=0.400000,Max=1.000000)
     End Object
     Emitters(3)=SpriteEmitter'DA2.da_effects_FlareExpGreen.SpriteEmitter9'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter10
         UseColorScale=True
         RespawnDeadParticles=False
         AlphaTest=False
         UseRevolution=True
         SpinParticles=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         Acceleration=(Z=-500.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.600000,Color=(B=138,G=181,R=117,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(A=255))
         FadeOutFactor=(X=0.000000,Y=0.000000,Z=0.000000)
         FadeOutStartTime=2.000000
         FadeInFactor=(W=0.000000,X=0.000000,Y=0.000000,Z=0.000000)
         MaxParticles=8
         StartLocationOffset=(X=10.000000)
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Max=20.000000)
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-0.200000,Max=0.200000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         StartSizeRange=(X=(Min=10.000000,Max=20.000000))
         InitialParticlesPerSecond=1050.000000
         Texture=Texture'da2effects2.EmitterTextures.hardspot'
         TextureUSubdivisions=1
         TextureVSubdivisions=1
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=3.000000)
         StartVelocityRange=(X=(Min=-800.000000,Max=800.000000),Y=(Min=-800.000000,Max=800.000000),Z=(Min=-800.000000,Max=800.000000))
         StartVelocityRadialRange=(Min=10.000000,Max=10.000000)
         VelocityLossRange=(X=(Min=3.000000,Max=3.000000),Y=(Min=3.000000,Max=3.000000),Z=(Min=3.000000,Max=3.000000))
         VelocityScale(0)=(RelativeTime=1.000000,RelativeVelocity=(X=0.200000,Y=0.200000,Z=0.200000))
     End Object
     Emitters(4)=SpriteEmitter'DA2.da_effects_FlareExpGreen.SpriteEmitter10'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter41
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=30.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=90,G=140,R=106))
         ColorMultiplierRange=(X=(Min=0.800000,Max=0.800000),Z=(Min=0.800000,Max=0.800000))
         Opacity=0.300000
         FadeOutStartTime=0.125000
         FadeInEndTime=0.125000
         MaxParticles=4
         StartLocationRange=(X=(Min=-600.000000,Max=600.000000),Y=(Min=-600.000000,Max=600.000000))
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=500.000000,Max=600.000000)
         UseRotationFrom=PTRS_Actor
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.400000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=0.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=400.000000,Max=600.000000),Y=(Min=400.000000,Max=600.000000),Z=(Min=400.000000,Max=600.000000))
         InitialParticlesPerSecond=1000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'DA2Effects.Weapon.SmokePanels2'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.500000,Max=0.500000)
         VelocityLossRange=(X=(Min=3.000000,Max=3.000000),Y=(Min=3.000000,Max=3.000000),Z=(Min=3.000000,Max=3.000000))
     End Object
     Emitters(5)=SpriteEmitter'DA2.da_effects_FlareExpGreen.SpriteEmitter41'

     LightHue=90
     LightSaturation=180
}
