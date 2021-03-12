class da_effects_NuclearGrenadeFX extends Emitter;

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
         Acceleration=(Z=-500.000000)
         ExtentMultiplier=(X=0.060000,Y=0.060000,Z=0.060000)
         DampingFactorRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         ColorScale(1)=(RelativeTime=0.150000,Color=(B=186,G=237,R=252))
         ColorScale(2)=(RelativeTime=0.696429,Color=(B=66,G=129,R=213))
         ColorScale(3)=(RelativeTime=1.000000)
         MaxParticles=24
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
         StartVelocityRange=(X=(Min=-200.000000,Max=200.000000),Y=(Min=-200.000000,Max=200.000000),Z=(Min=-200.000000,Max=200.000000))
     End Object
     Emitters(0)=SpriteEmitter'DA2.da_effects_NuclearGrenadeFX.SpriteEmitter0'

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
     Emitters(1)=SpriteEmitter'DA2.da_effects_NuclearGrenadeFX.SpriteEmitter122'

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
     Emitters(2)=SpriteEmitter'DA2.da_effects_NuclearGrenadeFX.SpriteEmitter123'

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
     Emitters(3)=SpriteEmitter'DA2.da_effects_NuclearGrenadeFX.SpriteEmitter124'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
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
         StartSizeRange=(X=(Min=72.000000,Max=96.000000),Y=(Min=240.000000,Max=240.000000),Z=(Min=240.000000,Max=240.000000))
         InitialParticlesPerSecond=4368.000000
         Texture=Texture'DA2Effects.Blast_4Frame'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=0.228938,Max=0.343407)
     End Object
     Emitters(4)=SpriteEmitter'DA2.da_effects_NuclearGrenadeFX.SpriteEmitter4'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
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
         MaxParticles=16
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
     Emitters(5)=SpriteEmitter'DA2.da_effects_NuclearGrenadeFX.SpriteEmitter5'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter6
         UseColorScale=True
         RespawnDeadParticles=False
         AutoDestroy=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ColorScale(1)=(RelativeTime=0.075000,Color=(B=255,G=255,R=255))
         ColorScale(2)=(RelativeTime=0.725000,Color=(B=70,G=160,R=255))
         ColorScale(3)=(RelativeTime=1.000000)
         MaxParticles=2
         StartLocationOffset=(X=15.000000)
         SpinsPerSecondRange=(X=(Min=2.830000,Max=2.830000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.800000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=2.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.100000)
         StartSizeRange=(X=(Min=240.000000,Max=480.000000),Y=(Min=120.000000,Max=120.000000),Z=(Min=120.000000,Max=120.000000))
         InitialParticlesPerSecond=565.950012
         Texture=Texture'da2effects2.EmitterTextures.BrightFlareTex'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.530083,Max=2.120329)
     End Object
     Emitters(6)=SpriteEmitter'DA2.da_effects_NuclearGrenadeFX.SpriteEmitter6'

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
         Acceleration=(Z=460.800049)
         ColorScale(0)=(Color=(B=134,G=181,R=251))
         ColorScale(1)=(RelativeTime=0.075000,Color=(B=255,G=255,R=255,A=200))
         ColorScale(2)=(RelativeTime=0.300000,Color=(B=184,G=211,R=239,A=255))
         ColorScale(3)=(RelativeTime=0.439286,Color=(B=61,G=94,R=163,A=255))
         ColorScale(4)=(RelativeTime=0.646429,Color=(B=26,G=31,R=94,A=255))
         ColorScale(5)=(RelativeTime=1.000000,Color=(B=21,G=22,R=30))
         FadeOutFactor=(X=0.000000,Y=0.000000,Z=0.000000)
         FadeOutStartTime=1.683502
         FadeInFactor=(W=0.000000,X=0.000000,Y=0.000000,Z=0.000000)
         StartLocationRange=(X=(Min=-150.000000,Max=150.000000),Y=(Min=-150.000000,Max=150.000000),Z=(Min=-75.000000,Max=75.000000))
         StartLocationShape=PTLS_Polar
         SphereRadiusRange=(Min=400.000000,Max=400.000000)
         StartLocationPolarRange=(X=(Max=65340.000000),Y=(Min=700.000000,Max=1000.000000),Z=(Max=80.000000))
         SpinsPerSecondRange=(X=(Min=-0.148000,Max=0.148000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.400000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=0.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=40.000000,Max=60.000000),Y=(Min=50.000000,Max=50.000000),Z=(Min=50.000000,Max=50.000000))
         InitialParticlesPerSecond=1559.250000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'da2effects2.EmitterTextures.ExploParticleTex'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.020202,Max=2.424242)
         StartVelocityRange=(X=(Max=9.900001),Y=(Max=19.800001))
         StartVelocityRadialRange=(Min=-1000.000000,Max=-1000.000000)
         MaxAbsVelocity=(Z=780.000061)
         VelocityLossRange=(X=(Min=4.455000,Max=4.455000),Y=(Min=4.455000,Max=4.455000),Z=(Min=4.455000,Max=4.455000))
         GetVelocityDirectionFrom=PTVD_AddRadial
         VelocityScale(0)=(RelativeTime=1.000000,RelativeVelocity=(X=0.200000,Y=0.200000,Z=0.200000))
     End Object
     Emitters(7)=SpriteEmitter'DA2.da_effects_NuclearGrenadeFX.SpriteEmitter7'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter8
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
         Acceleration=(Z=460.800049)
         ColorScale(0)=(Color=(B=134,G=181,R=251))
         ColorScale(1)=(RelativeTime=0.075000,Color=(B=250,G=252,R=254,A=200))
         ColorScale(2)=(RelativeTime=0.346429,Color=(B=198,G=220,R=242,A=255))
         ColorScale(3)=(RelativeTime=0.646429,Color=(B=48,G=73,R=173,A=255))
         ColorScale(4)=(RelativeTime=0.750000,Color=(B=23,G=28,R=104,A=255))
         ColorScale(5)=(RelativeTime=1.000000,Color=(B=21,G=22,R=30))
         FadeOutFactor=(X=0.000000,Y=0.000000,Z=0.000000)
         FadeOutStartTime=1.683502
         FadeInFactor=(W=0.000000,X=0.000000,Y=0.000000,Z=0.000000)
         MaxParticles=30
         StartLocationRange=(X=(Min=-450.006989,Max=450.006989),Y=(Min=-450.006989,Max=450.006989),Z=(Min=-75.000999,Max=75.000999))
         StartLocationShape=PTLS_Polar
         SphereRadiusRange=(Min=400.000000,Max=400.000000)
         StartLocationPolarRange=(X=(Max=65340.000000),Y=(Min=2500.000000,Max=3500.000000),Z=(Min=10.000000,Max=10.000000))
         AlphaRef=3
         SpinsPerSecondRange=(X=(Min=-0.248000,Max=0.248000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.400000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=0.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=30.000465,Max=60.000931),Y=(Min=60.000931,Max=60.000931),Z=(Min=60.000931,Max=60.000931))
         InitialParticlesPerSecond=1559.250000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'da2effects2.EmitterTextures.ExploParticleTex'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.010102,Max=2.525253)
         StartVelocityRange=(X=(Max=9.900154),Y=(Max=19.800308))
         StartVelocityRadialRange=(Min=-1000.000000,Max=-1000.000000)
         MaxAbsVelocity=(Z=720.000000)
         VelocityLossRange=(X=(Min=4.455000,Max=4.455000),Y=(Min=4.455000,Max=4.455000),Z=(Min=4.455000,Max=4.455000))
         GetVelocityDirectionFrom=PTVD_AddRadial
         VelocityScale(0)=(RelativeTime=1.000000,RelativeVelocity=(X=0.200000,Y=0.200000,Z=0.200000))
     End Object
     Emitters(8)=SpriteEmitter'DA2.da_effects_NuclearGrenadeFX.SpriteEmitter8'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter9
         UseColorScale=True
         RespawnDeadParticles=False
         AutoDestroy=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=619.200073)
         ColorScale(1)=(RelativeTime=0.075000,Color=(B=186,G=237,R=252))
         ColorScale(2)=(RelativeTime=0.696429,Color=(B=2,G=92,R=242))
         ColorScale(3)=(RelativeTime=1.000000)
         MaxParticles=1
         StartLocationOffset=(X=15.000000)
         SpinsPerSecondRange=(X=(Min=0.148000,Max=0.148000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.800000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=2.200000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.300000)
         StartSizeRange=(X=(Min=150.000000,Max=150.000000),Y=(Min=15.000000,Max=15.000000),Z=(Min=15.000000,Max=15.000000))
         InitialParticlesPerSecond=2970.000000
         Texture=Texture'da2effects2.EmitterTextures.BrightFlareTex'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.666667,Max=2.000000)
         StartVelocityRange=(Z=(Max=540.000000))
         VelocityLossRange=(X=(Min=4.800000,Max=4.800000),Y=(Min=4.800000,Max=4.800000),Z=(Min=4.800000,Max=4.800000))
     End Object
     Emitters(9)=SpriteEmitter'DA2.da_effects_NuclearGrenadeFX.SpriteEmitter9'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter10
         UseSpawnedVelocityScale=True
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
         Acceleration=(Z=6800.000000)
         SpawnFromOtherEmitter=9
         SpawnAmount=1
         SpawnedVelocityScaleRange=(Z=(Max=200.000000))
         ColorScale(1)=(RelativeTime=0.200000,Color=(B=255,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.696429,Color=(B=143,G=156,R=184,A=255))
         ColorScale(3)=(RelativeTime=0.896429,Color=(B=67,G=72,R=135,A=200))
         ColorScale(4)=(RelativeTime=1.000000)
         FadeOutFactor=(X=0.000000,Y=0.000000,Z=0.000000)
         FadeOutStartTime=0.740741
         FadeInFactor=(W=0.000000,X=0.000000,Y=0.000000,Z=0.000000)
         MaxParticles=40
         StartLocationOffset=(Z=-800.000000)
         StartLocationRange=(X=(Min=-1200.000000,Max=1200.000000),Y=(Min=-1200.000000,Max=1200.000000))
         StartLocationShape=PTLS_Polar
         SphereRadiusRange=(Min=400.000000,Max=400.000000)
         StartLocationPolarRange=(X=(Max=65530.000000),Y=(Min=850.000000,Max=850.000000),Z=(Min=900.000000,Max=900.000000))
         SpinsPerSecondRange=(X=(Min=-0.676000,Max=0.676000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.800000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=1.200000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.600000)
         StartSizeRange=(X=(Min=25.000000,Max=30.000000),Y=(Min=6.000000,Max=9.000000),Z=(Min=6.000000,Max=9.000000))
         ScaleSizeByVelocityMultiplier=(Y=0.005000)
         InitialParticlesPerSecond=270.000000
         Texture=Texture'da2effects2.EmitterTextures.FlameParticleTex'
         TextureUSubdivisions=1
         TextureVSubdivisions=1
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=1.200000)
         InitialDelayRange=(Min=0.100000,Max=0.100000)
         StartVelocityRange=(Z=(Min=-1200.000000))
         VelocityLossRange=(X=(Min=48.000000,Max=48.000000),Y=(Min=48.000000,Max=48.000000),Z=(Min=48.000000,Max=48.000000))
         AddVelocityMultiplierRange=(Z=(Min=2.000000,Max=2.000000))
         GetVelocityDirectionFrom=PTVD_AddRadial
         VelocityScale(0)=(RelativeTime=1.000000,RelativeVelocity=(X=0.200000,Y=0.200000,Z=0.200000))
     End Object
     Emitters(10)=SpriteEmitter'DA2.da_effects_NuclearGrenadeFX.SpriteEmitter10'

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