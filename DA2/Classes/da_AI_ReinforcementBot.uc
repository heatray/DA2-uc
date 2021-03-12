//-----------------------------------------------------------
//
//-----------------------------------------------------------
class da_AI_ReinforcementBot extends da_AI_HumanBot;


state dead {
begin:
    PlayerReplicationInfo.Team.RemoveFromTeam(self);
    destroy();
}

defaultproperties
{
}
