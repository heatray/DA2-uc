//-----------------------------------------------------------
//
//-----------------------------------------------------------
class da_turrets_DFATurretSwivel extends ASTurret_Base;

simulated function UpdateSwivelRotation( Rotator TurretRotation ) {
    local Rotator SwivelRotation;

    //Blocks the neck from rotating when the turret is stunned.
    if (Owner != none && Owner.isInState('Stunned'))
       return;

    SwivelRotation          = TurretRotation;
    SwivelRotation.Pitch    = 0;
    SetRotation( SwivelRotation );
}

defaultproperties
{
     DrawType=DT_Mesh
     Physics=PHYS_Rotating
     Mesh=SkeletalMesh'DA2_Stationary.DFATurretNeck'
     DrawScale=0.800000
     Skins(0)=Shader'DA2DefenseStructures.Turrets.Turret_Skin'
     bMovable=True
}
