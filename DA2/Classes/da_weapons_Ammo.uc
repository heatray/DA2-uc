//-----------------------------------------------------------
//
//-----------------------------------------------------------
class da_weapons_ammo extends Ammunition;

var travel  int ammoLeft;

replication {
    reliable if (bNetOwner && ROLE == ROLE_Authority)
        ammoLeft;
}

simulated function bool canReload() {
    return ammoLeft > 0 && ammoAmount < maxAmmo;
}


// Also reload clientside to prevent repeating reloading anims
simulated function reload(optional int amount) {
    local int reqAmmo;

    if (canReload()) {
        reqAmmo = Min(MaxAmmo - ammoAmount, ammoLeft);
        if (amount > 0)
            reqAmmo = Min(amount, reqAmmo);
        ammoLeft -= reqAmmo;
        addAmmo(reqAmmo);
    }
}

simulated function CheckOutOfAmmo()
{
    if (AmmoAmount <= 0)
        Pawn(Owner).Weapon.OutOfAmmo();
}

simulated function bool UseAmmo(int AmountNeeded, optional bool bAmountNeededIsMax) {
    local bool res;
    res = super.useAmmo(AmountNeeded, bAmountNeededIsMax);
    if (da_players_PRI(instigator.PlayerReplicationInfo) != none) {
        da_players_PRI(instigator.PlayerReplicationInfo).weaponInfo.ammo = allAmmo();
    }
    return res;
}

simulated function bool AddAmmo(int AmmoToAdd)
{
    AmmoAmount = Min(MaxAmmo, AmmoAmount+AmmoToAdd);
    if (instigator != none && da_players_PRI(instigator.PlayerReplicationInfo) != none) {
        da_players_PRI(instigator.PlayerReplicationInfo).weaponInfo.ammo = allAmmo();
    }
    return true;
}

function GiveFullAmmo()
{
//Removed, players cant put ammo to a clip without actually reloading.
//   AmmoAmount=default.AmmoAmount;
	if (Instigator.Owner != none)
	{
		if (da_SteamStatsAndAchievements(da_Players_PlayerController(Instigator.Owner).SteamStatsAndAchievements).AmmoboxCompleted) 
			AmmoLeft=default.ammoLeft*1.25;
		else
			AmmoLeft=default.ammoLeft;
	}
}
simulated function int allAmmo() {
	return AmmoAmount + ammoLeft;
}

defaultproperties
{
     ammoLeft=50
     MaxAmmo=10
}
