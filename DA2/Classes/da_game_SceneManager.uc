//=============================================================================
//da_game_SceneManager
//Coded by aBsOlUt, Dante
//
// DA2 mappers should use this scenemanager custom for DA2. The tag is
// 'DAendgame0' or 'DAendgame1' and the game code automatically identifies it
// and plays it at the end.
// Each team must have a scenemanager with the tag if you want the game to play
// them at the end.
//=============================================================================
class da_Game_SceneManager extends SceneManager
	placeable;

var()	bool bHidePlayers; //Hides the player models when the movie plays.

function playScene() {
	if (Level.NetMode == NM_DedicatedServer)
		return;
	bIsRunning = true;
	bIsSceneStarted = false;
}

event SceneStarted()    // Called from C++ when the scene starts.
{
//    local AIScript S;

	if (Level.NetMode == NM_DedicatedServer) {
		abortScene();
		return;
	}

    // Figure out who our viewer is.
    Viewer = None;
    if( Affect==AFFECT_Actor ) {
        Viewer = AffectedActor;
        Viewer.StartInterpolation();
    } else
    {
		viewer = Level.getLocalPlayerController();
        PlayerController(Viewer).unpossess();
        PlayerController(Viewer).bViewingMatineeCinematic = true;
        PlayerController(Viewer).myHUD.bShowScoreBoard = true;
//		PlayerController(Viewer).MyHud.bHideHUD = bHideHUD;/
		Viewer.StartInterpolation();
    }

    TriggerEvent( EventStart, Self, None);
	if (ROLE == ROLE_Authority)
		Level.Game.SceneStarted( Self, None );
}

event SceneEnded()      // Called from C++ when the scene ends.
{
    bIsSceneStarted = false;

    if( Affect==AFFECT_ViewportCamera )
    {
		/*
		if ( OldPawn != None )
			PlayerController(Viewer).Possess( OldPawn );
			*/
		PlayerController(Viewer).bViewingMatineeCinematic = false;
		PlayerController(Viewer).bInterpolating = false;
		PlayerController(Viewer).MyHud.bHideHUD = false;
    } else
        Viewer.FinishedInterpolation();
    Enable( 'Trigger' );

    TriggerEvent( EventEnd, Self, None);
	if (ROLE == ROLE_Authority)
		Level.Game.SceneEnded( Self, None );
}
// remoteRole=ROLE_SimulatedProxy

defaultproperties
{
     bCinematicView=True
     bNoDelete=True
     Tag="DAendgame0"
}
