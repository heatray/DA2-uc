// ============================================================================
// Coded by: Leviathan
// Generic tracer
// ============================================================================
class da_effects_Tracer extends Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseDirectionAs=PTDU_Right
         AutomaticInitialSpawning=False
         ColorMultiplierRange=(Y=(Min=0.750000,Max=0.750000),Z=(Min=0.600000,Max=0.500000))
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartSizeRange=(X=(Min=150.000000,Max=170.000000),Y=(Min=5.000000,Max=5.000000))
         InitialParticlesPerSecond=500.000000
         Texture=None
         LifetimeRange=(Min=0.200000,Max=0.200000)
         InitialDelayRange=(Min=0.050000,Max=0.050000)
         StartVelocityRange=(X=(Max=10.000000))
         VelocityLossRange=(X=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(0)=SpriteEmitter'DA2.da_effects_Tracer.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         ProjectionNormal=(X=1.000000,Z=0.000000)
         UseColorScale=True
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorMultiplierRange=(Y=(Min=0.750000,Max=0.750000),Z=(Min=0.600000,Max=0.500000))
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         SpinCCWorCW=(X=0.000000,Y=0.000000,Z=0.000000)
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.200000))
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=4.000000,Max=4.500000))
         InitialParticlesPerSecond=50.000000
         Texture=Texture'da2effects2.EmitterTextures.plasmastar'
         LifetimeRange=(Min=0.050000,Max=0.100000)
         InitialDelayRange=(Min=0.050000,Max=0.050000)
     End Object
     Emitters(1)=SpriteEmitter'DA2.da_effects_Tracer.SpriteEmitter2'

     bNoDelete=False
     Physics=PHYS_Trailer
     bHardAttach=True
     bDirectional=True
}
