// D:\mods\UT2004Script3339\GUI2K4\Classes\UT2K4GamePageSP.uc
//-----------------------------------------------------------
//
//-----------------------------------------------------------
class da_gui_GamePageSP extends UT2K4GamePageSP;

function InitComponent(GUIController MyController, GUIComponent MyOwner) {
    super.initComponent(myController, myOwner);

	// Replaces the hard-coded rules panel with the right one
	c_Tabs.RemoveTab(PanelCaption[2]);
	mcRules = da_GUI_IAMultiColumnRulesPanel ( c_Tabs.InsertTab(2, PanelCaption[2], "DA2.da_GUI_IAMultiColumnRulesPanel",, PanelHint[2]) );

	// Removes the gametype selection, makes DA the only one
    c_Tabs.RemoveTab(panelCaption[0]);
//    p_game = none;
    Controller.LastGameType = "DA2.DefenceAlliance";
    changeGameType(false);
}

function bool InternalOnPreDraw(canvas c) {
	i_Background.Image = class'da_GUI_Utilities'.static.getCorrectBackground(c);
	return false;
}

defaultproperties
{
     PageCaption="Offline Game"
     Begin Object Class=da_GUI_TabControl Name=PageTabs
         bDockPanels=True
         WinLeft=0.010000
         WinWidth=0.980000
         RenderWeight=0.490000
         TabOrder=3
         bAcceptsInput=True
         OnActivate=PageTabs.InternalOnActivate
         OnChange=da_gui_GamePageSP.InternalOnChange
     End Object
     c_Tabs=da_GUI_TabControl'DA2.da_gui_GamePageSP.PageTabs'

     Begin Object Class=da_GUI_Header Name=GamePageHeader
         RenderWeight=0.300000
     End Object
     t_Header=da_GUI_Header'DA2.da_gui_GamePageSP.GamePageHeader'

     Begin Object Class=da_GUI_GameFooter Name=MPFooter
         PrimaryCaption="PLAY"
         PrimaryHint="Start A Match With These Settings"
         SecondaryCaption="SPECTATE"
         SecondaryHint="Spectate A Match With These Settings"
         TextIndent=5
         RenderWeight=0.300000
         TabOrder=8
         OnPreDraw=MPFooter.InternalOnPreDraw
     End Object
     t_Footer=da_GUI_GameFooter'DA2.da_gui_GamePageSP.MPFooter'

     Begin Object Class=BackgroundImage Name=PageBackground
         Image=Texture'DA2GUI.Dialog.window_1024x768'
         RenderWeight=0.010000
     End Object
     i_Background=BackgroundImage'DA2.da_gui_GamePageSP.PageBackground'

     i_bkChar=None

     Begin Object Class=BackgroundImage Name=RealBackground
         Image=Texture'DA2GUI.Generic.blackBox'
         RenderWeight=0.001000
     End Object
     i_bkScan=BackgroundImage'DA2.da_gui_GamePageSP.RealBackground'

     PanelClass(1)="DA2.da_GUI_Tab_MainSP"
     PanelClass(2)="DA2.da_GUI_Tab_RulesBase"
     PanelClass(3)="DA2.da_GUI_Tab_MutatorSP"
     PanelClass(4)="DA2.da_GUI_Tab_BotConfigSP"
     OnPreDraw=da_gui_GamePageSP.InternalOnPreDraw
}
