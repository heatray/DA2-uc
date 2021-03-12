class da_GUI_ServerInfo extends UT2K4ServerInfo;

defaultproperties
{
     Begin Object Class=GUIImage Name=ServerInfoBackground
         Image=Texture'DA2GUI.Dialog.window_1024x768'
         ImageStyle=ISTY_Stretched
         WinHeight=1.000000
         bBoundToParent=True
         bScaleToParent=True
         bNeverFocus=True
     End Object
     i_Background=GUIImage'DA2.da_GUI_ServerInfo.ServerInfoBackground'

     Begin Object Class=da_GUI_TabControl Name=ServerInfoTabs
         bDockPanels=True
         TabHeight=0.040000
         WinTop=0.100000
         WinHeight=0.060000
         bBoundToParent=True
         bScaleToParent=True
         bAcceptsInput=True
         OnActivate=ServerInfoTabs.InternalOnActivate
     End Object
     c_Tabs=da_GUI_TabControl'DA2.da_GUI_ServerInfo.ServerInfoTabs'

     Begin Object Class=GUITitleBar Name=ServerInfoHeader
         Effect=Texture'InterfaceArt_tex.Menu.changeme_texture'
         StyleName="DA2Style_DialogText"
         WinHeight=0.100000
         bBoundToParent=True
         bScaleToParent=True
     End Object
     t_Header=GUITitleBar'DA2.da_GUI_ServerInfo.ServerInfoHeader'

     Begin Object Class=GUIFooter Name=ServerInfoFooter
         StyleName="DA2Style_DialogText"
         WinTop=0.925000
         WinHeight=0.075000
     End Object
     t_Footer=GUIFooter'DA2.da_GUI_ServerInfo.ServerInfoFooter'

     Begin Object Class=da_GUI_Button Name=ServerBackButton
         Caption="Close"
         Hint="Close this menu"
         WinTop=0.934167
         WinLeft=0.848750
         WinWidth=0.120000
         WinHeight=0.055000
         RenderWeight=0.510000
         bBoundToParent=True
         bScaleToParent=True
         OnClick=UT2K4ServerInfo.ButtonClicked
         OnKeyEvent=ServerBackButton.InternalOnKeyEvent
     End Object
     b_Close=da_GUI_Button'DA2.da_GUI_ServerInfo.ServerBackButton'

     PanelClass(0)="DA2.da_GUI_Tab_ServerMOTD"
     PanelClass(1)="GUI2K4.UT2k4Tab_ServerInfo"
}
