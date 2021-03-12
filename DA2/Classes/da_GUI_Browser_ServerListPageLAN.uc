// D:\mods\UT2004Script3339\GUI2K4\Classes\UT2K4Browser_ServerListPageLAN.uc
// D:\mods\UT2004Script3339\GUI2K4\Classes\UT2K4Browser_ServerListPageBase.uc

class da_GUI_Browser_ServerListPageLAN extends UT2K4Browser_ServerListPageLAN;

defaultproperties
{
     Begin Object Class=da_GUI_Splitter Name=HorzSplitter
         DefaultPanels(0)="DA2.da_GUI_Browser_ServerListBox"
         DefaultPanels(1)="DA2.da_GUI_Splitter"
         MaxPercentage=0.900000
         OnReleaseSplitter=da_GUI_Browser_ServerListPageLAN.InternalReleaseSplitter
         OnCreateComponent=da_GUI_Browser_ServerListPageLAN.InternalOnCreateComponent
         IniOption="@Internal"
         WinHeight=1.000000
         RenderWeight=1.000000
         OnLoadINI=da_GUI_Browser_ServerListPageLAN.InternalOnLoadINI
     End Object
     sp_Main=da_GUI_Splitter'DA2.da_GUI_Browser_ServerListPageLAN.HorzSplitter'

     RulesListBoxClass="DA2.da_GUI_Browser_RulesListBox"
     PlayersListBoxClass="DA2.da_GUI_Browser_PlayersListBox"
     PanelCaption="Server Browser | LAN"
     bStandardized=True
     StandardHeight=0.800000
}
