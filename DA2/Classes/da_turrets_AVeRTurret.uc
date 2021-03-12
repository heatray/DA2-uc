//==============================================================================
// Made by Leviathan
// The AVeR is a anti-vehicle rocket-launcher shooting guided rockets.
// Slow rotation time.
//==============================================================================
class da_turrets_AVeRTurret extends da_turrets_Turret;

simulated function Material getSkinFor(Actor a) {
	switch (team) {
		case 0:
			return Shader'DA2DefenseStructures.Turrets.CrusherGreen_Shader';
		case 1:
			return Shader'DA2DefenseStructures.Turrets.Turret_Skin2';
	}
}

simulated function setSkins() {
    setSkin(self, Shader'DA2DefenseStructures.Turrets.AVeRTurret_Skin');
	setSkin(turretBase, getSkinFor(turretBase));
	setSkin(turretSwivel, getSkinFor(turretSwivel));
}

defaultproperties
{
     descriptiveName="AVeR Turret"
     buildTime=15.000000
     CrosshairTex=Texture'InterfaceArt_tex.Cursors.Crosshair_Cross2'
     TurretBaseClass=Class'DA2.da_turrets_CrushTurretBase'
     TurretSwivelClass=Class'DA2.da_turrets_AVeRTurretSwivel'
     RotationInertia=0.050000
     RotationSpeed=4.000000
     CamDistance=(X=-1000.000000,Z=200.000000)
     bZooming=False
     DefaultWeaponClassName="DA2.da_weapons_AVeRTurret"
     bRemoteControlled=False
     bNoFriendlyFire=True
     bTeamLocked=True
     FPCamPos=(X=18.000000,Z=0.000000)
     bNoTeamBeacon=True
     HealthMax=1000.000000
     Health=1000
     Mesh=SkeletalMesh'DA2_Stationary.AVeRTurretHead'
     DrawScale=1.200000
     Skins(0)=Shader'DA2DefenseStructures.Turrets.AVeRTurret_Skin'
     CollisionRadius=50.000000
     CollisionHeight=35.000000
}
