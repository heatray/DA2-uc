class da_effects_AVRocketFX extends Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         UseSizeScale=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=255,G=255,R=255))
         ColorScale(1)=(RelativeTime=0.696429,Color=(B=119,G=122,R=183,A=255))
         ColorScale(2)=(RelativeTime=1.000000)
         CoordinateSystem=PTCS_Relative
         MaxParticles=3
         StartLocationOffset=(X=-40.000000)
         StartSizeRange=(X=(Min=1.000000,Max=6.000000),Y=(Min=25.000000,Max=75.000000),Z=(Min=45.000000,Max=45.000000))
         InitialParticlesPerSecond=2000.000000
         Texture=Texture'da2effects2.EmitterTextures.MuzParticleTex'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.100000,Max=0.100000)
         InitialDelayRange=(Min=0.200000,Max=0.200000)
         StartVelocityRange=(X=(Min=-400.000000,Max=-300.000000))
         VelocityLossRange=(X=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(0)=SpriteEmitter'DA2.da_effects_AVRocketFX.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseColorScale=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=255,G=255,R=255))
         ColorScale(1)=(RelativeTime=0.500000,Color=(B=138,G=146,R=208,A=255))
         ColorScale(2)=(RelativeTime=1.000000)
         CoordinateSystem=PTCS_Relative
         MaxParticles=6
         StartLocationOffset=(X=-5.000000)
         SpinsPerSecondRange=(X=(Min=-3.000000,Max=3.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.400000)
         SizeScale(1)=(RelativeTime=0.280000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.200000)
         StartSizeRange=(X=(Min=8.000000,Max=12.000000),Y=(Min=45.000000,Max=45.000000),Z=(Min=45.000000,Max=45.000000))
         InitialParticlesPerSecond=1000.000000
         Texture=Texture'da2effects2.EmitterTextures.MuzParticleTex'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.400000,Max=0.400000)
         StartVelocityRange=(X=(Min=-200.000000,Max=-100.000000))
         VelocityLossRange=(X=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(1)=SpriteEmitter'DA2.da_effects_AVRocketFX.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         UseColorScale=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(0)=(Color=(B=223,G=214,R=208))
         ColorScale(1)=(RelativeTime=0.696429,Color=(B=151,G=173,R=196,A=255))
         ColorScale(2)=(RelativeTime=1.000000)
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         StartLocationOffset=(X=-3.000000)
         SpinsPerSecondRange=(X=(Min=-3.000000,Max=3.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=0.700000,RelativeSize=1.200000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.200000)
         StartSizeRange=(X=(Min=30.000000,Max=40.000000),Y=(Min=45.000000,Max=45.000000),Z=(Min=45.000000,Max=45.000000))
         InitialParticlesPerSecond=1000.000000
         Texture=Texture'da2effects2.EmitterTextures.BrightFlareTex'
         TextureUSubdivisions=1
         TextureVSubdivisions=1
         LifetimeRange=(Min=0.200000,Max=0.200000)
         InitialDelayRange=(Min=0.100000,Max=0.100000)
         StartVelocityRange=(X=(Min=-160.000000,Max=-120.000000))
         VelocityLossRange=(X=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(2)=SpriteEmitter'DA2.da_effects_AVRocketFX.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorScale(1)=(RelativeTime=0.121429,Color=(B=255,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.600000,Color=(B=143,G=168,R=209,A=255))
         ColorScale(3)=(RelativeTime=0.800000,Color=(B=108,G=125,R=193,A=255))
         ColorScale(4)=(RelativeTime=1.000000)
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=-40.000000)
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.800000)
         StartSizeRange=(X=(Min=15.000000,Max=20.000000),Y=(Min=120.000000,Max=160.000000),Z=(Min=45.000000,Max=45.000000))
         InitialParticlesPerSecond=1000.000000
         Texture=Texture'da2effects2.EmitterTextures.BrightFlareTex'
         TextureUSubdivisions=1
         TextureVSubdivisions=1
         LifetimeRange=(Min=1.200000,Max=1.600000)
         InitialDelayRange=(Min=0.200000,Max=0.200000)
         StartVelocityRange=(X=(Min=-80.000000,Max=-80.000000))
         VelocityLossRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
     End Object
     Emitters(3)=SpriteEmitter'DA2.da_effects_AVRocketFX.SpriteEmitter3'

     AutoDestroy=True
     LightType=LT_Steady
     LightHue=15
     LightSaturation=220
     LightBrightness=100.000000
     LightRadius=8.000000
     bNoDelete=False
     bDynamicLight=True
     Physics=PHYS_Trailer
     bHardAttach=True
}
