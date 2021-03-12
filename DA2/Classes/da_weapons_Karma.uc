// ============================================================================
// A weapon (static mesh) dropped when a player dies. Uses karma for a neat
// effect.
// Coded by aBsOlUt
// High-Detail Only.
// ============================================================================

class da_weapons_Karma extends Actor;

// Physics=PHYS_Karma

defaultproperties
{
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'DA2KarmaStatics.mr56'
     RemoteRole=ROLE_SimulatedProxy
     LifeSpan=4.000000
     DrawScale=1.050000
     bCollideActors=True
     bCollideWorld=True
     bBlockKarma=True
     Begin Object Class=KarmaParams Name=KParams0
         KMass=1.100000
         KLinearDamping=0.900000
         KAngularDamping=0.100000
         KStartEnabled=True
         KMaxSpeed=1000.000000
         KMaxAngularSpeed=10000.000000
         bClientOnly=False
         bKAllowRotate=True
         bDoSafetime=True
         StayUprightStiffness=0.000000
         KFriction=0.500000
         KRestitution=0.250000
     End Object
     KParams=KarmaParams'DA2.da_weapons_Karma.KParams0'

}
