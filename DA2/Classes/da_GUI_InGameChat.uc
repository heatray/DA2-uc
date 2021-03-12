class da_GUI_InGameChat extends UT2K4InGameChat;

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
	b_ExitButton.bRepeatClick = False;
}

defaultproperties
{
     Begin Object Class=da_GUI_AltSectionBackground Name=sbMain
         bFillClient=True
         WinTop=0.090000
         WinLeft=0.012500
         WinWidth=0.975000
         WinHeight=0.840000
         bBoundToParent=True
         bNeverFocus=True
         OnPreDraw=sbMain.InternalPreDraw
     End Object
     sb_Main=da_GUI_AltSectionBackground'DA2.da_GUI_InGameChat.sbMain'

     Begin Object Class=da_GUI_moEditBox Name=ebSend
         CaptionWidth=0.100000
         Caption="Say: "
         OnCreateComponent=ebSend.InternalOnCreateComponent
         Hint="Prefix a message with a dot (.) to send a team message or a slash (/) to send a command."
         WinTop=0.943855
         WinLeft=0.099584
         WinWidth=0.818909
         WinHeight=0.035416
         TabOrder=0
         bBoundToParent=True
         bScaleToParent=True
     End Object
     eb_Send=da_GUI_moEditBox'DA2.da_GUI_InGameChat.ebSend'

     Begin Object Class=da_GUI_ScrollTextBox Name=lbChat
         bNoTeletype=True
         CharDelay=0.002500
         EOLDelay=0.000000
         Separator="þ"
         OnCreateComponent=lbChat.InternalOnCreateComponent
         FontScale=FNS_Small
         WinTop=0.441667
         WinHeight=0.558333
         bBoundToParent=True
         bScaleToParent=True
         bNeverFocus=True
     End Object
     lb_Chat=da_GUI_ScrollTextBox'DA2.da_GUI_InGameChat.lbChat'

     Begin Object Class=da_GUI_Header Name=TitleBar
         WinTop=0.025000
         WinHeight=0.040000
     End Object
     t_WindowTitle=da_GUI_Header'DA2.da_GUI_InGameChat.TitleBar'

     DefaultLeft=0.100000
     DefaultTop=0.020000
     DefaultWidth=0.770000
     DefaultHeight=0.900000
     Begin Object Class=FloatingImage Name=MessageWindowFrameBackground
         Image=Texture'DA2GUI.Dialog.window_1024x768'
         DropShadowX=0
         DropShadowY=0
         WinLeft=0.000000
         WinWidth=1.000000
         WinHeight=1.000000
     End Object
     i_FrameBG=FloatingImage'DA2.da_GUI_InGameChat.MessageWindowFrameBackground'

     StyleName="DA2Style_BodyText"
     WinTop=0.020000
     WinLeft=0.100000
     WinWidth=0.770000
     WinHeight=0.900000
}
