class da_players_ClassInfo extends Info;

var string name; //Name of this class
var da_players_WeaponSet Weapons[10]; //Weapons given to this class
var int grenadenumber; //Amount of grenades
var class<projectile> GrenadeClass;
var int armor; //Armor?
var int classSpeed; //Groundspeed
var int classSpawnDelay; //Seconds until this class can spawn
var int auraHealPerSec;
var float auraHealRadius;
var bool bStealth;
var bool bCanBuild;
var bool bCanOnlyRepair;
var bool bCanUseTurrets;

replication
{
 reliable if (Role == ROLE_Authority)
          classSpawnDelay, grenadenumber, armor, classSpeed, bCanBuild;
}

simulated function da_players_WeaponSet addWeaponSet()
{
    local int i;

	for (i = 0;true; i++)
        if (Weapons[i] == none) {
            Weapons[i] = spawn(class'da_players_WeaponSet');
            return Weapons[i];
        }
}

simulated function Destroyed()
{
    local int i;

    super.Destroyed();

	for (i = 0;i < ArrayCount(Weapons); i++)
	{
        if (Weapons[i] != none)
        {
            Weapons[i].Destroy();
            Weapons[i] = none;
        }
    }
}

defaultproperties
{
}
