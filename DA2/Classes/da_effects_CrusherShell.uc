// ============================================================================
// Coded by: Leviathan
// Generic tracer
// ============================================================================
class da_effects_CrusherShell extends Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseDirectionAs=PTDU_Right
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartSizeRange=(X=(Min=140.000000,Max=160.000000),Y=(Min=10.000000,Max=12.000000))
         InitialParticlesPerSecond=500.000000
         Texture=Texture'da2effects2.EmitterTextures.LeviBulletTracer'
         LifetimeRange=(Min=0.200000,Max=0.200000)
         InitialDelayRange=(Min=0.050000,Max=0.050000)
         StartVelocityRange=(X=(Max=10.000000))
         VelocityLossRange=(X=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(0)=SpriteEmitter'DA2.da_effects_CrusherShell.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.800000,Max=0.800000),Z=(Min=0.600000,Max=0.600000))
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         StartLocationOffset=(X=60.000000)
         StartSizeRange=(X=(Min=3.000000,Max=6.000000))
         InitialParticlesPerSecond=500.000000
         Texture=Texture'da2effects2.EmitterTextures.hardspot'
         LifetimeRange=(Min=0.200000,Max=0.200000)
         InitialDelayRange=(Min=0.050000,Max=0.050000)
         StartVelocityRange=(X=(Max=10.000000))
         VelocityLossRange=(X=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(1)=SpriteEmitter'DA2.da_effects_CrusherShell.SpriteEmitter1'

     bNoDelete=False
     Physics=PHYS_Trailer
     bHardAttach=True
     bDirectional=True
}
