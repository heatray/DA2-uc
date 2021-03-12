//==============================================================================
// Made by aBsOlUt, Dante
// An automated turret that will be used for mainly base defense.
// Provides a high ROF machine gun to mow down enemy.
//==============================================================================

class da_turrets_DFATurret extends da_turrets_Turret;

#exec OBJ LOAD FILE=DA2_Stationary.ukx
// #exec OBJ LOAD FILE=DA2_DefenseStructures.ukx

simulated function vector GetMuzzleStart() {
         return GetBoneCoords('Muzzle').Origin;
}
simulated function vector GetFireStart( optional float XOffset ) {
    return super.getFireStart(xOffset) - location + GetBoneCoords('Muzzle').origin;

}

simulated function Material getSkinFor(Actor a) {
	switch (team) {
		case 0:
			return Shader'DA2DefenseStructures.Turrets.DFAGreen_Shader';
		case 1:
			return Shader'DA2DefenseStructures.Turrets.Turret_Skin';
	}
}

defaultproperties
{
     descriptiveName="DFA Turret"
     buildTime=10.000000
     Score=7.000000
     CrosshairTex=Texture'InterfaceArt_tex.Cursors.Crosshair_Cross2'
     TurretBaseClass=Class'DA2.da_turrets_DFATurretBase'
     TurretSwivelClass=Class'DA2.da_turrets_DFATurretSwivel'
     RotationInertia=0.100000
     RotationSpeed=7.000000
     CamDistance=(X=-1000.000000,Z=200.000000)
     DefaultWeaponClassName="DA2.da_weapons_DFATurret"
     bRemoteControlled=False
     bNoFriendlyFire=True
     bTeamLocked=True
     FPCamPos=(X=2.000000,Z=30.000000)
     bNoTeamBeacon=True
     HealthMax=800.000000
     Health=800
     Mesh=SkeletalMesh'DA2_Stationary.DFATurretHead'
     DrawScale=0.800000
     Skins(0)=Shader'DA2DefenseStructures.Turrets.Turret_Skin'
     CollisionRadius=35.000000
     CollisionHeight=30.000000
}
