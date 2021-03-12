class da_effects_MineExplosion extends Emitter;

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
     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         RespawnDeadParticles=False
         AlphaTest=False
         UseRevolution=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         Acceleration=(Z=-300.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.500000,Color=(B=255,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(A=255))
         FadeOutFactor=(X=0.000000,Y=0.000000,Z=0.000000)
         FadeOutStartTime=0.300000
         FadeInFactor=(W=0.000000,X=0.000000,Y=0.000000,Z=0.000000)
         MaxParticles=3
         StartLocationOffset=(X=10.000000)
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=30.000000,Max=50.000000)
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-1.000000,Max=1.000000))
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
         LifetimeRange=(Min=0.100000,Max=0.250000)
         StartVelocityRadialRange=(Min=10.000000,Max=10.000000)
         MaxAbsVelocity=(X=1.000000,Y=1.000000,Z=1.000000)
         VelocityLossRange=(X=(Min=-500.000000,Max=500.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Min=-50.000000,Max=50.000000))
         VelocityScale(0)=(RelativeTime=1.000000,RelativeVelocity=(X=0.200000,Y=0.200000,Z=0.200000))
     End Object
     Emitters(0)=SpriteEmitter'DA2.da_effects_MineExplosion.SpriteEmitter5'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter6
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
         MaxParticles=5
         StartLocationOffset=(X=10.000000)
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=10.000000,Max=30.000000)
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=7.000000,Max=11.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=0.750000,RelativeSize=0.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.200000)
         StartSizeRange=(X=(Min=30.000000,Max=90.000000))
         InitialParticlesPerSecond=1000.000000
         Texture=Texture'da2effects2.EmitterTextures.FlameParticleTex'
         TextureUSubdivisions=1
         TextureVSubdivisions=1
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.050000,Max=0.300000)
         StartVelocityRadialRange=(Min=10.000000,Max=10.000000)
         MaxAbsVelocity=(X=1.000000,Y=1.000000,Z=1.000000)
         VelocityLossRange=(X=(Min=-500.000000,Max=500.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Min=-50.000000,Max=50.000000))
         VelocityScale(0)=(RelativeTime=1.000000,RelativeVelocity=(X=0.200000,Y=0.200000,Z=0.200000))
     End Object
     Emitters(1)=SpriteEmitter'DA2.da_effects_MineExplosion.SpriteEmitter6'

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
         ColorScale(0)=(Color=(B=100,G=135,R=208,A=64))
         ColorScale(1)=(RelativeTime=0.075000,Color=(B=52,G=57,R=65,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=41,G=45,R=48))
         Opacity=0.800000
         MaxParticles=8
         StartLocationOffset=(X=10.000000)
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=10.000000,Max=30.000000)
         RevolutionsPerSecondRange=(X=(Max=0.050000))
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Max=0.100000))
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
         LifetimeRange=(Min=2.000000)
         StartVelocityRange=(X=(Min=-150.000000,Max=150.000000),Y=(Min=-200.000000,Max=200.000000),Z=(Min=-200.000000,Max=200.000000))
         StartVelocityRadialRange=(Min=200.000000,Max=200.000000)
         VelocityLossRange=(X=(Max=8.000000),Y=(Max=8.000000),Z=(Max=8.000000))
     End Object
     Emitters(2)=SpriteEmitter'DA2.da_effects_MineExplosion.SpriteEmitter7'

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
         ColorScale(1)=(RelativeTime=0.300000,Color=(B=186,G=228,R=252))
         ColorScale(2)=(RelativeTime=0.850000,Color=(B=4,G=85,R=206))
         ColorScale(3)=(RelativeTime=1.000000)
         Opacity=0.850000
         MaxParticles=1
         StartLocationOffset=(X=10.000000)
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=1.000000,Max=1.000000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.750000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=1.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.200000)
         StartSizeRange=(X=(Min=250.000000,Max=300.000000))
         InitialParticlesPerSecond=2000.000000
         Texture=Texture'da2effects2.EmitterTextures.plasmastar'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.200000,Max=0.250000)
     End Object
     Emitters(3)=SpriteEmitter'DA2.da_effects_MineExplosion.SpriteEmitter8'

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
         ColorScale(0)=(Color=(B=255,G=255,R=255))
         ColorScale(1)=(RelativeTime=1.000000)
         MaxParticles=1
         StartLocationOffset=(X=10.000000)
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=10.000000,Max=30.000000)
         UseRotationFrom=PTRS_Actor
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=7.000000)
         StartSizeRange=(X=(Min=30.000000,Max=40.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'DA2Effects.Blast_4Frame'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=0.250000,Max=0.300000)
     End Object
     Emitters(4)=SpriteEmitter'DA2.da_effects_MineExplosion.SpriteEmitter9'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter10
         UseDirectionAs=PTDU_UpAndNormal
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         ScaleSizeYByVelocity=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-400.000000)
         ColorScale(0)=(Color=(B=221,G=236,R=251,A=255))
         ColorScale(1)=(RelativeTime=0.171429,Color=(B=123,G=186,R=249,A=255))
         ColorScale(2)=(RelativeTime=0.696429,Color=(B=19,G=53,R=108,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(A=255))
         FadeOutStartTime=1.800000
         MaxParticles=40
         StartLocationOffset=(X=10.000000)
         StartLocationRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=10.000000,Max=10.000000),Z=(Min=10.000000,Max=10.000000))
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Max=5.000000)
         AlphaRef=2
         UseRotationFrom=PTRS_Actor
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000)
         SizeScaleRepeats=1.000000
         StartSizeRange=(X=(Min=4.000000,Max=8.000000),Y=(Min=60.000000,Max=60.000000),Z=(Min=60.000000,Max=60.000000))
         ScaleSizeByVelocityMultiplier=(Y=0.001000)
         InitialParticlesPerSecond=1000.000000
         Texture=Texture'da2effects2.EmitterTextures.burnflare'
         TextureUSubdivisions=1
         TextureVSubdivisions=1
         LifetimeRange=(Min=0.300000,Max=0.500000)
         StartVelocityRange=(X=(Min=-200.000000,Max=700.000000),Y=(Min=-1400.000000,Max=1400.000000),Z=(Min=-1400.000000,Max=1400.000000))
         StartVelocityRadialRange=(Min=1000.000000,Max=1200.000000)
         VelocityLossRange=(X=(Min=5.000000,Max=5.000000),Y=(Min=5.000000,Max=5.000000),Z=(Min=5.000000,Max=5.000000))
     End Object
     Emitters(5)=SpriteEmitter'DA2.da_effects_MineExplosion.SpriteEmitter10'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter11
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=236,G=247,R=253))
         ColorScale(1)=(RelativeTime=0.782143,Color=(B=66,G=124,R=189,A=255))
         ColorScale(2)=(RelativeTime=1.000000)
         MaxParticles=1
         StartLocationOffset=(X=10.000000)
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=10.000000,Max=30.000000)
         UseRotationFrom=PTRS_Actor
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=10.000000)
         StartSizeRange=(X=(Min=20.000000,Max=30.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'da2effects2.EmitterTextures.SparkCloudTex'
         TextureUSubdivisions=1
         TextureVSubdivisions=1
         LifetimeRange=(Min=0.150000,Max=0.200000)
     End Object
     Emitters(6)=SpriteEmitter'DA2.da_effects_MineExplosion.SpriteEmitter11'

     AutoDestroy=True
     LightType=LT_Steady
     LightEffect=LE_NonIncidence
     LightHue=20
     LightSaturation=150
     LightBrightness=300.000000
     LightRadius=19.000000
     bNoDelete=False
     bDynamicLight=True
}
