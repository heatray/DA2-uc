class da_GUI_VoiceChatConfig extends VoiceChatConfig;

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
     Begin Object Class=da_GUI_moEditBox Name=ChatPasswordEdit
         CaptionWidth=0.600000
         Caption="Chat Password"
         OnCreateComponent=ChatPasswordEdit.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Set a password on your personal chat room to limit who is allowed to join"
         WinTop=0.332828
         WinLeft=0.032569
         WinWidth=0.420403
         TabOrder=4
         OnChange=VoiceChatConfig.InternalOnChange
         OnLoadINI=VoiceChatConfig.InternalOnLoadINI
     End Object
     ed_ChatPassword=da_GUI_moEditBox'DA2.da_GUI_VoiceChatConfig.ChatPasswordEdit'

     Begin Object Class=da_GUI_moEditBox Name=DefaultActiveChannelEditBox
         CaptionWidth=0.600000
         Caption="Default Channel Name"
         OnCreateComponent=DefaultActiveChannelEditBox.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Enter the name of the channel to speak on by default when you join the server.  To use the default chatroom for whichever gametype you're playing, leave this field empty"
         WinTop=0.757277
         WinLeft=0.032569
         WinWidth=0.420403
         TabOrder=4
         OnChange=VoiceChatConfig.InternalOnChange
         OnLoadINI=VoiceChatConfig.InternalOnLoadINI
     End Object
     ed_Active=da_GUI_moEditBox'DA2.da_GUI_VoiceChatConfig.DefaultActiveChannelEditBox'

     Begin Object Class=da_GUI_moSlider Name=VoiceVolume
         MaxValue=10.000000
         MinValue=1.000000
         CaptionWidth=0.600000
         Caption="Voice Chat Volume"
         OnCreateComponent=VoiceVolume.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Adjusts the volume of other players' voice chat communication."
         WinTop=0.142484
         WinLeft=0.518507
         WinWidth=0.408907
         RenderWeight=1.040000
         TabOrder=0
         OnChange=VoiceChatConfig.InternalOnChange
         OnLoadINI=VoiceChatConfig.InternalOnLoadINI
     End Object
     sl_VoiceVol=da_GUI_moSlider'DA2.da_GUI_VoiceChatConfig.VoiceVolume'

     Begin Object Class=da_GUI_moCheckBox Name=AutoJoinPublic
         CaptionWidth=0.940000
         Caption="Autojoin Public Channel"
         OnCreateComponent=AutoJoinPublic.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Automatically join the 'Public' channel upon connecting to a server."
         WinTop=0.042496
         WinLeft=0.086280
         WinWidth=0.826652
         TabOrder=1
         OnChange=VoiceChatConfig.InternalOnChange
         OnLoadINI=VoiceChatConfig.InternalOnLoadINI
     End Object
     ch_AJPublic=da_GUI_moCheckBox'DA2.da_GUI_VoiceChatConfig.AutoJoinPublic'

     Begin Object Class=da_GUI_moCheckBox Name=AutoJoinLocal
         CaptionWidth=0.940000
         Caption="Autojoin Local Channel"
         OnCreateComponent=AutoJoinLocal.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Automatically join the 'Local' channel upon connecting to a server."
         WinTop=0.145784
         WinLeft=0.086280
         WinWidth=0.826652
         TabOrder=2
         OnChange=VoiceChatConfig.InternalOnChange
         OnLoadINI=VoiceChatConfig.InternalOnLoadINI
     End Object
     ch_AJLocal=da_GUI_moCheckBox'DA2.da_GUI_VoiceChatConfig.AutoJoinLocal'

     Begin Object Class=da_GUI_moCheckBox Name=AutoJoinTeam
         Caption="Autojoin Team Channel"
         OnCreateComponent=AutoJoinTeam.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Automatically join the 'Team' channel upon connecting to a server."
         WinTop=0.226937
         WinLeft=0.022803
         WinWidth=0.440910
         TabOrder=3
         OnChange=VoiceChatConfig.InternalOnChange
         OnLoadINI=VoiceChatConfig.InternalOnLoadINI
     End Object
     ch_AJTeam=da_GUI_moCheckBox'DA2.da_GUI_VoiceChatConfig.AutoJoinTeam'

     Begin Object Class=da_GUI_moCheckBox Name=AutoSpeakCheckbox
         Caption="Auto-select Active Channel"
         OnCreateComponent=AutoSpeakCheckbox.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Automatically set an active channel when you join a server.  The default channel is determined by the gametype, but you can specify your own using the editbox below"
         WinTop=0.603526
         WinLeft=0.039812
         WinWidth=0.442638
         WinHeight=0.060000
         TabOrder=3
         bBoundToParent=True
         bScaleToParent=True
         OnChange=VoiceChatConfig.InternalOnChange
         OnLoadINI=VoiceChatConfig.InternalOnLoadINI
     End Object
     ch_AutoSpeak=da_GUI_moCheckBox'DA2.da_GUI_VoiceChatConfig.AutoSpeakCheckbox'

     Begin Object Class=da_GUI_moComboBox Name=VoiceQuality
         bReadOnly=True
         CaptionWidth=0.600000
         Caption="Internet Quality"
         OnCreateComponent=VoiceQuality.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Determines the codec used to transmit voice chat to and from internet servers."
         WinTop=0.241391
         WinLeft=0.523390
         WinWidth=0.408907
         TabOrder=5
         OnChange=VoiceChatConfig.InternalOnChange
         OnLoadINI=VoiceChatConfig.InternalOnLoadINI
     End Object
     co_Quality=da_GUI_moComboBox'DA2.da_GUI_VoiceChatConfig.VoiceQuality'

     Begin Object Class=da_GUI_moComboBox Name=VoiceQualityLAN
         bReadOnly=True
         CaptionWidth=0.600000
         Caption="LAN Quality"
         OnCreateComponent=VoiceQualityLAN.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Determines the codec used to transmit voice chat to and from LAN servers."
         WinTop=0.333786
         WinLeft=0.523390
         WinWidth=0.408907
         TabOrder=6
         OnChange=VoiceChatConfig.InternalOnChange
         OnLoadINI=VoiceChatConfig.InternalOnLoadINI
     End Object
     co_LANQuality=da_GUI_moComboBox'DA2.da_GUI_VoiceChatConfig.VoiceQualityLAN'

     Begin Object Class=da_GUI_AltSectionBackground Name=InternalFrameImage
         WinTop=0.177500
         WinLeft=0.040000
         WinWidth=0.675859
         WinHeight=0.490000
         OnPreDraw=InternalFrameImage.InternalPreDraw
     End Object
     sb_Main=da_GUI_AltSectionBackground'DA2.da_GUI_VoiceChatConfig.InternalFrameImage'

     Begin Object Class=da_GUI_Button Name=LockedCancelButton
         Caption="Cancel"
         bAutoShrink=False
         WinTop=0.872397
         WinLeft=0.512695
         WinWidth=0.159649
         TabOrder=99
         bBoundToParent=True
         OnClick=da_GUI_VoiceChatConfig.InternalOnClick
         OnKeyEvent=LockedCancelButton.InternalOnKeyEvent
     End Object
     b_Cancel=da_GUI_Button'DA2.da_GUI_VoiceChatConfig.LockedCancelButton'

     Begin Object Class=da_GUI_Button Name=LockedOKButton
         Caption="OK"
         bAutoShrink=False
         WinTop=0.872397
         WinLeft=0.742188
         WinWidth=0.159649
         TabOrder=100
         bBoundToParent=True
         OnClick=da_GUI_VoiceChatConfig.InternalOnClick
         OnKeyEvent=LockedOKButton.InternalOnKeyEvent
     End Object
     b_OK=da_GUI_Button'DA2.da_GUI_VoiceChatConfig.LockedOKButton'

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
     i_FrameBG=FloatingImage'DA2.da_GUI_VoiceChatConfig.MessageWindowFrameBackground'

}
