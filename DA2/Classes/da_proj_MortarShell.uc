class da_proj_MortarShell extends da_proj_projectile;


simulated function PostNetBeginPlay()
{
  if(frand()<0.5)
        SetTimer(frand()/2+2.5, false);
    PlaySound(sound'DA2_Weaponsounds.P280_fire',,3,,300,0.5+frand()*0.1,true);
}

simulated function Timer()
{
    PlayOwnedSound(sound'DA2_Various.MortarShellAmb',,1+frand()/2,,250,0.90+frand()*0.2,true);
}

simulated function Tick(float deltatime)
{
    Super.Tick(DeltaTime);
    SetRotation(rotator(velocity));
}

defaultproperties
{
     ExplosionSounds(0)=Sound'DA2_WeaponSounds.explosions.Grenade_Explosion1'
     ExplosionSounds(1)=Sound'DA2_WeaponSounds.explosions.Grenade_Explosion2'
     ExplosionSounds(2)=Sound'DA2_WeaponSounds.explosions.Grenade_Explosion3'
     ExplosionSounds(3)=Sound'DA2_WeaponSounds.explosions.Grenade_Explosion4'
     ExplosionSoundFar=Sound'DA2_WeaponSounds.MS25_ExplosionFar'
     ExpSoundsNum=4
     Dispersion=50.000000
     Armor=10.000000
     ProjTrail=Class'DA2.da_effects_MortarTrail'
     Speed=2600.000000
     MaxSpeed=3000.000000
     Damage=200.000000
     DamageRadius=400.000000
     MomentumTransfer=60000.000000
     MyDamageType=Class'DA2.da_damtypes_Mortar'
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'DA_WeaponPickupSM.shells.122mm_shell'
     Acceleration=(Z=-750.000000)
     DrawScale=0.700000
     TransientSoundVolume=4.500000
     TransientSoundRadius=400.000000
}
