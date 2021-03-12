// D:\mods\UT2004Script3339\GUI2K4\Classes\UT2K4SettingsPage.uc

class da_GUI_SettingsPage extends UT2K4SettingsPage;

function bool InternalOnPreDraw(canvas c) {
	i_Background.Image = class'da_GUI_Utilities'.static.getCorrectBackground(c);
	return Super.InternalOnPreDraw(c);
}

defaultproperties
{
     PageCaption="Settings"
     Begin Object Class=da_GUI_TabControl Name=PageTabs
         bDockPanels=True
         WinLeft=0.010000
         WinWidth=0.980000
         RenderWeight=0.490000
         TabOrder=3
         bAcceptsInput=True
         OnActivate=PageTabs.InternalOnActivate
         OnChange=da_GUI_SettingsPage.InternalOnChange
     End Object
     c_Tabs=da_GUI_TabControl'DA2.da_GUI_SettingsPage.PageTabs'

     Begin Object Class=da_GUI_Header Name=GamePageHeader
         Caption="Settings"
         RenderWeight=0.300000
     End Object
     t_Header=da_GUI_Header'DA2.da_GUI_SettingsPage.GamePageHeader'

     Begin Object Class=da_GUI_Settings_Footer Name=SettingFooter
         RenderWeight=0.300000
         TabOrder=4
         OnPreDraw=SettingFooter.InternalOnPreDraw
     End Object
     t_Footer=da_GUI_Settings_Footer'DA2.da_GUI_SettingsPage.SettingFooter'

     Begin Object Class=BackgroundImage Name=PageBackground
         Image=Texture'DA2GUI.Dialog.window_1024x768'
         RenderWeight=0.010000
     End Object
     i_Background=BackgroundImage'DA2.da_GUI_SettingsPage.PageBackground'

     i_bkChar=None

     Begin Object Class=BackgroundImage Name=RealBackground
         Image=Texture'DA2GUI.Generic.blackBox'
         RenderWeight=0.001000
     End Object
     i_bkScan=BackgroundImage'DA2.da_GUI_SettingsPage.RealBackground'

     PanelClass(0)="DA2.da_GUI_Tab_DetailSettings"
     PanelClass(1)="DA2.da_GUI_Tab_AudioSettings"
     PanelClass(2)="DA2.da_GUI_Tab_PlayerSettings"
     PanelClass(3)="DA2.da_GUI_Tab_GameSettings"
     PanelClass(4)="DA2.da_GUI_Tab_IForceSettings"
     PanelClass(5)="none"
     PanelClass(6)="none"
     OnPreDraw=da_GUI_SettingsPage.InternalOnPreDraw
}
