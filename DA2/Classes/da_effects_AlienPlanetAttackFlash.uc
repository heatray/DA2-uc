//-----------------------------------------------------------
//
//-----------------------------------------------------------
class da_effects_AlienPlanetAttackFlash extends Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=AlienExplosionFlash
         RespawnDeadParticles=False
         UniformSize=True
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.600000),Y=(Min=0.400000,Max=0.400000),Z=(Min=0.400000,Max=0.600000))
         MaxParticles=2
         StartSizeRange=(X=(Min=1000.000000,Max=5000.000000))
         Texture=Texture'Effects_Tex.Weapons.flarefinal2'
         LifetimeRange=(Min=0.150000,Max=0.150000)
     End Object
     Emitters(0)=SpriteEmitter'DA2.da_effects_AlienPlanetAttackFlash.AlienExplosionFlash'

     bNoDelete=False
}
