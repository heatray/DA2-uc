class da_AI_TeamAI extends TeamAI;

function CriticalObjectiveWarning(GameObjective G, Pawn NewEnemy)
{
    local SquadAI S;
	super.CriticalObjectiveWarning(G, newEnemy);
	
    for ( S=Squads; S!=None; S=S.NextSquad )
        if ( S.SquadObjective == G )
            S.CriticalObjectiveWarning(NewEnemy);
}


function SetBotOrders(Bot NewBot, RosterEntry R)
{
    local da_game_ReplicationInfo DAGRI;
    local da_players_TeamConfig config;

    if ( Objectives == None )
        SetObjectiveLists();

    DAGRI = da_game_ReplicationInfo(Level.Game.GameReplicationInfo);
    config = DAGRI.teamConfig[NewBot.PlayerReplicationInfo.Team.TeamIndex];

    switch(config.BotBehaviour)
	{
           case Attack:
                 PutOnOffense(NewBot);
                 break;
           case Defend:
                 PutOnDefense(NewBot);
                 break;
           case Sweeper:
                 PutOnFreelance(NewBot);
                 break;
           Case Random:
                 if (FRand() < 0.4)
                 {
                    PutOnDefense(NewBot);
                 }
                 else
                 {
                    PutOnOffense(NewBot);
                 }
                 break;
    }
}

defaultproperties
{
     SquadType=Class'DA2.da_AI_SquadAI'
}
