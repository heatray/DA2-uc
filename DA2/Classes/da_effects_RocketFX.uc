class da_effects_RocketFX extends Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=168,G=206,R=234))
         ColorScale(1)=(RelativeTime=0.471429,Color=(B=101,G=149,R=201,A=255))
         ColorScale(2)=(RelativeTime=1.000000)
         CoordinateSystem=PTCS_Relative
         MaxParticles=4
         StartLocationOffset=(X=-30.000000)
         StartSizeRange=(X=(Min=2.250000,Max=7.500000),Y=(Min=22.500000,Max=45.000000),Z=(Min=45.000000,Max=45.000000))
         InitialParticlesPerSecond=1000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'da2effects2.EmitterTextures.Part_explode2'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.150000,Max=0.150000)
         InitialDelayRange=(Min=0.200000,Max=0.200000)
         StartVelocityRange=(X=(Min=-150.000000,Max=-75.000000))
         VelocityLossRange=(X=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(0)=SpriteEmitter'DA2.da_effects_RocketFX.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         UseColorScale=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=255,G=255,R=255))
         ColorScale(1)=(RelativeTime=0.500000,Color=(B=119,G=182,R=227,A=255))
         ColorScale(2)=(RelativeTime=1.000000)
         CoordinateSystem=PTCS_Relative
         MaxParticles=6
         StartLocationOffset=(X=-5.000000)
         SpinsPerSecondRange=(X=(Min=-3.000000,Max=3.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.400000)
         SizeScale(1)=(RelativeTime=0.280000,RelativeSize=1.200000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.200000)
         StartSizeRange=(X=(Min=9.000000,Max=18.000000),Y=(Min=45.000004,Max=45.000004),Z=(Min=45.000004,Max=45.000004))
         InitialParticlesPerSecond=1000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'da2effects2.EmitterTextures.Part_explode2'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.200000,Max=0.200000)
         StartVelocityRange=(X=(Min=-225.000000,Max=-150.000000))
         VelocityLossRange=(X=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(1)=SpriteEmitter'DA2.da_effects_RocketFX.SpriteEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         UseColorScale=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255))
         ColorScale(1)=(RelativeTime=0.500000,Color=(B=119,G=182,R=227,A=255))
         ColorScale(2)=(RelativeTime=1.000000)
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         StartLocationOffset=(X=-3.000000)
         SpinsPerSecondRange=(X=(Min=-3.000000,Max=3.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.400000)
         SizeScale(1)=(RelativeTime=0.280000,RelativeSize=1.200000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.200000)
         StartSizeRange=(X=(Min=30.000000,Max=60.000000),Y=(Min=45.000000,Max=45.000000),Z=(Min=45.000000,Max=45.000000))
         InitialParticlesPerSecond=1000.000000
         Texture=Texture'da2effects2.EmitterTextures.plasmastar'
         TextureUSubdivisions=1
         TextureVSubdivisions=1
         LifetimeRange=(Min=0.200000,Max=0.200000)
         InitialDelayRange=(Min=0.100000,Max=0.100000)
         StartVelocityRange=(X=(Min=-90.000000,Max=-75.000000))
         VelocityLossRange=(X=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(2)=SpriteEmitter'DA2.da_effects_RocketFX.SpriteEmitter4'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter24
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorScale(1)=(RelativeTime=0.121429,Color=(B=255,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.600000,Color=(B=108,G=125,R=193,A=255))
         ColorScale(3)=(RelativeTime=1.000000)
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=-60.000000)
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.700000)
         StartSizeRange=(X=(Min=18.000000,Max=22.000000),Y=(Min=80.000000),Z=(Min=45.000000,Max=45.000000))
         InitialParticlesPerSecond=1000.000000
         Texture=Texture'da2effects2.EmitterTextures.SparkGlowTex'
         TextureUSubdivisions=1
         TextureVSubdivisions=1
         LifetimeRange=(Min=3.000000,Max=3.300000)
         InitialDelayRange=(Min=0.200000,Max=0.200000)
         StartVelocityRange=(X=(Min=-20.000000,Max=-10.000000))
     End Object
     Emitters(3)=SpriteEmitter'DA2.da_effects_RocketFX.SpriteEmitter24'

     AutoDestroy=True
     LightType=LT_Steady
     LightHue=20
     LightSaturation=220
     LightBrightness=100.000000
     LightRadius=16.000000
     bNoDelete=False
     bDynamicLight=True
     Physics=PHYS_Trailer
     bHardAttach=True
}
