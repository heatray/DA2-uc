// D:\mods\UT2004Script3339\GUI2K4\Classes\UT2K4PlayerLoginMenu.uc
// D:\mods\UT2004Script3339\GUI2K4\Classes\FloatingWindow.uc

// Much of this code comes directly from UT2K4PlayerLoginMenu, but heavily modified

class da_GUI_PlayerLoginMenu extends da_GUI_FloatingWindow; // UT2K4PlayerLoginMenu;

var automated da_GUI_Button b_Team, b_Spec, b_Settings, b_Favs, b_Leave, b_Browser, b_Close, b_Quit, b_MapVote, b_ChangeClass, b_Achievements;

var() noexport bool bTeamGame, bFFAGame, bNetGame;

function InitComponent(GUIController MyController, GUIComponent MyComponent) {
//	local PlayerController PC;

	Super.InitComponent(MyController, MyComponent);

	// rjp -- when playing SinglePlayer or InstantAction game, remove tabs which only apply to multiplayer
//	PC = PlayerOwner();
//	if ( PC != None && PC.Level.NetMode == NM_StandAlone )
//		RemoveMultiplayerTabs(PC.Level.Game);
	// -- rjp

/*
	if ( Panels.Length > 0 )
		AddPanels();
*/

	SetTitle();
//	T_WindowTitle.DockedTabs = c_Main;
}

function GameReplicationInfo GetGRI() {
	return PlayerOwner().GameReplicationInfo;
}

function bool FloatingPreDraw( Canvas C ) {

	local PlayerController PC;
	local GameReplicationInfo GRI;

	GRI = GetGRI();
	PC = PlayerOwner();

	if ( !bTeamGame && !bFFAGame ) {
		if ( GRI.bTeamGame )
			bTeamGame = True;
		else if ( !(GRI.GameClass ~= "Engine.GameInfo") )
			bFFAGame = True;
	}

	bNetGame = PC.Level.NetMode != NM_StandAlone;

	if ( bNetGame )
		b_Leave.Caption = "Leave match";
	else
		b_Leave.Caption = "Forfeit match";

	if (PC.PlayerReplicationInfo.bOnlySpectator)
		b_Spec.Caption = "Join game";
	else
		b_Spec.Caption = "Spectate";

	if (PlayerOwner().GameReplicationInfo!=None)
		SetVisibility(true);
	else
		SetVisibility(false);


	return Super.InternalOnPreDraw(C);;
}


function InternalOnClose(optional Bool bCanceled) {
	local PlayerController PC;

	PC = PlayerOwner();

	// Turn pause off if currently paused
	if(PC != None && PC.Level.Pauser != None)
		PC.SetPause(false);

	Super.OnClose(bCanceled);
}

/*
function AddPanels()
{
	local int i;
	local MidGamePanel Panel;

	for ( i = 0; i < Panels.Length; i++ )
	{
		Panel = MidGamePanel(c_Main.AddTabItem(Panels[i]));
		if ( Panel != None )
			Panel.ModifiedChatRestriction = UpdateChatRestriction;
	}
}
*/

// Called via delegate by a MidGamePanel when a player chat restriction has been updated
// this notifies all other panels about the change
/*
function UpdateChatRestriction( MidGamePanel Sender, int PlayerID )
{
	local int i;

	if ( Sender == None )
		return;

	for ( i = 0; i < c_Main.TabStack.Length; i++ )
	{
		if ( c_Main.TabStack[i] != None && MidGamePanel(c_Main.TabStack[i].MyPanel) != None &&
			c_Main.TabStack[i].MyPanel != Sender )
			MidGamePanel(c_Main.TabStack[i].MyPanel).UpdateChatRestriction(PlayerID);
	}
}
*/

function SetTitle() {
	local PlayerController PC;

	PC = PlayerOwner();
	if ( PC.Level.NetMode == NM_StandAlone || PC.GameReplicationInfo == None || PC.GameReplicationInfo.ServerName == "" )
		WindowName = PC.Level.GetURLMap();
	else WindowName = PC.GameReplicationInfo.ServerName;

	t_WindowTitle.SetCaption(WindowName);
}

/*
function RemoveMultiplayerTabs(GameInfo Game) {

	if (Game.CurrentGameProfile != none)
		Panels[2] = SPRulesPanel; //there's no map rotation in a single player tournament

	Panels.Remove(3,1);
	Panels.Remove(1,1);
}
*/

event bool NotifyLevelChange() {
	bPersistent = false;
	LevelChanged();
	return true;
}

function bool InternalOnClick(GUIComponent Sender) {
	local PlayerController PC;
	PC = PlayerOwner();

	if (Sender == b_Close) {
		// Close the window
		//InternalOnClose(true);
		Controller.CloseMenu();

	} else if (Sender == b_Team) {
		// Change (swap) team
		PlayerOwner().ConsoleCommand("switchteam");
		Controller.CloseMenu(false);
		return true;

	} else if (Sender == b_Spec) {
		// Spectate OR join
		Controller.CloseMenu();
		//Spectate/rejoin
		if (PC.PlayerReplicationInfo.bOnlySpectator)
			PC.BecomeActivePlayer();
		else
			PC.BecomeSpectator();

	} else if (Sender == b_Settings) {
		// Open the settings window
		Controller.OpenMenu(Controller.GetSettingsPage());

	} else if (Sender == b_Favs) {
		// Add this server to favorites
		PC.ConsoleCommand( "ADDCURRENTTOFAVORITES" );
		b_Favs.MenuStateChange(MSAT_Disabled);

	} else if (Sender == b_Leave) {
		// Leave the server OR forfeit (sp)
		Controller.CloseMenu();
		if ( PC.Level.Game != none && PC.Level.Game.CurrentGameProfile != None )
			PC.Level.Game.CurrentGameProfile.ContinueSinglePlayerGame(PC.Level, true);
		else
			PC.ConsoleCommand( "DISCONNECT" );		

	} else if (Sender == b_Browser) {
		// Open the server browser
		Controller.OpenMenu(Controller.GetServerBrowserPage());

	} else if (Sender == b_Quit) {
		// Quit the game
		Controller.OpenMenu(Controller.GetQuitPage());

	}
	else if (Sender == b_MapVote) 
	{
		// Open the map vote menu
		PC.ShowVoteMenu();
	}
/*
	else if (Sender == b_Achievements) 
	{
		Controller.OpenMenu("DA2.da_GUI_Achievements");
	}
*/
	else if (Sender == b_ChangeClass) 
	{
		// Open the class menu
		Controller.OpenMenu("DA2.da_GUI_chooseClass");
	}
	return true;
}

defaultproperties
{
     Begin Object Class=da_GUI_Button Name=TeamButton
         Caption="Change Team"
         WinTop=0.200000
         WinLeft=0.040000
         WinWidth=0.300000
         WinHeight=0.120000
         TabOrder=1
         OnClick=da_GUI_PlayerLoginMenu.InternalOnClick
         OnKeyEvent=TeamButton.InternalOnKeyEvent
     End Object
     b_Team=da_GUI_Button'DA2.da_GUI_PlayerLoginMenu.TeamButton'

     Begin Object Class=da_GUI_Button Name=SpectateButton
         Caption="Spectate"
         WinTop=0.200000
         WinLeft=0.350000
         WinWidth=0.300000
         WinHeight=0.120000
         TabOrder=2
         OnClick=da_GUI_PlayerLoginMenu.InternalOnClick
         OnKeyEvent=SpectateButton.InternalOnKeyEvent
     End Object
     b_Spec=da_GUI_Button'DA2.da_GUI_PlayerLoginMenu.SpectateButton'

     Begin Object Class=da_GUI_Button Name=SettingsButton
         Caption="Settings"
         WinTop=0.680000
         WinLeft=0.040000
         WinWidth=0.450000
         WinHeight=0.120000
         TabOrder=7
         OnClick=da_GUI_PlayerLoginMenu.InternalOnClick
         OnKeyEvent=SettingsButton.InternalOnKeyEvent
     End Object
     b_Settings=da_GUI_Button'DA2.da_GUI_PlayerLoginMenu.SettingsButton'

     Begin Object Class=da_GUI_Button Name=FavoritesButton
         Caption="Add this server to Favorites"
         Hint="Add this server to your Favorites"
         WinTop=0.520000
         WinLeft=0.040000
         WinWidth=0.450000
         WinHeight=0.120000
         TabOrder=4
         OnClick=da_GUI_PlayerLoginMenu.InternalOnClick
         OnKeyEvent=FavoritesButton.InternalOnKeyEvent
     End Object
     b_Favs=da_GUI_Button'DA2.da_GUI_PlayerLoginMenu.FavoritesButton'

     Begin Object Class=da_GUI_Button Name=LeaveMatchButton
         Caption="Leave Match"
         WinTop=0.200000
         WinLeft=0.660000
         WinWidth=0.300000
         WinHeight=0.120000
         TabOrder=3
         OnClick=da_GUI_PlayerLoginMenu.InternalOnClick
         OnKeyEvent=LeaveMatchButton.InternalOnKeyEvent
     End Object
     b_Leave=da_GUI_Button'DA2.da_GUI_PlayerLoginMenu.LeaveMatchButton'

     Begin Object Class=da_GUI_Button Name=BrowserButton
         Caption="Server Browser"
         WinTop=0.520000
         WinLeft=0.510000
         WinWidth=0.450000
         WinHeight=0.120000
         TabOrder=5
         OnClick=da_GUI_PlayerLoginMenu.InternalOnClick
         OnKeyEvent=BrowserButton.InternalOnKeyEvent
     End Object
     b_Browser=da_GUI_Button'DA2.da_GUI_PlayerLoginMenu.BrowserButton'

     Begin Object Class=da_GUI_Button Name=FClose
         Caption="CLOSE"
         WinTop=0.888000
         WinLeft=0.400000
         WinWidth=0.200000
         WinHeight=0.090000
         RenderWeight=0.800000
         TabOrder=0
         OnClick=da_GUI_PlayerLoginMenu.InternalOnClick
         OnKeyEvent=FClose.InternalOnKeyEvent
     End Object
     b_Close=da_GUI_Button'DA2.da_GUI_PlayerLoginMenu.FClose'

     Begin Object Class=da_GUI_Button Name=QuitGameButton
         Caption="Exit Game"
         WinTop=0.680000
         WinLeft=0.510000
         WinWidth=0.450000
         WinHeight=0.120000
         TabOrder=8
         OnClick=da_GUI_PlayerLoginMenu.InternalOnClick
         OnKeyEvent=QuitGameButton.InternalOnKeyEvent
     End Object
     b_Quit=da_GUI_Button'DA2.da_GUI_PlayerLoginMenu.QuitGameButton'

     Begin Object Class=da_GUI_Button Name=MapVoteButton
         Caption="Map Vote"
         WinTop=0.360000
         WinLeft=0.040000
         WinWidth=0.450000
         WinHeight=0.120000
         TabOrder=4
         OnClick=da_GUI_PlayerLoginMenu.InternalOnClick
         OnKeyEvent=MapVoteButton.InternalOnKeyEvent
     End Object
     b_MapVote=da_GUI_Button'DA2.da_GUI_PlayerLoginMenu.MapVoteButton'

     Begin Object Class=da_GUI_Button Name=ChangeClassButton
         Caption="Change Class"
         WinTop=0.360000
         WinLeft=0.510000
         WinWidth=0.450000
         WinHeight=0.120000
         TabOrder=6
         OnClick=da_GUI_PlayerLoginMenu.InternalOnClick
         OnKeyEvent=ChangeClassButton.InternalOnKeyEvent
     End Object
     b_ChangeClass=da_GUI_Button'DA2.da_GUI_PlayerLoginMenu.ChangeClassButton'

     bResizeWidthAllowed=False
     bResizeHeightAllowed=False
     bMoveAllowed=False
     bPersistent=True
     bAllowedAsLast=True
     OnClose=da_GUI_PlayerLoginMenu.InternalOnClose
     OnCreateComponent=da_GUI_PlayerLoginMenu.InternalOnCreateComponent
     WinTop=0.200000
     WinHeight=0.560000
     OnPreDraw=da_GUI_PlayerLoginMenu.FloatingPreDraw
     OnRendered=da_GUI_PlayerLoginMenu.FloatingRendered
     OnHover=da_GUI_PlayerLoginMenu.FloatingHover
     OnMousePressed=da_GUI_PlayerLoginMenu.FloatingMousePressed
     OnMouseRelease=da_GUI_PlayerLoginMenu.FloatingMouseRelease
}
