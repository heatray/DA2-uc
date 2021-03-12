// ============================================================================
// Effects by: aBsOlUt
// Coded by: aBsOlUt
// For humans maybe?
// ============================================================================

class da_effects_SpawnEffectB extends Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=Lines
         UseDirectionAs=PTDU_Right
         UseColorScale=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ScaleSizeXByVelocity=True
         AutomaticInitialSpawning=False
         UseVelocityScale=True
         ColorScale(1)=(RelativeTime=0.100000,Color=(B=169,G=254,R=252))
         ColorScale(2)=(RelativeTime=0.750000,Color=(B=38,G=237,R=253))
         ColorScale(3)=(RelativeTime=1.000000)
         StartLocationRange=(Z=(Min=-64.000000,Max=64.000000))
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=48.000000,Max=48.000000)
         UseRotationFrom=PTRS_Actor
         SizeScale(0)=(RelativeSize=20.000000)
         SizeScale(1)=(RelativeTime=0.300000,RelativeSize=8.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.500000)
         StartSizeRange=(X=(Min=8.000000,Max=12.000000))
         ScaleSizeByVelocityMultiplier=(X=0.005000)
         ScaleSizeByVelocityMax=100000.000000
         InitialParticlesPerSecond=1000.000000
         Texture=None
         LifetimeRange=(Min=0.500000,Max=1.000000)
         StartVelocityRange=(X=(Min=5.000000,Max=8.000000))
         VelocityScale(0)=(RelativeVelocity=(X=1.000000,Y=1.000000,Z=1.000000))
         VelocityScale(1)=(RelativeTime=0.200000,RelativeVelocity=(X=5.000000,Y=5.000000,Z=5.000000))
         VelocityScale(2)=(RelativeTime=0.400000,RelativeVelocity=(X=20.000000,Y=20.000000,Z=20.000000))
         VelocityScale(3)=(RelativeTime=1.000000,RelativeVelocity=(X=200.000000,Y=200.000000,Z=200.000000))
     End Object
     Emitters(0)=SpriteEmitter'DA2.da_effects_SpawnEffectB.Lines'

     TimeTillResetRange=(Min=0.500000,Max=0.500000)
     AutoDestroy=True
     AutoReset=True
     bNoDelete=False
}
