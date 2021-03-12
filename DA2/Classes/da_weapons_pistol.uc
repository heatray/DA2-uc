//-----------------------------------------------------------
//
//-----------------------------------------------------------
class da_weapons_pistol extends da_Weapons_BasicGun abstract;

defaultproperties
{
     FireModeClass(0)=Class'DA2.da_weapons_GunFire'
     FireModeClass(1)=Class'DA2.da_weapons_GunFire'
     SelectSound=Sound'DA2_WeaponSounds.Handguns_Pull'
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.100000
     Priority=4
     ItemName="A pistol"
}
