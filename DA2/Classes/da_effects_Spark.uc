// ============================================================================
// Effects by: Czar
// Coded by: aBsOlUt
// Our own sparks
// ============================================================================

class da_effects_Spark extends Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=Spark
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         RespawnDeadParticles=False
         UniformSize=True
         ScaleSizeXByVelocity=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=38,G=215,R=192))
         ColorScale(1)=(RelativeTime=0.800000,Color=(B=4,G=205,R=240))
         ColorScale(2)=(RelativeTime=1.000000)
         MaxParticles=20
         UseRotationFrom=PTRS_Normal
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=0.400000,RelativeSize=1.500000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.300000)
         StartSizeRange=(X=(Min=4.000000,Max=10.000000))
         ScaleSizeByVelocityMultiplier=(X=0.015000,Y=0.010000)
         InitialParticlesPerSecond=300.000000
         Texture=Texture'da2effects2.EmitterTextures.plasmastar'
         LifetimeRange=(Min=0.300000,Max=0.600000)
         StartVelocityRange=(X=(Min=-30.000000,Max=30.000000),Y=(Min=-30.000000,Max=30.000000),Z=(Min=14.000000,Max=200.000000))
         VelocityLossRange=(Z=(Min=2.000000,Max=4.000000))
     End Object
     Emitters(0)=SpriteEmitter'DA2.da_effects_Spark.Spark'

     AutoDestroy=True
     bNoDelete=False
}
