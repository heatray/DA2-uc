// ============================================================================
// Effects by: Czar
// Coded by: aBsOlUt
// Spawns explosion effect after an AlienGrenade detonates.
// ============================================================================

class da_effects_ExplosionC extends Emitter;

#EXEC OBJ LOAD FILE=ParticleMeshes.usx
#EXEC OBJ LOAD FILE=DA2Effects.utx

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=AlienExplosionSmoke
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=10.000000)
         Opacity=0.800000
         FadeOutStartTime=0.500000
         MaxParticles=25
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=-100.000000,Max=100.000000)
         SpinsPerSecondRange=(X=(Min=-0.250000,Max=0.250000))
         SizeScale(0)=(RelativeSize=0.250000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.750000)
         InitialParticlesPerSecond=1000.000000
         Texture=Texture'DA2Effects.Weapon.Alien_Grenade_Effectf1'
         LifetimeRange=(Min=0.250000,Max=1.500000)
     End Object
     Emitters(0)=SpriteEmitter'DA2.da_effects_ExplosionC.AlienExplosionSmoke'

     Begin Object Class=MeshEmitter Name=AlienExplosionShockWave
         UseParticleColor=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorMultiplierRange=(Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         Opacity=0.200000
         FadeOutStartTime=0.250000
         FadeInEndTime=0.250000
         MaxParticles=5
         SpinsPerSecondRange=(X=(Min=-0.500000,Max=0.500000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.500000)
         InitialParticlesPerSecond=75.000000
         LifetimeRange=(Min=0.500000,Max=0.750000)
     End Object
     Emitters(1)=MeshEmitter'DA2.da_effects_ExplosionC.AlienExplosionShockWave'

     Begin Object Class=SpriteEmitter Name=AlienExplosionSparks
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-400.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255))
         ColorScale(1)=(RelativeTime=0.500000,Color=(B=6,R=236))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=4,R=179))
         Opacity=0.750000
         FadeOutStartTime=1.250000
         FadeInEndTime=0.200000
         MaxParticles=100
         StartLocationOffset=(Z=-15.000000)
         StartLocationShape=PTLS_Polar
         StartSizeRange=(X=(Min=20.000000,Max=20.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=None
         LifetimeRange=(Min=1.000000,Max=2.500000)
         StartVelocityRange=(X=(Min=-250.000000,Max=250.000000),Y=(Min=-250.000000,Max=250.000000),Z=(Min=-50.000000,Max=450.000000))
     End Object
     Emitters(2)=SpriteEmitter'DA2.da_effects_ExplosionC.AlienExplosionSparks'

     bNoDelete=False
}
