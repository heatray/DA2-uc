class da_GUI_SpeechBinder extends SpeechBinder;

function bool InternalOnPreDraw(canvas c) {
	local bool b;

	i_FrameBG.Image = class'da_GUI_Utilities'.static.getCorrectBackground(c);
	b = Super.InternalOnPreDraw(c);

	b_Cancel.WinTop = 0.935;
	b_OK.WinTop = 0.935;

	return b;
}

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
     Begin Object Class=da_GUI_MultiColumnListBox Name=BindListBox
         HeaderColumnPerc(0)=0.500000
         HeaderColumnPerc(1)=0.250000
         HeaderColumnPerc(2)=0.250000
         OnCreateComponent=da_GUI_SpeechBinder.InternalOnCreateComponent
         WinTop=0.120000
         WinLeft=0.040000
         WinWidth=0.920000
         WinHeight=0.760000
         TabOrder=0
         bBoundToParent=True
         bScaleToParent=True
     End Object
     lb_Binds=da_GUI_MultiColumnListBox'DA2.da_GUI_SpeechBinder.BindListBox'

     Begin Object Class=GUIImage Name=BindBk
         Image=Texture'DA2GUI.Dialog.Display99'
         ImageStyle=ISTY_Stretched
         WinTop=0.120000
         WinLeft=0.030000
         WinWidth=0.940000
         WinHeight=0.780000
         bBoundToParent=True
         bScaleToParent=True
     End Object
     i_bk=GUIImage'DA2.da_GUI_SpeechBinder.BindBk'

     Begin Object Class=GUILabel Name=HintLabel
         TextAlign=TXTA_Center
         bMultiLine=True
         VertAlign=TXTA_Center
         FontScale=FNS_Small
         StyleName="DA2Style_BodyText"
         WinTop=0.920000
         WinLeft=0.032813
         WinWidth=0.520313
         WinHeight=0.085000
         bBoundToParent=True
         bScaleToParent=True
     End Object
     l_Hint=GUILabel'DA2.da_GUI_SpeechBinder.HintLabel'

     Begin Object Class=da_GUI_Button Name=LockedCancelButton
         Caption="Cancel"
         bAutoShrink=False
         WinTop=0.935000
         WinLeft=0.512695
         WinWidth=0.159649
         TabOrder=99
         bBoundToParent=True
         OnClick=da_GUI_SpeechBinder.InternalOnClick
         OnKeyEvent=LockedCancelButton.InternalOnKeyEvent
     End Object
     b_Cancel=da_GUI_Button'DA2.da_GUI_SpeechBinder.LockedCancelButton'

     Begin Object Class=da_GUI_Button Name=LockedOKButton
         Caption="OK"
         bAutoShrink=False
         WinTop=0.935000
         WinLeft=0.742188
         WinWidth=0.159649
         TabOrder=100
         bBoundToParent=True
         OnClick=da_GUI_SpeechBinder.InternalOnClick
         OnKeyEvent=LockedOKButton.InternalOnKeyEvent
     End Object
     b_OK=da_GUI_Button'DA2.da_GUI_SpeechBinder.LockedOKButton'

     Begin Object Class=da_GUI_Header Name=TitleBar
         bUseTextHeight=True
         WinTop=0.038000
         WinHeight=0.043750
         RenderWeight=0.100000
         bBoundToParent=True
         bScaleToParent=True
         bAcceptsInput=True
         bNeverFocus=False
         ScalingType=SCALE_X
         OnMousePressed=da_GUI_SpeechBinder.FloatingMousePressed
         OnMouseRelease=da_GUI_SpeechBinder.FloatingMouseRelease
     End Object
     t_WindowTitle=da_GUI_Header'DA2.da_GUI_SpeechBinder.TitleBar'

     Begin Object Class=FloatingImage Name=MessageWindowFrameBackground
         Image=Texture'DA2GUI.Dialog.window_1024x768'
         DropShadowX=0
         DropShadowY=0
         WinLeft=0.000000
         WinWidth=1.000000
         WinHeight=0.250000
     End Object
     i_FrameBG=FloatingImage'DA2.da_GUI_SpeechBinder.MessageWindowFrameBackground'

}
