class da_GUI_BotConfigPage extends UT2K4BotConfigPage;

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
     Begin Object Class=da_GUI_moSlider Name=BotAggrSlider
         MaxValue=1.000000
         SliderCaptionStyleName="TextLabel"
         Caption="Aggressiveness"
         OnCreateComponent=BotAggrSlider.InternalOnCreateComponent
         Hint="Configures the aggressiveness rating of this bot."
         WinTop=0.107618
         WinLeft=0.345313
         WinWidth=0.598438
         WinHeight=0.037500
         TabOrder=0
         bBoundToParent=True
         bScaleToParent=True
         OnChange=da_GUI_BotConfigPage.SliderChange
     End Object
     sl_Agg=da_GUI_moSlider'DA2.da_GUI_BotConfigPage.BotAggrSlider'

     Begin Object Class=da_GUI_moSlider Name=BotAccuracySlider
         MaxValue=2.000000
         MinValue=-2.000000
         SliderCaptionStyleName="TextLabel"
         Caption="Accuracy"
         OnCreateComponent=BotAccuracySlider.InternalOnCreateComponent
         Hint="Configures the accuracy rating of this bot."
         WinTop=0.177603
         WinLeft=0.345313
         WinWidth=0.598438
         WinHeight=0.037500
         TabOrder=1
         bBoundToParent=True
         bScaleToParent=True
         OnChange=da_GUI_BotConfigPage.SliderChange
     End Object
     sl_Acc=da_GUI_moSlider'DA2.da_GUI_BotConfigPage.BotAccuracySlider'

     Begin Object Class=da_GUI_moSlider Name=BotCStyleSlider
         MaxValue=1.000000
         SliderCaptionStyleName="TextLabel"
         Caption="Combat Style"
         OnCreateComponent=BotCStyleSlider.InternalOnCreateComponent
         Hint="Adjusts the combat style of this bot."
         WinTop=0.247588
         WinLeft=0.345313
         WinWidth=0.598438
         WinHeight=0.037500
         TabOrder=2
         bBoundToParent=True
         bScaleToParent=True
         OnChange=da_GUI_BotConfigPage.SliderChange
     End Object
     sl_Com=da_GUI_moSlider'DA2.da_GUI_BotConfigPage.BotCStyleSlider'

     Begin Object Class=da_GUI_moSlider Name=BotStrafeSlider
         MaxValue=2.000000
         MinValue=-2.000000
         SliderCaptionStyleName="TextLabel"
         Caption="Strafing Ability"
         OnCreateComponent=BotStrafeSlider.InternalOnCreateComponent
         Hint="Adjusts the strafing ability of this bot."
         WinTop=0.317573
         WinLeft=0.345313
         WinWidth=0.598438
         WinHeight=0.037500
         TabOrder=3
         bBoundToParent=True
         bScaleToParent=True
         OnChange=da_GUI_BotConfigPage.SliderChange
     End Object
     sl_Str=da_GUI_moSlider'DA2.da_GUI_BotConfigPage.BotStrafeSlider'

     Begin Object Class=da_GUI_moSlider Name=BotTacticsSlider
         MaxValue=2.000000
         MinValue=-2.000000
         SliderCaptionStyleName="TextLabel"
         Caption="Tactics"
         OnCreateComponent=BotTacticsSlider.InternalOnCreateComponent
         Hint="Adjusts the team-play awareness ability of this bot."
         WinTop=0.387558
         WinLeft=0.345313
         WinWidth=0.598438
         WinHeight=0.037500
         TabOrder=4
         bBoundToParent=True
         bScaleToParent=True
         OnChange=da_GUI_BotConfigPage.SliderChange
     End Object
     sl_Tac=da_GUI_moSlider'DA2.da_GUI_BotConfigPage.BotTacticsSlider'

     Begin Object Class=da_GUI_moSlider Name=BotReactionSlider
         MaxValue=2.000000
         MinValue=-2.000000
         SliderCaptionStyleName="TextLabel"
         Caption="Reaction Time"
         OnCreateComponent=BotReactionSlider.InternalOnCreateComponent
         Hint="Adjusts the reaction speed of this bot."
         WinTop=0.457542
         WinLeft=0.345313
         WinWidth=0.598438
         WinHeight=0.037500
         TabOrder=5
         bBoundToParent=True
         bScaleToParent=True
         OnChange=da_GUI_BotConfigPage.SliderChange
     End Object
     sl_Rea=da_GUI_moSlider'DA2.da_GUI_BotConfigPage.BotReactionSlider'

     Begin Object Class=da_GUI_moSlider Name=BotJumpy
         MaxValue=1.000000
         SliderCaptionStyleName="TextLabel"
         Caption="Jumpiness"
         OnCreateComponent=BotJumpy.InternalOnCreateComponent
         Hint="Controls whether this bot jumps a lot during the game."
         WinTop=0.527528
         WinLeft=0.345313
         WinWidth=0.598438
         WinHeight=0.037500
         TabOrder=6
         bBoundToParent=True
         bScaleToParent=True
         OnChange=da_GUI_BotConfigPage.SliderChange
     End Object
     sl_Jumpy=da_GUI_moSlider'DA2.da_GUI_BotConfigPage.BotJumpy'

     Begin Object Class=da_GUI_moComboBox Name=BotWeapon
         bReadOnly=True
         ComponentJustification=TXTA_Left
         Caption="Preferred Weapon"
         OnCreateComponent=BotWeapon.InternalOnCreateComponent
         Hint="Select which weapon this bot should prefer."
         WinTop=0.647967
         WinLeft=0.345313
         WinWidth=0.598438
         WinHeight=0.055469
         TabOrder=7
         bBoundToParent=True
         bScaleToParent=True
     End Object
     co_Weapon=da_GUI_moComboBox'DA2.da_GUI_BotConfigPage.BotWeapon'

     Begin Object Class=da_GUI_moComboBox Name=BotVoice
         bReadOnly=True
         ComponentJustification=TXTA_Left
         Caption="Voice"
         OnCreateComponent=BotVoice.InternalOnCreateComponent
         Hint="Choose which voice this bot uses."
         WinTop=0.718011
         WinLeft=0.345313
         WinWidth=0.598438
         WinHeight=0.055469
         TabOrder=8
         bBoundToParent=True
         bScaleToParent=True
         OnChange=UT2K4BotConfigPage.ComboBoxChange
     End Object
     co_Voice=da_GUI_moComboBox'DA2.da_GUI_BotConfigPage.BotVoice'

     Begin Object Class=da_GUI_moComboBox Name=BotOrders
         bReadOnly=True
         ComponentJustification=TXTA_Left
         Caption="Orders"
         OnCreateComponent=BotOrders.InternalOnCreateComponent
         Hint="Choose which role this bot will play in the game."
         WinTop=0.791159
         WinLeft=0.345313
         WinWidth=0.598438
         WinHeight=0.055469
         TabOrder=9
         bBoundToParent=True
         bScaleToParent=True
         OnChange=UT2K4BotConfigPage.ComboBoxChange
     End Object
     co_Orders=da_GUI_moComboBox'DA2.da_GUI_BotConfigPage.BotOrders'

     Begin Object Class=da_GUI_SectionBackground Name=PicBK
         WinTop=0.078391
         WinLeft=0.026150
         WinWidth=0.290820
         WinHeight=0.638294
         OnPreDraw=PicBK.InternalPreDraw
     End Object
     sb_PicBK=da_GUI_SectionBackground'DA2.da_GUI_BotConfigPage.PicBK'

     Begin Object Class=da_GUI_AltSectionBackground Name=InternalFrameImage
         WinTop=0.177500
         WinLeft=0.040000
         WinWidth=0.675859
         WinHeight=0.490000
         OnPreDraw=InternalFrameImage.InternalPreDraw
     End Object
     sb_Main=da_GUI_AltSectionBackground'DA2.da_GUI_BotConfigPage.InternalFrameImage'

     Begin Object Class=da_GUI_Button Name=LockedCancelButton
         Caption="Cancel"
         bAutoShrink=False
         WinTop=0.872397
         WinLeft=0.512695
         WinWidth=0.159649
         TabOrder=99
         bBoundToParent=True
         OnClick=da_GUI_BotConfigPage.InternalOnClick
         OnKeyEvent=LockedCancelButton.InternalOnKeyEvent
     End Object
     b_Cancel=da_GUI_Button'DA2.da_GUI_BotConfigPage.LockedCancelButton'

     Begin Object Class=da_GUI_Button Name=LockedOKButton
         Caption="OK"
         bAutoShrink=False
         WinTop=0.872397
         WinLeft=0.742188
         WinWidth=0.159649
         TabOrder=100
         bBoundToParent=True
         OnClick=da_GUI_BotConfigPage.InternalOnClick
         OnKeyEvent=LockedOKButton.InternalOnKeyEvent
     End Object
     b_OK=da_GUI_Button'DA2.da_GUI_BotConfigPage.LockedOKButton'

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
     i_FrameBG=FloatingImage'DA2.da_GUI_BotConfigPage.MessageWindowFrameBackground'

}
