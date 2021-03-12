// D:\mods\UT2004Script3339\GUI2K4\Classes\UT2K4ServerBrowser.uc
// D:\mods\UT2004Script3339\GUI2K4\Classes\UT2k4MainPage.uc

// TODO
// * Some testing, buttons getting resized

class da_gui_ServerBrowser extends UT2K4ServerBrowser;

var private ROMasterServerClient  ROMSC;
var da_BrowserFilters              da_FilterMaster;


function bool InternalOnPreDraw(canvas c) {
	i_Background.Image = class'da_GUI_Utilities'.static.getCorrectBackground(c);
	return false;
}

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
    Super.InitComponent(MyController, MyOwner);

    f_Browser = UT2K4Browser_Footer(t_Footer);

    f_Browser.p_Anchor = Self;
    f_Browser.ch_Standard.OnChange = StandardOptionChanged;
    f_Browser.ch_Standard.SetComponentValue(bStandardServersOnly, True);

        da_FilterMaster = new(Self) class'DA2.da_BrowserFilters';
        da_FilterMaster.InitCustomFilters();

    if (FilterInfo == None)
        FilterInfo = new(None) class'Engine.PlayInfo';

    Background=MyController.DefaultPens[0];

    InitializeGameTypeCombo();
    co_GameType.MyComboBox.Edit.bCaptureMouse = True;
    CreateTabs();
}

function bool ComboOnPreDraw(Canvas Canvas) {
//	co_GameType.WinTop = 1.1; //co_GameType.RelativeTop(t_Header.ActualTop() + t_Header.ActualHeight() + float(Controller.ResY) / 480.0);
//	co_GameType.WinLeft = co_GameType.RelativeLeft((c_Tabs.ActualLeft() + c_Tabs.ActualWidth()) - (co_GameType.ActualWidth() + 3));
    return false;
}

function MasterServerClient Uplink()
{
	if ( ROMSC == None && PlayerOwner() != None )
		ROMSC = PlayerOwner().Spawn( class'ROMasterServerClient' );

	return ROMSC;
}

// Server browser must remain persistent across level changes, in order for the IRC client to function properly
event bool NotifyLevelChange()
{
	if ( ROMSC != None )
	{
		ROMSC.Stop();
		ROMSC.Destroy();
		ROMSC = None;
	}

	LevelChanged();
	return false;
}

function EnableMSTabs()
{
}

function DisableMSTabs()
{
	Verified = False;
}

defaultproperties
{
     CurrentGameType="DA2.DefenceAlliance"
     Begin Object Class=da_GUI_moComboBox Name=GameTypeCombo
         bReadOnly=True
         CaptionWidth=0.100000
         Caption="Game Type"
         OnCreateComponent=GameTypeCombo.InternalOnCreateComponent
         IniOption="@INTERNAL"
         Hint="Choose the gametype to query"
         WinTop=0.860000
         WinLeft=0.620000
         WinWidth=0.358680
         WinHeight=0.035000
         RenderWeight=1.000000
         TabOrder=0
         OnPreDraw=da_GUI_ServerBrowser.ComboOnPreDraw
         OnLoadINI=da_GUI_ServerBrowser.InternalOnLoadINI
     End Object
     co_GameType=da_GUI_moComboBox'DA2.da_GUI_ServerBrowser.GameTypeCombo'

     Begin Object Class=da_GUI_TabControl Name=PageTabs
         bDockPanels=True
         WinLeft=0.010000
         WinWidth=0.980000
         RenderWeight=0.490000
         TabOrder=3
         bAcceptsInput=True
         OnActivate=PageTabs.InternalOnActivate
         OnChange=da_GUI_ServerBrowser.InternalOnChange
     End Object
     c_Tabs=da_GUI_TabControl'DA2.da_GUI_ServerBrowser.PageTabs'

     Begin Object Class=da_GUI_Header Name=ServerBrowserHeader
         Caption="Server Browser"
     End Object
     t_Header=da_GUI_Header'DA2.da_GUI_ServerBrowser.ServerBrowserHeader'

     Begin Object Class=da_GUI_Browser_Footer Name=FooterPanel
         TabOrder=4
         OnPreDraw=FooterPanel.InternalOnPreDraw
     End Object
     t_Footer=da_GUI_Browser_Footer'DA2.da_GUI_ServerBrowser.FooterPanel'

     Begin Object Class=BackgroundImage Name=PageBackground
         Image=Texture'DA2GUI.Dialog.window_1024x768'
         RenderWeight=0.010000
     End Object
     i_Background=BackgroundImage'DA2.da_GUI_ServerBrowser.PageBackground'

     i_bkChar=None

     Begin Object Class=BackgroundImage Name=RealBackground
         Image=Texture'DA2GUI.Generic.blackBox'
         RenderWeight=0.001000
     End Object
     i_bkScan=BackgroundImage'DA2.da_GUI_ServerBrowser.RealBackground'

     PanelClass(0)="DA2.da_GUI_Browser_MOTD"
     PanelClass(1)="DA2.da_GUI_Browser_IRC"
     PanelClass(2)="DA2.da_GUI_Browser_ServerListPageFavorites"
     PanelClass(3)="DA2.da_GUI_Browser_ServerListPageLAN"
     PanelClass(4)="DA2.da_GUI_Browser_ServerListPageBuddy"
     PanelClass(5)="DA2.da_GUI_Browser_ServerListPageInternet"
     OnPreDraw=da_GUI_ServerBrowser.InternalOnPreDraw
}
