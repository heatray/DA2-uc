class da_effects_BulletHitRicochet extends Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter15
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         RespawnDeadParticles=False
         UniformSize=True
         ScaleSizeYByVelocity=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-200.000000)
         ColorScale(0)=(Color=(B=236,G=249,R=255))
         ColorScale(1)=(RelativeTime=0.800000,Color=(B=22,G=73,R=192))
         ColorScale(2)=(RelativeTime=1.000000)
         ColorMultiplierRange=(Z=(Min=0.800000))
         FadeOutStartTime=0.600000
         MaxParticles=3
         UseRotationFrom=PTRS_Actor
         StartSizeRange=(X=(Min=0.500000,Max=2.000000))
         ScaleSizeByVelocityMultiplier=(Y=0.010000)
         InitialParticlesPerSecond=2000.000000
         Texture=Texture'da2effects2.EmitterTextures.burnflare'
         LifetimeRange=(Min=0.200000,Max=0.600000)
         StartVelocityRange=(X=(Min=200.000000,Max=800.000000),Y=(Min=-500.000000,Max=500.000000),Z=(Min=-500.000000,Max=500.000000))
         VelocityLossRange=(X=(Min=6.000000,Max=8.000000),Y=(Min=6.000000,Max=8.000000),Z=(Min=6.000000,Max=8.000000))
     End Object
     Emitters(0)=SpriteEmitter'DA2.da_effects_BulletHitRicochet.SpriteEmitter15'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter16
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255))
         ColorScale(1)=(RelativeTime=0.800000,Color=(B=52,G=115,R=177,A=255))
         ColorScale(2)=(RelativeTime=1.000000)
         MaxParticles=1
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-3.000000,Max=3.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=30.000000,Max=40.000000),Y=(Min=60.000000,Max=60.000000),Z=(Min=60.000000,Max=60.000000))
         InitialParticlesPerSecond=800.000000
         Texture=Texture'da2effects2.EmitterTextures.SparkCloudTex'
         TextureUSubdivisions=1
         TextureVSubdivisions=1
         LifetimeRange=(Min=0.100000,Max=0.150000)
         StartVelocityRange=(X=(Min=50.000000,Max=150.000000),Y=(Min=-20.000000,Max=20.000000),Z=(Min=-20.000000,Max=20.000000))
         VelocityLossRange=(X=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(1)=SpriteEmitter'DA2.da_effects_BulletHitRicochet.SpriteEmitter16'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter17
         UseDirectionAs=PTDU_Right
         UseCollision=True
         UseMaxCollisions=True
         UseColorScale=True
         RespawnDeadParticles=False
         ScaleSizeXByVelocity=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-200.000000)
         MaxCollisions=(Min=1.000000,Max=1.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255))
         ColorScale(1)=(RelativeTime=0.500000,Color=(B=255,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000)
         ColorMultiplierRange=(Z=(Min=0.800000))
         FadeOutStartTime=0.700000
         MaxParticles=1
         UseRotationFrom=PTRS_Actor
         StartSizeRange=(X=(Min=6.000000,Max=9.000000),Y=(Min=6.000000,Max=9.000000))
         ScaleSizeByVelocityMultiplier=(X=0.005000)
         InitialParticlesPerSecond=2000.000000
         Texture=Texture'da2effects2.EmitterTextures.LeviBulletTracer'
         LifetimeRange=(Min=0.200000,Max=0.500000)
         StartVelocityRange=(X=(Min=4000.000000,Max=5000.000000),Y=(Min=-1200.000000,Max=1200.000000),Z=(Min=-1200.000000,Max=1200.000000))
         VelocityLossRange=(X=(Min=3.000000,Max=5.000000),Y=(Min=2.000000,Max=5.000000),Z=(Min=2.000000,Max=5.000000))
     End Object
     Emitters(2)=SpriteEmitter'DA2.da_effects_BulletHitRicochet.SpriteEmitter17'

     AutoDestroy=True
     CullDistance=4000.000000
     bNoDelete=False
}
