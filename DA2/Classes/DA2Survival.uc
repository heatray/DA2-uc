// FGSurvival by CNSDEV (cns@cnsdev.dk)
//  - Perhaps include or create seperately mutation for changing turret limit values.
//  X Override draw radar and remove objective marker.. Customize the display, remove self and make boss more visible
//  X Dynamic difficulty. (Configurable)
//  X Perhaps change lives left to respawns left, use ModifyPlayer to subtract respawns orr....
//  X Tweak health of zombies.
//  - Rework zombie squad mechanisms, primarily needs less FPs (Lottery system perhaps)
//  X Scale Turret Damage, Sniper dmg etc.
//  - Try to find some icons for the HUD :)
//  - Consider removing invisible walls, not needed in Survival!
//  X Fix respawn so players are not in third person.
//  X Turrets built in Prep time not auto firing.
//  X DD goes to Level 7 a little too easily. (Add array with infestation %, calculate average 5-10 waves and base diff on that) Also do not allow to raise diff when boss is alive-
//  - Consider adding difficulty levels above 7 with perhaps special waves (like full stalker mode, full crawler etc.)
//  X Consider awarding score for damage dealt instead of kills.
//  % Consider implementing champion functionality and spawn 3 champions, one every 500 kills and then the pat at the forth 500 kill.
//  X Some players are still spawned at the wrong team.
//  - HUD timer never goes below 1 or 2 seconds left. Remember to update it after assault ends :)
//  - Could be fun with RPG say messages over people's heads! ^^
//  - Make a bloat explode on death? ooh
//  X Remember to consider floating healthbars, yep.
//  X Make some broadcast thingy so we can move text over the crosshair
//  - Consider the possibility of creating highscores for each champ and the final pat, also pause the game after kill and show scoreboard and rewards? Cool.
//  X Lower stalker damage ever so slightly.
//  X Change HUD, Players vs Zombies (%)
//  X Boost scrake slightly?
//  ? Work on impact visual solution, bloodsplatter.
//  - Consider implementing some kind of highscore function that either requests and submits info to a webservice or to a local file / config.
//  - Add class topscore to the scoreboard, right side. (Or rather, most damage inflicted, most health healed, most ammo supplied)
//  - Add healing amount/ammo supplied/damage dealt to the scoreboard. Reduce the size so more players fit onto the screen.
//  - Also add healing and ammo supplied to the custom score system but it requires custom gametype first because we need to overwrite da_players_ClassPlayer and the ammobox class. (Waiting for gametype)
//  X Lifeless clones at enemy spawn at start of game? Also players who did marked as out of lives when there are team lives left, set as not out of lives.
//  X Fix Champion HUD healthbar, size and base draw shit.
//  X Title (server name) on Scoreboard too short, title gets clipped :o
//  X After time runs out, the game still cannot remove all zombies. fix fix!
//  - Fix the turret amount/limit HUD when we overwrite turrets, replicate Team and mechOwner. Use mechOwner to make a HUD display of turret status to the owners.
//=============================================================================
class DA2Survival extends Mutator config;

var int prepTimeElapsed;
var() config int StartTime, MaxZombies, MinZombies, MinimumInfestation, MaxChampPerWave;
var() config bool ShareLives, ShowDebug, ForceSpawnBoss, TrackBuildings, DynamicDifficulty, ChampionBased, NoTurrets;
var() config float ZombieMod, ZombiesPerPlayer, AverageDDUp, AverageDDDown, AverageDDRange;
var int zombiesSpawned, zombiesKilled, waveIndex, maximumDensity, livesLeft, waveCount, wavesOnDifficulty, playerKills, championsSpawned, tickCounter;
var bool bossActive, waveChilled, playerSpawned, updateBuildCounts;
var float integrityMod, fallbackDifficulty;
var KFMonster recentBoss;
var array<NavigationPoint> zombieSpawnPoints;
var array<string> debugRegs;
var array<int> wavePercentages;
var string mutVersion, mutName, serverName;
var Controller latestRespawn;
var bool GameTime20;

var SurvivalGameReplicationInfo SGRI;
var SurvivalPlayerReplicationInfo SPRI;

enum ZombieType { Clot, Stalker, Crawler, GoreFast, Husk, Siren, Fleshpound, Scrake, Bloat, Boss };
enum dDifficulty { NoAction, Increase, Decrease };
enum RessurectRule { Random, HighestScore, TimeElapsed }; // TimeElapsed = The one that has been dead the longest, might require new gamemode first.

struct ZombieDamaged
{
	var KFMonster zombie;
	var int playerId;
	var float amount;
	var bool safeToDelete;
};
var array<ZombieDamaged> dmgZombie;

static function FillPlayInfo(PlayInfo PlayInfo) 
{
	Super.FillPlayInfo(PlayInfo);  // Always begin with calling parent

	PlayInfo.AddSetting("Survival", "StartTime", "Wave start time in seconds", 0, 1, "Text", "3;0:300");
	PlayInfo.AddSetting("Survival", "MaxZombies", "Maximum amount of zombies allowed ingame.", 0, 2, "Text", "3;1:200");
	PlayInfo.AddSetting("Survival", "ZombiesPerPlayer", "Base amount of zombies per player.", 0, 3, "Text", "5;1:10");
	PlayInfo.AddSetting("Survival", "MinZombies", "Minimum amount of zombies per player spawned before Patriarch can appear.", 0, 4, "Text", "3;8:250");
	PlayInfo.AddSetting("Survival", "ZombieMod", "Modify amount of zombies spawned each wave.", 0, 5, "Text", "5;0.1:3.0");
	PlayInfo.AddSetting("Survival", "MinimumInfestation", "The lower infestation threshold that spawns the patriarch", 0, 6, "Text", "3;5.0:30.0");
	PlayInfo.AddSetting("Survival", "ShareLives", "Share lives between all members of the survivors.", 0, 7, "Check");
	PlayInfo.AddSetting("Survival", "NoTurrets", "Turrets will not be built at the beginning of each game.", 0, 8, "Check");
	//PlayInfo.AddSetting("Survival", "MaxChampPerWave", "Max champions per wave.", 0, 9, "Text", "3;0:5");
	//PlayInfo.AddSetting("Survival", "ChampionBased", "Changes minimum zombies spawned before Patriarch appears, to minimum champions spawned.", 0, 10, "Check");

	//PlayInfo.AddSetting("Dynamic Difficulty", "DynamicDifficulty", "Let the Mutator decide the difficulty of the game based on player performance.", 0, 0, "Check");
	PlayInfo.AddSetting("Dynamic Difficulty", "AverageDDUp", "Average infestation should be below this threshold to increase game difficulty", 0, 1, "Text", "5;1.0:75.0");
	PlayInfo.AddSetting("Dynamic Difficulty", "AverageDDDown", "Average infestation should be above this threshold to decrease game difficulty", 0, 2, "Text", "5;25.0:99.0");
	PlayInfo.AddSetting("Dynamic Difficulty", "AverageDDRange", "Amount of waves to calculate average on", 0, 3, "Text", "5;1:10");
}

function PreBeginPlay()
{
	local vehicle t;
	//local SurvivalPlayerController pc;
	
	//pc = SurvivalPlayerController(owner);

	//Level.Game.HUDType="SurvivalHud";
	//DefenceAlliance(Level.Game).HUDType="SurvivalHud";
	
	//pc.myHUD.bCrosshairShow=false;

	if (Level.Game!=none && Level.Game.IsA('DefenceAlliance'))
	{
		DefenceAlliance(Level.Game).GameReplicationInfoClass=Class'DA2.SurvivalGameReplicationInfo';
		DefenceAlliance(Level.Game).PlayerControllerClassName="DA2.SurvivalPlayerController"; //needed for SurvivalChooseClass at gamestart
		DefenceAlliance(Level.Game).HUDType = "DA2.SurvivalHud";
		DefenceAlliance(Level.Game).ScoreBoardType="DA2.SurvivalScoreBoard";
        DefenceAlliance(Level.Game).DefaultPlayerClassName="DA2.SurvivalClassPlayer"; //needed for class exclusive skins
		DefenceAlliance(Level.Game).bBalanceTeams = false;
		DefenceAlliance(Level.Game).SpawnProtectionTime=0.000000;
		DefenceAlliance(Level.Game).bSpawnInTeamArea = true;
		DefenceAlliance(Level.Game).ThisIsSurvival = true;
		//DefenceAlliance(Level.Game).bPlayersVsBots = true;
		//DefenceAlliance(Level.Game).bAllowPlayerLights = true;
		//DefenceAlliance(Level.Game).GoreLevel = 3;
		DefenceAlliance(Level.Game).LoginMenuClass="DA2.SurvivalPlayerLoginMenu";
		teamgame(level.game).bforcerespawn = false;
	}

	if (NoTurrets)
	{
		foreach allactors(class'vehicle', t)
		{
			if(t!=none&&t.isa('da_turrets_Turret'))
			{
				da_turrets_Turret(t).bstartbuilt=false;
			}
		}
	}

	super.PostBeginPlay();

	//SGRI = SurvivalGameReplicationInfo(Level.Game.GameReplicationInfo);	
}

function PostBeginPlay()
{
	local GameRules gameRule;
	local actor l;
	local SurvivalTeamConfig 	config;
	local int	i, j;
	local string MapName;

	//SGRI = SurvivalGameReplicationInfo(GameReplicationInfo);

	gameRule = spawn(class'SurvivalMode');

	if (Level.Game != none)
	{
		if (Level.Game.GameRulesModifiers == none)
			Level.Game.GameRulesModifiers = gameRule;
		else Level.Game.GameRulesModifiers.AddGameRules(gameRule);

		SurvivalMode(gameRule).mut = self;

		//GiveTurretsAI();


			// Get the MapName out of the URL
			MapName = Level.GetLocalURL();

			i = InStr(MapName, "/") + 1;
			if ( i < 0 || i > 16 )
			{
				i = 0;
			}

			j = InStr(MapName, "?");
			if ( j < 0 )
			{
				j = Len(MapName);
			}

			if ( Mid(MapName, j - 3, 3) ~= "rom" )
			{
				j -= 4;
			}

			MapName = Mid(MapName, i, j - i);

		log("MapName:"@MapName);


		foreach allactors(class'actor', l)
		{
			if(l!=none&&l.isa('mover'))
			mover(l).InterpolateTo( 1, 1);

			if (l!=none&&l.IsA('da_map_AmbFXManager'))
				da_map_AmbFXManager(l).Active = false;
				
			if (l!=none&&l.IsA('da_zombie_PlayerStart'))
				da_zombie_PlayerStart(l).bEnabled = true;

			if(l!=none&&l.IsA('TriggeredPlayerStart'))
				if ((TriggeredPlayerStart(l).TeamNumber == 0) && ( MapName ~= "DA2-Triumph"  ||  MapName ~= "DA2-Triumph2" ))
				TriggeredPlayerStart(l).bEnabled = true;

			if (BlockedPath(l) != none)
				BlockedPath(l).bBlocked = false;
		}
	}


	//Team Config
	foreach AllActors(class'SurvivalTeamConfig', config)
		SGRI.TeamConfig[config.team]= config;

	for ( i=0; i < 2; i++ )
		if (SGRI.TeamConfig[i] == None)
		{
		    log("-> Setting default-SurvivalTeamConfig for team "$i);
			SGRI.TeamConfig[i]= getDefaultSurvivalTeamConfig(i);
		}
		else
            log("-> Found map-SurvivalTeamConfig for team "$i);

	Super.PostBeginPlay();
}

function da_players_TeamConfig getDefaultSurvivalTeamConfig(int team) 
{
	local SurvivalTeamConfig config;

	if (team < 0 || team > 1) {
	   warn("-> Team "$team$" out of range.");
	   return None;
	}

	log("-> using getDefaultSurvivalTeamConfig");

	config= spawn( class'SurvivalTeamConfig' );
	config.team=team;
	return config;
}

function Tick(float DeltaTime)
{

	tickCounter++;

	
	if ((tickCounter % 300) == 0)
	{
		if (SurvivalGameReplicationInfo(Level.Game.GameReplicationInfo) != none)
		{
			if (recentBoss!=none)
			{
				if (recentBoss.Health != SurvivalGameReplicationInfo(Level.Game.GameReplicationInfo).bossHealth)
					SurvivalGameReplicationInfo(Level.Game.GameReplicationInfo).bossHealth = recentBoss.Health;
			}

			SurvivalGameReplicationInfo(Level.Game.GameReplicationInfo).numPlayers = GetPlayerCount();
		}
	}

	if ((tickCounter % 1000) == 0)
		CleanZombieDamagedIndex();

	if (tickCounter > 10000)
		tickCounter = 0;

}



function ModifyPlayer(Pawn Other)
{
local da_weapons_Grenades grenades;
local Weapon newWeapon;

if (other.controller != none )
{

if (SurvivalPlayerReplicationInfo(PlayerController(Other.controller).PlayerReplicationInfo) != none)
	SPRI = SurvivalPlayerReplicationInfo(PlayerController(Other.controller).PlayerReplicationInfo);
	
if (SurvivalGameReplicationInfo(Level.Game.GameReplicationInfo) != none)
	SGRI = SurvivalGameReplicationInfo(Level.Game.GameReplicationInfo);
	
if (da_weapons_Grenades(Other.FindInventoryType(class'da_weapons_Grenades')) != none)
	grenades = da_weapons_Grenades(Other.FindInventoryType(class'da_weapons_Grenades'));

	if (!playerSpawned)
	{
		playerSpawned=true;
	}
	
	if (SPRI != none)
	{
	
		if (!other.controller.isa('da_ai_HumanBot')) 
		{
			Other.Health = SPRI.ChosenHealth;
			Other.HealthMax = SPRI.ChosenHealth; 
		}

		if (SPRI.selectedNade != -1)
		{
			switch (SPRI.selectedNade)
			{
					case 0: 
						SGRI.TeamConfig[0].classSet.playerClasses[SPRI.playerClass].grenadeclass = class'DA2.da_weapons_humanGrenade'; 
						SGRI.TeamConfig[0].classSet.playerClasses[SPRI.playerClass].grenadenumber = 3;
						break; 
							
					case 1: 
						SGRI.TeamConfig[0].classSet.playerClasses[SPRI.playerClass].grenadeclass = class'da_proj_thermiteGrenade_SR'; 
						SGRI.TeamConfig[0].classSet.playerClasses[SPRI.playerClass].grenadenumber = 2;
						break;
					
					case 2: 
						SGRI.TeamConfig[0].classSet.playerClasses[SPRI.playerClass].grenadeclass = class'da_proj_EMPGrenade';
						SGRI.TeamConfig[0].classSet.playerClasses[SPRI.playerClass].grenadenumber = 2;
						break;
					
					case 3: 
						SGRI.TeamConfig[0].classSet.playerClasses[SPRI.playerClass].grenadeclass = class'da_proj_PlasmaBomb'; 
						SGRI.TeamConfig[0].classSet.playerClasses[SPRI.playerClass].grenadenumber = 1;
						break;
					
					case 4: 
						SGRI.TeamConfig[0].classSet.playerClasses[SPRI.playerClass].grenadeclass = class'da_proj_APMine'; 
						SGRI.TeamConfig[0].classSet.playerClasses[SPRI.playerClass].grenadenumber = 3;
						break;
					
					case 5: 
						SGRI.TeamConfig[0].classSet.playerClasses[SPRI.playerClass].grenadeclass = class'da_proj_NuclearGrenade'; 
						SGRI.TeamConfig[0].classSet.playerClasses[SPRI.playerClass].grenadenumber = 3;
						break;
			}
		}

	       grenades = spawn(class'da_weapons_Grenades',,,Other.Location);
	       grenades.grenadeClass=SGRI.TeamConfig[0].classSet.playerClasses[SPRI.playerClass].grenadeclass;
           grenades.GiveTo(Other);
	       if (SurvivalPlayerController(Other.controller) != none)
	       SurvivalPlayerController(Other.controller).grenades = grenades;
		   grenades.grenadeAmount = SGRI.TeamConfig[0].classSet.playerClasses[SPRI.playerClass].grenadenumber; 
		   
		if (SPRI.playerClass == 5 && da_SteamStatsAndAchievements(PlayerController(Other.controller).SteamStatsAndAchievements).RocketCompleted) 
		{
			newWeapon = spawn(class'da_weapons_MS25RocketLauncher_SR',,,Other.location);
		 	newWeapon.giveTo(Other);
			newWeapon.bCanThrow= false; 
		}
		else if (SPRI.playerClass == 5) 
		{
			newWeapon = spawn(class'da_weapons_MS25RocketLauncher',,,Other.location);
		 	newWeapon.giveTo(Other);
			newWeapon.bCanThrow= false; 
		}
	}
super.ModifyPlayer(Other);
}
}

function bool CheckReplacement(Actor Other, out byte bSuperRelevant)
{


	if (da_game_DAMutator(Other) != none)
	{
		return false;
	}
	else if (Controller(Other) != none)
	{
		Controller(Other).PlayerReplicationInfoClass = class'SurvivalPlayerReplicationInfo';
	}
	else if (da_turrets_Turret(Other) != none)
	{

		da_turrets_Turret(Other).AutoTurretControllerClass=Class'DA2.Tdat';
		da_turrets_Turret(Other).bAutoTurret = true;
	}
	
	return true;
}

function float GetGameDifficulty()
{
	return Level.Game.GameDifficulty;
}

function SetGameDifficulty(float difficulty)
{
	if (Level.Game.GameDifficulty != difficulty)
	{
		Level.Game.GameDifficulty = difficulty;
		wavesOnDifficulty=0;
		SurvivalGameReplicationInfo(Level.Game.GameReplicationInfo).difficulty = GetGameDifficulty();
		SurvivalGameReplicationInfo(Level.Game.GameReplicationInfo).deathPenalty = GetDeathPenalty();
	}
}

function int GetPlayerCount()
{
	return Level.Game.NumPlayers + Level.Game.NumBots;
}

function int GetZombieCount(optional bool fullCheck)
{
	if (!fullCheck)
	{
		return zombiesSpawned-zombiesKilled;
	}
	else
	{
		return ReturnPawnCount('monster');
	}
}

function float GetInfestationPercentage(optional bool basedOnMaxZombies)
{
	local int currentDensity;
	if (!basedOnMaxZombies)
	{
		currentDensity = GetZombieCount();

		if (currentDensity > maximumDensity)
			maximumDensity = currentDensity;


		return float(GetZombieCount()) / float(maximumDensity) * 100.0;
	}
	else 
	{
		return float(GetZombieCount()) / float(MaxZombies) * 100.0;
	}
}

function int GetDeathPenalty()
{
	if (!ShareLives)
		return 1 * GetGameDifficulty();
	else return 1;
}

function int GetLifeGainMod()
{
	return GetGameDifficulty()+5.0*(1.0+float(livesLeft)*0.10);
}

function int ReturnPawnCount(name className)
{
	local int n;
	local Controller c;
	For ( c=Level.ControllerList; c!=None; c=c.NextController )
	{
		if(c.pawn!=none && c.pawn.isa(className))
		{
			n++;
		}
	}
	return n;
}

function RegisterZombieKill(Controller zombie, Controller killer)
{
	zombiesKilled++;
	SurvivalGameReplicationInfo(Level.Game.GameReplicationInfo).zombiesKilled = zombiesKilled;
	SurvivalGameReplicationInfo(Level.Game.GameReplicationInfo).zombieCount = GetZombieCount();
	SurvivalGameReplicationInfo(Level.Game.GameReplicationInfo).infestationPercentage = GetInfestationPercentage();
}

function RegisterBossDeath(Controller boss, Controller killer)
{
	bossActive=false;
	waveIndex = 0;

	EndAssault(true);
	BroadcastMessage("The horde leader has been slain!", GetColor(255,255,255),15.0, 1);

	if (killer!=none) //&& killer.IsA('da_player_ClassPlayer'))
		BroadcastMessage("Killing blow by:"@killer.PlayerReplicationInfo.playerName,,2);

	SurvivalGameReplicationInfo(Level.Game.GameReplicationInfo).bossAlive = false;
}

function Debug(string debugName, string message)
{
	local bool debugExists;
	local int i, debugIndex;

	if (ShowDebug)
	{
		for (i=0; i<debugRegs.Length; i++)
		{
			if (debugRegs[i] == debugName)
			{
				debugExists=true;
				debugIndex = i;
				break;
			}
		}

		if (!debugExists)
		{
			debugRegs[debugRegs.Length] = debugName;
			debugIndex = debugRegs.Length-1;
		}

	
		Log(debugName@"["$debugIndex$"]:"@message);
		//BroadCastMessage(message, GetColor(255,255,255),5.0, debugIndex);
	}
}

/* Mutator states:
	- Inactive (auto)
	- Initialize
	- Preparation
	- Assault
	- GameOver
*/

auto state Inactive
{
	function Timer()
	{
		Log("Survival Mutator currently idle. PlayerCount:"@GetPlayerCount()@", ZombieCount:"@GetZombieCount());
		if (GetPlayerCount() > 0)
		{
			GotoState('Initialize');
		}
	}
Begin:
	SetTimer(1.0, true);
}

state Initialize
{

	
	function Timer()
	{	
		if (GetPlayerCount() > 0 && playerSpawned)
		{
			livesLeft = 1+GetPlayerCount()/2;		
			
			SurvivalGameReplicationInfo(Level.Game.GameReplicationInfo).difficulty = GetGameDifficulty();
			SurvivalGameReplicationInfo(Level.Game.GameReplicationInfo).livesLeft = livesLeft;
			SurvivalGameReplicationInfo(Level.Game.GameReplicationInfo).sharedLives = ShareLives;
			SurvivalGameReplicationInfo(Level.Game.GameReplicationInfo).deathPenalty = GetDeathPenalty();

			GotoState('Preparation');
		}
	}


	function int InitializeZombieSpawnPoints()
	{
		local NavigationPoint navi;
		for ( navi=Level.NavigationPointList; navi!=None; navi=navi.NextNavigationPoint )
		{
			if (navi.isA('PlayerStart'))
			{			
				if (PlayerStart(navi).TeamNumber == 1)
					zombieSpawnPoints[zombieSpawnPoints.Length] = navi;
			}
		}
		return zombieSpawnPoints.Length;
	}

Begin:
	Log("Survival Mutator initializing...");
	// Perhaps start a difficulty vote here?
	Log("Initializing ZombieSpawnPoint collection, cached:"@InitializeZombieSpawnPoints()@"player starts.");
	Log("Initializing Build Limits..");

	DefenceAlliance(Level.Game).DAGRI.teamConfig[0].BotBehaviour = Sweeper;

	SetTimer(1.0, true);
}

state Preparation
{
Begin:
	prepTimeElapsed = 0;
	Log("Survival Mutator, Preparation started. GameDifficulty:"@GetGameDifficulty());
Announce:
	if (prepTimeElapsed <= startTime)
	{
		DisplayCountDown(startTime-prepTimeElapsed, "Prepare yourselves, you have {0} until the horde arrives at your location!");
		prepTimeElapsed++;
		Sleep(1.0);
		goto('Announce');
	}
	GotoState('Assault');
}

function EndAssault(optional bool isVictory)
{
	// Does nothing by default.
}

function ModifyLife(optional bool takeAway, optional Controller other)
{
	// Does nothing by default.
}



function UpdateGameInfo()
{
	SurvivalGameReplicationInfo(Level.Game.GameReplicationInfo).zombieCount = GetZombieCount();
	SurvivalGameReplicationInfo(Level.Game.GameReplicationInfo).infestationPercentage = GetInfestationPercentage();
	SurvivalGameReplicationInfo(Level.Game.GameReplicationInfo).livesLeft = livesLeft;
	SurvivalGameReplicationInfo(Level.Game.GameReplicationInfo).sharedLives = ShareLives;
	SurvivalGameReplicationInfo(Level.Game.GameReplicationInfo).deathPenalty = GetDeathPenalty();

}

function PlayMusicOnClients(string songFileName)
{
	local Controller c;
	for (c=Level.ControllerList; c!=None; c=c.NextController)
	{
		if(c.isa('PlayerController'))
		{
			playercontroller(c).ClientSetMusic(songFileName, mtran_fade);
		}
	}
}

function DetermineDynamicDifficulty(optional int averageRange)
{
	local dDifficulty diff;
	local float averageInfestation;
	local int i, startIndex;

	if (DynamicDifficulty && ShareLives)
	{
		if (averageRange <=0) averageRange = 5;
		wavePercentages[wavePercentages.Length] = GetInfestationPercentage();

		if (wavePercentages.Length > averageRange)
			wavePercentages.Remove(0, wavePercentages.Length-averageRange);

		if (wavePercentages.Length >= averageRange)
		{
			startIndex = wavePercentages.Length-averageRange;
			for (i=startIndex; i<startIndex+averageRange; i++)
			{
				averageInfestation += wavePercentages[i];
			}
			averageInfestation = averageInfestation / averageRange;
			//Debug("AverageInfestation", "Calculated average infestion to:"@averageInfestation@"@ Wave:"@waveCount@"("$wavesOnDifficulty$") and difficulty:"@GetGameDifficulty());

			if ((averageInfestation <= AverageDDUp && (livesLeft>=5) && wavesOnDifficulty>=2*GetGameDifficulty()+1) && GetGameDifficulty() < 7.0)
				diff=dDifficulty.Increase;
			else if (averageInfestation >= AverageDDDown && (livesLeft<5) && GetGameDifficulty() > 0.0 && wavesOnDifficulty>=5)
				diff=dDifficulty.Decrease;
			else if (livesLeft>= 15 && wavesOnDifficulty>10*GetGameDifficulty()+1)
				diff=dDifficulty.Increase;

			switch (diff)
			{
				case dDifficulty.Increase:
					SetGameDifficulty(GetGameDifficulty()+1);
					Log("Dynamic Difficulty determined that the game is too easy. Increased difficulty!");
				break;
				case dDifficulty.Decrease:
					SetGameDifficulty(GetGameDifficulty()-1);
					Log("Dynamic Difficulty determined that the game is too hard. Decreased difficulty!");
				break;
			}
		}		
	}
}

state Assault
{
	function Timer()
	{	
		if (Level.Game.GameReplicationInfo.RemainingTime > 1160 && !GameTime20)
			GameTime20=true;
		
		if (Level.Game.GameReplicationInfo.RemainingTime>0)
		{
			Log("Infestation Percentage:"@GetInfestationPercentage()@"Zombies:"@GetZombieCount()@", Killed:"@zombiesKilled@", Spawed:"@zombiesSpawned);

			if (DynamicDifficulty && waveCount > 10) DetermineDynamicDifficulty(AverageDDRange);

			if (zombiesSpawned > (MinZombies * GetPlayerCount()))
			{
				if (GetGameDifficulty() == 7) MinimumInfestation = 50;
			
				if ((GetInfestationPercentage() < MinimumInfestation && !bossActive) || (!bossActive && ForceSpawnBoss))
				{
					Log("Infestation percentage too low! Calling patriarch!!");
					CallPatriarch();
				}
			}

			if (waveCount>5)
			{
				if (GetInfestationPercentage() > 90.0 && !waveChilled)
				{
					SetTimer(CalculateWaveTime()*(2.0*GetGameDifficulty()+1), true);
					waveChilled=true;
					Log("Wave culled, new wave timer:"@CalculateWaveTime()*(2.0*GetGameDifficulty()+1));
				}
				else if (GetInfestationPercentage() < MinimumInfestation*2 && waveChilled)
				{
					SetTimer(CalculateWaveTime(), true);
					waveChilled=false;
					Log("Wave unculled");
				}
			}

			if (GetZombieCount()<MaxZombies)
			{
				//Debug("DetermineWave", GetZombieCount()@"<"@(ZombiesPerPlayer+(0.5*GetGameDifficulty()))*GetPlayerCount());
				if (GetZombieCount() < (ZombiesPerPlayer+(0.5*GetGameDifficulty()))*GetPlayerCount())
				{
					CreateZombieWave();
					wavesOnDifficulty++;
				}
			}

			if (waveCount % GetGameDifficulty()+1 == 0)
			{
				CheckSurvivalModeIntegrity();
			}

			if (bossActive && recentBoss!=none)
			{
				SurvivalGameReplicationInfo(Level.Game.GameReplicationInfo).bossHealth = recentBoss.Health;
				SurvivalGameReplicationInfo(Level.Game.GameReplicationInfo).bossMaxHealth = recentBoss.HealthMax;
			}
		}
		else EndAssault(true);
		UpdateGameInfo();
	}

	function CallPatriarch()
	{
		local NavigationPoint navi;
		local KFMonster boss;

		if (!bossActive)
		{
			navi = FindZombieSpawn();
			boss = SpawnZombie(ZombieType.Boss, navi.location);
			if (boss!=none)
			{
				BroadcastMessage("Warning! The horde has called in reinforcements.", GetColor(255, 0, 0), 10.0, 1);
				Level.Game.BroadCast(none, "Warning! The horde has called in reinforcements.", 'CriticalEvent');
				Level.Game.GameReplicationInfo.RemainingTime += 300;	
				PlayMusicOnClients("snowfallaction");

				//PlayMusic("snowfallaction", 3.0);
				// Would like the boss to say something, can't figure out how to do it at this time though :(
				ZombieBoss(boss).PatriarchEntrance();
				SurvivalGameReplicationInfo(Level.Game.GameReplicationInfo).bossMaxHealth = boss.HealthMax;
				SurvivalGameReplicationInfo(Level.Game.GameReplicationInfo).bossHealth = boss.Health;
				SurvivalGameReplicationInfo(Level.Game.GameReplicationInfo).bossAlive = true;
				bossActive=true;
				recentBoss = boss;
			}
		}
	}

//	function bool SpawnRandomChampion()
//	{
//		local int champIndex;
//		local KFMonster champion;
//		local NavigationPoint navi;
//		
//		champIndex = Rand(GetGameDifficulty());
//		navi = FindZombieSpawn();
//
//		switch (champIndex)
//		{
//			case 0:
//			case 1:
//			case 2:
//				champion = SpawnZombie(ZombieType.Husk, navi.location, true);
//				break;
//			case 3:
//				champion = SpawnZombie(ZombieType.GoreFast, navi.location, true);
//				break;
//			case 4:
//			case 5:
//				champion = SpawnZombie(ZombieType.Scrake, navi.location, true);
//				break;
//			case 6:
//				champion = SpawnZombie(ZombieType.Siren, navi.location, true);
//				break;
//			case 7:
//				champion = SpawnZombie(ZombieType.FleshPound, navi.location, true);
//				break;
//		}
//
//		if (champion != none)
//		{
//			BroadcastMessage("Warning! A champion has joined the fight.", GetColor(255,0,0), 5.0);
//			champSpawned++;
//			return true;
//		}
//		return false; 
//	} 

	function ModifyLife(optional bool takeAway, optional Controller other)	
	{
	local Controller C;	
	
		if (ShareLives)
		{
			if (!takeAway)
			{
				if (livesLeft==0)
				{
					if (RessurectDeadPlayer(RessurectRule.HighestScore))
						livesLeft--;
				}
				
				// Award a life to the team.
				livesLeft++;
			}
			else
			{
				// Subtract a life from the team.
				
				if (livesLeft > 0)
				{
					livesLeft--;
					
					if (other != none)
					{
						other.PlayerReplicationInfo.bOutOfLives = false;
						other.PlayerReplicationInfo.bOutOfLives = false;
						PlayerController(other).ClientMessage("You've died and thus cost your team 1 life!");
						//BroadcastMessage(other.PlayerReplicationInfo.PlayerName@"has died, your team has"@livesLeft@"lives left!", GetColor(255,255,255),,2);
						Level.Game.BroadCast(none, other.PlayerReplicationInfo.PlayerName@"has died, your team has"@livesLeft@"lives left!", 'CriticalEvent');
					
    						// Hint check
							if (livesLeft == 0) 
							{
								log ("check for hint 20");
								da_players_playercontroller(C).CheckForHint(20);
							}
					}
				}
				else if (other != none)
				{
					Other.PlayerReplicationInfo.bOutOfLives = true;
					PlayerController(other).ClientMessage("You're dead, wait for your team to accumulate more lives so you can respawn!");
					//Other.GoToState('Spectating');
				}
				
				//Debug("AnyoneAlive?", string(IsAnyoneAlive()));
				if (!IsAnyoneAlive())
				{
					EndAssault();
				}
			}
		}
		else
		{
			if (takeAway)
			{
				if (Other!=none)
				{
					// Subtract points from the player.
					other.PlayerReplicationInfo.Score = other.PlayerReplicationInfo.Score-GetDeathPenalty();
					if (other.PlayerReplicationInfo.Score < 0)
					{
						other.PlayerReplicationInfo.bOutOfLives = true;
						//Other.GoToState('Spectating');
					}

					PlayerController(other).ClientMessage("You've lost"@GetDeathPenalty()@"points for dying, make sure you don't drop below zero or you will be unable to respawn.");

				}
		
				
				if (!IsAnyoneAlive())
				{
					EndAssault();
				}		
			}
		}
	}

	function CheckSurvivalModeIntegrity()
	{
		local int liveZombies, pseudoZombies;

		liveZombies = GetZombieCount(true);
		pseudoZombies = GetZombieCount();
		Log("Checking SurvivalMode integrity. True Count:"@liveZombies@"vs. pseudoCount:"@pseudoZombies);
		if (liveZombies != pseudoZombies)
		{
			Log("Survival mode compromised.. Live Zombies:"@pseudoZombies);
			if (liveZombies < pseudoZombies)
			{
				zombiesKilled = zombiesKilled+(GetZombieCount()-liveZombies);
				Log("- Increased zombiesKilled to compensate. > Live Zombies:"@GetZombieCount());
			}
			else if (liveZombies > pseudoZombies)
			{
				zombiesSpawned = zombiesSpawned+(liveZombies-GetZombieCount());
				Log("- Increased zombiesSpawned to compensate. > Live Zombies:"@GetZombieCount());
			}
		}
	}

	function EndAssault(optional bool isVictory)
	{	
	local Controller c;
	
		//Debug("EndGame", "Supposed to end game now.");
		SetTimer(0.0, false);
		if (!isVictory)
		{
			BroadcastMessage("You've been overwhelmed by zombies! :(", GetColor(255, 0, 0), 10.0);
			da_players_PlayerController(PlayerController(C)).AMIAnnouncement(sound'AMISounds.Player.GameLost');
		}
		else
		{
			if (GetGameDifficulty() == 7 && GameTime20) 
			{
				for (c=Level.ControllerList; c!=none; c=c.NextController)
				{
					da_SteamStatsAndAchievements(PlayerController(c).SteamStatsAndAchievements).SurvivedSuicidal();
				}
			}
			Level.Game.EndGame(none, "triggered");
			BroadcastMessage("You've survived the onslaught!", GetColor(0, 255, 0), 10.0);
			da_players_PlayerController(PlayerController(C)).AMIAnnouncement(sound'AMISounds.Player.GameWin');
		}	
		KillAllZombies();
		GotoState('GameOver');
	}

	function KillAllZombies()
	{
	local Actor A;
	
		ForEach DynamicActors(class'Actor', A)
		{
			if (MonsterController(A) != none && A != None)
			{
				MonsterController(A).GotoState('GameEnded');
			}
		}
	}

	function float CalculateWaveTime()
	{
		return 12/(GetGameDifficulty()+1);
	}

	function InitializeAssault()
	{
		waveIndex = 0 + GetGameDifficulty();

		Log("Survival: Initializing Assault timer: "@CalculateWaveTime());

		CreateZombieWave();
		SetTimer(CalculateWaveTime(), true);
	}

Begin:
	
	BroadcastMessage("INCOMING!!", class'Canvas'.static.MakeColor(255, 255, 255), 5.0);
	InitializeAssault();
}

state GameOver
{
Begin:
	if (!Level.Game.IsInState('MatchOver'))
	{
		Level.Game.gotostate('matchover');
	}
}

function static Color GetColor(int red, int green, int blue)
{
	return class'Canvas'.static.MakeColor(red, green, blue);
}

simulated function ShowBlood(Pawn injured, Pawn instigator, Vector location, Vector momentum, int damage)
{
	local Rotator splatRot;
	local class<Actor> bloodClass;

	if ( Momentum != vect(0,0,0) )
		splatRot = rotator(Normal(momentum));
	else
	{
		if ( instigator != None )
			splatRot = rotator(Normal(injured.Location - instigator.Location));
		else
			splatRot = rotator(Normal(injured.Location - location));
	}

	if (damage < 10)
	{
		bloodClass = class'KFBloodPuff';
	}
	else
	{
		bloodClass = class'KFBloodTrail';
	}

	spawn(bloodClass, injured,, location, splatRot);
}

// IS ANYONE STILL ALIVE OUT THERE?!? HELLO?!
function bool IsAnyoneAlive()
{
	local Controller c;
	for (c=Level.ControllerList; c!=none; c=c.NextController)
	{
		if (c!=none && c.bIsPlayer || c.Pawn.IsA('da_player_PlayerClass'))
		{
			if ((!c.PlayerReplicationInfo.bOutOfLives || c.Pawn.Health > 0) && (PlayerController(c) == none || !PlayerController(c).IsSpectating()))
			{
				return true;
			}
		}
	}
	return false;
}

function bool RessurectDeadPlayer(RessurectRule rule)
{
	local Controller c, ressurectPlayer;
	local array<Controller> deadPlayers;
	local int i, highestScore;

	for (c=Level.ControllerList; c!=none; c=c.NextController)
	{
		//Debug("RessurectDeadPlayers", "Found"@c.Name);
		if (c!=none && (c.bIsPlayer || c.IsA('da_player_ClassPlayer') || c.IsA('da_AI_HumanBot')))
		{
			//Debug("RessurectDeadPlayers", "Found bIsPlayer OR da_player_ClassPlayer OR da_AI_HumanBot");
			if (c.PlayerReplicationInfo.bOutOfLives && (c.Pawn==none || c.Pawn.Health <= 0))
			{
				deadPlayers[deadPlayers.Length] = c;
			}
		}
	}

	if (deadPlayers.Length > 0)
	{
		switch (rule)
		{
			case RessurectRule.Random:
			case RessurectRule.TimeElapsed:
				ressurectPlayer = deadPlayers[Rand(deadPlayers.Length-1)];
			break;
			case RessurectRule.HighestScore:
				for (i=0; i<deadPlayers.Length; i++)
				{
					if (deadPlayers[i].PlayerReplicationInfo.Score > highestScore && (deadPlayers[i] != latestRespawn || deadPlayers.Length == 1))
					{
						highestScore = deadPlayers[i].PlayerReplicationInfo.Score;
						ressurectPlayer = deadPlayers[i];
					}
				}
			break;
		}

		if (ressurectPlayer != none)
		{
			ressurectPlayer.PlayerReplicationInfo.bOutOfLives=false;
			latestRespawn = ressurectPlayer;

			if (ressurectPlayer.IsA('PlayerController') && ressurectPlayer.IsInState('Spectating'))
				PlayerController(ressurectPlayer).GotoState('PlayerWaiting');
			else Level.Game.RestartPlayer(ressurectPlayer);

				Level.Game.Broadcast(ressurectPlayer,"Respawning"@ressurectPlayer.PlayerReplicationInfo.playerName@"["$GetPlayerClassName(ressurectPlayer)$"]");
			return true;
		}
	}

	return false;
}

function string GetPlayerClassName(Controller c)
{
	SPRI = SurvivalPlayerReplicationInfo(c.PlayerReplicationInfo);
	SGRI = SurvivalGameReplicationInfo(Level.Game.GameReplicationInfo);
	if (SGRI != none && SPRI != none)
	{
		return SGRI.teamConfig[SPRI.team.teamIndex].classSet.playerClasses[SPRI.playerClass].name;
	}
	return "Unknown";
}

function CreateZombieWave()
{
	local NavigationPoint navi;
	local ZombieType nextSpawn;
	local int i, waveSize, waveRand;
	local bool spawnChamp;
	
	waveSize = (GetPlayerCount()*ZombieMod)+GetGameDifficulty();

	if (float(Rand(100)) < 0.05*waveIndex*GetGameDifficulty() && !bossActive)
		spawnChamp = true;

	//Debug("CreateZombieWave", "Do create a little zombie wave, please?"@waveIndex@"Spawn champ?:"@spawnChamp);
	for (i=0; i<waveSize; i++)
	{
		// Clot,Crawler,Stalker,GoreFast,Husk,Siren,Scrake,Fleshpound
		//switch(Rand(waveIndex*2))
		//{
		
		waveRand = float(Rand(102));
				
		if (waveCount > 150)
		{
			if (waveRand < 15) //15%
			nextSpawn = ZombieType.Clot;
		
			else if (waveRand < 25) //10%
			nextSpawn = ZombieType.GoreFast;
			
			else if (waveRand < 35) //10%
			nextSpawn = ZombieType.Bloat;
			
			else if (waveRand < 45) //10%
			nextSpawn = ZombieType.Crawler;
			
			else if (waveRand < 55) //10%
			nextSpawn = ZombieType.Stalker;
			
			else if (waveRand < 67) //12%
			nextSpawn = ZombieType.Husk;
			
			else if (waveRand < 79) //12%
			nextSpawn = ZombieType.Siren;
			
			else if (waveRand < 91) //12%
			nextSpawn = ZombieType.Scrake;
			
			else if (waveRand < 100) //9%
			nextSpawn = ZombieType.Fleshpound;
			
			else nextSpawn = ZombieType.Clot;
		}
		
		if (waveCount > 100)
		{
			if (waveRand < 20) //20%
			nextSpawn = ZombieType.Clot;
		
			else if (waveRand < 30) //10%
			nextSpawn = ZombieType.GoreFast;
			
			else if (waveRand < 40) //10%
			nextSpawn = ZombieType.Bloat;
			
			else if (waveRand < 50) //10%
			nextSpawn = ZombieType.Crawler;
			
			else if (waveRand < 60) //10%
			nextSpawn = ZombieType.Stalker;
			
			else if (waveRand < 74) //14%
			nextSpawn = ZombieType.Husk;
			
			else if (waveRand < 84) //10%
			nextSpawn = ZombieType.Siren;
			
			else if (waveRand < 96) //12%
			nextSpawn = ZombieType.Scrake;
			
			else if (waveRand < 100) //4%
			nextSpawn = ZombieType.Fleshpound;
			
			else nextSpawn = ZombieType.Clot;
		}
		
		if (waveCount > 50)
		{
			if (waveRand < 20) //20%
			nextSpawn = ZombieType.Clot;
		
			else if (waveRand < 34) //14%
			nextSpawn = ZombieType.GoreFast;
			
			else if (waveRand < 44) //10%
			nextSpawn = ZombieType.Bloat;
			
			else if (waveRand < 57) //13%
			nextSpawn = ZombieType.Crawler;
			
			else if (waveRand < 67) //10%
			nextSpawn = ZombieType.Stalker;
			
			else if (waveRand < 77) //10%
			nextSpawn = ZombieType.Husk;
			
			else if (waveRand < 87) //10%
			nextSpawn = ZombieType.Siren;
			
			else if (waveRand < 97) //10%
			nextSpawn = ZombieType.Scrake;
			
			else if (waveRand < 100) //3%
			nextSpawn = ZombieType.Fleshpound;
			
			else nextSpawn = ZombieType.Clot;
		}
		
		if (waveCount > 20)
		{
			if (waveRand < 25) //25%
			nextSpawn = ZombieType.Clot;
		
			else if (waveRand < 39) //14%
			nextSpawn = ZombieType.GoreFast;
			
			else if (waveRand < 49) //10%
			nextSpawn = ZombieType.Bloat;
			
			else if (waveRand < 66) //17%
			nextSpawn = ZombieType.Crawler;
			
			else if (waveRand < 76) //10%
			nextSpawn = ZombieType.Stalker;
			
			else if (waveRand < 84) //8%
			nextSpawn = ZombieType.Husk;
			
			else if (waveRand < 92) //8%
			nextSpawn = ZombieType.Siren;
			
			else if (waveRand < 98) //6%
			nextSpawn = ZombieType.Scrake;
			
			else if (waveRand < 100) //2%
			nextSpawn = ZombieType.Fleshpound;
			
			else nextSpawn = ZombieType.Clot;
		}
		
		else
		{
			if (waveRand < 35) //35%
			nextSpawn = ZombieType.Clot;
		
			else if (waveRand < 55) //20%
			nextSpawn = ZombieType.GoreFast;
			
			else if (waveRand < 70) //15%
			nextSpawn = ZombieType.Bloat;
			
			else if (waveRand < 92) //22%
			nextSpawn = ZombieType.Crawler;
			
			else if (waveRand < 99) //7%
			nextSpawn = ZombieType.Stalker;
			
			else if (waveRand < 100) //1%
			nextSpawn = ZombieType.Scrake;
			
			else nextSpawn = ZombieType.Clot;
		}
		
		if (GetZombieCount()<MaxZombies)
		{

			navi = FindZombieSpawn();
			if (SpawnZombie(nextSpawn, navi.location, spawnChamp) != none)
			{
				zombiesSpawned++;
				if (spawnChamp)
					spawnChamp=false;
			}
		}
		else break;
	}
	
	SurvivalGameReplicationInfo(Level.Game.GameReplicationInfo).waveCount = waveCount;
	
	waveCount++;
	if (waveIndex < 30)
		waveIndex++;
	
}

function NavigationPoint FindZombieSpawn()
{
	local array<NavigationPoint> viableSpawnPoints;
	local int i;

	for (i=0; i<zombieSpawnPoints.Length; i++)
	{
		if (PlayerStart(zombieSpawnPoints[i]).bEnabled)
			viableSpawnPoints[viableSpawnPoints.Length] = zombieSpawnPoints[i];
	}
	
	//Log("Found"@viableSpawnPoints.Length@"viable spawn points for the zombies.");
	return viableSpawnPoints[Rand(viableSpawnPoints.Length-1)];

}

function CleanZombieDamagedIndex()
{
	local int i, initialSize, skipped;

	initialSize = dmgZombie.Length;
	for (i=0; i<dmgZombie.Length; i++)
	{
		if (dmgZombie[i].safeToDelete)
		{
			dmgZombie.Remove(i, 1);
			i--;
		}
		else if (dmgZombie[i].zombie == none)
		{
			skipped++;
			dmgZombie[i].safeToDelete = true;
		}
	}
	Log("Cleaned ZombieDamagedIndex, initial size:"@initialSize@", current size:"@dmgZombie.length@", skipped:"@skipped);
}

function int GetZombieDamagedIndex(KFMonster zombie, Controller c)
{
	local int i, playerId;
	local ZombieDamaged zomDmg;

	if (c.PlayerReplicationInfo != none)
	{
		playerId = c.PlayerReplicationInfo.PlayerID;

		for (i=0; i<dmgZombie.Length; i++)
		{
			//Debug("GetZombieDamaged", "Searching entries, found"@dmgZombie[i].zombie@"regged to"@dmgZombie[i].playerId);
			if (dmgZombie[i].zombie == zombie && dmgZombie[i].playerId == playerId)
				return i;
		}
		
		zomDmg.zombie = zombie;
		zomDmg.playerId = playerId;
		zomDmg.amount = 0;

		i = dmgZombie.Length;
		dmgZombie[i] = zomDmg;

		return i;
	}
	return -1;
}

function RegisterDamage(KFMonster zombie, Controller c, float damage)
{
	local int dmgIndex;
	local float damageInflicted;
	dmgIndex = GetZombieDamagedIndex(zombie, c);

	if (dmgIndex >= 0 && dmgZombie[dmgIndex].zombie != none)
	{
		if (zombie.Health < damage)
			damageInflicted = zombie.Health;
		else damageInflicted = damage;

		if (c.Pawn.IsA('da_turrets_Turret'))
		{
			if (da_turrets_Turret(c.Pawn).mechOwner != none)
			{
				if (da_turrets_Turret(c.Pawn).mechOwner != c)
					RegisterDamage(zombie, da_turrets_Turret(c.Pawn).mechOwner, damageInflicted * 0.25);

				damageInflicted = damageInflicted * 0.75;
			}
		}

		if (damageInflicted > 0)
		{
			//Debug("RegisterDamage", "Registering"@damageInflicted@"to"@c.PlayerReplicationInfo.PlayerName@"afflicted to"@zombie.Name);		
			dmgZombie[dmgIndex].amount += damageInflicted;
			if (c.PlayerReplicationInfo != none && SurvivalPlayerReplicationInfo(c.PlayerReplicationInfo) != none)
			{
				SurvivalPlayerReplicationInfo(c.PlayerReplicationInfo).totalDamageDone += damageInflicted;
				if (GetGameDifficulty() > 1)
					SurvivalPlayerReplicationInfo(c.PlayerReplicationInfo).DamageDone += damageInflicted;
			}
		}
	}
}

function RegisterKill(KFMonster zombie)
{
	local array<ZombieDamaged> damagesZombie;
	local int i;
	local float pointsToShare, pointsAwarded, totalDamage;
	local Controller c;

	pointsToShare = GetPointsForKill(zombie);
	if (zombie.bIsSquadLeader)
		pointsToShare += 5;

	for (i=0; i<dmgZombie.Length; i++)
	{
		//Debug("RegisterKill", "Searching entries, found"@dmgZombie[i].zombie@"regged to"@dmgZombie[i].playerId);
		if (dmgZombie[i].zombie == zombie && dmgZombie[i].amount > 0)
		{
			damagesZombie[damagesZombie.Length] = dmgZombie[i];
			totalDamage += dmgZombie[i].amount;
			dmgZombie[i].safeToDelete = true;
		}
	}

	if (damagesZombie.Length > 0)
	{
		for (i=0; i<damagesZombie.Length; i++)
		{
			c=GetControllerByPlayerId(damagesZombie[i].playerId);
			if (c != none && totalDamage > 0)
			{
				pointsAwarded = pointsToShare * (damagesZombie[i].amount / totalDamage);
				c.PlayerReplicationInfo.Score += pointsAwarded;
				
				if (da_Players_PlayerController(C) != none)
				da_SteamStatsAndAchievements(da_Players_PlayerController(C).SteamStatsAndAchievements).AddScore(pointsAwarded, SurvivalPlayerReplicationInfo(c.PlayerReplicationInfo).playerClass);
				
				//Debug("RegisterKill", "Awarded"@pointsAwarded@"out of"@pointsToShare@"to"@c.PlayerReplicationInfo.PlayerName@damagesZombie[i].amount@totalDamage);
			}
		}
	}
}

function Controller GetControllerByPlayerId(int playerId)
{
	local Controller c;
	for (c=Level.ControllerList; c!=none; c=c.NextController)
	{
		//Debug("RessurectDeadPlayers", "Found"@c.Name);
		if ((da_players_PlayerController(c) != none || da_AI_HumanBot(c) != none) && c.PlayerReplicationInfo.PlayerID == playerId)
		{
			return c;
		}
	}
	return none;
}

function KFMonster SpawnZombie(ZombieType type, Vector location, optional bool makeChampion)
{
	local KFMonster zombie;
	local float runSpeed;
	local float jumpHeight;
	//local float scaleIncomingDamage; // ReceivedDamageScaling
	local float scaleOutgoingDamage; // DamageScaling
	local int health;
	
	location.Z += Rand(50)+100;
	location.X += Rand(50);
	location.Y += Rand(50);

	switch (type)
	{
		case ZombieType.Clot:
			zombie=spawn(class'ZombieClot',,,location);
			runSpeed = 1.75;
			health = 85; // KF=130
		break;
		case ZombieType.Crawler:
			zombie=spawn(class'daZombieCrawler',,,location);
			runSpeed = 1.75;
			health = 55; //KF=70
			jumpHeight = 0.7;
		break;
		case ZombieType.FleshPound:
			zombie=spawn(class'ZombieFleshPound',,,location);
			health = 1000; //KF=1500 
		break;
		case ZombieType.Stalker:
			zombie=spawn(class'ZombieStalker',,,location);
			health = 70; //KF=100
		break;
		case ZombieType.GoreFast:
			zombie=spawn(class'ZombieGoreFast',,,location);
			health = 175; // KF=250 
		break;
		case ZombieType.Husk:
			zombie=spawn(class'daZombieHusk',,,location);
			health = 450; //KF=600 
		break;
		case ZombieType.Siren:
			zombie=spawn(class'ZombieSiren',,,location);
			health = 200; //KF=300
			runSpeed = 1.75;
		break;
		case ZombieType.Scrake:
			zombie=spawn(class'ZombieScrake',,,location);
			health = 750; // KF=1000
		break;
		case ZombieType.Boss:
			zombie=spawn(class'ZombieBoss',,,location);
			health = zombie.HealthMax * 1.25; //(1000*GetPlayerCount())*2;
		break;
		case ZombieType.Bloat:
			zombie=spawn(class'ZombieBloat',,,location);
			health = 380; //KF=525
			runSpeed = 1.75;
		break;
	}
	
	if (zombie != none)
	{
		if (runSpeed != 0.0)
		{
			zombie.groundspeed *= runSpeed;
			zombie.OriginalGroundSpeed *= runSpeed;
		}

		if (!zombie.IsA('ZombieBoss'))
		{	
		
			if (makeChampion)
			{
				championsSpawned++;
				
					switch (type)
					{
						case ZombieType.Clot:
							runSpeed = 2.25;
							health = 1000; 
							runSpeed = 1.50;
						break;
						case ZombieType.Crawler:
							runSpeed = 2.00;
							health = 700; 
							jumpHeight = 0.7;
						break;
						case ZombieType.FleshPound:
							health = 4000;
							runSpeed = 1.10;
						break;
						case ZombieType.Stalker:
							health = 1200; 
							runSpeed = 1.50;
						break;
						case ZombieType.GoreFast:
							health = 2000; 
							runSpeed = 1.50;
						break;
						case ZombieType.Husk:
							health = 2500; 
							runSpeed = 1.50;
						break;
						case ZombieType.Siren:
							health = 2200;
							runSpeed = 2.00;
						break;
						case ZombieType.Scrake:
							health = 3000; 
							runSpeed = 1.50;
						break;
						case ZombieType.Bloat:
							health = 2400; 
							runSpeed = 2.00;
						break;
					}
		
				runSpeed *= 1 + (0.25 * (GetGameDifficulty()+1/2));
				//scaleOutgoingDamage *= 1 + (0.10 * (GetGameDifficulty()+1/2));
				//jumpHeight *= 1 + (0.50*(GetGameDifficulty()+1));

				zombie.SetDrawScale(1.15);
				zombie.AmbientGlow=255;
				zombie.bIsSquadLeader = true;
				scaleOutgoingDamage = 2.0;
			}
			
			if (GetGameDifficulty() > 0)
			health *= 1.0+(0.035*float(GetPlayerCount()));
			health *= zombie.DifficultyHealthModifer();
			jumpHeight *= 1.25;
			
			
			if (health != 0)
			{
				zombie.Health = health;
				zombie.HealthMax = health;
				
				if (GetGameDifficulty() > 2)
					zombie.HeadHealth = health * 5;
					
				else if (GetGameDifficulty() > 1)
					zombie.HeadHealth = health * 3;
					
				if (makeChampion)
					zombie.HeadHealth = health * 10;
				
			}			
			//Debug("ZombieHealth", "Zombie'"$zombie.Name$"' spawning with:"@health@"health, KFMod:"@zombie.DifficultyHealthModifer()@"FGSMod:"@1.0+(0.035*float(GetPlayerCount())));
		}

		if (jumpHeight != 0.0);
			zombie.jumpZ *= jumpHeight;

		/*if (scaleIncomingDamage != 0.0)
			zombie.ReceivedDamageScaling *= scaleIncomingDamage;*/

		if (GetGameDifficulty() > 5)
			scaleOutgoingDamage = 2.0;

		if (scaleOutgoingDamage != 0.0)
			zombie.DamageScaling *= scaleOutgoingDamage;

		//		xp.OriginalGroundSpeed *= 1.4;

		//zombie.bBlockActors = false;
		//zombie.bBlockPlayers = true;
		//zombie.PathColliding = false;
	
		//log("Zombie'"$zombie.Name$"Champion?:"@zombie.bIsSquadLeader@"spawning with:"@health@"health, KFMod:"@zombie.DifficultyHealthModifer()@"FGSMod:"@1.0+(0.035*float(GetPlayerCount())));
	
		return zombie;
	}
	return none;
}

function ZombieType IdentityZombie(KFMonster zombie)
{
	//  Clot, Stalker, Crawler, GoreFast, Husk, Siren, Fleshpound, Scrake, Bloat, Boss
	switch (zombie.Name)
	{
		case 'ZombieClot':
			return ZombieType.Clot;
		case 'daZombieCrawler':
			return ZombieType.Crawler;
		case 'ZombieStalker':
			return ZombieType.Stalker;
		case 'ZombieScrake':
			return ZombieType.Scrake;
		case 'daZombieHusk':
			return ZombieType.Husk;
		case 'ZombieSiren':
			return ZombieType.Siren;
		case 'ZombieFleshpound':
			return ZombieType.Fleshpound;
		case 'ZombieBloat':
			return ZombieType.Bloat;
		case 'ZombieGoreFast':
			return ZombieType.GoreFast;
		case 'ZombieBoss':
			return ZombieType.Boss;
	}
}

function float GetPointsForKill(KFMonster zombie)
{
	switch (IdentityZombie(zombie))
	{
		case ZombieType.Clot:
			return 0.25;
		case ZombieType.Crawler:
			return 0.50;
		case ZombieType.Stalker:
			return 1;
		case ZombieType.Scrake:
			return 2.00;
		case ZombieType.Husk:
			return 1.50;
		case ZombieType.Siren:
			return 1;
		case ZombieType.Fleshpound:
			return 3;
		case ZombieType.GoreFast:
			return 1.25;
		case ZombieType.Bloat:
			return 1;
		case ZombieType.Boss:
			return 50;
		default:
			return 1;
	}
}

function DisplayCountDown(int seconds, optional string messageFormat)
{
	local int minutesLeft;
	local int secondsLeft;
	local string timeLeft;
	local Color messageColor;
	local string messageToDisplay;
	
	minutesLeft = seconds / 60;
	secondsLeft = seconds - (minutesLeft*60);
	
	//Debug("CountDown", "CountDown, seconds:"@seconds@", minutesLeft:"@minutesLeft@", secondsLeft:"@secondsLeft);

	if (minutesLeft > 0)
	{
		if (minutesLeft==1)
			timeLeft = minutesLeft@"minute";
		else timeLeft = minutesLeft@"minutes";
		if (secondsLeft>0)
		{
			if (secondsLeft==1)
			timeLeft @= "and"@secondsLeft@"second";
			else timeLeft @= "and"@secondsLeft@"seconds";
		}

		messageColor = class'Canvas'.static.MakeColor(255, 255, 255);
	}
	else
	{
		if (secondsLeft==1)
			timeLeft = secondsLeft@"second";
		else timeLeft = secondsLeft@"seconds";

		if (seconds > 30)
			messageColor = class'Canvas'.static.MakeColor(255, 150, 0);
		else messageColor = class'Canvas'.static.MakeColor(255, 0, 0);
	}
	
	messageToDisplay = Repl(messageFormat, "{0}", timeLeft);
	BroadcastMessage(messageToDisplay, messageColor);
}

simulated function BroadcastMessage(string message, optional Color messageColor, optional float persistTime, optional int index)
{

	local Controller c;

	if (persistTime == 0) 
		persistTime = 2;

	for (c=Level.ControllerList; c!=none; c=c.NextController)
	{
		if (c!=none && PlayerController(c)!=none)
		{
			//PlayerController(c).ClearProgressMessages();
			//PlayerController(c).SetProgressTime(persistTime);
			//PlayerController(c).SetProgressMessage(index, message, messageColor);

			//SurvivalHud(PlayerController(c).MyHUD).SetEventMessage(message, persistTime, messageColor);

			//SurvivalPlayerReplicationInfo(c.PlayerReplicationInfo).eventMessage = message;
			//SurvivalPlayerReplicationInfo(c.PlayerReplicationInfo).eventColor = messageColor;
			//SurvivalPlayerReplicationInfo(c.PlayerReplicationInfo).eventTime = persistTime+Level.TimeSeconds;

			SurvivalPlayerReplicationInfo(c.PlayerReplicationInfo).AddEventMessage(message, messageColor, persistTime);
		}
	}
}


function GetServerDetails(out GameInfo.ServerResponseLine ServerState)
{
	// append the mutator name.
	local int i;
	i = ServerState.ServerInfo.Length;
	ServerState.ServerInfo.Length = i+1;
	ServerState.ServerInfo[i].Key = "Mutator";
	ServerState.ServerInfo[i].Value = mutName@mutVersion;

	//ServerState.ServerInfo[i].Key = "Dynamic Difficulty";
	//ServerState.ServerInfo[i].Value = string(DynamicDifficulty);

	//if (serverName == "") serverName = ServerState.ServerName;
	//ServerState.ServerName = serverName@"D"$int(GetGameDifficulty())@"ZK:"@zombiesKilled;
}

function BroadcastDeathMessage(Controller Killer, Controller Other, class<DamageType> damageType)
{
}

defaultproperties
{
     StartTime=60
     MaxZombies=100
     MinZombies=100
     MinimumInfestation=20
     ShareLives=True
     DynamicDifficulty=True
     NoTurrets=True
     ZombieMod=1.000000
     ZombiesPerPlayer=6.000000
     AverageDDUp=55.000000
     AverageDDDown=85.000000
     AverageDDRange=3.000000
     integrityMod=1.000000
     fallbackDifficulty=2.000000
     mutVersion="0.9.83"
     mutname="CNSDEV FGSurvival"
     bAddToServerPackages=True
     FriendlyName="Defence Alliance Specimen Survival"
     Description="Survive the onslaught of the zombie horde!"
     bAlwaysRelevant=True
     RemoteRole=ROLE_SimulatedProxy
}
