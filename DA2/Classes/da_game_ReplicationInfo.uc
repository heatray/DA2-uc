// ============================================================================
//  DA2.da_game_ReplicationInfo:
//  By: aBsOlUt, Dante
// ============================================================================

class da_game_ReplicationInfo extends GameReplicationInfo;

//var da_game_mapSetup        ClientDGM; //If used add to replication
//var int playerRespawnDelay; // Time players have to wait before they can respawn again

var int buildCount_def[4], buildCount_att[4], buildLimits_def[4], buildLimits_att[4];
var da_players_TeamConfig	teamConfig[2];	// DA actually supports 2 Teams only
var da_game_TeamInfo		teamInfo[2];

replication {
    reliable if (ROLE == ROLE_AUTHORITY)
        teamConfig, teamInfo, buildCount_def, buildCount_att, buildLimits_def, buildLimits_att;
}


simulated function float timeSeconds() {
    return level.TimeSeconds;
}

defaultproperties
{
     bNoTeamSkins=True
}
