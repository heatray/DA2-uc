// D:\mods\UT2004Script3339\GUI2K4\Classes\UT2K4QuickPlay.uc

// ============================================================================
//  DA2.da_GUI_QuickPlay
//  Quick Play GUI Windows based on DA2 Graphics
//  Coded by aBsOlUt, Dante
// ============================================================================

class da_GUI_QuickPlay extends UT2K4QuickPlay;

var automated moNumericEdit co_minPlayers;


function bool InternalOnPreDraw(canvas c) {
	i_FrameBG.Image = class'da_GUI_Utilities'.static.getCorrectBackground(c);
	return super.InternalOnPreDraw(c);

}

//function AddSystemMenu(); //Hack to avoid drawing the 'X' button
//check super.AddSystemMenu(); to see what is drawing.

function AddSystemMenu() {
	local eFontScale tFontScale;

	b_ExitButton = GUIButton(t_WindowTitle.AddComponent("DA2.da_GUI_Button"));
	b_ExitButton.Style = Controller.GetStyle("DA2Style_CloseButton",tFontScale);
	b_ExitButton.OnClick = XButtonClicked;
	b_ExitButton.bNeverFocus=true;
	b_ExitButton.FocusInstead = t_WindowTitle;
	b_ExitButton.RenderWeight=1;
	b_ExitButton.bScaleToParent=false;
	b_ExitButton.OnPreDraw = SystemMenuPreDraw;

	// Do not want OnClick() called from MousePressed()
	b_ExitButton.bRepeatClick = False;
}

function InitComponent(GUIController MyController, GUIComponent MyComponent) {
	super.initComponent(myController, myComponent);
//	removeComponent(co_Game);
}

event Opened(GUIComponent Sender) {
	local array<CacheManager.MapRecord> rec;
	local int i;
	super(LargeWindow).opened(sender);
	class'CacheManager'.static.getMapList(rec, "DA2");
	co_game.addItem("<ANY>");
	for (i = 0; i < rec.length; i++)
		co_game.addItem(rec[i].mapName,,rec[i].mapName);
}

function CreateDAQuickPlayQuery(int Index )
{
    // Reset any browser query in progress.
    ResetQueryClient(MSC);

    // Add all query parameters
    ChangeQuickPlayStatus(True);

    // Desired GameType
    AddQueryTerm( "gametype", "DefenceAlliance", QT_Equals );

    // Desired Difficulty, only if desired
	if (index > 0)
	    AddQueryTerm( "category", Index - 1, QT_Equals );

	if (co_game.getIndex() > 0)
		AddQueryTerm("mapname", co_game.getExtra(), QT_Equals);

    // Must be standard server
    AddQueryTerm( "standard", "true", QT_Equals );

    // Must not be passworded
    AddQueryTerm( "password", "false", QT_Equals );

    // Cannot be empty or full
    AddQueryTerm( "currentplayers", co_minplayers.getComponentValue(), QT_GreaterThanEquals );
    AddQueryTerm( "freespace", "0", QT_GreaterThan );

    // begin searching for an appropriate server (too bad objects don't support states)
    QuickConnectSeconds = PlayerOwner().Level.TimeSeconds;
    MSC.StartQuery( CTM_Query );
}

function bool InternalOnClick(GUIComponent Sender) {
    if ( Sender == b_QuickConnect )
    {
        if ( QuickConnectPending() )
        {
            CancelQuickPlay();
            SetStatusCaption(SearchCancelledText);
        }
        else
        {
            SetStatusCaption( BeginningSearchText @ "Defence Alliance " );
            CreateDAQuickPlayQuery(co_Difficulty.GetIndex() );
        }
        return true;
    }

    if ( Sender == b_lClose )
    {
        Controller.CloseMenu(false);
        return true;
    }

    return false;
}

defaultproperties
{
     Begin Object Class=da_GUI_moNumericEdit Name=MinPlayers
         MinValue=0
         MaxValue=32
         CaptionWidth=0.300000
         Caption="Minimum players"
         OnCreateComponent=MinPlayers.InternalOnCreateComponent
         Hint="Select the minimum number of players of the server to search."
         WinTop=0.450000
         WinLeft=0.100000
         WinWidth=0.488417
         WinHeight=0.087720
         TabOrder=4
         bBoundToParent=True
         bScaleToParent=True
     End Object
     co_minPlayers=da_GUI_moNumericEdit'DA2.da_GUI_QuickPlay.MinPlayers'

     i_Border=None

     Begin Object Class=GUILabel Name=ConnectionStatus
         TextAlign=TXTA_Center
         StyleName="DA2Style_BodyText"
         WinTop=0.520000
         WinLeft=0.073594
         WinWidth=0.849415
         WinHeight=0.150000
         RenderWeight=0.100000
         bBoundToParent=True
         bScaleToParent=True
         OnTimer=da_GUI_QuickPlay.StatusTimer
     End Object
     l_Status=GUILabel'DA2.da_GUI_QuickPlay.ConnectionStatus'

     Begin Object Class=GUILabel Name=ServerCount
         TextAlign=TXTA_Center
         FontScale=FNS_Small
         StyleName="DA2Style_BodyText"
         WinTop=0.630000
         WinLeft=0.120469
         WinWidth=0.761916
         WinHeight=0.150000
         RenderWeight=0.100000
         bBoundToParent=True
         bScaleToParent=True
     End Object
     l_ServerCount=GUILabel'DA2.da_GUI_QuickPlay.ServerCount'

     Begin Object Class=da_GUI_moComboBox Name=Map
         bReadOnly=True
         CaptionWidth=0.300000
         Caption="Map"
         OnCreateComponent=Map.InternalOnCreateComponent
         Hint="Select the desired map to search for."
         WinTop=0.300000
         WinLeft=0.100000
         WinWidth=0.367167
         WinHeight=0.087720
         TabOrder=1
         bBoundToParent=True
         bScaleToParent=True
     End Object
     co_Game=da_GUI_moComboBox'DA2.da_GUI_QuickPlay.Map'

     Begin Object Class=da_GUI_moComboBox Name=DifficultyLevel
         bReadOnly=True
         CaptionWidth=0.300000
         Caption="Difficulty"
         OnCreateComponent=DifficultyLevel.InternalOnCreateComponent
         Hint="Select the desired game difficulty level to search for."
         WinTop=0.300000
         WinLeft=0.571664
         WinWidth=0.367167
         WinHeight=0.087720
         TabOrder=1
         bBoundToParent=True
         bScaleToParent=True
     End Object
     co_Difficulty=da_GUI_moComboBox'DA2.da_GUI_QuickPlay.DifficultyLevel'

     Begin Object Class=da_GUI_Button Name=QuickPlaySearch
         WinTop=0.860000
         WinLeft=0.250000
         WinWidth=0.200000
         WinHeight=0.120000
         TabOrder=2
         bBoundToParent=True
         bScaleToParent=True
         bStandardized=True
         OnClick=da_GUI_QuickPlay.InternalOnClick
         OnKeyEvent=QuickPlaySearch.InternalOnKeyEvent
     End Object
     b_QuickConnect=da_GUI_Button'DA2.da_GUI_QuickPlay.QuickPlaySearch'

     Begin Object Class=da_GUI_Button Name=QuickPlayClose
         Caption="CLOSE"
         Hint="Close this window"
         WinTop=0.860000
         WinLeft=0.550000
         WinWidth=0.200000
         WinHeight=0.120000
         TabOrder=4
         bBoundToParent=True
         bScaleToParent=True
         bStandardized=True
         OnClick=da_GUI_QuickPlay.InternalOnClick
         OnKeyEvent=QuickPlayClose.InternalOnKeyEvent
     End Object
     b_lClose=da_GUI_Button'DA2.da_GUI_QuickPlay.QuickPlayClose'

     DifficultyOptions(0)="<ANY>"
     DifficultyOptions(1)="Beginner"
     DifficultyOptions(2)="Experienced"
     DifficultyOptions(3)="Expert"
     ConnectHint="Once you've selected a difficulty level, click "
     BeginningSearchText="Please wait...requesting servers for"
     NoServersReceivedText="Sorry, no valid servers found!"
     Begin Object Class=da_GUI_Header Name=TBar
         bUseTextHeight=True
         WinTop=0.090000
         RenderWeight=0.100000
         bBoundToParent=True
         bScaleToParent=True
         bAcceptsInput=True
         bNeverFocus=False
         ScalingType=SCALE_X
         OnMousePressed=da_GUI_QuickPlay.FloatingMousePressed
         OnMouseRelease=da_GUI_QuickPlay.FloatingMouseRelease
     End Object
     t_WindowTitle=da_GUI_Header'DA2.da_GUI_QuickPlay.TBar'

     Begin Object Class=FloatingImage Name=FFrameBackground
         Image=Texture'DA2GUI.Dialog.window_1024x768'
         DropShadow=None
         ImageStyle=ISTY_Stretched
         ImageRenderStyle=MSTY_Normal
         WinTop=0.000000
         WinLeft=0.000000
         WinWidth=1.000000
         WinHeight=1.000000
         RenderWeight=0.000003
     End Object
     i_FrameBG=FloatingImage'DA2.da_GUI_QuickPlay.FFrameBackground'

     WinTop=0.325000
     WinLeft=0.200000
     WinWidth=0.600000
     WinHeight=0.400000
     OnPreDraw=da_GUI_QuickPlay.InternalOnPreDraw
}
