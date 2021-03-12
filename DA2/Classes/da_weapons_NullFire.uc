class da_weapons_NullFire extends WeaponFire;

// Just a dummy firemode
event ModeDoFire() {
	return;
}

simulated function bool AllowFire() {
	return false;
}

defaultproperties
{
     bModeExclusive=False
}
