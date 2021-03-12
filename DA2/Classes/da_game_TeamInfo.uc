class da_game_TeamInfo extends ReplicationInfo;

//var	int	teamPoints;
var	int	teamlifes;

replication {
	reliable if (ROLE == ROLE_Authority)
		teamlifes;
}

defaultproperties
{
}
