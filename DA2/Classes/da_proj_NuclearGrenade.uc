class da_proj_NuclearGrenade extends da_weapons_BasicGrenade;

defaultproperties
{
     ExplosionEmitter=Class'DA2.da_effects_NuclearGrenadeFX'
     ExplosionSounds(0)=Sound'DA2_WeaponSounds.explosions.Grenade_Explosion5'
     ExplosionSoundFar=Sound'DA2_WeaponSounds.explosions.Grenade_Explosion5_far'
     ExpSoundsNum=1
     Speed=650.000000
     MaxSpeed=650.000000
     Damage=450.000000
     DamageRadius=450.000000
     MyDamageType=Class'DA2.da_damtypes_NuclearGrenade'
     LifeSpan=4.500000
     DrawScale=2.300000
     Skins(0)=Texture'DA2Weapons.Skins.Grenade_Nuclear'
     bFullVolume=True
     SoundVolume=255
     SoundRadius=96.000000
     TransientSoundVolume=25.000000
     TransientSoundRadius=750.000000
     CollisionRadius=2.000000
     CollisionHeight=2.000000
}
