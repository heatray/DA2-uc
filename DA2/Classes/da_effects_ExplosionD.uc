// ============================================================================
// Effects by: Czar
// Coded by: aBsOlUt
// Spawns explosion effect after an AlienGrenade detonates.
// ============================================================================

class da_effects_ExplosionD extends Emitter;

#EXEC OBJ LOAD FILE=ParticleMeshes.usx
#EXEC OBJ LOAD FILE=DA2Effects.utx

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=AlienExplosionFlash
         RespawnDeadParticles=False
         UniformSize=True
         ColorMultiplierRange=(Y=(Min=0.200000,Max=0.200000),Z=(Min=0.500000,Max=0.500000))
         MaxParticles=1
         StartSizeRange=(X=(Min=550.000000,Max=550.000000))
         Texture=Texture'Effects_Tex.Weapons.flarefinal2'
         LifetimeRange=(Min=0.150000,Max=0.150000)
     End Object
     Emitters(0)=SpriteEmitter'DA2.da_effects_ExplosionD.AlienExplosionFlash'

     Begin Object Class=SpriteEmitter Name=AlienExplosionSmoke
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=50.000000)
         Opacity=0.500000
         FadeOutStartTime=0.500000
         MaxParticles=25
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=-100.000000,Max=100.000000)
         SpinsPerSecondRange=(X=(Min=-0.250000,Max=0.250000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.500000)
         InitialParticlesPerSecond=1000.000000
         Texture=Texture'DA2Effects.Weapon.Alien_Grenade_Effectf1'
         LifetimeRange=(Min=0.500000,Max=3.000000)
         InitialDelayRange=(Min=0.350000,Max=0.350000)
     End Object
     Emitters(1)=SpriteEmitter'DA2.da_effects_ExplosionD.AlienExplosionSmoke'

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
         MaxParticles=2
         SpinsPerSecondRange=(X=(Min=-0.500000,Max=0.500000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.500000)
         InitialParticlesPerSecond=75.000000
         LifetimeRange=(Min=0.500000,Max=0.750000)
     End Object
     Emitters(2)=MeshEmitter'DA2.da_effects_ExplosionD.AlienExplosionShockWave'

     Begin Object Class=SpriteEmitter Name=AlienExplosionSparks
         UseDirectionAs=PTDU_Up
         UseCollision=True
         UseMaxCollisions=True
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         AutomaticInitialSpawning=False
         Acceleration=(Z=-400.000000)
         DampingFactorRange=(X=(Min=0.400000,Max=0.400000),Y=(Min=0.400000,Max=0.400000),Z=(Min=0.850000,Max=0.850000))
         MaxCollisions=(Min=5.000000,Max=5.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255))
         ColorScale(1)=(RelativeTime=0.500000,Color=(B=6,R=236))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=4,R=179))
         Opacity=0.750000
         FadeOutStartTime=1.250000
         FadeInEndTime=0.200000
         MaxParticles=125
         StartLocationOffset=(Z=-15.000000)
         StartLocationShape=PTLS_Polar
         StartSizeRange=(X=(Min=7.000000,Max=7.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=None
         LifetimeRange=(Min=1.500000,Max=3.250000)
         StartVelocityRange=(X=(Min=-250.000000,Max=250.000000),Y=(Min=-250.000000,Max=250.000000),Z=(Min=-50.000000,Max=550.000000))
     End Object
     Emitters(3)=SpriteEmitter'DA2.da_effects_ExplosionD.AlienExplosionSparks'

     AutoDestroy=True
     bNoDelete=False
}
