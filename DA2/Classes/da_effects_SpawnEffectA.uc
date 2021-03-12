// ============================================================================
// Effects by: aBsOlUt
// Coded by: aBsOlUt
// Use it to spawn bosses or other more imporant stuff
// ============================================================================

class da_effects_SpawnEffectA extends Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=ChargeParticles
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UniformSize=True
         UseVelocityScale=True
         LowDetailFactor=1.000000
         ColorScale(0)=(Color=(B=247,G=179,R=176))
         ColorScale(1)=(RelativeTime=0.200000,Color=(B=189,G=9,R=22))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=250,G=187,R=182))
         FadeOutStartTime=1.300000
         FadeInEndTime=0.250000
         MaxParticles=200
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=16.000000,Max=16.000000)
         RevolutionsPerSecondRange=(Z=(Min=0.200000,Max=0.500000))
         RevolutionScale(0)=(RelativeRevolution=(Z=2.000000))
         RevolutionScale(1)=(RelativeTime=0.600000)
         RevolutionScale(2)=(RelativeTime=1.000000,RelativeRevolution=(Z=2.000000))
         SpinsPerSecondRange=(X=(Max=4.000000))
         StartSizeRange=(X=(Min=9.000000,Max=1.000000),Y=(Min=5.000000,Max=3.000000),Z=(Min=14.000000,Max=10.000000))
         Texture=Texture'Effects_Tex.Weapons.flarefinal2'
         LifetimeRange=(Min=1.600000,Max=1.600000)
         StartVelocityRadialRange=(Min=-40.000000,Max=-40.000000)
         VelocityLossRange=(X=(Min=0.200000,Max=0.200000),Y=(Min=0.200000,Max=0.200000),Z=(Min=1.000000,Max=1.000000))
         GetVelocityDirectionFrom=PTVD_AddRadial
         VelocityScale(0)=(RelativeVelocity=(X=2.000000,Y=2.000000,Z=2.000000))
         VelocityScale(1)=(RelativeTime=0.600000)
         VelocityScale(2)=(RelativeTime=1.000000,RelativeVelocity=(X=-10.000000,Y=-10.000000,Z=-10.000000))
     End Object
     Emitters(0)=SpriteEmitter'DA2.da_effects_SpawnEffectA.ChargeParticles'

     Begin Object Class=SpriteEmitter Name=ChargeBall
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UniformSize=True
         FadeOutStartTime=3.000000
         FadeInFactor=(W=2.000000,X=2.000000,Y=2.000000,Z=2.000000)
         FadeInEndTime=2.000000
         Texture=Texture'Effects_Tex.Weapons.flarefinal2'
     End Object
     Emitters(1)=SpriteEmitter'DA2.da_effects_SpawnEffectA.ChargeBall'

     Begin Object Class=SpriteEmitter Name=ExplodeOut
         ProjectionNormal=(Z=0.000000)
         UseColorScale=True
         RespawnDeadParticles=False
         UseRevolutionScale=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseVelocityScale=True
         LowDetailFactor=1.000000
         ColorScale(0)=(Color=(B=217,G=176,R=94))
         ColorScale(1)=(RelativeTime=0.500000,Color=(B=206,G=62,R=69))
         ColorScale(2)=(RelativeTime=0.800000,Color=(B=255,G=128))
         ColorScale(3)=(RelativeTime=1.000000)
         MaxParticles=300
         StartLocationRange=(Z=(Min=-1.000000,Max=1.000000))
         StartLocationShape=PTLS_All
         SphereRadiusRange=(Min=1.000000,Max=1.000000)
         RevolutionsPerSecondRange=(Z=(Max=1.000000))
         RevolutionScale(1)=(RelativeTime=0.125000)
         RevolutionScale(2)=(RelativeTime=0.400000,RelativeRevolution=(X=0.200000,Y=0.200000,Z=0.200000))
         RevolutionScale(3)=(RelativeTime=1.000000,RelativeRevolution=(X=1.000000,Y=1.000000,Z=1.000000))
         UseRotationFrom=PTRS_Normal
         SizeScale(0)=(RelativeSize=3.000000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=2.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=80.000000,Max=20.000000),Z=(Min=60.000000,Max=20.000000))
         ScaleSizeByVelocityMax=0.000000
         InitialParticlesPerSecond=10000.000000
         Texture=Texture'Effects_Tex.Weapons.flarefinal2'
         LifetimeRange=(Min=1.000000,Max=0.800000)
         InitialDelayRange=(Min=3.500000,Max=3.500000)
         StartVelocityRadialRange=(Min=-1600.000000,Max=-1600.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
         VelocityScale(0)=(RelativeVelocity=(X=1.000000,Y=1.000000,Z=1.000000))
         VelocityScale(1)=(RelativeTime=0.050000,RelativeVelocity=(X=1.000000,Y=1.000000,Z=1.000000))
         VelocityScale(2)=(RelativeTime=0.100000,RelativeVelocity=(X=0.010000,Y=0.010000,Z=0.010000))
         VelocityScale(3)=(RelativeTime=1.000000,RelativeVelocity=(X=0.010000,Y=0.010000,Z=0.010000))
     End Object
     Emitters(2)=SpriteEmitter'DA2.da_effects_SpawnEffectA.ExplodeOut'

     AutoDestroy=True
     bNoDelete=False
}
