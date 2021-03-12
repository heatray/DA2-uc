class da_GUI_BotInfoPage extends UT2K4BotInfoPage;


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
     Begin Object Class=da_GUI_ProgressBar Name=myPB
         BarColor=(B=255,G=155)
         Value=50.000000
         bShowValue=False
         StyleName="TextLabel"
         WinHeight=0.040000
         RenderWeight=1.200000
     End Object
     pb_Accuracy=da_GUI_ProgressBar'DA2.da_GUI_BotInfoPage.myPB'

     pb_Agility=da_GUI_ProgressBar'DA2.da_GUI_BotInfoPage.myPB'

     pb_Tactics=da_GUI_ProgressBar'DA2.da_GUI_BotInfoPage.myPB'

     pb_Aggression=da_GUI_ProgressBar'DA2.da_GUI_BotInfoPage.myPB'

     Begin Object Class=da_GUI_ScrollTextBox Name=DecoDescription
         CharDelay=0.002500
         EOLDelay=0.500000
         OnCreateComponent=DecoDescription.InternalOnCreateComponent
         WinTop=0.613447
         WinLeft=0.353008
         WinWidth=0.570936
         WinHeight=0.269553
         bNeverFocus=True
     End Object
     lb_Deco=da_GUI_ScrollTextBox'DA2.da_GUI_BotInfoPage.DecoDescription'

     Begin Object Class=da_GUI_SectionBackground Name=PicBK
         WinTop=0.057558
         WinLeft=0.026150
         WinWidth=0.290820
         WinHeight=0.661731
         OnPreDraw=PicBK.InternalPreDraw
     End Object
     sb_PicBK=da_GUI_SectionBackground'DA2.da_GUI_BotInfoPage.PicBK'

     Begin Object Class=da_GUI_AltSectionBackground Name=HistBk
         LeftPadding=0.010000
         RightPadding=0.010000
         WinTop=0.515790
         WinLeft=0.357891
         WinWidth=0.546522
         WinHeight=0.269553
         OnPreDraw=HistBk.InternalPreDraw
     End Object
     sb_HistBK=da_GUI_AltSectionBackground'DA2.da_GUI_BotInfoPage.HistBk'

     Begin Object Class=da_GUI_AltSectionBackground Name=InternalFrameImage
         WinTop=0.177500
         WinLeft=0.040000
         WinWidth=0.675859
         WinHeight=0.490000
         OnPreDraw=InternalFrameImage.InternalPreDraw
     End Object
     sb_Main=da_GUI_AltSectionBackground'DA2.da_GUI_BotInfoPage.InternalFrameImage'

     Begin Object Class=da_GUI_Button Name=LockedCancelButton
         Caption="Cancel"
         bAutoShrink=False
         WinTop=0.872397
         WinLeft=0.512695
         WinWidth=0.159649
         TabOrder=99
         bBoundToParent=True
         OnClick=da_GUI_BotInfoPage.InternalOnClick
         OnKeyEvent=LockedCancelButton.InternalOnKeyEvent
     End Object
     b_Cancel=da_GUI_Button'DA2.da_GUI_BotInfoPage.LockedCancelButton'

     Begin Object Class=da_GUI_Button Name=LockedOKButton
         Caption="OK"
         bAutoShrink=False
         WinTop=0.872397
         WinLeft=0.742188
         WinWidth=0.159649
         TabOrder=100
         bBoundToParent=True
         OnClick=da_GUI_BotInfoPage.InternalOnClick
         OnKeyEvent=LockedOKButton.InternalOnKeyEvent
     End Object
     b_OK=da_GUI_Button'DA2.da_GUI_BotInfoPage.LockedOKButton'

     t_WindowTitle=da_GUI_Header'DA2.da_GUI_FloatingWindow.TitleBar'

     bMoveAllowed=False
     Begin Object Class=FloatingImage Name=MessageWindowFrameBackground
         Image=Texture'DA2GUI.Dialog.window_1024x768'
         DropShadowX=0
         DropShadowY=0
         WinLeft=0.000000
         WinWidth=1.000000
         WinHeight=1.000000
     End Object
     i_FrameBG=FloatingImage'DA2.da_GUI_BotInfoPage.MessageWindowFrameBackground'

}
