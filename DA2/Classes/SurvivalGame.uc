class SurvivalGame extends DefenceAlliance;
// I don't think this class is used anymore??

// ============================================================================
function byte PickTeam(byte num, Controller C)
{
	return 0;
}

// ============================================================================
event PreBeginPlay()
{
	super.PreBeginPlay();
}

// ============================================================================
event PostBeginPlay()
{
	local SurvivalTeamConfig 	config;
	local int	i;

	DAGRI = da_game_ReplicationInfo(GameReplicationInfo);

	//Team Config
	foreach AllActors(class'SurvivalTeamConfig', config)
		DAGRI.TeamConfig[config.team]= config;

	for ( i=0; i < 2; i++ )
		if (DAGRI.TeamConfig[i] == None)
		{
		    log("-> Setting default-SurvivalTeamConfig for team "$i);
			DAGRI.TeamConfig[i]= getDefaultSurvivalTeamConfig(i);
		}
		else
            log("-> Found map-SurvivalTeamConfig for team "$i);

	super.PostBeginPlay();
}

// ============================================================================
function da_players_TeamConfig getDefaultSurvivalTeamConfig(int team) {
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

defaultproperties
{
     LoginMenuClass="DA2.SurvivalPlayerLoginMenu"
     HUDType="DA2.SurvivalHud"
     PlayerControllerClassName="DA2.SurvivalPlayerController"
     GameReplicationInfoClass=Class'DA2.SurvivalGameReplicationInfo'
}
