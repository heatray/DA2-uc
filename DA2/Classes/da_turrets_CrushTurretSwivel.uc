//-----------------------------------------------------------
//
//-----------------------------------------------------------
class da_turrets_CrushTurretSwivel extends ASTurret_Base;

simulated function UpdateSwivelRotation( Rotator TurretRotation ) {
    local Rotator SwivelRotation;

    SwivelRotation          = TurretRotation;
    SwivelRotation.Pitch    = 0;
    SetRotation( SwivelRotation );
}

defaultproperties
{
     DrawType=DT_Mesh
     Physics=PHYS_Rotating
     Mesh=SkeletalMesh'DA2_Stationary.CrushTurretNeck'
     DrawScale=1.100000
     Skins(0)=Shader'DA2DefenseStructures.Turrets.Turret_Skin2'
     bMovable=True
}
