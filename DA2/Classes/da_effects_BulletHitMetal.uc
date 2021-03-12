class da_effects_BulletHitMetal extends HitEmitter;

defaultproperties
{
     ImpactSounds(0)=Sound'KFWeaponSound.bullethitmetal2'
     ImpactSounds(1)=Sound'KFWeaponSound.bullethitmetal3'
     ImpactSounds(2)=Sound'KFWeaponSound.bullethitmetal4'
     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
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
         MaxParticles=4
         UseRotationFrom=PTRS_Actor
         StartSizeRange=(X=(Min=0.500000,Max=2.000000))
         ScaleSizeByVelocityMultiplier=(Y=0.010000)
         InitialParticlesPerSecond=2000.000000
         Texture=Texture'da2effects2.EmitterTextures.burnflare'
         LifetimeRange=(Min=0.200000,Max=0.600000)
         StartVelocityRange=(X=(Min=200.000000,Max=1000.000000),Y=(Min=-400.000000,Max=400.000000),Z=(Min=-400.000000,Max=400.000000))
         VelocityLossRange=(X=(Min=6.000000,Max=8.000000),Y=(Min=6.000000,Max=8.000000),Z=(Min=6.000000,Max=8.000000))
     End Object
     Emitters(0)=SpriteEmitter'DA2.da_effects_BulletHitMetal.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
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
     Emitters(1)=SpriteEmitter'DA2.da_effects_BulletHitMetal.SpriteEmitter4'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         ScaleSizeYByVelocity=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-500.000000)
         ColorScale(0)=(Color=(B=236,G=249,R=255))
         ColorScale(1)=(RelativeTime=0.800000,Color=(B=22,G=73,R=192))
         ColorScale(2)=(RelativeTime=1.000000)
         ColorMultiplierRange=(Z=(Min=0.800000))
         FadeOutStartTime=0.142857
         MaxParticles=6
         UseRotationFrom=PTRS_Actor
         StartSizeRange=(X=(Min=0.900000,Max=1.500000),Y=(Min=4.000000,Max=6.000000),Z=(Min=4.000000,Max=6.000000))
         ScaleSizeByVelocityMultiplier=(Y=0.010000)
         InitialParticlesPerSecond=1400.000000
         Texture=Texture'da2effects2.EmitterTextures.Part_explode2'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         MinSquaredVelocity=100.000000
         LifetimeRange=(Min=0.486000,Max=0.629000)
         StartVelocityRange=(X=(Min=350.000000,Max=590.000000),Y=(Min=-375.000000,Max=375.000000),Z=(Min=-375.000000,Max=375.000000))
         VelocityLossRange=(X=(Min=4.200000,Max=5.600000),Y=(Min=4.200000,Max=5.600000),Z=(Min=4.200000,Max=5.600000))
     End Object
     Emitters(2)=SpriteEmitter'DA2.da_effects_BulletHitMetal.SpriteEmitter2'

     CullDistance=3000.000000
}
