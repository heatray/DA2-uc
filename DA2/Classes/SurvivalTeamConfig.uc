class SurvivalTeamConfig extends da_players_TeamConfig;

simulated function setDefaultClassSet() {
	local da_players_ClassInfo cInfo;

	if (team < 0 || team > 1) {
	   warn("team out of range!");
	   return;
	}

	classSet= spawn( class'da_players_ClassSet' ); //SET DEFAULT class SET

			cInfo = classSet.addClassInfo();
			cInfo.name= "Rifleman";
			cInfo.addWeaponSet().weapon = class'DA2.da_weapons_rifles_MR56AR_SR';
            cInfo.addWeaponSet().weapon = class'DA2.da_weapons_XD40Handgun';
            cInfo.grenadeclass =class'DA2.da_weapons_humanGrenade';
            cInfo.grenadenumber=3;
            cInfo.armor= 10;
            cInfo.classSpawnDelay=6;
            cInfo.classSpeed=280;

            cInfo = classSet.addClassInfo();
			cInfo.name= "Mechanic";
            cInfo.addWeaponSet().weapon = class'DA2.da_weapons_GK2Shotgun';
            cInfo.addWeaponSet().weapon = class'DA2.da_weapons_P280Handgun';
            cInfo.addWeaponSet().weapon = class'DA2.da_weapons_MechTool';
            cInfo.grenadeclass = class'da_proj_thermiteGrenade_SR';
			cInfo.grenadenumber=1;
            cInfo.armor= 0;
            cInfo.classSpawnDelay=6;
            cInfo.classSpeed=260;
            cInfo.bCanBuild = true;

			cInfo = classSet.addClassInfo();
			cInfo.name= "Medic";
			cInfo.addWeaponSet().weapon = class'DA2.da_weapons_LK2Shotgun';
            cInfo.addWeaponSet().weapon = class'DA2.da_weapons_XD40Handgun';
            cInfo.grenadeclass = class'DA2.da_weapons_humanGrenade';
            cInfo.auraHealPerSec = 10;
            cInfo.auraHealRadius = 300.0;
			cInfo.grenadenumber=2;
            cInfo.armor= 0;
            cInfo.classSpawnDelay=6;
            cInfo.classSpeed=320;

            cInfo = classSet.addClassInfo();
			cInfo.name= "Gunner";
			cInfo.addWeaponSet().weapon = class'DA2.da_weapons_rifles_MR40Heavy_SR';
            cInfo.addWeaponSet().weapon = class'DA2.da_weapons_P280Handgun';
            cInfo.grenadeclass = class'DA2.da_proj_thermiteGrenade_SR';
			cInfo.grenadenumber=2;
            cInfo.armor= 0;
            cInfo.classSpawnDelay=6;
            cInfo.classSpeed=270;
			cInfo.bCanUseTurrets = true;

			cInfo = classSet.addClassInfo();
			cInfo.name= "Sniper";
   			cInfo.addWeaponSet().weapon = class'DA2.da_weapons_rifles_SniperRifle_SR';
			cInfo.addWeaponSet().weapon = class'DA2.da_weapons_XD40Handgun';
			cInfo.grenadeclass = class'DA2.da_weapons_humanGrenade';
			cInfo.grenadenumber=2;
            cInfo.armor= 0;
            cInfo.classSpawnDelay=6;
            cInfo.classSpeed=250;
			cInfo.bStealth=true;

		    cInfo = classSet.addClassInfo();
		    cInfo.name= "Rocketeer";
		    //cInfo.addWeaponSet().weapon = class'DA2.da_weapons_MS25RocketLauncher_SR';
		    cInfo.addWeaponSet().weapon = class'DA2.da_weapons_P280Handgun';
		    cInfo.grenadeclass = class'DA2.da_proj_PlasmaBomb';
            cInfo.grenadenumber=1;
		    cInfo.classSpawnDelay=7;
		    cInfo.armor= 15;
            cInfo.classSpeed=240;

		    cInfo = classSet.addClassInfo();
		    cInfo.name= "Engineer";
		    cInfo.addWeaponSet().weapon = class'DA2.da_weapons_rifles_A9SMG_SR';
		    cInfo.addWeaponSet().weapon = class'DA2.da_weapons_XD40Handgun';
            cInfo.addWeaponSet().weapon = class'DA2.da_weapons_MechTool';
		    cInfo.grenadeclass = class'DA2.da_proj_APMine';
            cInfo.grenadenumber=3;
		    cInfo.classSpawnDelay=6;
		    cInfo.armor= 0;
            cInfo.classSpeed=320;
            cInfo.bCanBuild = true;
		    cInfo.bCanOnlyRepair=true;

	log("Setting default-SurvivalTeamConfig :"$classSet);
}

defaultproperties
{
     numAmmoboxes=4
     numDFAs=1
}
