// ============================================================================
// Effects by: aBsOlUt
// Coded by: aBsOlUt
// Artillery boom once it hits the ground
// ============================================================================

class da_effects_artilleryBoom extends Emitter;

#EXEC OBJ LOAD FILE=DA2Effects.utx

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=ExplosionBody
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=30.000000)
         Opacity=0.800000
         FadeOutFactor=(W=0.400000,X=0.400000,Y=0.400000,Z=0.400000)
         FadeOutStartTime=0.500000
         MaxParticles=25
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=-100.000000,Max=100.000000)
         SpinsPerSecondRange=(X=(Min=-0.250000,Max=0.250000))
         SizeScale(0)=(RelativeSize=0.250000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.750000)
         StartSizeRange=(X=(Min=155.000000,Max=155.000000),Y=(Min=155.000000,Max=155.000000),Z=(Min=155.000000,Max=155.000000))
         InitialParticlesPerSecond=2000.000000
         Texture=Texture'DA2Effects.Weapon.Alien_Artillery'
         LifetimeRange=(Min=0.250000,Max=1.500000)
     End Object
     Emitters(0)=SpriteEmitter'DA2.da_effects_artilleryBoom.ExplosionBody'

     Begin Object Class=SpriteEmitter Name=ExplosionSparks
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-400.000000)
         ColorScale(0)=(Color=(B=162,G=162,R=162))
         ColorScale(1)=(RelativeTime=0.500000,Color=(B=247,G=34,R=55))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=155,G=2,R=10))
         Opacity=0.750000
         FadeOutStartTime=1.250000
         FadeInEndTime=0.200000
         MaxParticles=100
         StartLocationOffset=(Z=-15.000000)
         StartLocationShape=PTLS_Polar
         StartSizeRange=(X=(Min=40.000000,Max=40.000000))
         InitialParticlesPerSecond=8000.000000
         Texture=Texture'da2effects2.EmitterTextures.Part_explode2'
         LifetimeRange=(Min=1.000000,Max=2.500000)
         StartVelocityRange=(X=(Min=-250.000000,Max=250.000000),Y=(Min=-250.000000,Max=250.000000),Z=(Min=-50.000000,Max=450.000000))
     End Object
     Emitters(1)=SpriteEmitter'DA2.da_effects_artilleryBoom.ExplosionSparks'

     bNoDelete=False
}
