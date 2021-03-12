class da_players_TeamConfig extends ReplicationInfo placeable;

var(DA)		int 					team;		// config which team (0-Defence Alliance, 1-The Horde)
var(DA)		da_players_ClassSet		classSet;	// Use this classSet ( Might also be none for default )
var(DA)		string					teamName;   // Team name correspoding to team number
var(DA)     int                     teamLifes;  // 0 - infinite
var(DA)		int						numAmmoboxes; //Limit of ammoboxes
var(DA)		int						numAVeRs; //Limit of Crusher turret
var(DA)		int						numCrushers; //Limit of Crusher turret
var(DA)		int						numDFAs; //Limit of DFA Turrets
var		    bool                    bHack;	// false in defaultproperties and true later to force postnetbeginplay on clientside


var(DA) enum EBotBehaviour //What is the default command bots should do once the map starts
{
Attack, //Attack first priority objective
Defend, //Defend first priority objective
Sweeper, //Search and Destroy
Random //Some will defend some will attack, no sweepers.
} BotBehaviour;


replication {
	reliable if (ROLE == ROLE_Authority)
		team, bHack, teamName;
}

simulated event PostNetBeginPlay() {
	local da_players_ClassSet cs;

	super.PostNetBeginPlay();

	foreach allactors(class'da_players_ClassSet', cs)
		if (cs.team == team)
			classSet = cs;
	if (cs == none)
		setDefaultClassSet();
}

simulated event BeginPlay() {
	bHack = true;	// ooooh hack
	super.beginPlay();
}

simulated function setDefaultClassSet() {
	local da_players_ClassInfo cInfo;

	if (team < 0 || team > 1) {
	   warn("team out of range!");
	   return;
	}

	classSet= spawn( class'da_players_ClassSet' ); //SET DEFAULT class SET

	switch ( team ) {
		case 0: //Defenders
			cInfo = classSet.addClassInfo();
			cInfo.name= "Rifleman";
			cInfo.addWeaponSet().weapon = class'DA2.da_weapons_rifles_MR56AR';
            cInfo.addWeaponSet().weapon = class'DA2.da_weapons_XD40Handgun';
            cInfo.grenadeclass =class'DA2.da_weapons_humanGrenade';
            cInfo.grenadenumber= 3;
            cInfo.armor= 60;
            cInfo.classSpawnDelay=9;
            cInfo.classSpeed=280;

            cInfo = classSet.addClassInfo();
			cInfo.name= "Mechanic";
            cInfo.addWeaponSet().weapon = class'DA2.da_weapons_GK2Shotgun';
            cInfo.addWeaponSet().weapon = class'DA2.da_weapons_P280Handgun';
            cInfo.addWeaponSet().weapon = class'DA2.da_weapons_MechTool';
            cInfo.grenadeclass = class'DA2.da_proj_APMine';
			cInfo.grenadenumber=2;
            cInfo.armor= 40;
            cInfo.classSpawnDelay=12;
            cInfo.classSpeed=260;
            cInfo.bCanBuild = true;

			cInfo = classSet.addClassInfo();
			cInfo.name= "Medic";
			cInfo.addWeaponSet().weapon = class'DA2.da_weapons_LK2Shotgun';
            cInfo.addWeaponSet().weapon = class'DA2.da_weapons_XD40Handgun';
            cInfo.grenadeclass = class'DA2.da_proj_EMPGrenade';
            cInfo.auraHealPerSec = 10;
            cInfo.auraHealRadius = 300.0;
			cInfo.grenadenumber=2;
            cInfo.armor= 30;
            cInfo.classSpawnDelay=9;
            cInfo.classSpeed=320;

            cInfo = classSet.addClassInfo();
			cInfo.name= "Gunner";
			cInfo.addWeaponSet().weapon = class'DA2.da_weapons_rifles_MR40Heavy';
            cInfo.addWeaponSet().weapon = class'DA2.da_weapons_P280Handgun';
            cInfo.grenadeclass = class'DA2.da_proj_thermiteGrenade';
			cInfo.grenadenumber=2;
            cInfo.armor= 20;
            cInfo.classSpawnDelay=12;
            cInfo.classSpeed=270;
			cInfo.bCanUseTurrets = true;

			cInfo = classSet.addClassInfo();
			cInfo.name= "Sniper";
   			cInfo.addWeaponSet().weapon = class'DA2.da_weapons_rifles_SniperRifle';
			cInfo.addWeaponSet().weapon = class'DA2.da_weapons_XD40Handgun';
			cInfo.grenadeclass = class'DA2.da_weapons_humanGrenade';
			cInfo.grenadenumber=2;
            cInfo.armor= 0;
            cInfo.classSpawnDelay=15;
            cInfo.classSpeed=250;
			cInfo.bStealth=true;

		    cInfo = classSet.addClassInfo();
		    cInfo.name= "Rocketeer";
		    cInfo.addWeaponSet().weapon = class'DA2.da_weapons_MS25RocketLauncher';
		    cInfo.addWeaponSet().weapon = class'DA2.da_weapons_rifles_A9SMG';
		    cInfo.grenadeclass = class'da_weapons_humanGrenade';
            cInfo.grenadenumber=3;
		    cInfo.classSpawnDelay=15;
		    cInfo.armor= 70;
            cInfo.classSpeed=240;

	break;
	case 1: //Attackers

			cInfo = classSet.addClassInfo();
			cInfo.name= "Rifleman";
			cInfo.addWeaponSet().weapon = class'DA2.da_weapons_rifles_MR56AR';
            cInfo.addWeaponSet().weapon = class'DA2.da_weapons_XD40Handgun';
            cInfo.grenadeclass = class'DA2.da_weapons_humanGrenade';
            cInfo.grenadenumber= 3;
            cInfo.armor= 60;
            cInfo.classSpawnDelay=1;
            cInfo.classSpeed=280;

            cInfo = classSet.addClassInfo();
			cInfo.name= "Mechanic";
            cInfo.addWeaponSet().weapon = class'DA2.da_weapons_GK2Shotgun';
            cInfo.addWeaponSet().weapon = class'DA2.da_weapons_P280Handgun';
            cInfo.addWeaponSet().weapon = class'DA2.da_weapons_MechTool';
            cInfo.grenadeclass = class'DA2.da_proj_thermiteGrenade';
			cInfo.grenadenumber=1;
            cInfo.armor= 40;
            cInfo.classSpawnDelay=2;
            cInfo.classSpeed=260;
            cInfo.bCanBuild = true;

			cInfo = classSet.addClassInfo();
			cInfo.name= "Medic";
			cInfo.addWeaponSet().weapon = class'DA2.da_weapons_LK2Shotgun';
            cInfo.addWeaponSet().weapon = class'DA2.da_weapons_XD40Handgun';
            cInfo.grenadeclass = class'DA2.da_proj_EMPGrenade';
            cInfo.auraHealPerSec = 10;
            cInfo.auraHealRadius = 300.0;
			cInfo.grenadenumber=2;
            cInfo.armor= 30;
            cInfo.classSpawnDelay=1;
            cInfo.classSpeed=340;

            cInfo = classSet.addClassInfo();
			cInfo.name= "Gunner";
			cInfo.addWeaponSet().weapon = class'DA2.da_weapons_rifles_MR40Heavy';
            cInfo.addWeaponSet().weapon = class'DA2.da_weapons_P280Handgun';
            cInfo.grenadeclass = class'DA2.da_proj_thermiteGrenade';
			cInfo.grenadenumber=2;
            cInfo.armor= 20;
            cInfo.classSpawnDelay=2;
            cInfo.classSpeed=275;
			cInfo.bCanUseTurrets = true;

			cInfo = classSet.addClassInfo();
			cInfo.name= "Sniper";
   			cInfo.addWeaponSet().weapon = class'DA2.da_weapons_rifles_SniperRifle';
			cInfo.addWeaponSet().weapon = class'DA2.da_weapons_XD40Handgun';
			cInfo.grenadeclass = class'DA2.da_proj_EMPGrenade';
			cInfo.grenadenumber=2;
            cInfo.armor= 0;
            cInfo.classSpawnDelay=3;
            cInfo.classSpeed=250;
			cInfo.bStealth=true;

		    cInfo = classSet.addClassInfo();
		    cInfo.name= "Rocketeer";
		    cInfo.addWeaponSet().weapon = class'DA2.da_weapons_MS25RocketLauncher';
		    cInfo.addWeaponSet().weapon = class'DA2.da_weapons_rifles_A9SMG';
		    cInfo.grenadeclass = class'DA2.da_proj_PlasmaBomb';
            cInfo.grenadenumber=1;
		    cInfo.classSpawnDelay=3;
		    cInfo.armor= 70;
            cInfo.classSpeed=240;

	break;
	}
	log("Setting default-TeamConfig for team "$team$" :"$classSet);
}

simulated function Destroyed()
{
    super.Destroyed();

    if (classSet != none)
    {
        classSet.Destroy();
        classSet = none;
    }
}

defaultproperties
{
     TeamName="Defence Alliance"
     numAmmoboxes=3
     numAVeRs=1
     numCrushers=1
     numDFAs=2
     Texture=Texture'DA2Textures.editing.icon_teamconfig'
     Style=STY_Translucent
     bNetNotify=True
}
