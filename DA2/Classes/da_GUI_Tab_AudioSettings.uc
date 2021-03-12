// D:\mods\UT2004Script3339\GUI2K4\Classes\UT2K4Tab_AudioSettings.uc
// D:\mods\UT2004Script3339\GUI2K4\Classes\Settings_Tabs.uc
// D:\mods\UT2004Script3339\GUI2K4\Classes\UT2K4TabPanel.uc

class da_GUI_Tab_AudioSettings extends UT2K4Tab_AudioSettings;

defaultproperties
{
     Begin Object Class=da_GUI_SectionBackground Name=AudioBK1
         Caption="Sound Effects"
         NumColumns=2
         MaxPerColumn=5
         WinTop=0.017393
         WinLeft=0.005000
         WinWidth=0.990000
         WinHeight=0.502850
         OnPreDraw=AudioBK1.InternalPreDraw
     End Object
     i_BG1=da_GUI_SectionBackground'DA2.da_GUI_Tab_AudioSettings.AudioBK1'

     Begin Object Class=da_GUI_SectionBackground Name=AudioBK2
         Caption="Announcer"
         WinTop=0.004372
         WinLeft=0.005000
         WinWidth=0.990000
         WinHeight=0.517498
         OnPreDraw=AudioBK2.InternalPreDraw
     End Object
     i_BG2=da_GUI_SectionBackground'DA2.da_GUI_Tab_AudioSettings.AudioBK2'

     Begin Object Class=da_GUI_SectionBackground Name=AudioBK3
         Caption="Text To Speech"
         WinTop=0.004372
         WinLeft=0.005000
         WinWidth=0.990000
         WinHeight=0.517498
         OnPreDraw=AudioBK3.InternalPreDraw
     End Object
     i_BG3=da_GUI_SectionBackground'DA2.da_GUI_Tab_AudioSettings.AudioBK3'

     Begin Object Class=da_GUI_moSlider Name=AudioMusicVolume
         MaxValue=1.000000
         Caption="Music Volume"
         OnCreateComponent=AudioMusicVolume.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="0.5"
         Hint="Adjusts the volume of the background music."
         WinTop=0.070522
         WinLeft=0.018164
         WinWidth=0.450000
         TabOrder=0
         OnChange=da_GUI_Tab_AudioSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_AudioSettings.InternalOnLoadINI
     End Object
     sl_MusicVol=da_GUI_moSlider'DA2.da_GUI_Tab_AudioSettings.AudioMusicVolume'

     Begin Object Class=da_GUI_moSlider Name=AudioEffectsVolumeSlider
         MaxValue=1.000000
         Caption="Effects Volume"
         OnCreateComponent=AudioEffectsVolumeSlider.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="0.9"
         Hint="Adjusts the volume of all in game sound effects."
         WinTop=0.070522
         WinLeft=0.524024
         WinWidth=0.450000
         TabOrder=5
         OnChange=da_GUI_Tab_AudioSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_AudioSettings.InternalOnLoadINI
     End Object
     sl_EffectsVol=da_GUI_moSlider'DA2.da_GUI_Tab_AudioSettings.AudioEffectsVolumeSlider'

     Begin Object Class=da_GUI_moSlider Name=AudioAnnouncerVolume
         MaxValue=4.000000
         MinValue=1.000000
         bIntSlider=True
         CaptionWidth=0.650000
         Caption="Volume"
         OnCreateComponent=AudioAnnouncerVolume.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Adjusts the volume of all in game voice messages."
         WinTop=0.597866
         WinLeft=0.011329
         WinWidth=0.470703
         TabOrder=10
         OnChange=da_GUI_Tab_AudioSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_AudioSettings.InternalOnLoadINI
     End Object
     sl_VoiceVol=da_GUI_moSlider'DA2.da_GUI_Tab_AudioSettings.AudioAnnouncerVolume'

     Begin Object Class=da_GUI_moComboBox Name=AudioMode
         bReadOnly=True
         Caption="Audio Mode"
         OnCreateComponent=AudioMode.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="Software 3D Audio"
         Hint="Changes the audio system mode."
         WinTop=0.149739
         WinLeft=0.018164
         WinWidth=0.450000
         TabOrder=1
         OnChange=da_GUI_Tab_AudioSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_AudioSettings.InternalOnLoadINI
     End Object
     co_Mode=da_GUI_moComboBox'DA2.da_GUI_Tab_AudioSettings.AudioMode'

     Begin Object Class=da_GUI_moComboBox Name=AudioPlayVoices
         bReadOnly=True
         Caption="Play Voices"
         OnCreateComponent=AudioPlayVoices.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="All"
         Hint="Defines the types of voice messages to play."
         WinTop=0.149739
         WinLeft=0.524024
         WinWidth=0.450000
         TabOrder=6
         OnChange=da_GUI_Tab_AudioSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_AudioSettings.InternalOnLoadINI
     End Object
     co_Voices=da_GUI_moComboBox'DA2.da_GUI_Tab_AudioSettings.AudioPlayVoices'

     Begin Object Class=da_GUI_moComboBox Name=AudioAnnounce
         bReadOnly=True
         CaptionWidth=0.650000
         Caption="Announcements"
         OnCreateComponent=AudioAnnounce.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="All"
         Hint="Adjusts the amount of in-game announcements."
         WinTop=0.711079
         WinLeft=0.011329
         WinWidth=0.470703
         TabOrder=11
         OnChange=da_GUI_Tab_AudioSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_AudioSettings.InternalOnLoadINI
     End Object
     co_Announce=da_GUI_moComboBox'DA2.da_GUI_Tab_AudioSettings.AudioAnnounce'

     Begin Object Class=da_GUI_moComboBox Name=AudioRewardAnnouncer
         bReadOnly=True
         CaptionWidth=0.650000
         Caption="Reward Announcer"
         OnCreateComponent=AudioRewardAnnouncer.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Each tournament player is linked to a Reward announcer that informs you when you've demonstrated exceptional combat skills."
         WinTop=0.890991
         WinLeft=0.011329
         WinWidth=0.470703
         TabOrder=13
         OnChange=da_GUI_Tab_AudioSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_AudioSettings.InternalOnLoadINI
     End Object
     co_RewardAnnouncer=da_GUI_moComboBox'DA2.da_GUI_Tab_AudioSettings.AudioRewardAnnouncer'

     Begin Object Class=da_GUI_moComboBox Name=AudioStatusAnnouncer
         bReadOnly=True
         CaptionWidth=0.650000
         Caption="Status Announcer"
         OnCreateComponent=AudioStatusAnnouncer.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="The Status announcer relays important information about the game to tournament players and spectators."
         WinTop=0.801035
         WinLeft=0.011329
         WinWidth=0.470703
         TabOrder=12
         OnChange=da_GUI_Tab_AudioSettings.InternalOnChange
     End Object
     co_StatusAnnouncer=da_GUI_moComboBox'DA2.da_GUI_Tab_AudioSettings.AudioStatusAnnouncer'

     Begin Object Class=da_GUI_moCheckBox Name=AudioReverseStereo
         ComponentJustification=TXTA_Left
         CaptionWidth=0.940000
         Caption="Reverse Stereo"
         OnCreateComponent=AudioReverseStereo.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="False"
         Hint="Reverses the left and right audio channels."
         WinTop=0.405678
         WinLeft=0.018164
         WinWidth=0.450000
         TabOrder=4
         OnChange=da_GUI_Tab_AudioSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_AudioSettings.InternalOnLoadINI
     End Object
     ch_ReverseStereo=da_GUI_moCheckBox'DA2.da_GUI_Tab_AudioSettings.AudioReverseStereo'

     Begin Object Class=da_GUI_moCheckBox Name=AudioMessageBeep
         ComponentJustification=TXTA_Left
         CaptionWidth=0.940000
         Caption="Message Beep"
         OnCreateComponent=AudioMessageBeep.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="True"
         Hint="Enables a beep when receiving a text message from other players."
         WinTop=0.405678
         WinLeft=0.524024
         WinWidth=0.450000
         TabOrder=9
         OnChange=da_GUI_Tab_AudioSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_AudioSettings.InternalOnLoadINI
     End Object
     ch_MessageBeep=da_GUI_moCheckBox'DA2.da_GUI_Tab_AudioSettings.AudioMessageBeep'

     Begin Object Class=da_GUI_moCheckBox Name=AudioAutoTaunt
         ComponentJustification=TXTA_Left
         CaptionWidth=0.940000
         Caption="Auto-Taunt"
         OnCreateComponent=AudioAutoTaunt.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="True"
         Hint="Enables your in-game player to automatically taunt opponents."
         WinTop=0.320365
         WinLeft=0.524024
         WinWidth=0.450000
         TabOrder=8
         OnChange=da_GUI_Tab_AudioSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_AudioSettings.InternalOnLoadINI
     End Object
     ch_AutoTaunt=da_GUI_moCheckBox'DA2.da_GUI_Tab_AudioSettings.AudioAutoTaunt'

     Begin Object Class=da_GUI_moCheckBox Name=IRCTextToSpeech
         ComponentJustification=TXTA_Left
         CaptionWidth=0.940000
         Caption="Enable on IRC"
         OnCreateComponent=IRCTextToSpeech.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Enables Text-To-Speech processing in the IRC client (only messages from active tab is processed)"
         WinTop=0.755462
         WinLeft=0.527734
         WinWidth=0.461134
         TabOrder=16
         OnChange=da_GUI_Tab_AudioSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_AudioSettings.InternalOnLoadINI
     End Object
     ch_TTSIRC=da_GUI_moCheckBox'DA2.da_GUI_Tab_AudioSettings.IRCTextToSpeech'

     Begin Object Class=da_GUI_moCheckBox Name=OnlyTeamTTSCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.940000
         Caption="Team Messages Only"
         OnCreateComponent=OnlyTeamTTSCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="If enabled, only team messages will be spoken in team games, unless the match or round is over."
         WinTop=0.755462
         WinLeft=0.527734
         WinWidth=0.461134
         TabOrder=17
         OnChange=da_GUI_Tab_AudioSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_AudioSettings.InternalOnLoadINI
     End Object
     ch_OnlyTeamTTS=da_GUI_moCheckBox'DA2.da_GUI_Tab_AudioSettings.OnlyTeamTTSCheck'

     Begin Object Class=da_GUI_moCheckBox Name=AudioMatureTaunts
         ComponentJustification=TXTA_Left
         CaptionWidth=0.940000
         Caption="Mature Taunts"
         OnCreateComponent=AudioMatureTaunts.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="True"
         Hint="Enables off-color commentary."
         WinTop=0.235052
         WinLeft=0.524024
         WinWidth=0.450000
         TabOrder=7
         OnChange=da_GUI_Tab_AudioSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_AudioSettings.InternalOnLoadINI
     End Object
     ch_MatureTaunts=da_GUI_moCheckBox'DA2.da_GUI_Tab_AudioSettings.AudioMatureTaunts'

     Begin Object Class=da_GUI_moCheckBox Name=AudioLowDetail
         ComponentJustification=TXTA_Left
         CaptionWidth=0.940000
         Caption="Low Sound Detail"
         OnCreateComponent=AudioLowDetail.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="False"
         Hint="Lowers quality of sound."
         WinTop=0.235052
         WinLeft=0.018164
         WinWidth=0.450000
         TabOrder=2
         OnChange=da_GUI_Tab_AudioSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_AudioSettings.InternalOnLoadINI
     End Object
     ch_LowDetail=da_GUI_moCheckBox'DA2.da_GUI_Tab_AudioSettings.AudioLowDetail'

     Begin Object Class=da_GUI_moCheckBox Name=AudioDefaultDriver
         ComponentJustification=TXTA_Left
         CaptionWidth=0.940000
         Caption="System Driver"
         OnCreateComponent=AudioDefaultDriver.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="False"
         Hint="Use system installed OpenAL driver"
         WinTop=0.320365
         WinLeft=0.018164
         WinWidth=0.450000
         TabOrder=3
         OnChange=da_GUI_Tab_AudioSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_AudioSettings.InternalOnLoadINI
     End Object
     ch_Default=da_GUI_moCheckBox'DA2.da_GUI_Tab_AudioSettings.AudioDefaultDriver'

     Begin Object Class=da_GUI_moCheckBox Name=AudioEnableTTS
         ComponentJustification=TXTA_Left
         CaptionWidth=0.940000
         Caption="Enable In Game"
         OnCreateComponent=AudioEnableTTS.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="False"
         Hint="Enables Text-To-Speech message processing"
         WinTop=0.685037
         WinLeft=0.527734
         WinWidth=0.461134
         TabOrder=15
         OnChange=da_GUI_Tab_AudioSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_AudioSettings.InternalOnLoadINI
     End Object
     ch_TTS=da_GUI_moCheckBox'DA2.da_GUI_Tab_AudioSettings.AudioEnableTTS'

     Begin Object Class=da_GUI_moCheckBox Name=EnableVoiceChat
         ComponentJustification=TXTA_Left
         CaptionWidth=0.940000
         Caption="Voice Chat"
         OnCreateComponent=EnableVoiceChat.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Enables the voice chat system during online matches."
         WinTop=0.834777
         WinLeft=0.527734
         WinWidth=0.461134
         TabOrder=18
         OnChange=da_GUI_Tab_AudioSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_AudioSettings.InternalOnLoadINI
     End Object
     ch_VoiceChat=da_GUI_moCheckBox'DA2.da_GUI_Tab_AudioSettings.EnableVoiceChat'

     Begin Object Class=da_GUI_moButton Name=VoiceOptions
         ButtonCaption="Configure"
         MenuTitle="Voice Chat Options"
         MenuClass="DA2.da_GUI_VoiceChatConfig"
         CaptionWidth=0.500000
         Caption="Voice Options"
         OnCreateComponent=VoiceOptions.InternalOnCreateComponent
         WinTop=0.909065
         WinLeft=0.527734
         WinWidth=0.461134
         WinHeight=0.050000
         TabOrder=19
     End Object
     b_VoiceChat=da_GUI_moButton'DA2.da_GUI_Tab_AudioSettings.VoiceOptions'

     FadeInTime=0.000000
     WinHeight=0.780000
     bStandardized=True
     StandardHeight=0.780000
}
