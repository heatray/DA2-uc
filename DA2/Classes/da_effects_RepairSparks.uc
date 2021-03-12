class da_effects_RepairSparks extends Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         RespawnDeadParticles=False
         UniformSize=True
         ScaleSizeYByVelocity=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-250.000000)
         ColorScale(0)=(Color=(B=236,G=249,R=255))
         ColorScale(1)=(RelativeTime=0.800000,Color=(B=205,G=122,R=39))
         ColorScale(2)=(RelativeTime=1.000000)
         ColorMultiplierRange=(X=(Min=0.800000))
         FadeOutStartTime=0.600000
         MaxParticles=8
         UseRotationFrom=PTRS_Actor
         StartSizeRange=(X=(Min=0.400000,Max=1.200000))
         ScaleSizeByVelocityMultiplier=(Y=0.020000)
         InitialParticlesPerSecond=20.000000
         Texture=Texture'da2effects2.EmitterTextures.burnflare'
         LifetimeRange=(Min=0.300000,Max=0.800000)
         StartVelocityRange=(X=(Min=150.000000,Max=400.000000),Y=(Min=-200.000000,Max=200.000000),Z=(Min=-200.000000,Max=200.000000))
         VelocityLossRange=(X=(Min=1.000000,Max=2.000000))
     End Object
     Emitters(0)=SpriteEmitter'DA2.da_effects_RepairSparks.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255))
         ColorScale(1)=(RelativeTime=0.800000,Color=(B=179,G=112,R=51,A=255))
         ColorScale(2)=(RelativeTime=1.000000)
         MaxParticles=1
         StartLocationOffset=(X=2.000000)
         UseRotationFrom=PTRS_Actor
         SpinCCWorCW=(X=0.800000)
         SpinsPerSecondRange=(X=(Min=6.000000,Max=9.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=0.370000,RelativeSize=0.100000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.500000)
         SizeScaleRepeats=20.000000
         StartSizeRange=(X=(Min=30.000000,Max=35.000000),Y=(Min=60.000000,Max=60.000000),Z=(Min=60.000000,Max=60.000000))
         InitialParticlesPerSecond=800.000000
         Texture=Texture'da2effects2.EmitterTextures.TriFlare'
         TextureUSubdivisions=1
         TextureVSubdivisions=1
         LifetimeRange=(Min=0.400000,Max=0.450000)
         VelocityLossRange=(X=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(1)=SpriteEmitter'DA2.da_effects_RepairSparks.SpriteEmitter1'

     AutoDestroy=True
     CullDistance=3000.000000
     bNoDelete=False
}
