class da_effects_PlasmaDud extends Emitter;

simulated function PostBeginPlay()
{
	setTimer(0.15, false);
}

simulated function Timer()
{
  bDynamicLight=false;
  super.Timer();
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter10
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
         Acceleration=(Z=-450.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutFactor=(X=0.000000,Y=0.000000,Z=0.000000)
         FadeOutStartTime=0.300000
         FadeInFactor=(W=0.000000,X=0.000000,Y=0.000000,Z=0.000000)
         FadeInEndTime=1.000000
         MaxParticles=20
         StartLocationOffset=(X=20.000000)
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=20.000000,Max=50.000000)
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=7.000000,Max=11.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=0.750000,RelativeSize=0.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.200000)
         StartSizeRange=(X=(Min=15.000000,Max=75.000000),Y=(Min=150.000000,Max=150.000000),Z=(Min=150.000000,Max=150.000000))
         InitialParticlesPerSecond=40.000000
         Texture=Texture'da2effects2.EmitterTextures.PlasmaParticleTex'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.050000,Max=0.250000)
         StartVelocityRadialRange=(Min=10.000000,Max=10.000000)
         MaxAbsVelocity=(X=1.000000,Y=1.000000,Z=1.000000)
         VelocityLossRange=(X=(Min=-500.000000,Max=500.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Min=-50.000000,Max=50.000000))
         VelocityScale(0)=(RelativeTime=1.000000,RelativeVelocity=(X=0.200000,Y=0.200000,Z=0.200000))
     End Object
     Emitters(0)=SpriteEmitter'DA2.da_effects_PlasmaDud.SpriteEmitter10'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter11
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
         Acceleration=(Z=120.000000)
         ColorScale(0)=(Color=(B=217,G=241,R=255,A=32))
         ColorScale(1)=(RelativeTime=1.000000)
         StartLocationOffset=(X=20.000000)
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=10.000000,Max=40.000000)
         RevolutionsPerSecondRange=(X=(Max=0.050000))
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=0.100000,Max=0.250000))
         StartSpinRange=(X=(Min=-0.100000,Max=0.100000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=0.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=60.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         InitialParticlesPerSecond=60.000000
         Texture=Texture'da2effects2.EmitterTextures.PlasmaParticleTex'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.400000,Max=1.200000)
         StartVelocityRange=(X=(Min=100.000000,Max=200.000000),Y=(Min=-300.000000,Max=300.000000),Z=(Min=-300.000000,Max=300.000000))
         StartVelocityRadialRange=(Min=200.000000,Max=200.000000)
         VelocityLossRange=(X=(Min=1.000000,Max=2.000000),Y=(Min=1.000000,Max=2.000000),Z=(Min=1.000000,Max=2.000000))
     End Object
     Emitters(1)=SpriteEmitter'DA2.da_effects_PlasmaDud.SpriteEmitter11'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter12
         UseColorScale=True
         RespawnDeadParticles=False
         AutoDestroy=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ColorScale(1)=(RelativeTime=0.150000,Color=(B=254,G=184,R=187))
         ColorScale(2)=(RelativeTime=0.896429,Color=(B=51,G=56,R=159))
         ColorScale(3)=(RelativeTime=1.000000)
         Opacity=0.700000
         MaxParticles=1
         StartLocationOffset=(X=15.000000)
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=1.000000,Max=1.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.750000)
         SizeScale(1)=(RelativeTime=0.070000,RelativeSize=1.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.300000)
         StartSizeRange=(X=(Min=320.000000,Max=320.000000),Y=(Min=150.000000,Max=150.000000),Z=(Min=150.000000,Max=150.000000))
         InitialParticlesPerSecond=2000.000000
         Texture=None
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.750000,Max=0.750000)
     End Object
     Emitters(2)=SpriteEmitter'DA2.da_effects_PlasmaDud.SpriteEmitter12'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter15
         UseColorScale=True
         RespawnDeadParticles=False
         AutoDestroy=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ColorScale(1)=(RelativeTime=0.150000,Color=(B=254,G=184,R=184))
         ColorScale(2)=(RelativeTime=0.896429,Color=(B=111,G=121,R=215))
         ColorScale(3)=(RelativeTime=1.000000)
         MaxParticles=2
         StartLocationOffset=(X=15.000000)
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=5.000000,Max=5.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=1.200000)
         SizeScale(2)=(RelativeTime=0.370000,RelativeSize=0.800000)
         SizeScale(3)=(RelativeTime=0.560000,RelativeSize=1.500000)
         SizeScale(4)=(RelativeTime=0.750000,RelativeSize=1.000000)
         SizeScale(5)=(RelativeTime=1.000000,RelativeSize=0.600000)
         SizeScaleRepeats=40.000000
         StartSizeRange=(X=(Min=150.000000,Max=150.000000),Y=(Min=150.000000,Max=150.000000),Z=(Min=150.000000,Max=150.000000))
         InitialParticlesPerSecond=2000.000000
         Texture=Texture'da2effects2.EmitterTextures.plasmastar'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.800000,Max=0.900000)
     End Object
     Emitters(3)=SpriteEmitter'DA2.da_effects_PlasmaDud.SpriteEmitter15'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter17
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
         Acceleration=(Z=300.000000)
         ColorScale(0)=(Color=(A=255))
         ColorScale(1)=(RelativeTime=0.200000,Color=(B=255,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.696429,Color=(B=102,G=122,R=153,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(A=255))
         FadeOutFactor=(X=0.000000,Y=0.000000,Z=0.000000)
         FadeOutStartTime=0.300000
         FadeInFactor=(W=0.000000,X=0.000000,Y=0.000000,Z=0.000000)
         FadeInEndTime=1.000000
         MaxParticles=0
         StartLocationRange=(X=(Min=-15.000000,Max=15.000000),Y=(Min=-45.000000,Max=45.000000),Z=(Min=-45.000000,Max=45.000000))
         SphereRadiusRange=(Min=10.000000,Max=40.000000)
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=0.300000,Max=0.500000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=0.750000,RelativeSize=0.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=40.000000,Max=120.000000),Y=(Min=150.000000,Max=150.000000),Z=(Min=150.000000,Max=150.000000))
         InitialParticlesPerSecond=40.000000
         Texture=Texture'da2effects2.EmitterTextures.FlameParticleTex'
         TextureUSubdivisions=1
         TextureVSubdivisions=1
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.600000,Max=0.800000)
         StartVelocityRange=(X=(Max=30.000000),Y=(Min=-450.000000,Max=450.000000),Z=(Min=-450.000000,Max=450.000000))
         StartVelocityRadialRange=(Min=10.000000,Max=10.000000)
         VelocityLossRange=(X=(Min=2.000000,Max=3.000000),Y=(Min=2.000000,Max=3.000000),Z=(Min=2.000000,Max=3.000000))
         VelocityScale(0)=(RelativeTime=1.000000,RelativeVelocity=(X=0.200000,Y=0.200000,Z=0.200000))
     End Object
     Emitters(4)=SpriteEmitter'DA2.da_effects_PlasmaDud.SpriteEmitter17'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter18
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
         Acceleration=(Z=-300.000000)
         ExtentMultiplier=(X=0.060000,Y=0.060000,Z=0.060000)
         DampingFactorRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         ColorScale(1)=(RelativeTime=0.100000,Color=(B=253,G=191,R=185))
         ColorScale(2)=(RelativeTime=0.400000,Color=(B=70,G=115,R=208))
         ColorScale(3)=(RelativeTime=1.000000)
         MaxParticles=8
         StartLocationOffset=(X=20.000000)
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=2.000000,Max=2.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.600000)
         StartSizeRange=(X=(Min=20.000000))
         InitialParticlesPerSecond=60.000000
         Texture=Texture'da2effects2.EmitterTextures.BrightFlareTex'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.500000,Max=5.000000)
         StartVelocityRange=(X=(Min=75.000000,Max=120.000000),Y=(Min=-75.000000,Max=75.000000),Z=(Min=-75.000000,Max=75.000000))
     End Object
     Emitters(5)=SpriteEmitter'DA2.da_effects_PlasmaDud.SpriteEmitter18'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter19
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-500.000000)
         ColorScale(0)=(Color=(B=253,G=219,R=221,A=255))
         ColorScale(1)=(RelativeTime=0.896429,Color=(B=31,G=44,R=97,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(A=255))
         FadeOutStartTime=0.133333
         MaxParticles=20
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Max=20.000000)
         AlphaRef=2
         UseRotationFrom=PTRS_Actor
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000)
         SizeScaleRepeats=1.000000
         StartSizeRange=(X=(Min=6.000000,Max=8.000000),Y=(Min=10.000000,Max=15.000000),Z=(Min=10.000000,Max=15.000000))
         InitialParticlesPerSecond=60.000000
         Texture=Texture'da2effects2.EmitterTextures.SparkGlowTex'
         TextureUSubdivisions=1
         TextureVSubdivisions=1
         LifetimeRange=(Min=0.300000,Max=0.900000)
         StartVelocityRange=(X=(Min=300.000000,Max=400.000000),Y=(Min=-600.000000,Max=600.000000),Z=(Min=-600.000000,Max=600.000000))
         VelocityLossRange=(X=(Min=2.000000,Max=2.000000),Y=(Min=2.000000,Max=2.000000),Z=(Min=2.000000,Max=2.000000))
     End Object
     Emitters(6)=SpriteEmitter'DA2.da_effects_PlasmaDud.SpriteEmitter19'

     AutoDestroy=True
     LightType=LT_Steady
     LightEffect=LE_NonIncidence
     LightHue=245
     LightSaturation=160
     LightBrightness=220.000000
     LightRadius=24.000000
     bNoDelete=False
     bDynamicLight=True
}
