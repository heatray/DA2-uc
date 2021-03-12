//-----------------------------------------------------------
//
//-----------------------------------------------------------
class da_menu_PlayerController extends CinematicPlayer;

var bool bShowingMenu;

auto state PlayerWaiting {
    function ProcessMove(float DeltaTime, vector NewAccel, eDoubleClickDir DoubleClickMove, rotator DeltaRot) {
    }

    function UpdateRotation(float DeltaTime, float maxPitch) {
        local rotator newRot;
        newRot = rotation;
        newRot.yaw += deltaTime * 4096;
        setRotation(newRot);
    }

}

function PlayerTick(float DeltaTime) {
    if (player != none && !bShowingMenu) {
        showMenu();
    }
    super.PlayerTick(deltaTime);
}

exec function GotoMenu(string MenuName) {
//    log("GOING TO MENU"@menuName@getStateName());
    if (MenuName != "") Player.GUIController.OpenMenu(MenuName);
    bShowingMenu = true;
//    ConsoleCommand( "DISCONNECT" );
}

defaultproperties
{
     SteamStatsAndAchievementsClass=Class'DA2.da_SteamStatsAndAchievements'
}
