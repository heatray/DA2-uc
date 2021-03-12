class da_effects_NuclearRocketExplosion extends Emitter;

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
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseCollision=True
         UseColorScale=True
         RespawnDeadParticles=False
         AutoDestroy=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-700.000000)
         ExtentMultiplier=(X=0.060000,Y=0.060000,Z=0.060000)
         DampingFactorRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         ColorScale(1)=(RelativeTime=0.150000,Color=(B=186,G=237,R=252))
         ColorScale(2)=(RelativeTime=0.696429,Color=(B=66,G=129,R=213))
         ColorScale(3)=(RelativeTime=1.000000)
         MaxParticles=12
         StartLocationOffset=(X=20.000000)
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=2.000000,Max=2.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.600000)
         StartSizeRange=(X=(Min=15.000000,Max=75.000000))
         InitialParticlesPerSecond=60.000000
         Texture=Texture'da2effects2.EmitterTextures.BrightFlareTex'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000)
         StartVelocityRange=(X=(Min=-300.000000,Max=300.000000),Y=(Min=-300.000000,Max=300.000000),Z=(Min=-300.000000,Max=300.000000))
         StartVelocityRadialRange=(Min=-1000.000000)
     End Object
     Emitters(0)=SpriteEmitter'DA2.da_effects_NuclearRocketExplosion.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter122
         UseColorScale=True
         FadeOut=True
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
         Acceleration=(Z=100.000000)
         ColorScale(0)=(Color=(B=165,G=207,R=235,A=128))
         ColorScale(1)=(RelativeTime=0.107143,Color=(B=255,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.317857,Color=(B=209,G=224,R=250,A=255))
         ColorScale(3)=(RelativeTime=0.560714,Color=(B=36,G=41,R=74,A=255))
         ColorScale(4)=(RelativeTime=0.721429,Color=(A=255))
         ColorScale(5)=(RelativeTime=1.000000,Color=(B=253,G=253,R=253))
         MaxParticles=12
         StartLocationOffset=(Z=50.000000)
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=20.000000,Max=20.000000)
         StartLocationPolarRange=(X=(Min=-1000.000000,Max=1000.000000),Y=(Min=-1000.000000,Max=1000.000000),Z=(Max=10.000000))
         RevolutionsPerSecondRange=(X=(Max=0.050000))
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Max=0.160000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.400000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=0.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=80.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         InitialParticlesPerSecond=120.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'da2effects2.EmitterTextures.ExploParticleTex'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=1.000000,Max=3.000000)
         StartVelocityRange=(Z=(Max=100.000000))
         StartVelocityRadialRange=(Min=-700.000000,Max=-700.000000)
         MaxAbsVelocity=(Z=300.000000)
         VelocityLossRange=(X=(Max=6.400000),Y=(Max=6.400000),Z=(Max=6.400000))
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(1)=SpriteEmitter'DA2.da_effects_NuclearRocketExplosion.SpriteEmitter122'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter123
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
         SpinsPerSecondRange=(X=(Min=0.800000,Max=0.800000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.750000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=1.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.200000)
         StartSizeRange=(X=(Min=500.000000,Max=600.000000),Y=(Min=200.000000,Max=200.000000),Z=(Min=200.000000,Max=200.000000))
         InitialParticlesPerSecond=1600.000000
         Texture=Texture'da2effects2.EmitterTextures.hardspot'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.250000,Max=0.375000)
     End Object
     Emitters(2)=SpriteEmitter'DA2.da_effects_NuclearRocketExplosion.SpriteEmitter123'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter124
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
         StartSizeRange=(X=(Min=57.600002,Max=76.800003),Y=(Min=192.000000,Max=192.000000),Z=(Min=192.000000,Max=192.000000))
         InitialParticlesPerSecond=3057.600098
         Texture=Texture'DA2Effects.Blast_4Frame'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=0.327054,Max=0.490581)
     End Object
     Emitters(3)=SpriteEmitter'DA2.da_effects_NuclearRocketExplosion.SpriteEmitter124'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-512.000000)
         ColorScale(0)=(Color=(B=221,G=236,R=251,A=255))
         ColorScale(1)=(RelativeTime=0.171429,Color=(B=123,G=170,R=249,A=255))
         ColorScale(2)=(RelativeTime=0.696429,Color=(B=4,G=34,R=123,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(A=255))
         FadeOutStartTime=2.250000
         MaxParticles=40
         StartLocationRange=(X=(Min=20.000000,Max=20.000000),Y=(Min=20.000000,Max=20.000000),Z=(Min=20.000000,Max=20.000000))
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Max=10.000000)
         AlphaRef=2
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-0.800000,Max=0.800000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000)
         SizeScaleRepeats=1.000000
         StartSizeRange=(X=(Min=6.000000,Max=20.000000),Y=(Min=120.000000,Max=120.000000),Z=(Min=120.000000,Max=120.000000))
         InitialParticlesPerSecond=400.000000
         Texture=Texture'da2effects2.EmitterTextures.burnflare'
         TextureUSubdivisions=1
         TextureVSubdivisions=1
         LifetimeRange=(Min=0.625000,Max=1.750000)
         StartVelocityRange=(X=(Min=-480.000000,Max=480.000000),Y=(Min=-480.000000,Max=480.000000),Z=(Max=1200.000000))
         VelocityLossRange=(X=(Min=1.600000,Max=1.600000),Y=(Min=1.600000,Max=1.600000),Z=(Min=1.600000,Max=1.600000))
     End Object
     Emitters(4)=SpriteEmitter'DA2.da_effects_NuclearRocketExplosion.SpriteEmitter4'

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
