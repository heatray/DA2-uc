// D:\mods\UT2004Script3339\GUI2K4\Classes\UT2K4Browser_IRC.uc

class da_GUI_Browser_IRC extends UT2K4Browser_IRC;

defaultproperties
{
     Begin Object Class=da_GUI_TabControl Name=ChannelTabControl
         bDockPanels=True
         WinLeft=0.010000
         WinWidth=0.980000
         bAcceptsInput=True
         OnActivate=ChannelTabControl.InternalOnActivate
     End Object
     c_Channel=da_GUI_TabControl'DA2.da_GUI_Browser_IRC.ChannelTabControl'

     SystemPageClass="DA2.da_GUI_IRC_System"
     PublicChannelClass="DA2.da_GUI_IRC_Channel"
     PrivateChannelClass="DA2.da_GUI_IRC_Private"
     PanelCaption="DA2 Internet Chat Client"
     bStandardized=True
     StandardHeight=0.780000
}
