//-----------------------------------------------------------
//
//-----------------------------------------------------------

// D:\mods\UT2004Script3339\GUI2K4\Classes\UT2K4GamePageMP.uc
// D:\mods\UT2004Script3339\GUI2K4\Classes\UT2K4GamePageBase.uc
// D:\mods\UT2004Script3339\GUI2K4\Classes\UT2k4MainPage.uc

class da_gui_GamePageMP extends UT2K4GamePageMP;

/*
function xInitComponent(GUIController MyController, GUIComponent MyOwner) {
    local int i;

    RuleInfo = new(None) class'Engine.PlayInfo';

	p_Game = UT2K4Tab_GameTypeBase( c_Tabs.AddTab(PanelCaption[i], PanelClass[i],, PanelHint[i++], True) );
	p_Game.OnChangeGameType = ChangeGameType;

    p_Main        = UT2K4Tab_MainBase(c_Tabs.AddTab(PanelCaption[i],PanelClass[i],,PanelHint[i++]) );
    p_Game.tp_Main = p_Main;

    // if bUseTabs, we'll use a tabcontrol display for setting groups
    // if not, we'll use a mult-column multioptionlist, with section headers
    if (bUseTabs)
        p_Rules       = da_GUI_Tab_RulesBase(c_Tabs.AddTab(PanelCaption[i],PanelClass[i],,PanelHint[i++]));
    else
		mcRules = IAMultiColumnRulesPanel(c_Tabs.AddTab(PanelCaption[i], "DA2.da_GUI_IAMultiColumnRulesPanel",, PanelHint[i++]));

    p_Mutators    = UT2K4Tab_MutatorBase(c_Tabs.AddTab(PanelCaption[i],PanelClass[i],,PanelHint[i++]));
    p_BotConfig   = UT2K4Tab_BotConfigBase(c_Tabs.AddTab(PanelCaption[i],PanelClass[i],,PanelHint[i++]));

	b_Back = UT2K4GameFooter(t_Footer).b_Back;
	b_Secondary = UT2K4GameFooter(t_Footer).b_Secondary;
	b_Primary = UT2K4GameFooter(t_Footer).b_Primary;

}
*/


function InitComponent(GUIController MyController, GUIComponent MyOwner) {
    super.initComponent(myController, myOwner);

	// Replaces the hard-coded rules panel with the right one
	c_Tabs.RemoveTab(PanelCaption[2]);
	mcRules = da_GUI_IAMultiColumnRulesPanel ( c_Tabs.InsertTab(2, PanelCaption[2], "DA2.da_GUI_IAMultiColumnRulesPanel",, PanelHint[2]) );

	// Removes the gametype selection, makes DA the only one
    c_Tabs.RemoveTab(panelCaption[0]);
    p_game = none;
    Controller.LastGameType = "DA2.DefenceAlliance";
    changeGameType(false);
}


function bool InternalOnPreDraw(canvas c) {
	i_Background.Image = class'da_GUI_Utilities'.static.getCorrectBackground(c);
	return false;
}

function StartGame(string GameURL, bool bAlt) {
    local GUIController C;

    C = Controller;

    if (bAlt)
    {
        if ( mcServerRules != None )
            GameURL $= mcServerRules.Play();

        // Append optional server flags
        PlayerOwner().ConsoleCommand("relaunch"@GameURL@"-server -mod=da2 -log=server.log");
    }
    else
        PlayerOwner().ClientTravel(GameURL $ "?Listen",TRAVEL_Absolute,false);

    C.CloseAll(false,True);
}

defaultproperties
{
     PageCaption="Host Multiplayer Game"
     Begin Object Class=da_GUI_TabControl Name=PageTabs
         bDockPanels=True
         WinLeft=0.010000
         WinWidth=0.980000
         RenderWeight=0.490000
         TabOrder=3
         bAcceptsInput=True
         OnActivate=PageTabs.InternalOnActivate
         OnChange=da_gui_GamePageMP.InternalOnChange
     End Object
     c_Tabs=da_GUI_TabControl'DA2.da_gui_GamePageMP.PageTabs'

     Begin Object Class=da_GUI_Header Name=GamePageHeader
         RenderWeight=0.300000
     End Object
     t_Header=da_GUI_Header'DA2.da_gui_GamePageMP.GamePageHeader'

     Begin Object Class=da_GUI_GameFooter Name=MPFooter
         PrimaryCaption="LISTEN"
         PrimaryHint="Start A Listen Server With These Settings"
         SecondaryCaption="DEDICATED"
         SecondaryHint="Start a Dedicated Server With These Settings"
         TextIndent=5
         RenderWeight=0.300000
         TabOrder=8
         OnPreDraw=MPFooter.InternalOnPreDraw
     End Object
     t_Footer=da_GUI_GameFooter'DA2.da_gui_GamePageMP.MPFooter'

     Begin Object Class=BackgroundImage Name=PageBackground
         Image=Texture'DA2GUI.Dialog.window_1024x768'
         RenderWeight=0.010000
     End Object
     i_Background=BackgroundImage'DA2.da_gui_GamePageMP.PageBackground'

     i_bkChar=None

     Begin Object Class=BackgroundImage Name=RealBackground
         Image=Texture'DA2GUI.Generic.blackBox'
         RenderWeight=0.001000
     End Object
     i_bkScan=BackgroundImage'DA2.da_gui_GamePageMP.RealBackground'

     PanelClass(0)="DA2.da_GUI_Tab_GameTypeMP"
     PanelClass(1)="DA2.da_GUI_Tab_MainSP"
     PanelClass(2)="DA2.da_GUI_Tab_RulesBase"
     PanelClass(3)="DA2.da_GUI_Tab_MutatorMP"
     PanelClass(4)="DA2.da_GUI_Tab_BotConfigMP"
     PanelClass(5)="DA2.da_GUI_Tab_ServerRulesPanel"
     OnPreDraw=da_gui_GamePageMP.InternalOnPreDraw
}
