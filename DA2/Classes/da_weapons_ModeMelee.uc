// Unreal Script :
// Author:

class da_weapons_ModeMelee extends WeaponFire;

function PlayFiring();

//simulated function bool AllowFire() {
//	return true;
//}

function ServerPlayFiring();

event ModeDoFire() {
	if (!da_weapons_BasicGun(Weapon).bGrenadeHack) {
		da_weapons_Reloadable(Weapon).MeleeAttack();
		super.ModeDoFire();
	}
}

defaultproperties
{
     bWaitForRelease=True
     FireRate=1.900000
     BotRefireRate=1.200000
}
