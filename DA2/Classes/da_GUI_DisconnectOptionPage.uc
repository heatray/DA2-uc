// D:\mods\UT2004Script3339\GUI2K4\Classes\UT2K4DisconnectOptionPage.uc

class da_GUI_DisconnectOptionPage extends UT2K4DisconnectOptionPage;

function bool InternalOnPreDraw(canvas c) {
	local bool b;

	i_FrameBG.Image = class'da_GUI_Utilities'.static.getCorrectBackground(c);
	b = Super.InternalOnPreDraw(c);
	return b;
}

defaultproperties
{
     Begin Object Class=da_GUI_Button Name=MainMenuButton
         Caption="MAIN MENU"
         bAutoSize=True
         WinTop=0.571000
         WinLeft=0.157811
         WinWidth=0.132806
         TabOrder=1
         OnClick=da_GUI_DisconnectOptionPage.InternalOnClick
         OnKeyEvent=MainMenuButton.InternalOnKeyEvent
     End Object
     b_MainMenu=da_GUI_Button'DA2.da_GUI_DisconnectOptionPage.MainMenuButton'

     Begin Object Class=da_GUI_Button Name=ServerBrowserButton
         Caption="SERVER BROWSER"
         bAutoSize=True
         WinTop=0.571000
         WinLeft=0.398437
         WinWidth=0.223632
         TabOrder=2
         OnClick=da_GUI_DisconnectOptionPage.InternalOnClick
         OnKeyEvent=ServerBrowserButton.InternalOnKeyEvent
     End Object
     b_ServerBrowser=da_GUI_Button'DA2.da_GUI_DisconnectOptionPage.ServerBrowserButton'

     Begin Object Class=da_GUI_Button Name=ReconnectButton
         Caption="RECONNECT"
         bAutoSize=True
         WinTop=0.571000
         WinLeft=0.345702
         WinWidth=0.132806
         TabOrder=0
         OnClick=da_GUI_DisconnectOptionPage.InternalOnClick
         OnKeyEvent=ReconnectButton.InternalOnKeyEvent
     End Object
     b_Reconnect=da_GUI_Button'DA2.da_GUI_DisconnectOptionPage.ReconnectButton'

     Begin Object Class=da_GUI_Button Name=QuitButton
         Caption="EXIT DA2"
         bAutoSize=True
         WinTop=0.571000
         WinLeft=0.627929
         WinWidth=0.223632
         TabOrder=3
         OnClick=da_GUI_DisconnectOptionPage.InternalOnClick
         OnKeyEvent=QuitButton.InternalOnKeyEvent
     End Object
     b_Quit=da_GUI_Button'DA2.da_GUI_DisconnectOptionPage.QuitButton'

     Begin Object Class=GUILabel Name=cNetStatLabel
         Caption="Select an option"
         TextAlign=TXTA_Center
         bMultiLine=True
         FontScale=FNS_Large
         StyleName="DA2Style_BodyText"
         WinTop=0.489168
         WinHeight=0.099922
         bBoundToParent=True
     End Object
     l_Status=GUILabel'DA2.da_GUI_DisconnectOptionPage.cNetStatLabel'

     Begin Object Class=FloatingImage Name=MessageWindowFrameBackground
         Image=Texture'DA2GUI.Dialog.window_1024x768'
         DropShadowX=0
         DropShadowY=0
         WinLeft=0.200000
         WinWidth=0.600000
         WinHeight=0.250000
     End Object
     i_FrameBG=FloatingImage'DA2.da_GUI_DisconnectOptionPage.MessageWindowFrameBackground'

     WinTop=0.000000
     WinHeight=1.000000
}
