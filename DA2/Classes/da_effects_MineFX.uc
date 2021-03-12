class da_effects_MineFX extends Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseColorScale=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(1)=(RelativeTime=0.100000,Color=(B=159,G=159,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.200000,Color=(R=255,A=255))
         ColorScale(3)=(RelativeTime=1.000000)
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=3.000000)
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.100000)
         StartSizeRange=(X=(Min=3.000000,Max=3.000000))
         InitialParticlesPerSecond=2.000000
         Texture=Texture'da2effects2.EmitterTextures.BrightFlareTex'
         LifetimeRange=(Min=0.250000,Max=0.250000)
         InitialDelayRange=(Min=0.600000,Max=0.600000)
         VelocityLossRange=(X=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(0)=SpriteEmitter'DA2.da_effects_MineFX.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorScale(1)=(RelativeTime=0.100000,Color=(B=159,G=159,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.200000,Color=(R=255,A=255))
         ColorScale(3)=(RelativeTime=1.000000)
         Opacity=0.200000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=10.000000)
         StartSizeRange=(X=(Min=15.000000,Max=15.000000),Y=(Min=30.000000,Max=30.000000),Z=(Min=30.000000,Max=30.000000))
         InitialParticlesPerSecond=2.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'da2effects2.EmitterTextures.BrightFlareTex'
         LifetimeRange=(Min=0.250000,Max=0.250000)
         InitialDelayRange=(Min=0.600000,Max=0.600000)
         StartVelocityRange=(X=(Min=1.000000,Max=1.000000))
         VelocityLossRange=(X=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(1)=SpriteEmitter'DA2.da_effects_MineFX.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         UseColorScale=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(1)=(RelativeTime=0.100000,Color=(B=159,G=159,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.200000,Color=(R=255,A=255))
         ColorScale(3)=(RelativeTime=1.000000)
         Opacity=0.100000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=28.000000)
         StartSizeRange=(X=(Min=30.000000,Max=30.000000),Y=(Min=30.000000,Max=30.000000),Z=(Min=30.000000,Max=30.000000))
         InitialParticlesPerSecond=2.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'da2effects2.EmitterTextures.BrightFlareTex'
         LifetimeRange=(Min=0.250000,Max=0.250000)
         InitialDelayRange=(Min=0.600000,Max=0.600000)
         StartVelocityRange=(X=(Min=1.000000,Max=1.000000))
         VelocityLossRange=(X=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(2)=SpriteEmitter'DA2.da_effects_MineFX.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         UseColorScale=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(1)=(RelativeTime=0.100000,Color=(B=159,G=159,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.200000,Color=(R=255,A=255))
         ColorScale(3)=(RelativeTime=1.000000)
         Opacity=0.080000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=50.000000)
         StartSizeRange=(X=(Min=70.000000,Max=70.000000))
         InitialParticlesPerSecond=2.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'da2effects2.EmitterTextures.BrightFlareTex'
         LifetimeRange=(Min=0.250000,Max=0.250000)
         InitialDelayRange=(Min=0.600000,Max=0.600000)
         VelocityLossRange=(X=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(3)=SpriteEmitter'DA2.da_effects_MineFX.SpriteEmitter3'

     AutoDestroy=True
     CullDistance=750.000000
     bNoDelete=False
     Physics=PHYS_Trailer
     bHardAttach=True
}
