class da_effects_BulletHitDirt extends HitEmitter;

defaultproperties
{
     ImpactSounds(0)=Sound'KFWeaponSound.bullethitdirt'
     ImpactSounds(1)=Sound'KFWeaponSound.bullethitdirt2'
     ImpactSounds(2)=Sound'KFWeaponSound.bullethitdirt3'
     ImpactSounds(3)=Sound'KFWeaponSound.bullethitdirt4'
     Begin Object Class=SpriteEmitter Name=SpriteEmitter8
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         RespawnDeadParticles=False
         UniformSize=True
         ScaleSizeYByVelocity=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-200.000000)
         ColorScale(0)=(Color=(B=68,G=68,R=87,A=255))
         ColorScale(1)=(RelativeTime=0.500000,Color=(B=68,G=68,R=87,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=68,G=68,R=87))
         ColorMultiplierRange=(Z=(Min=0.800000))
         MaxParticles=2
         UseRotationFrom=PTRS_Actor
         StartSizeRange=(X=(Min=1.000000,Max=3.000000))
         ScaleSizeByVelocityMultiplier=(Y=0.010000)
         InitialParticlesPerSecond=2000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'da2effects2.EmitterTextures.MatDirtParticleTex'
         TextureUSubdivisions=16
         TextureVSubdivisions=16
         LifetimeRange=(Min=0.200000,Max=0.800000)
         StartVelocityRange=(X=(Min=200.000000,Max=600.000000),Y=(Min=-400.000000,Max=400.000000),Z=(Min=-400.000000,Max=400.000000))
         VelocityLossRange=(X=(Min=6.000000,Max=8.000000),Y=(Min=6.000000,Max=8.000000),Z=(Min=6.000000,Max=8.000000))
     End Object
     Emitters(0)=SpriteEmitter'DA2.da_effects_BulletHitDirt.SpriteEmitter8'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter10
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-100.000000)
         ColorScale(0)=(Color=(B=113,G=113,R=130,A=255))
         ColorScale(1)=(RelativeTime=0.400000,Color=(B=113,G=113,R=130,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=94,G=94,R=111))
         MaxParticles=1
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-0.300000,Max=0.300000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=0.700000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=30.000000,Max=40.000000),Y=(Min=60.000000,Max=60.000000),Z=(Min=60.000000,Max=60.000000))
         InitialParticlesPerSecond=800.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'DA2Effects.Weapon.SmokePanels2'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.400000,Max=0.600000)
         StartVelocityRange=(X=(Min=200.000000,Max=400.000000),Y=(Min=-30.000000,Max=30.000000),Z=(Min=-30.000000,Max=30.000000))
         VelocityLossRange=(X=(Min=5.000000,Max=5.000000),Y=(Min=5.000000,Max=5.000000),Z=(Min=5.000000,Max=5.000000))
     End Object
     Emitters(1)=SpriteEmitter'DA2.da_effects_BulletHitDirt.SpriteEmitter10'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter11
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
         ColorScale(0)=(Color=(B=71,G=71,R=84,A=255))
         ColorScale(1)=(RelativeTime=0.500000,Color=(B=71,G=71,R=84,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=71,G=71,R=84))
         ColorMultiplierRange=(Z=(Min=0.800000))
         MaxParticles=2
         UseRotationFrom=PTRS_Actor
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=6.000000,Max=12.000000))
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
     Emitters(2)=SpriteEmitter'DA2.da_effects_BulletHitDirt.SpriteEmitter11'

     CullDistance=3000.000000
}
