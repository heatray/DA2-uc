// Unreal Script :
// Author:

class da_weapons_ModeChangeFire extends WeaponFire;

function PlayFiring();

simulated function bool AllowFire() {
	return true;
}

function ServerPlayFiring();

event ModeDoFire() {
	da_weapons_BasicGun(Weapon).ToggleMode();
	super.ModeDoFire();
}

defaultproperties
{
     bWaitForRelease=True
     bModeExclusive=False
     BotRefireRate=0.300000
}
