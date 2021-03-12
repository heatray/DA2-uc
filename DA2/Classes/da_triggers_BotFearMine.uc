class da_triggers_BotFearMine extends da_triggers_BotFearSpot;

function bool RelevantTo(Pawn P)
{
	return(frand()<0.5 && (AIController(P.Controller)!=None)
			&& (P.Controller.PlayerReplicationInfo==None || P.Controller.PlayerReplicationInfo.Team==None || P.Controller.PlayerReplicationInfo.Team.TeamIndex!=TeamNum));
}

defaultproperties
{
     CollisionRadius=150.000000
}
