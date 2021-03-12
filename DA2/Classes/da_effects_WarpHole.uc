// ============================================================================
// Effects by: aBsOlUt
// Coded by: aBsOlUt
// For the sky maybe to spawn pods or other alien motherships
// ============================================================================

class da_effects_WarpHole extends Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=Circle
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(1)=(RelativeTime=0.400000,Color=(B=224,G=18,R=208))
         ColorScale(2)=(RelativeTime=0.600000,Color=(B=80,G=40,R=40))
         ColorScale(3)=(RelativeTime=1.000000)
         FadeOutFactor=(W=2.000000,X=2.000000,Y=2.000000,Z=2.000000)
         FadeOutStartTime=5.000000
         CoordinateSystem=PTCS_Relative
         MaxParticles=4
         SpinsPerSecondRange=(X=(Max=0.020000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.200000)
         StartSizeRange=(X=(Min=250.000000,Max=250.000000),Y=(Min=250.000000,Max=250.000000),Z=(Min=120.000000,Max=120.000000))
         Texture=None
         LifetimeRange=(Min=7.000000,Max=7.000000)
         WarmupTicksPerSecond=1.000000
         RelativeWarmupTime=1.000000
     End Object
     Emitters(0)=SpriteEmitter'DA2.da_effects_WarpHole.Circle'

     Begin Object Class=SpriteEmitter Name=Particles
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseRevolution=True
         UniformSize=True
         UseVelocityScale=True
         LowDetailFactor=1.000000
         Acceleration=(X=5.000000,Z=-5.000000)
         ColorScale(0)=(Color=(B=210,G=14,R=216))
         ColorScale(1)=(RelativeTime=0.200000,Color=(B=219,G=130,R=238))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=244,G=123,R=244))
         FadeOutStartTime=1.300000
         FadeInEndTime=0.250000
         MaxParticles=300
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=64.000000,Max=64.000000)
         RevolutionsPerSecondRange=(Z=(Min=0.200000,Max=0.500000))
         RevolutionScale(0)=(RelativeRevolution=(Z=2.000000))
         RevolutionScale(1)=(RelativeTime=0.600000)
         RevolutionScale(2)=(RelativeTime=1.000000,RelativeRevolution=(Z=2.000000))
         SpinsPerSecondRange=(X=(Max=4.000000))
         StartSizeRange=(X=(Min=9.000000,Max=1.000000),Y=(Min=5.000000,Max=3.000000),Z=(Min=14.000000,Max=10.000000))
         Texture=Texture'Effects_Tex.Weapons.flarefinal2'
         LifetimeRange=(Min=2.700000,Max=2.700000)
         InitialDelayRange=(Max=1.000000)
         StartVelocityRadialRange=(Min=-40.000000,Max=-40.000000)
         VelocityLossRange=(X=(Min=0.200000,Max=0.200000),Y=(Min=0.200000,Max=0.200000),Z=(Min=1.000000,Max=1.000000))
         GetVelocityDirectionFrom=PTVD_AddRadial
         VelocityScale(0)=(RelativeVelocity=(X=2.000000,Y=2.000000,Z=2.000000))
         VelocityScale(1)=(RelativeTime=0.600000)
         VelocityScale(2)=(RelativeTime=1.000000,RelativeVelocity=(X=-10.000000,Y=-10.000000,Z=-10.000000))
     End Object
     Emitters(1)=SpriteEmitter'DA2.da_effects_WarpHole.Particles'

     bNoDelete=False
}
