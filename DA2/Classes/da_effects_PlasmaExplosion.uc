class da_effects_PlasmaExplosion extends Emitter;

var float LightEnd;

simulated function PostBeginPlay()
{
	LightEnd=level.timeseconds+3.5;
	Settimer(0.1, true);
}

simulated function timer()
{
    if(LightBrightness>0)
        LightBrightness=fmax(0,default.lightbrightness*(lightend-level.timeseconds)/3.5);
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseColorScale=True
         RespawnDeadParticles=False
         AlphaTest=False
         UseRevolution=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         Acceleration=(Z=100.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.750000,Color=(B=255,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(A=255))
         ColorMultiplierRange=(Y=(Min=0.850000),Z=(Min=0.850000))
         FadeOutFactor=(X=0.000000,Y=0.000000,Z=0.000000)
         FadeOutStartTime=0.400000
         FadeInFactor=(W=0.000000,X=0.000000,Y=0.000000,Z=0.000000)
         MaxParticles=20
         StartLocationRange=(Y=(Min=-75.000000,Max=75.000000),Z=(Min=-75.000000,Max=75.000000))
         SphereRadiusRange=(Max=100.000000)
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=0.100000,Max=0.500000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.300000)
         SizeScale(1)=(RelativeTime=0.560000,RelativeSize=0.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=40.000000,Max=120.000000),Y=(Min=200.000000,Max=200.000000),Z=(Min=200.000000,Max=200.000000))
         InitialParticlesPerSecond=12.000000
         Texture=Texture'da2effects2.EmitterTextures.PlasmaParticleTex'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.750000,Max=1.500000)
         StartVelocityRange=(X=(Min=250.000000,Max=250.000000))
         StartVelocityRadialRange=(Min=10.000000,Max=10.000000)
         VelocityLossRange=(X=(Min=2.000000,Max=2.000000),Y=(Min=2.000000,Max=2.000000),Z=(Min=2.000000,Max=2.000000))
         VelocityScale(0)=(RelativeTime=1.000000,RelativeVelocity=(X=0.200000,Y=0.200000,Z=0.200000))
     End Object
     Emitters(0)=SpriteEmitter'DA2.da_effects_PlasmaExplosion.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         RespawnDeadParticles=False
         UseRevolution=True
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         UseVelocityScale=True
         Acceleration=(Z=10.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=128))
         ColorScale(1)=(RelativeTime=0.400000,Color=(B=129,G=132,R=143,A=255))
         ColorScale(2)=(RelativeTime=1.000000)
         ColorMultiplierRange=(Y=(Min=0.750000),Z=(Min=0.750000))
         MaxParticles=30
         StartLocationOffset=(X=2.000000)
         StartLocationRange=(X=(Max=1.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Min=-50.000000,Max=50.000000))
         SphereRadiusRange=(Min=30.000000,Max=40.000000)
         StartLocationPolarRange=(X=(Min=-10000.000000,Max=10000.000000),Y=(Min=-1000.000000,Max=1000.000000),Z=(Min=-1000.000000,Max=1000.000000))
         RevolutionsPerSecondRange=(X=(Max=0.050000))
         UseRotationFrom=PTRS_Actor
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Max=150.000000),Y=(Min=200.000000,Max=300.000000),Z=(Min=0.000000,Max=0.000000))
         InitialParticlesPerSecond=2000.000000
         Texture=Texture'da2effects2.EmitterTextures.PlasmaParticleTex'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.500000,Max=0.800000)
         StartVelocityRadialRange=(Min=-1800.000000,Max=-1800.000000)
         VelocityLossRange=(X=(Min=4.000000,Max=4.000000),Y=(Min=4.000000,Max=4.000000),Z=(Min=4.000000,Max=4.000000))
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(1)=SpriteEmitter'DA2.da_effects_PlasmaExplosion.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
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
         ColorScale(2)=(RelativeTime=0.500000,Color=(B=255,G=255,R=255,A=255))
         ColorScale(3)=(RelativeTime=1.000000)
         Opacity=0.750000
         MaxParticles=3
         StartLocationOffset=(X=15.000000)
         SpinsPerSecondRange=(X=(Min=1.000000,Max=1.000000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=0.070000,RelativeSize=1.500000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.500000)
         StartSizeRange=(X=(Min=400.000000,Max=800.000000))
         InitialParticlesPerSecond=2000.000000
         Texture=Texture'da2effects2.EmitterTextures.FlashStreakTex'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.200000,Max=0.300000)
     End Object
     Emitters(2)=SpriteEmitter'DA2.da_effects_PlasmaExplosion.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=255,G=255,R=255))
         ColorScale(1)=(RelativeTime=0.600000,Color=(B=129,G=132,R=143,A=255))
         ColorScale(2)=(RelativeTime=1.000000)
         MaxParticles=16
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Max=50.000000)
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=0.100000,Max=0.200000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.050000)
         SizeScale(1)=(RelativeTime=0.280000,RelativeSize=0.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=75.000000,Max=150.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'da2effects2.EmitterTextures.PlasmaParticleTex'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=1.500000,Max=2.500000)
         StartVelocityRange=(X=(Min=600.000000,Max=1000.000000),Y=(Min=-500.000000,Max=500.000000),Z=(Min=-500.000000,Max=500.000000))
         VelocityLossRange=(X=(Min=3.000000,Max=3.000000),Y=(Min=3.000000,Max=3.000000),Z=(Min=3.000000,Max=3.000000))
     End Object
     Emitters(3)=SpriteEmitter'DA2.da_effects_PlasmaExplosion.SpriteEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         UseColorScale=True
         RespawnDeadParticles=False
         AutoDestroy=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ColorScale(1)=(RelativeTime=0.150000,Color=(B=243,G=156,R=137))
         ColorScale(2)=(RelativeTime=0.800000,Color=(B=125,G=85,R=104))
         ColorScale(3)=(RelativeTime=1.000000)
         Opacity=0.900000
         MaxParticles=1
         StartLocationOffset=(X=15.000000)
         SpinsPerSecondRange=(X=(Min=0.500000,Max=1.500000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.750000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=1.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.200000)
         StartSizeRange=(X=(Min=600.000000,Max=700.000000))
         InitialParticlesPerSecond=2000.000000
         Texture=Texture'da2effects2.EmitterTextures.TriFlare'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.250000,Max=0.300000)
     End Object
     Emitters(4)=SpriteEmitter'DA2.da_effects_PlasmaExplosion.SpriteEmitter4'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         UseColorScale=True
         RespawnDeadParticles=False
         AutoDestroy=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ColorScale(1)=(RelativeTime=0.150000,Color=(B=253,G=232,R=213))
         ColorScale(2)=(RelativeTime=0.550000,Color=(B=72,G=79,R=138))
         ColorScale(3)=(RelativeTime=1.000000)
         MaxParticles=1
         StartLocationOffset=(X=15.000000)
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=1.000000,Max=1.000000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.750000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=1.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.900000)
         StartSizeRange=(X=(Min=400.000000,Max=400.000000))
         InitialParticlesPerSecond=2000.000000
         Texture=Texture'da2effects2.EmitterTextures.BrightFlareTex'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=900.000000,Max=900.000000))
         VelocityLossRange=(X=(Min=3.000000,Max=3.000000),Y=(Min=3.000000,Max=3.000000),Z=(Min=3.000000,Max=3.000000))
     End Object
     Emitters(5)=SpriteEmitter'DA2.da_effects_PlasmaExplosion.SpriteEmitter5'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter6
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         UseRandomSubdivision=True
         Acceleration=(Z=200.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255))
         ColorScale(1)=(RelativeTime=0.600000,Color=(B=129,G=132,R=143,A=255))
         ColorScale(2)=(RelativeTime=1.000000)
         MaxParticles=6
         StartLocationOffset=(X=-20.000000)
         StartLocationShape=PTLS_Sphere
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=0.100000,Max=0.250000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.050000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=0.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=75.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'da2effects2.EmitterTextures.PlasmaParticleTex'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=1.500000,Max=2.500000)
         StartVelocityRange=(X=(Max=600.000000),Y=(Min=-100.000000,Max=100.000000),Z=(Min=-100.000000,Max=100.000000))
         VelocityLossRange=(X=(Min=3.000000,Max=3.000000),Y=(Min=3.000000,Max=3.000000),Z=(Min=3.000000,Max=3.000000))
     End Object
     Emitters(6)=SpriteEmitter'DA2.da_effects_PlasmaExplosion.SpriteEmitter6'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter7
         UseColorScale=True
         RespawnDeadParticles=False
         AutoDestroy=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ColorScale(1)=(RelativeTime=0.100000,Color=(B=250,G=216,R=235))
         ColorScale(2)=(RelativeTime=0.550000,Color=(B=72,G=79,R=138))
         ColorScale(3)=(RelativeTime=1.000000)
         MaxParticles=1
         StartLocationOffset=(X=15.000000)
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=1.000000,Max=1.000000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=0.250000,RelativeSize=0.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.200000)
         StartSizeRange=(X=(Min=700.000000,Max=800.000000))
         InitialParticlesPerSecond=2000.000000
         Texture=Texture'da2effects2.EmitterTextures.BrightFlareTex'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=6.000000,Max=6.000000)
         VelocityLossRange=(X=(Min=3.000000,Max=3.000000),Y=(Min=3.000000,Max=3.000000),Z=(Min=3.000000,Max=3.000000))
     End Object
     Emitters(7)=SpriteEmitter'DA2.da_effects_PlasmaExplosion.SpriteEmitter7'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter8
         UseCollision=True
         UseColorScale=True
         RespawnDeadParticles=False
         AutoDestroy=True
         SpinParticles=True
         DampRotation=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-500.000000)
         ExtentMultiplier=(X=0.150000,Y=0.150000,Z=0.150000)
         DampingFactorRange=(X=(Min=0.300000,Max=0.300000),Y=(Min=0.300000,Max=0.300000),Z=(Min=0.300000,Max=0.300000))
         ColorScale(1)=(RelativeTime=0.100000,Color=(B=251,G=240,R=241,A=255))
         ColorScale(2)=(RelativeTime=0.750000,Color=(B=182,G=206,R=239,A=255))
         ColorScale(3)=(RelativeTime=1.000000)
         MaxParticles=15
         StartLocationOffset=(X=20.000000)
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Max=2.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         RotationDampingFactorRange=(X=(Min=0.200000,Max=0.200000),Y=(Min=0.200000,Max=0.200000),Z=(Min=0.200000,Max=0.200000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.600000)
         StartSizeRange=(X=(Min=15.000000,Max=50.000000))
         InitialParticlesPerSecond=1000.000000
         Texture=Texture'da2effects2.EmitterTextures.hardspot'
         TextureUSubdivisions=1
         TextureVSubdivisions=1
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=3.000000,Max=5.000000)
         StartVelocityRange=(X=(Min=400.000000,Max=600.000000),Y=(Min=-600.000000,Max=600.000000),Z=(Min=-600.000000,Max=600.000000))
         VelocityLossRange=(X=(Min=0.800000,Max=0.800000),Y=(Min=0.800000,Max=0.800000),Z=(Min=0.800000,Max=0.800000))
     End Object
     Emitters(8)=SpriteEmitter'DA2.da_effects_PlasmaExplosion.SpriteEmitter8'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter9
         UseCollision=True
         UseColorScale=True
         RespawnDeadParticles=False
         AutoDestroy=True
         SpinParticles=True
         DampRotation=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-300.000000)
         ExtentMultiplier=(X=0.100000,Y=0.100000,Z=0.100000)
         DampingFactorRange=(X=(Min=0.300000,Max=0.300000),Y=(Min=0.300000,Max=0.300000),Z=(Min=0.300000,Max=0.300000))
         ColorScale(1)=(RelativeTime=0.075000,Color=(B=249,G=240,R=240,A=255))
         ColorScale(2)=(RelativeTime=0.332143,Color=(B=223,G=203,R=231,A=255))
         ColorScale(3)=(RelativeTime=0.896429,Color=(B=181,G=198,R=238,A=255))
         ColorScale(4)=(RelativeTime=1.000000)
         MaxParticles=20
         StartLocationOffset=(X=10.000000)
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Max=2.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         RotationDampingFactorRange=(X=(Min=0.200000,Max=0.200000),Y=(Min=0.200000,Max=0.200000),Z=(Min=0.200000,Max=0.200000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.500000)
         StartSizeRange=(X=(Min=30.000000))
         InitialParticlesPerSecond=15.000000
         Texture=Texture'da2effects2.EmitterTextures.hardspot'
         TextureUSubdivisions=1
         TextureVSubdivisions=1
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=3.000000,Max=6.000000)
         StartVelocityRange=(X=(Min=150.000000,Max=350.000000),Y=(Min=-200.000000,Max=200.000000),Z=(Min=-200.000000,Max=200.000000))
         VelocityLossRange=(X=(Min=0.500000,Max=1.000000),Y=(Min=0.500000,Max=1.000000),Z=(Min=0.500000,Max=1.000000))
     End Object
     Emitters(9)=SpriteEmitter'DA2.da_effects_PlasmaExplosion.SpriteEmitter9'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter10
         UseColorScale=True
         RespawnDeadParticles=False
         AutoDestroy=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ColorScale(1)=(RelativeTime=0.150000,Color=(B=236,G=205,R=202))
         ColorScale(2)=(RelativeTime=0.850000,Color=(B=102,G=133,R=223))
         ColorScale(3)=(RelativeTime=1.000000)
         MaxParticles=2
         StartLocationOffset=(X=10.000000)
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=5.000000,Max=5.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=1.200000)
         SizeScale(2)=(RelativeTime=0.370000,RelativeSize=0.800000)
         SizeScale(3)=(RelativeTime=0.560000,RelativeSize=1.500000)
         SizeScale(4)=(RelativeTime=0.750000,RelativeSize=1.000000)
         SizeScale(5)=(RelativeTime=1.000000,RelativeSize=0.600000)
         SizeScaleRepeats=30.000000
         StartSizeRange=(X=(Min=240.000000,Max=280.000000))
         InitialParticlesPerSecond=2000.000000
         Texture=Texture'da2effects2.EmitterTextures.plasmastar'
         SecondsBeforeInactive=0.000000
     End Object
     Emitters(10)=SpriteEmitter'DA2.da_effects_PlasmaExplosion.SpriteEmitter10'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter11
         UseDirectionAs=PTDU_Forward
         UseColorScale=True
         RespawnDeadParticles=False
         AutoDestroy=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ColorScale(1)=(RelativeTime=0.100000,Color=(B=253,G=220,R=213))
         ColorScale(2)=(RelativeTime=0.550000,Color=(B=165,G=88,R=92))
         ColorScale(3)=(RelativeTime=1.000000)
         MaxParticles=3
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=1.000000,Max=1.000000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=700.000000,Max=800.000000))
         InitialParticlesPerSecond=2000.000000
         Texture=None
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.300000,Max=0.500000)
         StartVelocityRange=(X=(Min=5.000000,Max=10.000000))
     End Object
     Emitters(11)=SpriteEmitter'DA2.da_effects_PlasmaExplosion.SpriteEmitter11'

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
         ColorScale(1)=(RelativeTime=0.050000,Color=(B=253,G=220,R=213))
         ColorScale(2)=(RelativeTime=0.400000,Color=(B=107,G=56,R=74))
         ColorScale(3)=(RelativeTime=1.000000)
         MaxParticles=5
         StartLocationRange=(Y=(Min=-60.000000,Max=60.000000),Z=(Min=-60.000000,Max=60.000000))
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=1.000000,Max=1.000000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=300.000000,Max=500.000000))
         InitialParticlesPerSecond=2000.000000
         Texture=Texture'da2effects2.EmitterTextures.hardspot'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.600000)
         StartVelocityRange=(X=(Min=750.000000,Max=900.000000))
         VelocityLossRange=(X=(Min=2.500000,Max=2.500000),Y=(Min=2.500000,Max=2.500000),Z=(Min=2.500000,Max=2.500000))
     End Object
     Emitters(12)=SpriteEmitter'DA2.da_effects_PlasmaExplosion.SpriteEmitter12'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter13
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         UseRandomSubdivision=True
         Acceleration=(Z=150.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255))
         ColorScale(1)=(RelativeTime=0.750000,Color=(B=177,G=180,R=186,A=255))
         ColorScale(2)=(RelativeTime=1.000000)
         MaxParticles=70
         StartLocationOffset=(X=-15.000000)
         StartLocationRange=(Y=(Min=-200.000000,Max=200.000000),Z=(Min=-200.000000,Max=200.000000))
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=0.100000,Max=0.250000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.050000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=40.000000,Max=80.000000))
         InitialParticlesPerSecond=30.000000
         Texture=Texture'da2effects2.EmitterTextures.PlasmaParticleTex'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.750000,Max=2.000000)
         StartVelocityRadialRange=(Min=100.000000,Max=100.000000)
         VelocityLossRange=(X=(Min=2.000000,Max=2.000000),Y=(Min=2.000000,Max=2.000000),Z=(Min=2.000000,Max=2.000000))
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(13)=SpriteEmitter'DA2.da_effects_PlasmaExplosion.SpriteEmitter13'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter14
         UseColorScale=True
         RespawnDeadParticles=False
         UseRevolution=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         UseVelocityScale=True
         Acceleration=(Z=10.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=128))
         ColorScale(1)=(RelativeTime=0.346429,Color=(B=129,G=132,R=143,A=255))
         ColorScale(2)=(RelativeTime=1.000000)
         MaxParticles=31
         StartLocationOffset=(X=2.000000)
         StartLocationRange=(X=(Max=1.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Min=-50.000000,Max=50.000000))
         SphereRadiusRange=(Min=30.000000,Max=40.000000)
         StartLocationPolarRange=(X=(Min=-10000.000000,Max=10000.000000),Y=(Min=-1000.000000,Max=1000.000000),Z=(Min=-1000.000000,Max=1000.000000))
         RevolutionsPerSecondRange=(X=(Max=0.050000))
         UseRotationFrom=PTRS_Actor
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Max=150.000000),Y=(Min=200.000000,Max=300.000000),Z=(Min=0.000000,Max=0.000000))
         InitialParticlesPerSecond=2000.000000
         Texture=Texture'da2effects2.EmitterTextures.PlasmaParticleTex'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.800000,Max=1.000000)
         StartVelocityRadialRange=(Min=-1700.000000,Max=-1700.000000)
         VelocityLossRange=(X=(Min=4.000000,Max=4.000000),Y=(Min=4.000000,Max=4.000000),Z=(Min=4.000000,Max=4.000000))
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(14)=SpriteEmitter'DA2.da_effects_PlasmaExplosion.SpriteEmitter14'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter15
         UseDirectionAs=PTDU_Forward
         UseColorScale=True
         RespawnDeadParticles=False
         AutoDestroy=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ColorScale(1)=(RelativeTime=0.400000,Color=(B=251,G=188,R=164))
         ColorScale(2)=(RelativeTime=0.696429,Color=(B=108,G=55,R=70))
         ColorScale(3)=(RelativeTime=1.000000)
         MaxParticles=2
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=1.000000,Max=1.000000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.100000)
         StartSizeRange=(X=(Min=600.000000,Max=900.000000))
         InitialParticlesPerSecond=2000.000000
         Texture=Texture'SpecialEffects.WeatherEffects.splashring'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.300000,Max=0.500000)
         StartVelocityRange=(X=(Min=2.000000,Max=20.000000))
     End Object
     Emitters(15)=SpriteEmitter'DA2.da_effects_PlasmaExplosion.SpriteEmitter15'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter16
         UseDirectionAs=PTDU_Forward
         UseColorScale=True
         RespawnDeadParticles=False
         AutoDestroy=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ColorScale(1)=(RelativeTime=0.100000,Color=(B=253,G=216,R=208))
         ColorScale(2)=(RelativeTime=0.800000,Color=(B=96,G=105,R=172))
         ColorScale(3)=(RelativeTime=1.000000)
         MaxParticles=2
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=1.000000,Max=1.000000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.500000)
         StartSizeRange=(X=(Min=800.000000,Max=800.000000))
         InitialParticlesPerSecond=2000.000000
         Texture=Texture'da2effects2.EmitterTextures.BrightFlareTex'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=5.000000,Max=5.000000)
         StartVelocityRange=(X=(Min=1.000000,Max=3.000000))
     End Object
     Emitters(16)=SpriteEmitter'DA2.da_effects_PlasmaExplosion.SpriteEmitter16'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter17
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         UseRandomSubdivision=True
         Acceleration=(Z=100.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255))
         ColorScale(1)=(RelativeTime=0.300000,Color=(B=248,G=248,R=252,A=200))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=206,G=193,R=201))
         MaxParticles=40
         StartLocationRange=(Y=(Min=-250.000000,Max=250.000000),Z=(Min=-250.000000,Max=250.000000))
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Max=0.100000))
         SizeScale(0)=(RelativeSize=0.400000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=0.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=20.000000))
         InitialParticlesPerSecond=10.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'DA2Effects.Weapon.SmokePanels2'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=3.000000)
         StartVelocityRadialRange=(Min=180.000000,Max=180.000000)
         VelocityLossRange=(X=(Min=1.150000,Max=1.150000),Y=(Min=1.150000,Max=1.150000),Z=(Min=1.150000,Max=1.150000))
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(17)=SpriteEmitter'DA2.da_effects_PlasmaExplosion.SpriteEmitter17'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter18
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         UseRandomSubdivision=True
         Acceleration=(Z=75.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255))
         ColorScale(1)=(RelativeTime=0.346429,Color=(B=248,G=248,R=252,A=230))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=206,G=193,R=201))
         StartLocationRange=(Y=(Min=-50.000000,Max=50.000000),Z=(Min=-50.000000,Max=50.000000))
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Max=0.060000))
         SizeScale(0)=(RelativeSize=0.400000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=0.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=80.000000,Max=180.000000))
         InitialParticlesPerSecond=100.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'SpecialEffects.Smoke.MuchSmoke2t'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=5.000000,Max=8.000000)
         StartVelocityRange=(X=(Min=400.000000,Max=700.000000),Y=(Min=-350.000000,Max=350.000000),Z=(Min=-350.000000,Max=350.000000))
         StartVelocityRadialRange=(Min=180.000000,Max=180.000000)
         VelocityLossRange=(X=(Min=2.000000,Max=2.000000),Y=(Min=2.000000,Max=2.000000),Z=(Min=2.000000,Max=2.000000))
     End Object
     Emitters(18)=SpriteEmitter'DA2.da_effects_PlasmaExplosion.SpriteEmitter18'

     AutoDestroy=True
     LightType=LT_Steady
     LightEffect=LE_NonIncidence
     LightHue=245
     LightSaturation=160
     LightBrightness=300.000000
     LightRadius=42.000000
     bNoDelete=False
     bDynamicLight=True
}
