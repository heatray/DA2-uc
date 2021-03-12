class DA_Map_TurretGunner extends Actor;

var ASTurret Turret;

function postbeginplay()
{
	loopanim('Idle_Rest');
	settimer( 1.0, true);
}
function timer()
{
	if(turret != none && turret.driver == none)
		destroy();
}
simulated function tick(float delta)
{
	local vector Loc,X,Y,Z;
	local vector VP;

	if( Turret != none && !Turret.isa('da_turrets_DFATurret') )
	{
	GetAxes(Turret.TurretSwivel.rotation,X,Y,Z);

	if( Turret.isa('da_turrets_AVeRTurret') ) {
		VP.X = -52;
		VP.Z = -26;
	}
	else {
		VP.X = -44;
		VP.Z = -20;
	}
		Setlocation(Turret.location + X*VP.X + Y*VP.Y + Z*VP.Z);
		ServerUpdateLocation(Turret.location + X*VP.X + Y*VP.Y + Z*VP.Z);
		setrotation(turret.TurretSwivel.rotation);
	}
	else if( Turret != none && Turret.isa('da_turrets_DFATurret') )
	{
		GetAxes(Turret.base.rotation,X,Y,Z);

		VP.X = -70;
		VP.Z = -55;
		VP.Y = -10;

		Setlocation(Turret.turretbase.location + X*VP.X + Y*VP.Y + Z*VP.Z);
		ServerUpdateLocation(Turret.location + X*VP.X + Y*VP.Y + Z*VP.Z);
		setrotation(turret.base.rotation);
	}
		
}
function ServerUpdateLocation( vector Loc )
{
	setlocation(loc);
	setrotation(turret.TurretSwivel.rotation);
}

defaultproperties
{
     DrawType=DT_Mesh
     RemoteRole=ROLE_SimulatedProxy
     Mesh=SkeletalMesh'DA2_PlayerModels.FrontLine'
     Skins(0)=Shader'DA2PlayerSkins.Skins.Jungle_Body'
     Skins(1)=Shader'DA2PlayerSkins.Skins.Jungle_Head'
     AmbientGlow=50
}
