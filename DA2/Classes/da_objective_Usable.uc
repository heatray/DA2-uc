// ============================================================================
//  DA2.da_objective_Usable:
//  Once the player or bot presses the useButton on this objective it will get
//  get disabled.
// ============================================================================

class da_objective_Usable extends da_objective_Touchable placeable;

var     float     LastMessageTimer;

function Touch( Actor Other )
{
 if ((Pawn(Other) == None))
		return;
	
	if ( Pawn(Other).PlayerReplicationInfo != none && DefenderTeamIndex != Pawn(Other).PlayerReplicationInfo.Team.TeamIndex )
	{
			if ( PlayerController(Pawn(Other).controller) != none && LastMessageTimer < Level.TimeSeconds )
			{
				LastMessageTimer = Level.TimeSeconds + 0.6;
				PlayerController(Pawn(Other).controller).ReceiveLocalizedMessage(class'da2.da_WaitingMessage', 1);
			}
	}
	
    if (Pawn(Other) != none && (Bot(Pawn(Other).Controller) != None)) {
      		UsedBy( Pawn(Other) );
	}
}

event UsedBy( Pawn User )
{
    if (User != none && User.PlayerReplicationInfo != none && DefenderTeamIndex != User.PlayerReplicationInfo.Team.TeamIndex) {

        if (da_players_PlayerController(User.Controller) != none)
            da_players_PlayerController(User.Controller).AMIAnnouncement(Sound'AMISounds.Player.NewObjective2');

        DisableObjective( User );

        if(bDisabled) {
            setCollision(false, false, false);
            if(areaeffect!=none)
                areaeffect.kill();
	    }
    }
}

function bool TellBotHowToDisable(Bot B)
{
	if ( B.Pawn == None )
		return false;

	if ( B.Pawn.ReachedDestination(self))
	{
		UsedBy(B.Pawn);
		return true;
	}
	return Super.TellBotHowToDisable(B);
}

defaultproperties
{
     bAreaEffect=False
}
