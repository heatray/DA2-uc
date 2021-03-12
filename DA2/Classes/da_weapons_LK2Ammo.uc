class da_weapons_LK2Ammo extends da_weapons_Ammo;

simulated function reload(optional int amount) {
    super.reload(1);
}

defaultproperties
{
     ammoLeft=40
     MaxAmmo=8
}
