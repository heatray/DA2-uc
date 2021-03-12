// ============================================================================
//  DA2.da_objective_DefensePoint:
//  Bots can go there to defend specific points in the map. This way the mapper
//  can spread them around so they defend the base better rather than just going
//  to the primary objective.

// CANCELLED.
// ============================================================================

class da_objective_DefensePoint extends da_objective_Base
	hidecategories(DA) notplaceable;

defaultproperties
{
     CollisionRadius=150.000000
}
