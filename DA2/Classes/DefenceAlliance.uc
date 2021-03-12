// ============================================================================
//  DA2.DefenceAlliance: Our main gameplay class
//  By: aBsOlUt, Dante

//  Additional Info for mappers:
//  Defence Alliance 2 is considered a Team Game. The 2 teams are the 'Defence
//  Alliance Urban' and 'Defence Alliance Green'. Team0 (the UT2004 Red Team)
//  is the DA Team and Team1 (the UT2004 Blue Team) is also operated by humans.
//
//  A DA map must include objectives and also da_map_Setup actor to setup skins
//  and other attributes.
//
//  Objectives:
//  Our objective system is very flexible and advanced. Mappers can use any
//  da_objective_<objectivetype> actor to include a gameplay on their map.
//  More information about each Objective look at da_objective_Base actor.
//
// ============================================================================

class DefenceAlliance extends xTeamGame
		config;

var array<da_objective_ControlPoint> controlPoint;
var da_game_ReplicationInfo DAGRI;
var config float suicidePenalty;
var int tickCounter;
var bool updateBuildCounts;
var int PlasmaKills;
var bool ThisIsSurvival;
var String da_PathWhisps[2];

//var		byte		CurrentRound;
//var		int			MaxRounds;

// ============================================================================
function byte PickTeam(byte num, Controller C)
{
 if (ThisIsSurvival) return 0;
 
 else
 return super.PickTeam(num, C);
}

// ============================================================================
function UnrealTeamInfo GetBotTeam(optional int TeamBots)
{
 if (ThisIsSurvival) return Teams[0];
 
 else
 return super.GetBotTeam(TeamBots);	
}

// ============================================================================
function ShowPathTo(PlayerController P, int TeamNum)
{
	local class<WillowWhisp>	WWclass;
	local da_objective_base obj, best;
    local int priority;

    priority = -1;
    foreach allActors(class'da_objective_base', obj) {
        if (!obj.bDisabled && obj.DefensePriority > priority) {
            priority = obj.DefensePriority;
            best = obj;
        }
    }
	
	if ( (Best != None) && (P.FindPathToward(Best, false) != None) )
	{
		WWclass = class<WillowWhisp>(DynamicLoadObject(da_PathWhisps[TeamNum], class'Class'));
		Spawn(WWclass, P,, P.Pawn.Location);
	}
}

// ============================================================================
function float RatePlayerStart(NavigationPoint N, byte Team, Controller Player) 
{
    local float Score, NextDist;
    local Controller OtherPlayer;

	if ( (Team == 0) || ((Player !=None) && Player.bIsPlayer) )
		return Super.RatePlayerStart(N,Team,Player);

    if ( N.PhysicsVolume.bWaterVolume )
        return -10000000;

    //assess candidate
    if ( (SmallNavigationPoint(N) != None) && (PlayerStart(N) == None) )
		return -1;

	Score = 10000000;

    Score += 3000 * FRand(); //randomize

    for ( OtherPlayer=Level.ControllerList; OtherPlayer!=None; OtherPlayer=OtherPlayer.NextController)
        if ( (PlayerController(OtherPlayer) != None) && (OtherPlayer.Pawn != None) )
        {
            NextDist = VSize(OtherPlayer.Pawn.Location - N.Location);
            if ( NextDist < OtherPlayer.Pawn.CollisionRadius + OtherPlayer.Pawn.CollisionHeight )
                Score -= 1000000.0;
            else if ( NextDist > 5000 )
				Score -= 20000;
            else if ( NextDist < 3000 )
            {
				if ( (NextDist > 1200) && (Vector(OtherPlayer.Rotation) Dot (N.Location - OtherPlayer.Pawn.Location)) <= 0 )
					Score = Score + 5000 - NextDist;
				else if ( FastTrace(N.Location, OtherPlayer.Pawn.Location) )
					Score -= (10000.0 - NextDist);
				if ( (Location.Z > OtherPlayer.Pawn.Location.Z) && (NextDist > 1000) )
					Score += 1000;
			}
        }
    return FMax(Score, 5);
}

// Defence Alliance 2 - Spawning/Restarting a Player functions
// ============================================================================
function NavigationPoint FindPlayerStart( Controller Player, optional byte InTeam, optional string incomingName )
{
    local NavigationPoint N, BestStart;
    local float BestRating, NewRating;
    local byte Team;

    if ( GameRulesModifiers != None )
    {
        N = GameRulesModifiers.FindPlayerStart(Player,InTeam,incomingName);
        if ( N != None )
            return N;
    }
    // use InTeam if player doesn't have a team yet
    if ( (Player != None) && (Player.PlayerReplicationInfo != None) )
    {
        if ( Player.PlayerReplicationInfo.Team != None )
            Team = Player.PlayerReplicationInfo.Team.TeamIndex;
        else
            Team = InTeam;
    }
    else
        Team = InTeam;

    for ( N=Level.NavigationPointList; N!=None; N=N.NextNavigationPoint )
    {
        NewRating = RatePlayerStart(N,Team,Player);
        if ( NewRating > BestRating )
        {
            BestRating = NewRating;
            BestStart = N;
        }
    }

    return BestStart;
}

/* Overwritten method from Deathmatch, I don't like this but it needed a hack
*/
// ============================================================================
function Bot SpawnBot(Optional string BotName)
{
    local Bot NewBot;
    local RosterEntry Chosen;
	local UnrealTeamInfo BotTeam;
	local float oldDiff;

    BotTeam = GetBotTeam();
    if(BotTeam != none)
    {
	    Chosen = BotTeam.ChooseBotClass(botName);

	    if (Chosen.PawnClass == None)
	    {
	        Chosen.Init(); //amb
	    }
	    // log("Chose pawn class "$Chosen.PawnClass);
	    NewBot = Spawn(class'da_AI_HumanBot');

	    if ( NewBot != None ) {
            oldDiff = AdjustedDifficulty;
	        AdjustedDifficulty = 5;
	        InitializeBot(NewBot,BotTeam,Chosen);
	        AdjustedDifficulty = oldDiff;
	    }
    }
    return NewBot;
}

//Achievements
// ============================================================================
function Killed(Controller Killer, Controller Killed, Pawn KilledPawn, class<DamageType> damageType)
{

	if ( PlayerController(Killer) != none && Killed != Killer)
	{
		if ( da_SteamStatsAndAchievements(PlayerController(Killer).SteamStatsAndAchievements) != none )
		{

			if ( damageType == class'da_damtypes_Sniper' || damageType == class'da_damtypes_SniperHeadShot' )
				da_SteamStatsAndAchievements(PlayerController(Killer).SteamStatsAndAchievements).AddSniperKill();
 
			else if ( damageType == class'da_damtypes_HandGrenade')
				da_SteamStatsAndAchievements(PlayerController(Killer).SteamStatsAndAchievements).AddGrenadeKill();

			else if ( damageType == class'da_damtypes_MS25RocketLauncher' )
				da_SteamStatsAndAchievements(PlayerController(Killer).SteamStatsAndAchievements).AddRocketKill();
				
			else if ( damageType == class'da_damtypes_melee' )
				da_SteamStatsAndAchievements(PlayerController(Killer).SteamStatsAndAchievements).AddMeleeKill();
				
			if (KilledPawn.IsA('ASTurret') && damageType == class'da_damtypes_MS25RocketLauncher')
				da_SteamStatsAndAchievements(PlayerController(Killer).SteamStatsAndAchievements).DestroyTurret();
				
			if ( KFMonster(KilledPawn) != None )
			{	
				da_SteamStatsAndAchievements(PlayerController(Killer).SteamStatsAndAchievements).AddZedKill(damageType, da_players_PRI(Killer.PlayerReplicationInfo).playerClass);
				
				if ( KilledPawn.IsA('ZombieHusk') )
					da_SteamStatsAndAchievements(PlayerController(Killer).SteamStatsAndAchievements).AddHuskKill();
					
				else if ( KilledPawn.IsA('ZombieBoss') )
					da_SteamStatsAndAchievements(PlayerController(Killer).SteamStatsAndAchievements).PatriarchKilled();
					
				else if ( KilledPawn.IsA('ZombieFleshpound') && KFMonster(KilledPawn).bIsSquadLeader )
					da_SteamStatsAndAchievements(PlayerController(Killer).SteamStatsAndAchievements).FleshpoundChampionKilled();
					
				else if ( KilledPawn.IsA('ZombieScrake') && KFMonster(KilledPawn).bIsSquadLeader )
					da_SteamStatsAndAchievements(PlayerController(Killer).SteamStatsAndAchievements).ScrakeChampionKilled(); 
					
				else if ( KilledPawn.IsA('ZombieHusk') && KFMonster(KilledPawn).bIsSquadLeader )
					da_SteamStatsAndAchievements(PlayerController(Killer).SteamStatsAndAchievements).HuskChampionKilled();
					
				else if ( KilledPawn.IsA('ZombieBloat') && KFMonster(KilledPawn).bIsSquadLeader )
					da_SteamStatsAndAchievements(PlayerController(Killer).SteamStatsAndAchievements).BloatChampionKilled();
					
				else if ( KilledPawn.IsA('ZombieSiren') && KFMonster(KilledPawn).bIsSquadLeader )
					da_SteamStatsAndAchievements(PlayerController(Killer).SteamStatsAndAchievements).SirenChampionKilled();
					
				else if ( KilledPawn.IsA('ZombieStalker') && KFMonster(KilledPawn).bIsSquadLeader )
					da_SteamStatsAndAchievements(PlayerController(Killer).SteamStatsAndAchievements).StalkerChampionKilled();
					
				else if ( KilledPawn.IsA('ZombieGorefast') && KFMonster(KilledPawn).bIsSquadLeader )
					da_SteamStatsAndAchievements(PlayerController(Killer).SteamStatsAndAchievements).GorefastChampionKilled();
					
				else if ( KilledPawn.IsA('ZombieClot') && KFMonster(KilledPawn).bIsSquadLeader )
					da_SteamStatsAndAchievements(PlayerController(Killer).SteamStatsAndAchievements).ClotChampionKilled();
					
				else if ( KilledPawn.IsA('ZombieCrawler') && KFMonster(KilledPawn).bIsSquadLeader )
					da_SteamStatsAndAchievements(PlayerController(Killer).SteamStatsAndAchievements).CrawlerChampionKilled();
					
				if ( KilledPawn.IsA('ZombieFleshpound') && damageType == class'da_damtypes_melee')
					da_SteamStatsAndAchievements(PlayerController(Killer).SteamStatsAndAchievements).FPMelee();
				
				//log("Current Damage Done: "@SurvivalPlayerReplicationInfo(PlayerController(Killer).PlayerReplicationInfo).DamageDone);
				
				if (SurvivalPlayerReplicationInfo(PlayerController(Killer).PlayerReplicationInfo).DamageDone >= 40000)
					da_SteamStatsAndAchievements(PlayerController(Killer).SteamStatsAndAchievements).DamageDone40000();
					
				else if (SurvivalPlayerReplicationInfo(PlayerController(Killer).PlayerReplicationInfo).DamageDone >= 10000)
					da_SteamStatsAndAchievements(PlayerController(Killer).SteamStatsAndAchievements).DamageDone10000();
					

				if ( damageType == class'da_damtypes_PlasmaBomb' )
				{
					PlasmaKills ++;

					//log("PlasmaKills: "@PlasmaKills);

				    	if ( PlasmaKills >= 15 )
    					{
    						da_SteamStatsAndAchievements(PlayerController(Killer).SteamStatsAndAchievements).Killed15ZedsWithPlasmabomb();
    					}
				}	 
			}
		}
	}
super.Killed(Killer, Killed, KilledPawn, damageType);
}

// ============================================================================
function ResetPlasmaKills()
{
//log("PlasmaKills reset");

PlasmaKills = 0;
}

// ============================================================================
function int GetDefenderNum()
{
    return 0;
	
}

// ============================================================================
function FindNewObjectives(GameObjective dao) {
	local GameObjective o, best;
	local int dp;
	dp = 0;
	foreach allactors(class'GameObjective', o)
	if (!o.bDisabled) {
		if (o.defensepriority > dp) {
			dp = max(dp, o.defensepriority);
			best = o;
		}
	}
	if (best != none)
		best.setActive(true);
	super.findNewObjectives(dao);
}
// ============================================================================
function da_players_ClassInfo getClassInfo(Controller p)
{
    local da_players_PRI PRI;

    PRI= da_players_PRI( p.Pawn.PlayerReplicationInfo );
    if (PRI.playerClass < 0)
       return none;

    return DAGRI.teamConfig[PRI.team.TeamIndex].classSet.playerClasses[PRI.playerClass];
}

// ============================================================================
function SetPlayerDefaults(Pawn PlayerPawn)
{
    local da_players_ClassInfo ci;
    PlayerPawn.AirControl = PlayerPawn.Default.AirControl;
    PlayerPawn.WaterSpeed = PlayerPawn.Default.WaterSpeed;
    PlayerPawn.AirSpeed = PlayerPawn.Default.AirSpeed;
    PlayerPawn.Acceleration = PlayerPawn.Default.Acceleration;
    PlayerPawn.JumpZ = PlayerPawn.Default.JumpZ;
    PlayerPawn.AirControl = PlayerPawn.Default.AirControl;
    ci = getClassInfo(playerPawn.Controller);

    if (ci != none)
        PlayerPawn.GroundSpeed = ci.classSpeed;

	if (playerPawn.controller.isa('da_ai_HumanBot'))
		da_players_ClassPlayer(playerPawn).botFixes();

    BaseMutator.ModifyPlayer(PlayerPawn);
}

// ============================================================================
static final function string ReplaceString(coerce string Text, coerce string Replace, coerce string With)
{
    local int i;
    local string Output;

    i = InStr(Text, Replace);
    while (i != -1) {
        Output = Output $ Left(Text, i) $ With;
        Text = Mid(Text, i + Len(Replace));
        i = InStr(Text, Replace);
    }
    Output = Output $ Text;
    return Output;
}

// ============================================================================
function int ReduceDamage( int Damage, pawn injured, pawn instigatedBy, vector HitLocation, out vector Momentum, class<DamageType> DamageType )
{
	local int InjuredTeam, InstigatorTeam;
	local controller InstigatorController;

	if ( InstigatedBy != None )
		InstigatorController = InstigatedBy.Controller;

	if ( InstigatorController == None )
	{
		if ( DamageType.default.bDelayedDamage )
			InstigatorController = injured.DelayedDamageInstigatorController;
		if ( InstigatorController == None )
			return Super(UnrealMPGameInfo).ReduceDamage( Damage,injured,instigatedBy,HitLocation,Momentum,DamageType );
	}

	InjuredTeam = Injured.GetTeamNum();
	InstigatorTeam = InstigatorController.GetTeamNum();
	if ( InstigatorController != injured.Controller )
	{
		if ( (InjuredTeam != 255) && (InstigatorTeam != 255) )
		{
			if ( InjuredTeam == InstigatorTeam )
			{
				if ( class<WeaponDamageType>(DamageType) != None || class<VehicleDamageType>(DamageType) != None )
					Momentum *= TeammateBoost;
				if ( (Bot(injured.Controller) != None) && (InstigatorController.Pawn != None) )
					Bot(Injured.Controller).YellAt(InstigatorController.Pawn);
				else if ( (PlayerController(Injured.Controller) != None)
						&& Injured.Controller.AutoTaunt() )
					Injured.Controller.SendMessage(InstigatorController.PlayerReplicationInfo, 'FRIENDLYFIRE', Rand(3), 5, 'TEAM');

				if ( FriendlyFireScale==0.0 || (Vehicle(injured) != None && Vehicle(injured).bNoFriendlyFire) )
				{
					if ( GameRulesModifiers != None )
						return GameRulesModifiers.NetDamage( Damage, 0,injured,instigatedBy,HitLocation,Momentum,DamageType );
					else
						return 0;
				}
				Damage *= FriendlyFireScale;
			}
			else if ( !injured.IsHumanControlled() && (injured.Controller != None)
					&& (injured.PlayerReplicationInfo != None) && (injured.PlayerReplicationInfo.HasFlag != None) )
				injured.Controller.SendMessage(None, 'OTHER', injured.Controller.GetMessageIndex('INJURED'), 15, 'TEAM');
		}
	}
	
	if(Damage>0 && injured!=instigatedby && instigatedby!=none &&
    da_players_playercontroller(instigatedby.Controller)!=none)
        da_players_playercontroller(instigatedby.Controller).RecentHit+=128+Damage*2;
		
	return Super(UnrealMPGameInfo).ReduceDamage( Damage,injured,instigatedBy,HitLocation,Momentum,DamageType );
}

// ============================================================================
event PreBeginPlay()
{
	super.PreBeginPlay();

	DAGRI = da_game_ReplicationInfo(GameReplicationInfo);
    GameReplicationInfo.bNoTeamSkins=true;
	teamgame(level.game).bforcerespawn = false;
/*	
	if (MaxRounds > 0)
	{
		// Reset ALL actors (except controllers)
	foreach AllActors(class'Actor', A)
	{	
		if ( A.IsA('da_turrets_Turret') ) 
				da_turrets_Turret(A).Destroy();
				
		if ( A.IsA('da_items_worldAmmoBox') )
				da_items_worldAmmoBox(A).Destroy();
		
		if ( A.IsA('da_Objective_base') ) 
		{
			if ( da_Objective_base(A).bDisabled)  
			{
				da_Objective_base(A).bActive = True;
				da_Objective_base(A).TriggerEvent(Event, self, Instigator);
				da_Objective_base(A).bDisabled = False;
			}
			
		    if ( A.IsA('da_objective_destroyable') )
				da_objective_destroyable(A).health = 3000;
		}
	}
	}
*/
}

// Defence Alliance 2 - PostBeginPlay with full log support.
// ============================================================================
event PostBeginPlay()
{
	local da_players_TeamConfig 	config;
	local int						i;
	local da_objective_ControlPoint cp;
	local GameObjective	dao, best;
	local int dp;

	super.PostBeginPlay();

	DAGRI = da_game_ReplicationInfo(GameReplicationInfo);

    log("--Begin Defence Aliance 2 Setup--");
	log("-> Version:"@class'da_Utilities'.static.getVersionString());

    log("-> Setting up game objectives...");
	dp = 0;
	foreach allactors(class'GameObjective', dao)
		if (dao.isActive() && dao.defensepriority > dp) {
			if (best != none)
				best.setActive(false);
			best = dao;
			dp = best.defensePriority;
		}

    //Team Config
	foreach AllActors(class'da_players_TeamConfig', config)
		DAGRI.TeamConfig[config.team]= config;

	for ( i=0; i < 2; i++ )
		if (DAGRI.TeamConfig[i] == None)
		{
		    log("-> Setting default-TeamConfig for team "$i);
			DAGRI.TeamConfig[i]= getDefaultTeamConfig(i);
		}
		else
            log("-> Found map-TeamConfig for team "$i);

	//Team Info
    for (i = 0; i < 2; i++) {
		DAGRI.teamInfo[i] = spawn(class'da_game_TeamInfo');
		DAGRI.teamInfo[i].teamlifes = DAGRI.TeamConfig[i].teamlifes;
        log("-> Teamlifes for team "$i$": "$DAGRI.teamInfo[i].teamlifes);
	}

    // Controlpoints
	i = 0;
	foreach Allactors(class'da_objective_ControlPoint', cp) {
		controlPoint[cp.controlPointNumber] = cp;
		i++;
	}

	log("-> Found"@i@"controlpoint(s).");
    log("--End Defence Aliance 2 Setup--");

		DAGRI.buildLimits_def[0] = DAGRI.teamConfig[0].numAmmoboxes;
		DAGRI.buildLimits_def[1] = DAGRI.teamConfig[0].numAVeRs;
		DAGRI.buildLimits_def[2] = DAGRI.teamConfig[0].numCrushers;
		DAGRI.buildLimits_def[3] = DAGRI.teamConfig[0].numDFAs;
		DAGRI.buildLimits_att[0] = DAGRI.teamConfig[1].numAmmoboxes;
		DAGRI.buildLimits_att[1] = DAGRI.teamConfig[1].numAVeRs;
		DAGRI.buildLimits_att[2] = DAGRI.teamConfig[1].numCrushers;
		DAGRI.buildLimits_att[3] = DAGRI.teamConfig[1].numDFAs;

		updateBuildCounts = true;
}

/*	Loads the da_players_TeamConfig for the given team. I
 *  if it couldn't be found one in the map, then return
 *	Default.
 */
 // ============================================================================
function Tick(float DeltaTime) {
	tickCounter++;
	
	if (updateBuildCounts && (tickCounter % 50) == 0)
		CalculateTurretCount();
	
	if (tickCounter > 10000)
		tickCounter = 0;
}

// ============================================================================
function CalculateTurretCount()
{
	local da_turrets_Turret t;
	local da_items_WorldAmmoBox b;
	local int buildCount_att[4], buildCount_def[4], i;

	DAGRI = da_game_ReplicationInfo(Level.Game.GameReplicationInfo);

	foreach DynamicActors(class'da_items_WorldAmmoBox', b)
	{
		if (!b.bStartBuilt && b.Team == 0)
			buildCount_def[0] += 1;

		if (!b.bStartBuilt && b.Team == 1)
			buildCount_att[0] += 1;
	}

	foreach DynamicActors(class'da_turrets_Turret', t)
	{
		if (t.mechOwner != none && t.Team == 0)
		{
			if (ClassIsChildOf(t.class, class'da_turrets_AverTurret'))
				buildCount_def[1] += 1;
			else if (ClassIsChildOf(t.class, class'da_turrets_CrushTurret'))
				buildCount_def[2] += 1;
			else if (ClassIsChildOf(t.class, class'da_turrets_DFATurret'))
				buildCount_def[3] += 1;
		}

		if (t.mechOwner != none && t.Team == 1)
		{
			if (ClassIsChildOf(t.class, class'da_turrets_AverTurret'))
				buildCount_att[1] += 1;
			else if (ClassIsChildOf(t.class, class'da_turrets_CrushTurret'))
				buildCount_att[2] += 1;
			else if (ClassIsChildOf(t.class, class'da_turrets_DFATurret'))
				buildCount_att[3] += 1;
		}
	}

	for (i=0; i<4; i++) 
	{
		DAGRI.buildCount_def[i] = buildCount_def[i];
		DAGRI.buildCount_att[i] = buildCount_att[i];
	}
}

 // ============================================================================
function da_players_TeamConfig getDefaultTeamConfig(int team) {
	local da_players_TeamConfig config;

	if (team < 0 || team > 1) {
	   warn("-> Team "$team$" out of range.");
	   return None;
	}

	config= spawn( class'da_players_TeamConfig' );
	config.team=team;
	return config;
}

// ============================================================================
function bool canChooseClass(Controller c, int num, int nade, float extrahealth, float reload, bool inc) {
    local int teamNo;
    local da_players_TeamConfig config;

    teamNo = c.PlayerReplicationInfo.Team.TeamIndex;
    if (teamNo < 0 || teamNo >= 2)
        return false;
    config = DAGRI.teamConfig[c.PlayerReplicationInfo.Team.TeamIndex];
    return (num >= 0 && num < 10 && config.classSet.playerClasses[num] != none );
}

// ============================================================================
function bool teamIsDead(int team) {
	local int i;
	for (i = 0; i < DAGRI.PRIArray.length; i++)
		if (DAGRI.PRIArray[i].Team.TeamIndex == team && (!DAGRI.PRIArray[i].Owner.isInState('Dead') || !DAGRI.PRIArray[i].Owner.IsInState('PlayerWaiting')))
			return false;

	return true;
}

event InitGame( string Options, out string Error ) {
    super.initGame(options, error);
    bBalanceTeams = true;
    bPlayersBalanceTeams = true;
}

/* In DA, DefaultInventory is all a player can pickup
*/
// ============================================================================
function AddDefaultInventory(Pawn playerPawn) {
	local da_players_PRI 					PRI;
	local da_players_ClassInfo              cInfo;
	local int 								i;
	local Weapon							newWeapon;
	local da_weapons_Grenades               grenades;

	bAllowTrans = false;	// Just make sure...

	if (!PlayerPawn.PlayerReplicationInfo.bIsSpectator && PlayerPawn.PlayerReplicationInfo != none && PlayerPawn.PlayerReplicationInfo.Team != none ) {
		PRI= da_players_PRI( PlayerPawn.PlayerReplicationInfo );
		cInfo = DAGRI.TeamConfig[ PRI.Team.TeamIndex ].classSet.playerClasses[ PRI.playerClass ];
// Check if this playerpawn's first spawn or if there is an error with the selection
		if ( PRI.playerClass < 0 || PRI.playerClass > 10 || DAGRI.TeamConfig[ PRI.Team.TeamIndex ].classSet.playerClasses[PRI.playerClass] == none )
			return;

		for ( i=0; DAGRI.TeamConfig[ PRI.Team.TeamIndex ].classSet.playerClasses[ PRI.playerClass ].Weapons[i] != none; i++ )
			if (PlayerPawn.findInventoryType(DAGRI.TeamConfig[ PRI.Team.TeamIndex ].classSet.playerClasses[ PRI.playerClass ].Weapons[i].Weapon ) == None) {
				newWeapon = Spawn(DAGRI.TeamConfig[ PRI.Team.TeamIndex ].classSet.playerClasses[ PRI.playerClass ].Weapons[i].Weapon,,,PlayerPawn.Location);
				if ( newWeapon != None ) {
					newWeapon.giveTo(PlayerPawn);
					newWeapon.bCanThrow= false;
				}
			}

        da_players_HumanPlayer(playerPawn).armor = cInfo.armor;
        if (cInfo.bCanBuild) {
			newWeapon = spawn(class'da_weapons_MechTool',,,playerpawn.location);
			newWeapon.giveTo(playerPawn);
            da_players_ClassPlayer(playerPawn).mechTool = da_weapons_MechTool(playerPawn.findInventoryType(class'da_weapons_MechTool'));
		}
		
	    grenades = da_weapons_Grenades(playerPawn.FindInventoryType(class'da_weapons_Grenades'));
	    if (grenades == none) {
	       grenades = spawn(class'da_weapons_Grenades',,,playerPawn.Location);
	       grenades.grenadeClass=DAGRI.TeamConfig[PRI.Team.TeamIndex].classSet.playerClasses[PRI.playerClass].grenadeclass;
           grenades.GiveTo(playerPawn);
	       if (da_players_PlayerController(playerPawn.controller) != none)
	           da_players_PlayerController(playerPawn.Controller).grenades = grenades;
	        else
	           da_ai_HumanBot(playerPawn.Controller).grenades = grenades;
	    }
	    grenades.grenadeAmount = DAGRI.TeamConfig[ PRI.Team.TeamIndex ].classSet.playerClasses[ PRI.playerClass ].grenadenumber;
		
		SetPlayerDefaults(PlayerPawn);
		playerPawn.Controller.ClientSwitchToBestWeapon();
	} else {	// Something bad is going on !? Or maybe he just connected...
		// I left this is since a long time now, and it never happened something "bad"
//		Warn("DefenceAlliance:AddDefaultInventory() Player is in no team:"@PlayerPawn.PlayerReplicationInfo.Name@" Note: This is ok for players which connected only recently or if player just changed team");
	  }
}


// ============================================================================
function Timer()
{
	Super.Timer();

	if (ElapsedTime % 10 == 0)
	{
	    UpdateSteamUserData();
	}
}

// ============================================================================
function bool CheckEndGame(PlayerReplicationInfo Winner, string Reason) {
    local Controller P, NextController;

    if (reason ~= "timelimit" && winner == none) {
        //foreach allactors(class'da_game_MapSetup', msp)
            GameReplicationInfo.winner = Teams[0];
          //TeamInfo(GameReplicationInfo.Winner).TeamIndex == 0;
    }


    for ( P=Level.ControllerList; P!=None; P=P.nextController )
	  if ( (P.PlayerReplicationInfo != None) && (P.PlayerReplicationInfo.Team == GameReplicationInfo.Winner)
	   		&& ((Winner == None) || (P.PlayerReplicationInfo.Score > Winner.Score)) )
      {
	        Winner = P.PlayerReplicationInfo;
	  }

    EndTime = Level.TimeSeconds + EndTimeDelay;

    if (winner != none)
        GameReplicationInfo.Winner = Winner.Team;

	//log("GameReplicationInfo.Winner="$TeamInfo(GameReplicationInfo.Winner).TeamIndex);
    if ( CurrentGameProfile != None && winner != none)
		CurrentGameProfile.bWonMatch = (PlayerController(Winner.Owner) != None);

    for ( P=Level.ControllerList; P!=None; P=NextController )
    {
		NextController = P.NextController;
		
		if (PlayerController(P) != none)
		{
			//PlayerController(P).myHUD.bshowScoreboard = true;
			if ( TeamInfo(GameReplicationInfo.Winner).TeamIndex == 0 )
			{
				PlayerController(P).ReceiveLocalizedMessage(class'da2.da_WaitingMessage', 8); //defenders won
			}
			else
			{
				PlayerController(P).ReceiveLocalizedMessage(class'da2.da_WaitingMessage', 7); //attackers won
			}
			
			if (P.PlayerReplicationInfo.Team == GameReplicationInfo.Winner)
			{
				da_players_PlayerController(PlayerController(P)).AMIAnnouncement(sound'AMISounds.Player.GameWin');
			}
			else
			{
				da_players_PlayerController(PlayerController(P)).AMIAnnouncement(sound'AMISounds.Player.GameLost');
			}
				
			PlayWinMessage(PlayerController(P),(P.PlayerReplicationInfo.Team == GameReplicationInfo.Winner));
		}
		
		P.GameHasEnded();

    }

    return true;
}

// ============================================================================
function EndGame(PlayerReplicationInfo Winner, string Reason )
{
//	if ( CurrentRound >= MaxRounds )
//	{
		if (reason ~= "winobjective")
			reason = "triggered";
		if ( (Reason ~= "triggered") ||
			(Reason ~= "TimeLimit") )
			Super.EndGame(Winner,Reason);
//	}
//	else 
//	{
//		ResetLevel();
//		StartNewRound();
//	}
}

// ============================================================================
auto State PendingMatch
{
	function Timer()
	{
		super.Timer();

	    UpdateSteamUserData();
	}

	function EndState()
	{
		super.EndState();
	}
	
	function EndRound(String Reason);

Begin:
	if ( bQuickStart )
		StartMatch();
}

// ============================================================================
state MatchInProgress
{
	function Timer()
	{
		super.Timer();

		if (ElapsedTime % 10 == 0)
		{
		    UpdateSteamUserData();
		}
	}
	
	function beginstate()
    {
		local Controller C;
		
		for ( C = Level.ControllerList; C != none; C = C.NextController )
		{
			if ( da_players_PlayerController(C) != none )
				{
					log("MatchInProgress, sending rank for player "@da_players_PRI(PlayerController(C).PlayerReplicationInfo).PlayerName@" to server");
					da_players_PlayerController(C).SendRanktoServer();
				}
		}
	}
}

// ============================================================================
state MatchOver
{
	function EndRound(String Reason) {}
	
	function RestartPlayer( Controller aPlayer ) 
	{
		super.RestartPlayer( aPlayer );
	}
	
	function ScoreKill(Controller Killer, Controller Other) {}
	function int ReduceDamage( int Damage, pawn injured, pawn instigatedBy, vector HitLocation, out vector Momentum, class<DamageType> DamageType )
	{
		return 0;
	}

	function bool ChangeTeam(Controller Other, int num, bool bNewTeam)
	{
		return false;
	}

    function Timer()
    {
        Global.Timer();

        if ( !bGameRestarted && (Level.TimeSeconds > EndTime + RestartWait) )
            RestartGame();
    }
    function bool NeedPlayers()
    {
        return false;
    }

    function BeginState()
    {
		local Controller C;
		local PlayerController P;

		GameReplicationInfo.bStopCountDown = true;
        if ( CurrentGameProfile != None )
        {
			EndTime = Level.TimeSeconds + SinglePlayerWait;
			for ( c=Level.ControllerList; c!=None; c=c.NextController )
			{
				P = PlayerController(C);
				if ( P != None )
					break;
			}
			CurrentGameProfile.RegisterGame(self,P.PlayerReplicationInfo);
            SavePackage(CurrentGameProfile.PackageName);
        }
     }
}
/*
// ============================================================================
// Start new round... reset everything, swap teams...
function StartNewRound()
{
	log("## ASGameInfo::StartNewRound ##");

	CurrentRound++;

	BeginRound();
}
// ============================================================================
function StartMatch()
{
	super.StartMatch();

	if ( CurrentRound == 0 && Level.NetMode == NM_StandAlone )
		StartNewRound();
	else
		BeginRound();
}
// ============================================================================
function BeginRound()
{
	local Controller		C, NextC;
	
		// re spawn players
	C = Level.ControllerList;
	while ( C != None )
	{
		NextC = C.NextController;

		if ( C.IsA('PlayerController') && C.PlayerReplicationInfo != None && !C.PlayerReplicationInfo.bOnlySpectator )
			RestartPlayer( C );

		C = NextC;
	}
}
// ============================================================================
function ResetLevel()
{
	local Controller		C, NextC;
	local Actor				A;
	
	log("ResetLevel");
	
		// Reset ALL controllers first
	C = Level.ControllerList;
	while ( C != None )
	{
		NextC = C.NextController;

		if ( C.PlayerReplicationInfo == None || !C.PlayerReplicationInfo.bOnlySpectator )
		{
			if ( PlayerController(C) != None )
			{
				if ( (C.PlayerReplicationInfo.Team == None) || (C.PlayerReplicationInfo.Team.TeamIndex == 1) )
					PlayerController(C).ServerChangeTeam(0);
				else
					PlayerController(C).ServerChangeTeam(1);
					
				PlayerController(C).ClientReset();
			}
			C.Reset();
		}
		C = NextC;
	}

	Level.Game.KillBots(Level.Game.NumBots);
	
	// Reset ALL actors (except controllers)
	foreach AllActors(class'Actor', A)
	{	
		if ( A.IsA('da_turrets_Turret') ) 
				da_turrets_Turret(A).Destroy();
				
		if ( A.IsA('da_items_worldAmmoBox') )
				da_items_worldAmmoBox(A).Destroy();
		
		if ( A.IsA('da_Objective_base') ) 
		{
			if ( da_Objective_base(A).bDisabled)  
			{
				da_Objective_base(A).bActive = True;
				da_Objective_base(A).TriggerEvent(Event, self, Instigator);
				da_Objective_base(A).bDisabled = False;
			}
			
		    if ( A.IsA('da_objective_destroyable') )
				da_objective_destroyable(A).health = 3000;
		}
		
		if ( !A.IsA('Controller') )
			A.Reset();
	}
}

// ============================================================================
function EndRound(String Reason)
{
	if ( CurrentRound >= MaxRounds )
	{
		// need to override DeathMatch::EndGame because it's not supporting Reason="roundlimit"
		super(GameInfo).EndGame(None, "roundlimit");

		if ( bGameEnded )
            GotoState('MatchOver');

		return;
	}
}
*/
// Let's shoot the announcer and other random stuff ;)
// ============================================================================
function EndSpree(Controller Killer, Controller Other);
// ============================================================================
function NotifySpree(Controller Other, int num);
// ============================================================================
function AnnounceScore(int ScoringTeam);
// ============================================================================
function PlayEndOfMatchMessage();
// ============================================================================
function PlayStartupMessage();
// ============================================================================
function InitTeamSymbols();

// ============================================================================
function actor FindSpecGoalFor(PlayerReplicationInfo PRI, int TeamIndex) {
	local int i;
	local da_players_PlayerController pc;
	local float bestDist;
	local Actor best;

	pc = da_players_PlayerController(PRI.owner);
	if (pc == none)
		return none;

	bestDist = -1.0;
	for (i = 0; i < controlPoint.length; i++)
		if (controlPoint[i] != none && !controlPoint[i].bDisabled && controlPoint[i].bActive &&
            (bestDist < 0 || vsize(pc.Location - controlPoint[i].Location) < bestDist)) {
			bestDist = vsize(pc.Location - controlPoint[i].Location);
			best = controlPoint[i];
		}
	return best;
}

// ============================================================================
function ScoreKill(Controller Killer, Controller Other) {
         	local int team;

    if (killer == none)
         return;

	super.ScoreKill(Killer, Other);

	if (Other == none || other.PlayerReplicationInfo == none)
		return;

	team = Other.PlayerReplicationInfo.Team.TeamIndex;
	if (DAGRI.teamConfig[team].teamLifes > 0)
		DAGRI.teamInfo[team].teamlifes = max(0, DAGRI.teamInfo[team].teamlifes - 1);

	if (!bGameEnded && DAGRI.teamConfig[team].teamlifes > 0 && DAGRI.teamInfo[team].teamlifes <= 0)
		EndGame(Killer.PlayerReplicationInfo, "teamlifes");
}

// ============================================================================
function RestartPlayer(Controller aPlayer) {
	//local int team;
	//local NavigationPoint checkPoint;

	if (aPlayer == none)
		return;

    //team = aPlayer.PlayerReplicationInfo.Team.TeamIndex;

    //For control points check if we can spawn first before we can
    //restart player. -aBsOlUt
    //checkPoint = FindPlayerStart(aPlayer, team);
    //    if (checkPoint == none)
     //   {
    //       if (!aPlayer.IsInState('PlayerWaiting'))
    //          aPlayer.GotoState('PlayerWaiting');
    //         return;
    //    }

    //if (checkPoint != none && (DAGRI.teamInfo[team].teamlifes > 0 || DAGRI.teamConfig[team].teamLifes == 0))
	Super(GameInfo).RestartPlayer(aPlayer);
	
	if (aPlayer.pawn != none)
		da_players_PRI(aPlayer.playerReplicationInfo).suicidePenalty = 0;

}
function bool PlayerCanRestart( PlayerController aPlayer ) {
   return (da_players_PlayerController(aPlayer).PRI.playerClass < 0)
    && ((DAGRI.timeSeconds() >= da_players_PRI(aPlayer.PlayerReplicationInfo).nextRespawnTime)
    && super.PlayerCanRestart(aPlayer));
//
    //return super.PlayerCanRestart(aPlayer);
}

function float SpawnWait(AIController B) {
    return fMax(super.spawnWait(B), DAGRI.teamConfig[ B.PlayerReplicationInfo.Team.TeamIndex ].classSet.playerClasses[ da_players_PRI(B.PlayerReplicationInfo).playerClass ].classSpawnDelay );
}

// ============================================================================
//No precache of sounds we dont use them.
static function PrecacheGameAnnouncements(AnnouncerVoice V, bool bRewardSounds);

static event bool AcceptPlayInfoProperty(string PropertyName) {
	if ( InStr(PropertyName, "GoalScore") != -1 || InStr(PropertyName, "bAllowWeaponThrowing") != -1 ||
		InStr(PropertyName, "bWeaponStay") != -1 || InStr(PropertyName, "bAllowPlayerLights") != -1 ||
		InStr(PropertyName, "bAllowTrans") != -1)
		return false;

	return super.AcceptPlayInfoProperty(propertyName);
}




static function FillPlayInfo(PlayInfo PlayInfo) {

    Super.FillPlayInfo(PlayInfo);  // Always begin with calling parent

    playInfo.PopClass();
}

// ============================================================================
static function string ParseLoadingHintNoColor(string Hint, PlayerController Ref)
{
	local string CurrentHint, Cmd, Result, original;
	local int pos;

	original = hint;

	pos = InStr(Hint, "%");
	if ( pos == -1 )
		return Hint;

	do
	{
		Cmd = "";
		Result = "";

		CurrentHint $= Left(Hint,pos);
		Hint = Mid(Hint, pos+1);

		pos = InStr(Hint, "%");
		if ( pos == -1 )
			break;

		Cmd = Left(Hint,pos);
		Hint = Mid(Hint,pos+1);
		Result = GetKeyBindName(Cmd,Ref);
		if ( Result == Cmd || Result == "" )
		    Result = "(?)";
			//break;

		CurrentHint $= Result;
		pos = InStr(Hint, "%");
	} until ( Hint == "" || pos == -1 );

	if ( Result != "" && Result != Cmd )
		return CurrentHint $ Hint;

	return CurrentHint $ "(?)" $ Hint;
}

defaultproperties
{
     suicidePenalty=4.000000
     da_PathWhisps(0)="DA2.DA2Whisp"
     da_PathWhisps(1)="DA2.DA2Whisp"
     bSpawnInTeamArea=True
     TeamAIType(0)=Class'DA2.da_AI_TeamAI'
     TeamAIType(1)=Class'DA2.da_AI_TeamAI'
     bFirstBlood=True
     bForceNoPlayerLights=True
     SpawnProtectionTime=6.000000
     DefaultEnemyRosterClass="DA2.da_players_TeamInfo"
     LoginMenuClass="DA2.da_GUI_PlayerLoginMenu"
     bWaitingToStartMatch=True
     bAllowVehicles=True
     GameDifficulty=4.000000
     DefaultPlayerClassName="DA2.da_players_ClassPlayer"
     ScoreBoardType="DA2.da_game_ScoreBoard"
     HUDType="DA2.da_players_HUD"
     MapListType="DA2.da_game_MapList"
     MapPrefix="DA2"
     BeaconName="DA2"
     TimeLimit=15
     DeathMessageClass=Class'DA2.da_game_DeathMessageClass'
     MutatorClass="DA2.da_game_DAMutator"
     PlayerControllerClassName="DA2.da_players_PlayerController"
     GameReplicationInfoClass=Class'DA2.da_game_ReplicationInfo'
     GameName="Defence Alliance 2"
     Description="The training is over. The 2 forces are now finally in a head to head attack in Defence Alliance 2. You have joined the Defence Alliance, defend your base at all costs."
     ScreenShotName="DA2Menu.Screen2"
     Acronym="DA2"
     ServerSkillLevel="2"
}
