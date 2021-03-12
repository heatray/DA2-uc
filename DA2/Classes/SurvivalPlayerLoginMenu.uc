class SurvivalPlayerLoginMenu extends da_GUI_PlayerLoginMenu;

var 	automated da_GUI_AltSectionBackground sb_rank;
var		automated da_GUI_ProgressBar pb_Rank;
var 	automated GUILabel l_RankProgress,l_ranknumber,l_RankName;
var 	automated GUIImage i_Rank1, i_bgClass1;

var int totalscore;

function InitComponent(GUIController MyController, GUIComponent MyComponent) {

	Super.InitComponent(MyController, MyComponent);

	SetTitle();
	SetupRank();
}

function SetupRank()
{
	local PlayerController PC;
	
	totalscore = da_SteamStatsAndAchievements(pc.SteamStatsAndAchievements).ScoreStat.Value;
	
	if (totalscore >= 252000)
	{
		i_Rank1.Image = Texture'DA2GUI.Misc.Star';
		l_RankName.Caption="General";
		l_RankNumber.Caption="***";
		pb_Rank.High = totalscore;
		pb_Rank.Value = totalscore;
		l_RankProgress.Caption=((totalscore)$" Total Score");
	}
	
	else if (totalscore >= 192000)
	{
		i_Rank1.Image = Texture'DA2GUI.Misc.Star';
		l_RankName.Caption="Supreme Commander|ELITE";
		l_RankNumber.Caption="3";
		l_RankProgress.Caption=((252000-totalscore)$" Score|needed for next rank");
		pb_Rank.High = 60000;
		pb_Rank.Value = totalscore - 192000;
	}
		
	else if (totalscore >= 144000)
	{
		i_Rank1.Image = Texture'DA2GUI.Misc.Star';
		l_RankName.Caption="Supreme Commander|Second Class";
		l_RankNumber.Caption="2";
		l_RankProgress.Caption=((192000-totalscore)$" Score|needed for next rank");
		pb_Rank.High = 60000;
		pb_Rank.Value = totalscore - 144000;
	}
		
	else if (totalscore >= 108000)
	{
		i_Rank1.Image = Texture'DA2GUI.Misc.Star';
		l_RankName.Caption="Supreme Commander|First Class";
		l_RankNumber.Caption="1";
		l_RankProgress.Caption=((144000-totalscore)$" Score|needed for next rank");
		pb_Rank.High = 36000;
		pb_Rank.Value = totalscore - 108000;
	}
		
	else if (totalscore >= 84000)
	{
		i_Rank1.Image = Texture'DA2GUI.Misc.Captain';
		l_RankName.Caption="Alliance Captain|of War";
		l_RankNumber.Caption="3";
		l_RankProgress.Caption=((108000-totalscore)$" Score|needed for next rank");
		pb_Rank.High = 36000;
		pb_Rank.Value = totalscore - 84000;
	}
		
	else if (totalscore >= 48000)
	{
		i_Rank1.Image = Texture'DA2GUI.Misc.Captain';
		l_RankName.Caption="Alliance Captain|Senior";
		l_RankNumber.Caption="2";
		l_RankProgress.Caption=((84000-totalscore)$" Score|needed for next rank");
		pb_Rank.High = 36000;
		pb_Rank.Value = totalscore - 48000;
	}
		
	else if (totalscore >= 36000)
	{
		i_Rank1.Image = Texture'DA2GUI.Misc.Captain';
		l_RankName.Caption="Alliance Captain|Junior";
		l_RankNumber.Caption="1";
		l_RankProgress.Caption=((48000-totalscore)$" Score|needed for next rank");
		pb_Rank.High = 12000;
		pb_Rank.Value = totalscore - 36000;
	}
		
	else if (totalscore >= 24000)
	{
		i_Rank1.Image = Texture'DA2GUI.Misc.Private';
		l_RankName.Caption="Advanced Gunner|Bombadier";
		l_RankNumber.Caption="3";
		l_RankProgress.Caption=((36000-totalscore)$" Score|needed for next rank");
		pb_Rank.High = 12000;
		pb_Rank.Value = totalscore - 24000;
	}
		
	else if (totalscore >= 12000)
	{
		i_Rank1.Image = Texture'DA2GUI.Misc.Private';
		l_RankName.Caption="Advanced Gunner|Regular Arms";
		l_RankNumber.Caption="2";
		l_RankProgress.Caption=((24000-totalscore)$" Score|needed for next rank");
		pb_Rank.High = 12000;
		pb_Rank.Value = totalscore - 12000;
	}
		
	else
	{
		i_Rank1.Image = Texture'DA2GUI.Misc.Private';
		l_RankName.Caption="Advanced Gunner|Recruit";
		l_RankNumber.Caption="1";
		l_RankProgress.Caption=((12000-totalscore)$" Score|needed for next rank");
		pb_Rank.High = 12000;
		pb_Rank.Value = totalscore;
	}
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
		Controller.OpenMenu("DA2.SurvivalchooseClass");
	}
	return true;
}

defaultproperties
{
     Begin Object Class=da_GUI_AltSectionBackground Name=InternalFrameImageRank
         WinTop=0.210000
         WinLeft=0.014125
         WinWidth=0.971000
         WinHeight=0.160000
         OnPreDraw=InternalFrameImageRank.InternalPreDraw
     End Object
     sb_rank=da_GUI_AltSectionBackground'DA2.SurvivalPlayerLoginMenu.InternalFrameImageRank'

     Begin Object Class=da_GUI_ProgressBar Name=ProgressBarBig
         CaptionWidth=0.000000
         ValueRightWidth=0.000000
         bShowValue=False
         WinTop=0.260000
         WinLeft=0.030000
         WinWidth=0.600000
         WinHeight=0.060000
     End Object
     pb_Rank=da_GUI_ProgressBar'DA2.SurvivalPlayerLoginMenu.ProgressBarBig'

     Begin Object Class=GUILabel Name=RankProgress
         TextAlign=TXTA_Center
         bMultiLine=True
         VertAlign=TXTA_Center
         StyleName="DA2Style_BodyText"
         WinTop=0.210000
         WinLeft=0.638020
         WinWidth=0.125000
         WinHeight=0.160000
         RenderWeight=0.500000
     End Object
     l_RankProgress=GUILabel'DA2.SurvivalPlayerLoginMenu.RankProgress'

     Begin Object Class=GUILabel Name=RankNumber
         bMultiLine=True
         StyleName="DA2Style_DialogText"
         WinTop=0.210000
         WinLeft=0.841914
         WinWidth=0.050000
         WinHeight=0.160000
         RenderWeight=0.600000
     End Object
     l_ranknumber=GUILabel'DA2.SurvivalPlayerLoginMenu.RankNumber'

     Begin Object Class=GUILabel Name=RankName
         TextAlign=TXTA_Center
         bMultiLine=True
         VertAlign=TXTA_Center
         StyleName="DA2Style_BodyText"
         WinTop=0.210000
         WinLeft=0.854464
         WinWidth=0.110000
         WinHeight=0.160000
         RenderWeight=0.600000
     End Object
     l_RankName=GUILabel'DA2.SurvivalPlayerLoginMenu.RankName'

     Begin Object Class=GUIImage Name=Ranks
         ImageStyle=ISTY_Scaled
         ImageRenderStyle=MSTY_Normal
         WinTop=0.210000
         WinLeft=0.771000
         WinWidth=0.080000
         WinHeight=0.160000
         RenderWeight=0.600000
     End Object
     i_Rank1=GUIImage'DA2.SurvivalPlayerLoginMenu.Ranks'

     Begin Object Class=GUIImage Name=BGClass1
         Image=Texture'DA2GUI.Dialog.htab_tab_l'
         ImageStyle=ISTY_Stretched
         ImageRenderStyle=MSTY_Normal
         WinTop=0.210000
         WinLeft=0.770000
         WinWidth=0.200000
         WinHeight=0.160000
         RenderWeight=0.500000
     End Object
     i_bgClass1=GUIImage'DA2.SurvivalPlayerLoginMenu.BGClass1'

     Begin Object Class=da_GUI_Button Name=TeamButton
         Caption="Change Team"
         WinTop=0.414843
         WinLeft=0.040000
         WinWidth=0.300000
         WinHeight=0.100000
         TabOrder=1
         OnClick=SurvivalPlayerLoginMenu.InternalOnClick
         OnKeyEvent=TeamButton.InternalOnKeyEvent
     End Object
     b_Team=da_GUI_Button'DA2.SurvivalPlayerLoginMenu.TeamButton'

     Begin Object Class=da_GUI_Button Name=SpectateButton
         Caption="Spectate"
         WinTop=0.414843
         WinLeft=0.350000
         WinWidth=0.300000
         WinHeight=0.100000
         TabOrder=2
         OnClick=SurvivalPlayerLoginMenu.InternalOnClick
         OnKeyEvent=SpectateButton.InternalOnKeyEvent
     End Object
     b_Spec=da_GUI_Button'DA2.SurvivalPlayerLoginMenu.SpectateButton'

     Begin Object Class=da_GUI_Button Name=SettingsButton
         Caption="Settings"
         WinTop=0.750000
         WinLeft=0.040000
         WinWidth=0.450000
         WinHeight=0.100000
         TabOrder=7
         OnClick=SurvivalPlayerLoginMenu.InternalOnClick
         OnKeyEvent=SettingsButton.InternalOnKeyEvent
     End Object
     b_Settings=da_GUI_Button'DA2.SurvivalPlayerLoginMenu.SettingsButton'

     Begin Object Class=da_GUI_Button Name=FavoritesButton
         Caption="Add this server to Favorites"
         Hint="Add this server to your Favorites"
         WinTop=0.638817
         WinLeft=0.040000
         WinWidth=0.450000
         WinHeight=0.100000
         TabOrder=4
         OnClick=SurvivalPlayerLoginMenu.InternalOnClick
         OnKeyEvent=FavoritesButton.InternalOnKeyEvent
     End Object
     b_Favs=da_GUI_Button'DA2.SurvivalPlayerLoginMenu.FavoritesButton'

     Begin Object Class=da_GUI_Button Name=LeaveMatchButton
         Caption="Leave Match"
         WinTop=0.414843
         WinLeft=0.660000
         WinWidth=0.300000
         WinHeight=0.100000
         TabOrder=3
         OnClick=SurvivalPlayerLoginMenu.InternalOnClick
         OnKeyEvent=LeaveMatchButton.InternalOnKeyEvent
     End Object
     b_Leave=da_GUI_Button'DA2.SurvivalPlayerLoginMenu.LeaveMatchButton'

     Begin Object Class=da_GUI_Button Name=BrowserButton
         Caption="Server Browser"
         WinTop=0.638817
         WinLeft=0.510000
         WinWidth=0.450000
         WinHeight=0.100000
         TabOrder=5
         OnClick=SurvivalPlayerLoginMenu.InternalOnClick
         OnKeyEvent=BrowserButton.InternalOnKeyEvent
     End Object
     b_Browser=da_GUI_Button'DA2.SurvivalPlayerLoginMenu.BrowserButton'

     Begin Object Class=da_GUI_Button Name=FClose
         Caption="CLOSE"
         WinTop=0.888000
         WinLeft=0.400000
         WinWidth=0.200000
         WinHeight=0.090000
         RenderWeight=0.800000
         TabOrder=0
         OnClick=SurvivalPlayerLoginMenu.InternalOnClick
         OnKeyEvent=FClose.InternalOnKeyEvent
     End Object
     b_Close=da_GUI_Button'DA2.SurvivalPlayerLoginMenu.FClose'

     Begin Object Class=da_GUI_Button Name=QuitGameButton
         Caption="Exit Game"
         WinTop=0.750000
         WinLeft=0.510000
         WinWidth=0.450000
         WinHeight=0.100000
         TabOrder=8
         OnClick=SurvivalPlayerLoginMenu.InternalOnClick
         OnKeyEvent=QuitGameButton.InternalOnKeyEvent
     End Object
     b_Quit=da_GUI_Button'DA2.SurvivalPlayerLoginMenu.QuitGameButton'

     Begin Object Class=da_GUI_Button Name=MapVoteButton
         Caption="Map Vote"
         WinTop=0.527643
         WinLeft=0.040000
         WinWidth=0.450000
         WinHeight=0.100000
         TabOrder=4
         OnClick=SurvivalPlayerLoginMenu.InternalOnClick
         OnKeyEvent=MapVoteButton.InternalOnKeyEvent
     End Object
     b_MapVote=da_GUI_Button'DA2.SurvivalPlayerLoginMenu.MapVoteButton'

     Begin Object Class=da_GUI_Button Name=ChangeClassButton
         Caption="Change Class"
         WinTop=0.527643
         WinLeft=0.510000
         WinWidth=0.450000
         WinHeight=0.100000
         TabOrder=6
         OnClick=SurvivalPlayerLoginMenu.InternalOnClick
         OnKeyEvent=ChangeClassButton.InternalOnKeyEvent
     End Object
     b_ChangeClass=da_GUI_Button'DA2.SurvivalPlayerLoginMenu.ChangeClassButton'

     WinHeight=0.600000
}
