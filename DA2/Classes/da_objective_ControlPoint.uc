// ============================================================================
//  DA2.da_objective_ControlPoint:
//  Control points can be recaptured back. Events can be triggered once the
//  capture occurs. CPs are linked with da_game_PlayerStartPoint which spawns
//  players based on the spawnPreference variable.
// ============================================================================

class da_objective_ControlPoint extends da_objective_Touchable;

var(DA) byte  controlPointNumber;	// A number the CP is assigned to
var(DA) byte  spawnPreference;	// The "score" of the controlpoint when choosing playerstart for respawn
var(DA) name  teamOneCaptureTrigger; //Trigger for Team0
var(DA) name  teamTwoCaptureTrigger; //Trigger for Team1


function PostBeginPlay() {
	bDisabled = DefenderTeamIndex != 255 && !bTeamControlled;
	super.PostBeginPlay();
}

function DisableObjective(Pawn Instigator) {
// if this is a winobjective, behave like normal touchable
   if ( !IsActive() || !UnrealMPGameInfo(Level.Game).CanDisableObjective( Self ) )
       return;

   if (da_players_PlayerController(Instigator.Controller) != none)
	da_players_PlayerController(Instigator.Controller).AMIAnnouncement(Sound'AMISounds.Player.NewObjective1');

	super.DisableObjective(Instigator);

	if (DefenderTeamIndex == 0 && teamOneCaptureTrigger != '')
	   TriggerEvent(teamOneCaptureTrigger, self, instigator);

	if (DefenderTeamIndex == 1 && teamTwoCaptureTrigger != '')
	   TriggerEvent(teamTwoCaptureTrigger, self, instigator);
}

defaultproperties
{
     spawnPreference=1
     bAreaEffect=False
     bTeamControlled=True
     Texture=Texture'DA2Textures.editing.CP'
}
