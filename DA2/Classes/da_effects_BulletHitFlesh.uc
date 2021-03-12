class da_effects_BulletHitFlesh extends KFHitEmitter;

defaultproperties
{
     ImpactSounds(0)=Sound'KFPawnDamageSound.DamageSounds.bullethitflesh2'
     ImpactSounds(1)=Sound'KFPawnDamageSound.DamageSounds.bullethitflesh3'
     ImpactSounds(2)=Sound'KFPawnDamageSound.DamageSounds.bullethitflesh4'
     ImpactSounds(3)=Sound'KFPawnDamageSound.DamageSounds.bullethitflesh5'
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         RespawnDeadParticles=False
         UniformSize=True
         ScaleSizeYByVelocity=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-75.600006)
         ColorScale(0)=(Color=(B=157,G=164,R=160,A=255))
         ColorScale(1)=(RelativeTime=0.500000,Color=(B=157,G=164,R=160,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=157,G=164,R=160))
         ColorMultiplierRange=(Z=(Min=0.800000))
         MaxParticles=2
         UseRotationFrom=PTRS_Actor
         StartSizeRange=(X=(Min=4.200000,Max=10.500000),Y=(Min=420.000000,Max=420.000000),Z=(Min=420.000000,Max=420.000000))
         ScaleSizeByVelocityMultiplier=(Y=0.010000)
         InitialParticlesPerSecond=600.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'KFX.BloodDrops'
         TextureUSubdivisions=1
         TextureVSubdivisions=1
         LifetimeRange=(Min=0.300000,Max=0.500000)
         StartVelocityRange=(X=(Min=5.600000,Max=560.000000),Y=(Min=-70.000000,Max=70.000000),Z=(Min=-70.000000,Max=70.000000))
         VelocityLossRange=(X=(Min=1.800000,Max=2.400000),Y=(Min=1.800000,Max=2.400000),Z=(Min=1.800000,Max=2.400000))
     End Object
     Emitters(0)=SpriteEmitter'DA2.da_effects_BulletHitFlesh.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=157,G=164,R=160,A=255))
         ColorScale(1)=(RelativeTime=0.503571,Color=(B=157,G=164,R=160,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=157,G=164,R=160))
         FadeOutStartTime=0.190000
         MaxParticles=2
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-0.300000,Max=0.300000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=15.974401,Max=31.948801),Y=(Min=47.923199,Max=47.923199),Z=(Min=47.923199,Max=47.923199))
         InitialParticlesPerSecond=672.000000
         DrawStyle=PTDS_Modulated
         Texture=Texture'kf_fx_trip_t.Gore.kf_bloodspray_diff'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.300000,Max=0.500000)
         StartVelocityRange=(X=(Min=3.328000,Max=33.279999),Y=(Min=-6.656000,Max=6.656000),Z=(Min=-6.656000,Max=6.656000))
         VelocityLossRange=(X=(Min=0.840000,Max=0.840000))
     End Object
     Emitters(1)=SpriteEmitter'DA2.da_effects_BulletHitFlesh.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         UseRandomSubdivision=True
         Acceleration=(Z=-70.000000)
         ColorScale(0)=(Color=(A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(R=147))
         FadeOutStartTime=0.240000
         MaxParticles=6
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-0.300000,Max=0.300000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=0.700000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=14.000000,Max=28.000000),Y=(Min=42.000000,Max=42.000000),Z=(Min=42.000000,Max=42.000000))
         InitialParticlesPerSecond=400.000000
         DrawStyle=PTDS_Modulated
         Texture=Texture'kf_fx_trip_t.Gore.blood_hit_a'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=0.400000,Max=0.600000)
         StartVelocityRange=(X=(Min=100.000000,Max=150.000000),Y=(Min=-21.000000,Max=21.000000),Z=(Min=-21.000000,Max=21.000000))
         VelocityLossRange=(X=(Min=5.000000,Max=5.000000),Y=(Min=5.000000,Max=5.000000),Z=(Min=5.000000,Max=5.000000))
     End Object
     Emitters(2)=SpriteEmitter'DA2.da_effects_BulletHitFlesh.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-66.000000)
         ColorScale(0)=(Color=(B=48,G=48,R=48,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(R=147))
         MaxParticles=3
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-0.300000,Max=0.300000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=0.700000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=13.200001,Max=26.400002),Y=(Min=39.600002,Max=39.600002),Z=(Min=39.600002,Max=39.600002))
         InitialParticlesPerSecond=600.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'DA2Effects.Weapon.SmokePanels2'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.400000,Max=0.600000)
         StartVelocityRange=(X=(Min=132.000000,Max=264.000000),Y=(Min=-19.800001,Max=19.800001),Z=(Min=-19.800001,Max=19.800001))
         VelocityLossRange=(X=(Min=5.000000,Max=5.000000),Y=(Min=5.000000,Max=5.000000),Z=(Min=5.000000,Max=5.000000))
     End Object
     Emitters(3)=SpriteEmitter'DA2.da_effects_BulletHitFlesh.SpriteEmitter3'

     CullDistance=3000.000000
}
