// ============================================================================
// Effects by: Czar
// Coded by: aBsOlUt
// Effect when the alien grenade is thrown.
// ============================================================================

class da_effects_TrailEffectA extends Emitter;

#EXEC OBJ LOAD FILE=DA2Effects.utx

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=AlienPlasmaFire
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UniformSize=True
         Acceleration=(Z=100.000000)
         Opacity=0.800000
         FadeOutStartTime=0.350000
         FadeInEndTime=0.100000
         MaxParticles=80
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=2.000000,Max=10.000000)
         SpinsPerSecondRange=(X=(Min=-0.250000,Max=0.250000))
         StartSizeRange=(X=(Min=20.000000,Max=30.000000))
         Texture=Texture'DA2Effects.Weapon.Alien_Grenade_Effectf1'
         LifetimeRange=(Min=0.400000,Max=0.500000)
     End Object
     Emitters(0)=SpriteEmitter'DA2.da_effects_TrailEffectA.AlienPlasmaFire'

     AutoDestroy=True
     bNoDelete=False
     Physics=PHYS_Trailer
}
