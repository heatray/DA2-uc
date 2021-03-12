//==============================================================================
// Made by aBsOlUt
// The crusher acts as a semi-automatic cannon with low-explosive shells attached
// Powerful and more accurate but very slow ROF.
// Two shots at a time.
// Slow rotation time.
//==============================================================================

class da_turrets_CrushTurret extends da_turrets_Turret;

simulated function Material getSkinFor(Actor a) {
	switch (team) {
		case 0:
			return Shader'DA2DefenseStructures.Turrets.CrusherGreen_Shader';
		case 1:
			return Shader'DA2DefenseStructures.Turrets.Turret_Skin2';
	}
}

defaultproperties
{
     descriptiveName="Crusher Turret"
     buildTime=12.500000
     CrosshairTex=Texture'InterfaceArt_tex.Cursors.Crosshair_Cross2'
     TurretBaseClass=Class'DA2.da_turrets_CrushTurretBase'
     TurretSwivelClass=Class'DA2.da_turrets_CrushTurretSwivel'
     RotationInertia=0.050000
     RotationSpeed=4.000000
     CamDistance=(X=-1000.000000,Z=200.000000)
     DefaultWeaponClassName="DA2.da_weapons_CrushTurret"
     bRemoteControlled=False
     bNoFriendlyFire=True
     bTeamLocked=True
     FPCamPos=(X=30.000000,Z=0.000000)
     bNoTeamBeacon=True
     HealthMax=1200.000000
     Health=1200
     Mesh=SkeletalMesh'DA2_Stationary.CrushTurretHead'
     DrawScale=1.100000
     Skins(0)=Shader'DA2DefenseStructures.Turrets.Turret_Skin2'
}
