class da_effects_HGExplosion extends Emitter;

simulated function PostBeginPlay()
{
	setTimer(0.10, false);
}

simulated function Timer()
{
  bDynamicLight=false;
  super.Timer();
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter121
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         AlphaTest=False
         UseRevolution=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         UseRandomSubdivision=True
         Acceleration=(Z=-300.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.500000,Color=(B=255,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(A=255))
         FadeOutFactor=(X=0.000000,Y=0.000000,Z=0.000000)
         FadeOutStartTime=0.300000
         FadeInFactor=(W=0.000000,X=0.000000,Y=0.000000,Z=0.000000)
         FadeInEndTime=1.000000
         MaxParticles=4
         StartLocationOffset=(X=10.000000)
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=20.000000,Max=60.000000)
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=3.000000,Max=5.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.500000)
         StartSizeRange=(X=(Min=40.000000,Max=80.000000))
         InitialParticlesPerSecond=1050.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'da2effects2.EmitterTextures.Part_explode2'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.050000,Max=0.250000)
         StartVelocityRadialRange=(Min=10.000000,Max=10.000000)
         MaxAbsVelocity=(X=1.000000,Y=1.000000,Z=1.000000)
         VelocityLossRange=(X=(Min=-500.000000,Max=500.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Min=-50.000000,Max=50.000000))
         VelocityScale(0)=(RelativeTime=1.000000,RelativeVelocity=(X=0.200000,Y=0.200000,Z=0.200000))
     End Object
     Emitters(0)=SpriteEmitter'DA2.da_effects_HGExplosion.SpriteEmitter121'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter122
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         AlphaTest=False
         UseRevolution=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         UseRandomSubdivision=True
         Acceleration=(Z=-300.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.800000,Max=0.800000),Z=(Min=0.500000,Max=0.600000))
         FadeOutFactor=(X=0.000000,Y=0.000000,Z=0.000000)
         FadeOutStartTime=0.300000
         FadeInFactor=(W=0.000000,X=0.000000,Y=0.000000,Z=0.000000)
         FadeInEndTime=1.000000
         MaxParticles=6
         StartLocationOffset=(X=20.000000)
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=20.000000,Max=40.000000)
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=7.000000,Max=11.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=0.750000,RelativeSize=0.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.200000)
         StartSizeRange=(X=(Min=10.000000,Max=60.000000))
         InitialParticlesPerSecond=1000.000000
         Texture=Texture'da2effects2.EmitterTextures.MuzParticleTex'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.050000,Max=0.250000)
         StartVelocityRadialRange=(Min=10.000000,Max=10.000000)
         MaxAbsVelocity=(X=1.000000,Y=1.000000,Z=1.000000)
         VelocityLossRange=(X=(Min=-500.000000,Max=500.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Min=-50.000000,Max=50.000000))
         VelocityScale(0)=(RelativeTime=1.000000,RelativeVelocity=(X=0.200000,Y=0.200000,Z=0.200000))
     End Object
     Emitters(1)=SpriteEmitter'DA2.da_effects_HGExplosion.SpriteEmitter122'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter123
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
         ColorScale(0)=(Color=(B=33,G=39,R=97,A=128))
         ColorScale(1)=(RelativeTime=0.075000,Color=(B=30,G=30,R=30,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=45,G=45,R=45))
         Opacity=0.800000
         MaxParticles=8
         StartLocationOffset=(X=-5.000000)
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=30.000000,Max=40.000000)
         RevolutionsPerSecondRange=(X=(Max=0.050000))
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Max=0.200000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.400000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=0.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=40.000000,Max=120.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         InitialParticlesPerSecond=150.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'DA2Effects.Weapon.SmokePanels2'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=1.000000)
         StartVelocityRange=(X=(Max=220.000000),Y=(Min=-180.000000,Max=180.000000),Z=(Min=-180.000000,Max=180.000000))
         StartVelocityRadialRange=(Min=200.000000,Max=200.000000)
         VelocityLossRange=(X=(Max=8.000000),Y=(Max=8.000000),Z=(Max=8.000000))
     End Object
     Emitters(2)=SpriteEmitter'DA2.da_effects_HGExplosion.SpriteEmitter123'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter124
         UseColorScale=True
         RespawnDeadParticles=False
         AutoDestroy=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ColorScale(1)=(RelativeTime=0.150000,Color=(B=186,G=237,R=252))
         ColorScale(2)=(RelativeTime=0.725000,Color=(B=2,G=80,R=208))
         ColorScale(3)=(RelativeTime=1.000000)
         Opacity=0.750000
         MaxParticles=1
         StartLocationOffset=(X=15.000000)
         SpinsPerSecondRange=(X=(Min=1.000000,Max=1.000000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.750000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=1.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.200000)
         StartSizeRange=(X=(Min=250.000000,Max=300.000000))
         InitialParticlesPerSecond=2000.000000
         Texture=Texture'da2effects2.EmitterTextures.hardspot'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.200000,Max=0.300000)
     End Object
     Emitters(3)=SpriteEmitter'DA2.da_effects_HGExplosion.SpriteEmitter124'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter125
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=180,G=190,R=255))
         ColorScale(1)=(RelativeTime=1.000000)
         MaxParticles=2
         StartLocationOffset=(X=15.000000)
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=10.000000,Max=30.000000)
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=7.000000)
         StartSizeRange=(X=(Min=30.000000,Max=40.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'DA2Effects.Blast_4Frame'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=0.200000,Max=0.300000)
     End Object
     Emitters(4)=SpriteEmitter'DA2.da_effects_HGExplosion.SpriteEmitter125'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter126
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-400.000000)
         ColorScale(0)=(Color=(B=221,G=236,R=251,A=255))
         ColorScale(1)=(RelativeTime=0.178571,Color=(B=123,G=170,R=249,A=255))
         ColorScale(2)=(RelativeTime=0.696429,Color=(B=4,G=34,R=123,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(A=255))
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
         Texture=Texture'da2effects2.EmitterTextures.burnflare'
         TextureUSubdivisions=1
         TextureVSubdivisions=1
         LifetimeRange=(Min=0.500000,Max=1.400000)
         StartVelocityRange=(X=(Min=300.000000,Max=800.000000),Y=(Min=-600.000000,Max=600.000000),Z=(Min=-600.000000,Max=600.000000))
         VelocityLossRange=(X=(Min=2.000000,Max=2.000000),Y=(Min=2.000000,Max=2.000000),Z=(Min=2.000000,Max=2.000000))
     End Object
     Emitters(5)=SpriteEmitter'DA2.da_effects_HGExplosion.SpriteEmitter126'

     AutoDestroy=True
     LightType=LT_Steady
     LightEffect=LE_NonIncidence
     LightHue=13
     LightSaturation=120
     LightBrightness=260.000000
     LightRadius=16.000000
     bNoDelete=False
     bDynamicLight=True
}
