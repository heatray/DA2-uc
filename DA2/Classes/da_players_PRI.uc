// ============================================================================
//  DA2.da_players_PRI:
//  By: Dante, aBsOlUt
// ============================================================================

class da_players_PRI extends xPlayerReplicationInfo;

var int		playerClass;
var int 	playerRank;
var float   nextRespawnTime;
var float 	suicidePenalty;
var bool 	enableIncendiary;
var int 	SelectedNade;
var int 	ChosenHealth;
var int 	MedicHealed;
var int 	TurretsBuild;
var int 	PlayerHealth;
var float 	ReloadSpeed;


var struct WeaponInfoStruct {
    var int ammo, maxAmmo;
} weaponInfo;


replication
{
	reliable if ( ROLE == ROLE_Authority)
		playerClass, weaponInfo, clientSetRespawnTime, SelectedNade, enableIncendiary, ChosenHealth, ReloadSpeed, PlayerHealth, playerRank;
}

simulated function material GetPortrait();

simulated function clientSetRespawnTime(float suicidePenalty) {
	if (ROLE == ROLE_Authority)
		return;
	self.suicidePenalty = suicidePenalty;
	setRespawnTime();
}

simulated function setRespawnTime() {
    local float delay;

    if(playerClass >= 0) {
		if(da_players_PlayerController(owner)!=none)
            delay+=da_game_ReplicationInfo(level.gri).teamConfig[team.TeamIndex].classSet.playerClasses[da_players_PlayerController(owner).pendingClass].classSpawnDelay;
		else
            delay+=da_game_ReplicationInfo(level.gri).teamConfig[team.TeamIndex].classSet.playerClasses[playerClass].classSpawnDelay;
	}

	delay+=suicidePenalty;
	nextRespawnTime=da_game_ReplicationInfo(level.gri).timeSeconds()+delay;

	if (ROLE == ROLE_Authority)
		clientSetRespawnTime(suicidePenalty);
}
function Timer()
{
	local Controller C;

	SetTimer(1.0 + FRand(), False);
	UpdatePlayerLocation();
	
	C = Controller(Owner);
	if( C==None )
		Return;
	if( C.Pawn==None )
		PlayerHealth = 0;
	else PlayerHealth = C.Pawn.Health;
	
	if( !bBot )
	{
	    C = Controller(Owner);
		if ( !bReceivedPing )
			Ping = Min(int(0.25 * float(C.ConsoleCommand("GETPING"))),255);
	}
}

defaultproperties
{
     playerClass=-1
     ChosenHealth=100
     PlayerHealth=100
     ReloadSpeed=100.000000
     bForceNoPlayerLights=True
}
