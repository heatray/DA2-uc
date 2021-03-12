class da_effects_BulletHitRock extends HitEmitter;

defaultproperties
{
     ImpactSounds(0)=Sound'ProjectileSounds.Bullets.Impact_Asphalt01'
     ImpactSounds(1)=Sound'ProjectileSounds.Bullets.Impact_Asphalt02'
     ImpactSounds(2)=Sound'ProjectileSounds.Bullets.Impact_Asphalt03'
     ImpactSounds(3)=Sound'ProjectileSounds.Bullets.Impact_Asphalt04'
     ImpactSounds(4)=Sound'ProjectileSounds.Bullets.Impact_Asphalt05'
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         RespawnDeadParticles=False
         UniformSize=True
         ScaleSizeYByVelocity=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-200.000000)
         ColorScale(0)=(Color=(B=157,G=164,R=160,A=255))
         ColorScale(1)=(RelativeTime=0.500000,Color=(B=157,G=164,R=160,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=157,G=164,R=160))
         ColorMultiplierRange=(Z=(Min=0.800000))
         MaxParticles=2
         UseRotationFrom=PTRS_Actor
         StartSizeRange=(X=(Min=1.000000,Max=2.500000))
         ScaleSizeByVelocityMultiplier=(Y=0.010000)
         InitialParticlesPerSecond=2000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'da2effects2.EmitterTextures.MatDirtParticleTex'
         TextureUSubdivisions=16
         TextureVSubdivisions=16
         LifetimeRange=(Min=0.200000,Max=0.600000)
         StartVelocityRange=(X=(Min=200.000000,Max=1000.000000),Y=(Min=-300.000000,Max=300.000000),Z=(Min=-300.000000,Max=300.000000))
         VelocityLossRange=(X=(Min=6.000000,Max=8.000000),Y=(Min=6.000000,Max=8.000000),Z=(Min=6.000000,Max=8.000000))
     End Object
     Emitters(0)=SpriteEmitter'DA2.da_effects_BulletHitRock.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=157,G=164,R=160,A=255))
         ColorScale(1)=(RelativeTime=0.510714,Color=(B=157,G=164,R=160,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=157,G=164,R=160))
         MaxParticles=1
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-2.000000,Max=2.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=20.000000,Max=40.000000),Y=(Min=60.000000,Max=60.000000),Z=(Min=60.000000,Max=60.000000))
         InitialParticlesPerSecond=800.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'da2effects2.EmitterTextures.SparkCloudTex'
         TextureUSubdivisions=1
         TextureVSubdivisions=1
         LifetimeRange=(Min=0.150000,Max=0.300000)
         StartVelocityRange=(X=(Min=50.000000,Max=150.000000),Y=(Min=-20.000000,Max=20.000000),Z=(Min=-20.000000,Max=20.000000))
         VelocityLossRange=(X=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(1)=SpriteEmitter'DA2.da_effects_BulletHitRock.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-100.000000)
         ColorScale(0)=(Color=(B=180,G=186,R=183,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=157,G=164,R=160))
         MaxParticles=1
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-0.300000,Max=0.300000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=0.700000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=20.000000,Max=40.000000),Y=(Min=60.000000,Max=60.000000),Z=(Min=60.000000,Max=60.000000))
         InitialParticlesPerSecond=800.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'DA2Effects.Weapon.SmokePanels2'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.400000,Max=0.600000)
         StartVelocityRange=(X=(Min=200.000000,Max=400.000000),Y=(Min=-30.000000,Max=30.000000),Z=(Min=-30.000000,Max=30.000000))
         VelocityLossRange=(X=(Min=5.000000,Max=5.000000),Y=(Min=5.000000,Max=5.000000),Z=(Min=5.000000,Max=5.000000))
     End Object
     Emitters(2)=SpriteEmitter'DA2.da_effects_BulletHitRock.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ScaleSizeYByVelocity=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-100.000000)
         ColorScale(0)=(Color=(B=157,G=164,R=160,A=255))
         ColorScale(1)=(RelativeTime=0.500000,Color=(B=157,G=164,R=160,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=157,G=164,R=160))
         ColorMultiplierRange=(Z=(Min=0.800000))
         MaxParticles=1
         UseRotationFrom=PTRS_Actor
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=6.000000,Max=10.000000))
         ScaleSizeByVelocityMultiplier=(Y=0.025000)
         InitialParticlesPerSecond=2000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'da2effects2.EmitterTextures.MatDirtParticleTex'
         TextureUSubdivisions=16
         TextureVSubdivisions=16
         LifetimeRange=(Min=0.150000,Max=0.200000)
         StartVelocityRange=(X=(Min=200.000000,Max=300.000000),Y=(Min=-40.000000,Max=40.000000),Z=(Min=-40.000000,Max=40.000000))
         VelocityLossRange=(X=(Min=2.000000,Max=2.000000),Y=(Min=2.000000,Max=2.000000),Z=(Min=2.000000,Max=2.000000))
     End Object
     Emitters(3)=SpriteEmitter'DA2.da_effects_BulletHitRock.SpriteEmitter3'

     CullDistance=3000.000000
}
