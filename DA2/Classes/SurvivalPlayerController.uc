class SurvivalPlayerController extends da_players_PlayerController;

// ============================================================================
exec function chooseClass( int num, int nade, float extrahealth, float speed, float reload, bool inc )
{
local SurvivalPlayerReplicationInfo SPRI;

	if (SPRI == none)
		SPRI = SurvivalPlayerReplicationInfo(PlayerReplicationInfo);
			
	ChosenSpeed = speed;
	
    serverChooseClass(num, nade, extrahealth, reload, inc);
	pendingClass = num;
	pendingNade = nade;
	incendiary = inc;
	ChosenHealth = extrahealth;	
	ReloadSpeed = reload;

	//if (PRI != none)
	//	PRI.setRespawnTime();
}

// ============================================================================
exec function ShowCCMenu()
{
		ClientOpenMenu("DA2.SurvivalchooseClass");	
}

// ============================================================================
function serverChooseClass(int num, int nade, float extrahealth, float reload, bool inc) {
    if (DefenceAlliance(level.game).canChooseClass(self, num, nade, extrahealth, reload, inc)) {
    	pendingClass = num;
		pendingNade = nade;
		incendiary = inc;
		ChosenHealth = extrahealth;
		ReloadSpeed = reload;
		
        //PRI.setRespawnTime();
    } else {
		GotoState('RSChoosingClass');
		ClientGotoState('RSChoosingClass','');
    }
}

// ============================================================================
state RSChoosingClass extends PlayerWaiting
{
	function serverChooseClass( int num, int nade, float extrahealth, float reload, bool inc)
	{
		if ( Pawn != None ) {

			Pawn.destroy();
			Pawn = None;
		}
		global.serverChooseClass( num , nade, extrahealth, reload, inc);
		loadPlayers();
		ServerRestartPlayer();
	}

	exec function Fire(optional float F) {
	   ClientOpenMenu("DA2.SurvivalchooseClass");
	}
   
	function PawnDied(Pawn P);
	function ProcessMove(float DeltaTime, vector NewAccel, eDoubleClickDir DoubleClickMove, rotator DeltaRot);

	function BeginState()
	{
		super.BeginState();

           ClientOpenMenu("DA2.SurvivalchooseClass");

		if ( Pawn != None ) {
			Pawn.bhidden= true;
			Pawn.setCollision( false, false, false );
		}
	}
}

// ============================================================================
state Dead
{
	function BeginState()
	{
			local Actor A;

		EndZoom();
		CameraDist = Default.CameraDist;
		FOVAngle = DesiredFOV;
		Pawn = None;
        Enemy = None;
        bBehindView = true;
        bFrozen = true;
		bJumpStatus = false;
        bPressedJump = false;
        bBlockCloseCamera = true;
		bValidBehindCamera = false;
		bFreeCamera = False;
		if ( Viewport(Player) != None )
			ForEach DynamicActors(class'Actor',A)
				A.NotifyLocalPlayerDead(self);
        FindGoodView();
        SetTimer(1.0, false);
		StopForceFeedback();
		ClientPlayForceFeedback("Damage");  // jdf
		CleanOutSavedMoves();
		
		ClientOpenMenu("DA2.SurvivalchooseClass");
	
 		//pendingClass = -1;	
        da_players_PRI( PlayerReplicationInfo ).playerClass = -1;
		
		SurvivalPlayerReplicationInfo( PlayerReplicationInfo ).DamageDone = 0;
    }
Begin:
}

// ============================================================================
function ClientRestart(Pawn NewPawn) 
{
    DAGRI=da_game_ReplicationInfo(GameReplicationInfo);
    PRI=da_players_PRI( PlayerReplicationInfo );
    if (PRI != none) 
	{
        PRI.playerClass = pendingClass;
		PRI.selectedNade = pendingNade;
		PRI.enableIncendiary = incendiary;
		PRI.ChosenHealth = ChosenHealth;
		PRI.ReloadSpeed = ReloadSpeed;
		PRI.PlayerRank = PlayerRank;
	}
	
	super.clientRestart(newPawn);
	
		if (ChosenSpeed != -1)
	{
		//DAGRI.TeamConfig[PRI.Team.TeamIndex].classSet.playerClasses[pendingClass].armor = ChosenArmor;
		DAGRI.TeamConfig[PRI.Team.TeamIndex].classSet.playerClasses[pendingClass].classSpeed = ChosenSpeed;
	}
	
	log("Health:"@ChosenHealth);
	log("Speed:"@ChosenSpeed);
	
    da_players_Hud(self.myHUD).bShowedSpawnHints = false;
	
}



// ============================================================================
function Restart() {
    DAGRI=da_game_ReplicationInfo(GameReplicationInfo);
    PRI=da_players_PRI( PlayerReplicationInfo );
	
	if (PRI != none) 
	{
		PRI.playerClass = pendingClass;
		PRI.selectedNade = pendingNade;
		PRI.enableIncendiary = incendiary;
		PRI.ChosenHealth = ChosenHealth;
		PRI.ReloadSpeed = ReloadSpeed;
		SendRanktoServer();
		PRI.PlayerRank = PlayerRank;
	}
	
	
  if ( PRI.playerClass < 0 ) { //Check for class
        pawn.LinkMesh(none);
		GotoState('RSChoosingClass');
		ClientGotoState('RSChoosingClass','');
	} else
		ClientCloseMenu(true, true);
        super.Restart(); 

    grenades = da_weapons_Grenades(pawn.FindInventoryType(class'da_weapons_Grenades'));
}

// ============================================================================
static function bool CanBeGrabbed(SurvivalPlayerReplicationInfo SPRI, KFMonster Other)
{
	return true;
}

// ============================================================================

defaultproperties
{
     PlayerReplicationInfoClass=Class'DA2.SurvivalPlayerReplicationInfo'
}
