class da_effects_EMPGrenadeFX extends Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(1)=(RelativeTime=0.400000,Color=(B=165,G=114,R=118,A=255))
         ColorScale(2)=(RelativeTime=0.800000,Color=(B=233,G=167,R=122,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=245,G=205,R=197))
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         SpinsPerSecondRange=(X=(Min=3.000000,Max=6.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.400000)
         SizeScale(1)=(RelativeTime=0.450000,RelativeSize=0.500000)
         SizeScale(2)=(RelativeTime=0.900000,RelativeSize=1.000000)
         SizeScale(3)=(RelativeTime=1.000000,RelativeSize=0.100000)
         StartSizeRange=(X=(Min=30.000000,Max=35.000000))
         InitialParticlesPerSecond=1000.000000
         Texture=Texture'da2effects2.EmitterTextures.plasmastar'
         TextureUSubdivisions=1
         TextureVSubdivisions=1
         LifetimeRange=(Min=2.900000,Max=3.000000)
         InitialDelayRange=(Min=0.200000,Max=0.200000)
         VelocityLossRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
     End Object
     Emitters(0)=SpriteEmitter'DA2.da_effects_EMPGrenadeFX.SpriteEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter11
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=176,G=95,R=60,A=255))
         ColorMultiplierRange=(X=(Min=0.900000,Max=0.950000),Y=(Min=0.950000,Max=0.950000))
         CoordinateSystem=PTCS_Relative
         MaxParticles=15
         StartLocationRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-7.000000,Max=7.000000),Z=(Min=-5.000000,Max=5.000000))
         UseRotationFrom=PTRS_Actor
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.100000)
         StartSizeRange=(X=(Min=5.000000,Max=20.000000))
         InitialParticlesPerSecond=30.000000
         Texture=Texture'da2effects2.EmitterTextures.electric'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=0.050000,Max=0.200000)
         InitialDelayRange=(Min=2.400000,Max=2.500000)
         WarmupTicksPerSecond=1.000000
         RelativeWarmupTime=1.000000
     End Object
     Emitters(1)=SpriteEmitter'DA2.da_effects_EMPGrenadeFX.SpriteEmitter11'

     AutoDestroy=True
     bNoDelete=False
     Physics=PHYS_Trailer
     bHardAttach=True
}
