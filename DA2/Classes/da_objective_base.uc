// ============================================================================
//  DA2.DefenceAlliance: Our main gameplay class
//  By: aBsOlUt, Dante
//
// da_objective_Touchable: If Touched (Walk on) it will be triggered. Can end the game.
// da_objective_Usable: If player/bot presses the useKey this objective will get disabled.
// da_objective_ControlPoint: Can be captured (like UT2004 Nodes).
// da_objective_Destroyable: Attaches to a static mesh of your choice.
//                           Must be shot in order to get destroyed.
//
// ============================================================================

class da_objective_base extends GameObjective;

struct MissionUpdate {
      var() int messageSeconds;  // Time to show message
      var() string messageText;  // Text to show
      var() texture messageImage; //Image (64x64 to avoid text overlapping)
};

var(DA)		bool	bWinObjective;	// If this objective is completed the game is over
var(DA)     MissionUpdate MUB[2];
var(DA)     int bonusTime;

function DisableObjective(Pawn Instigator)
{
    local Controller c;
	
	if (da_Players_PlayerController(Instigator.Owner) != none)
	da_SteamStatsAndAchievements(da_Players_PlayerController(Instigator.Owner).SteamStatsAndAchievements).GotObjective();

    super.DisableObjective(Instigator);

    if ( bWinObjective ) {
		if (instigator != none)
		   DefenceAlliance( level.game ).EndGame( Instigator.PlayerReplicationInfo, "winobjective" );
		else
		   DefenceAlliance( level.game ).EndGame( none, "winobjective" );
	   return;
	}

    DefenceAlliance(level.game).FindNewObjectives(self);
    if (bDisabled) {
      DeathMatch(level.game).remainingTime += bonusTime;
      for (c = level.ControllerList; c != none; c = c.nextController) {
         if (c.isa('da_players_PlayerController'))
         {
           if (FRand() < 0.5)
              da_players_PlayerController(c).AMIAnnouncement(Sound'AMISounds.Player.IncomingMessage1');
           else
              da_players_PlayerController(c).AMIAnnouncement(Sound'AMISounds.Player.IncomingMessage2');

           da_players_PlayerController(c).updateMission(self);
         }
      }
    }
}

simulated function PlayDestructionMessage()
{
    local PlayerController  PC;

    if ( DestructionMessage == default.DestructionMessage && DefenderTeamIndex != 255)
           DestructionMessage = Level.GRI.Teams[DefenderTeamIndex].TeamName@DestructionMessage;

    if (DefenderTeamIndex == 255)
       DestructionMessage = "Neutral Control Point secured.";

    if ( ROLE == ROLE_Authority )
    {
        Level.Game.Broadcast(self,class'DefenceAlliance'.static.ReplaceString(DestructionMessage, "%team", DefenceAlliance(Level.Game).DAGRI.TeamConfig[1 - defenderTeamIndex].TeamName),'CriticalEvent');
        return;
    }

    PC = Level.GetLocalPlayerController();
    if ( PC != None )
        PC.TeamMessage(PC.PlayerReplicationInfo, DestructionMessage, 'CriticalEvent');
}


simulated function string GetHumanReadableName() {
	if (DefenderTeamIndex < 2 )
		return super.getHumanReadableName();
	return ObjectiveStringPrefix$ObjectiveStringSuffix;
}

function bool BetterObjectiveThan(GameObjective Best, byte DesiredTeamNum, byte RequesterTeamNum) {
	if ( bDisabled || Best == None || !Best.isA('da_objective_base') )
		return super.BetterObjectiveThan( Best, DesiredTeamNum, RequesterTeamNum );
	else
		return DesiredTeamNum == DefenderTeamIndex && bWinObjective && !da_objective_base( Best ).bWinObjective;

}

simulated function array<string> getInfo() {
    local array<string> info;
    info[0] = ObjectiveName;

    return info;
}

defaultproperties
{
     MUB(0)=(messageSeconds=10,messageText="Message to show for team red Message to show for team red",messageImage=Texture'DA2Objectives.Mission')
     MUB(1)=(messageSeconds=10,messageText="Message to show for team blue Message to show for team blue",messageImage=Texture'DA2Objectives.Mission')
     bonusTime=120
     bReplicateObjective=True
     Score=10
     ObjectiveName="Objective"
     DestructionMessage="%team captured Objective!"
     bAlwaysRelevant=True
}
