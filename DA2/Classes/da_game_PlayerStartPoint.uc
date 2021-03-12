// ============================================================================
//  DA2.da_game_PlayerStartPoint:
// Normal player start, except it can be linked with a da_objective_ControlPoint
// Code will automatically look for the best spot based on which CPs a team
// currently owns.
// ============================================================================
class da_game_PlayerStartPoint extends PlayerStart;

var(DA) byte	controlPointNumber;

defaultproperties
{
}
