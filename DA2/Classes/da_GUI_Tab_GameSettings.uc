// D:\mods\UT2004Script3339\GUI2K4\Classes\UT2K4Tab_GameSettings.uc
// D:\mods\UT2004Script3339\GUI2K4\Classes\Settings_Tabs.uc
// D:\mods\UT2004Script3339\GUI2K4\Classes\UT2K4TabPanel.uc

class da_GUI_Tab_GameSettings extends UT2K4Tab_GameSettings;


function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	super.Initcomponent(MyController, MyOwner);

    RemoveComponent(i_BG5);
    RemoveComponent(l_ID);
}

defaultproperties
{
     Begin Object Class=da_GUI_SectionBackground Name=GameBK1
         Caption="Gameplay"
         WinTop=0.033853
         WinLeft=0.005000
         WinWidth=0.485000
         WinHeight=0.748936
         RenderWeight=0.100100
         OnPreDraw=GameBK1.InternalPreDraw
     End Object
     i_BG1=da_GUI_SectionBackground'DA2.da_GUI_Tab_GameSettings.GameBK1'

     Begin Object Class=da_GUI_SectionBackground Name=GameBK2
         Caption="Network"
         WinTop=0.033853
         WinLeft=0.505000
         WinWidth=0.485000
         WinHeight=0.199610
         RenderWeight=0.100200
         OnPreDraw=GameBK2.InternalPreDraw
     End Object
     i_BG2=da_GUI_SectionBackground'DA2.da_GUI_Tab_GameSettings.GameBK2'

     Begin Object Class=da_GUI_SectionBackground Name=GameBK3
         Caption="Stats"
         WinTop=0.240491
         WinLeft=0.505000
         WinWidth=0.485000
         WinHeight=0.308985
         RenderWeight=0.100200
         OnPreDraw=GameBK3.InternalPreDraw
     End Object
     i_BG3=da_GUI_SectionBackground'DA2.da_GUI_Tab_GameSettings.GameBK3'

     Begin Object Class=da_GUI_SectionBackground Name=GameBK4
         Caption="Misc"
         WinTop=0.559889
         WinLeft=0.505000
         WinWidth=0.485000
         WinHeight=0.219141
         RenderWeight=0.100200
         OnPreDraw=GameBK4.InternalPreDraw
     End Object
     i_BG4=da_GUI_SectionBackground'DA2.da_GUI_Tab_GameSettings.GameBK4'

     Begin Object Class=da_GUI_moCheckBox Name=GameWeaponBob
         CaptionWidth=0.800000
         ComponentWidth=-1.000000
         Caption="Weapon Bob"
         OnCreateComponent=GameWeaponBob.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Prevent your weapon from bobbing up and down while moving"
         WinTop=0.290780
         WinLeft=0.050000
         WinWidth=0.400000
         RenderWeight=1.040000
         TabOrder=1
         OnChange=da_GUI_Tab_GameSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_GameSettings.InternalOnLoadINI
     End Object
     ch_WeaponBob=da_GUI_moCheckBox'DA2.da_GUI_Tab_GameSettings.GameWeaponBob'

     Begin Object Class=da_GUI_moCheckBox Name=WeaponAutoSwitch
         CaptionWidth=0.800000
         ComponentWidth=-1.000000
         Caption="Weapon Switch On Pickup"
         OnCreateComponent=WeaponAutoSwitch.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Automatically change weapons when you pick up a better one."
         RenderWeight=1.040000
         TabOrder=6
         OnChange=da_GUI_Tab_GameSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_GameSettings.InternalOnLoadINI
     End Object
     ch_AutoSwitch=da_GUI_moCheckBox'DA2.da_GUI_Tab_GameSettings.WeaponAutoSwitch'

     Begin Object Class=da_GUI_moCheckBox Name=SpeechRecognition
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Speech Recognition"
         OnCreateComponent=SpeechRecognition.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Enable speech recognition"
         WinTop=0.654527
         WinLeft=0.540058
         WinWidth=0.403353
         TabOrder=14
         bBoundToParent=True
         bScaleToParent=True
         OnChange=da_GUI_Tab_GameSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_GameSettings.InternalOnLoadINI
     End Object
     ch_Speech=da_GUI_moCheckBox'DA2.da_GUI_Tab_GameSettings.SpeechRecognition'

     Begin Object Class=da_GUI_moCheckBox Name=GameDodging
         CaptionWidth=0.800000
         ComponentWidth=-1.000000
         Caption="Dodging"
         OnCreateComponent=GameDodging.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Turn this option off to disable special dodge moves."
         WinTop=0.541563
         WinLeft=0.050000
         WinWidth=0.400000
         RenderWeight=1.040000
         TabOrder=3
         OnChange=da_GUI_Tab_GameSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_GameSettings.InternalOnLoadINI
     End Object
     ch_Dodging=da_GUI_moCheckBox'DA2.da_GUI_Tab_GameSettings.GameDodging'

     Begin Object Class=da_GUI_moCheckBox Name=GameAutoAim
         CaptionWidth=0.800000
         ComponentWidth=-1.000000
         Caption="Auto Aim"
         OnCreateComponent=GameAutoAim.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Enabling this option will activate computer-assisted aiming in single player games."
         WinTop=0.692344
         WinLeft=0.050000
         WinWidth=0.400000
         RenderWeight=1.040000
         TabOrder=4
         OnChange=da_GUI_Tab_GameSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_GameSettings.InternalOnLoadINI
     End Object
     ch_AutoAim=da_GUI_moCheckBox'DA2.da_GUI_Tab_GameSettings.GameAutoAim'

     Begin Object Class=da_GUI_moCheckBox Name=GameClassicTrans
         CaptionWidth=0.800000
         ComponentWidth=-1.000000
         Caption="High Beacon Trajectory"
         OnCreateComponent=GameClassicTrans.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Enable to use traditional-style high translocator beacon toss trajectory"
         RenderWeight=1.040000
         TabOrder=5
         OnChange=da_GUI_Tab_GameSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_GameSettings.InternalOnLoadINI
     End Object
     ch_ClassicTrans=da_GUI_moCheckBox'DA2.da_GUI_Tab_GameSettings.GameClassicTrans'

     Begin Object Class=da_GUI_moCheckBox Name=LandShaking
         CaptionWidth=0.900000
         Caption="Landing Viewshake"
         OnCreateComponent=LandShaking.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Enable view shaking upon landing."
         WinTop=0.150261
         WinLeft=0.705430
         WinWidth=0.266797
         TabOrder=7
         OnChange=da_GUI_Tab_GameSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_GameSettings.InternalOnLoadINI
     End Object
     ch_LandShake=da_GUI_moCheckBox'DA2.da_GUI_Tab_GameSettings.LandShaking'

     Begin Object Class=da_GUI_moComboBox Name=GameGoreLevel
         bReadOnly=True
         Caption="Gore Level"
         OnCreateComponent=GameGoreLevel.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Configure the amount of blood and gore you see while playing the game"
         WinTop=0.415521
         WinLeft=0.050000
         WinWidth=0.400000
         RenderWeight=1.040000
         TabOrder=2
         OnChange=da_GUI_Tab_GameSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_GameSettings.InternalOnLoadINI
     End Object
     co_GoreLevel=da_GUI_moComboBox'DA2.da_GUI_Tab_GameSettings.GameGoreLevel'

     Begin Object Class=GUILabel Name=InvalidWarning
         Caption="Your stats username or password is invalid.  Your username must be at least 4 characters long, and your password must be at least 6 characters long."
         TextAlign=TXTA_Center
         TextColor=(B=0,G=255,R=255)
         TextFont="UT2SmallFont"
         bMultiLine=True
         StyleName="DA2Style_BodyText"
         WinTop=0.926000
         WinLeft=0.057183
         WinWidth=0.887965
         WinHeight=0.070000
     End Object
     l_Warning=GUILabel'DA2.da_GUI_Tab_GameSettings.InvalidWarning'

     Begin Object Class=da_GUI_Button Name=ViewOnlineStats
         Caption="View Stats"
         Hint="Click to launch the UT stats website."
         WinTop=0.469391
         WinLeft=0.780383
         WinWidth=0.166055
         WinHeight=0.050000
         TabOrder=13
         OnClick=da_GUI_Tab_GameSettings.OnViewStats
         OnKeyEvent=ViewOnlineStats.InternalOnKeyEvent
     End Object
     b_Stats=da_GUI_Button'DA2.da_GUI_Tab_GameSettings.ViewOnlineStats'

     Begin Object Class=da_GUI_moCheckBox Name=OnlineTrackStats
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Track Stats"
         OnCreateComponent=OnlineTrackStats.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="True"
         Hint="Enable this option to join the online ranking system."
         WinTop=0.321733
         WinLeft=0.642597
         WinWidth=0.170273
         TabOrder=10
         OnChange=da_GUI_Tab_GameSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_GameSettings.InternalOnLoadINI
     End Object
     ch_TrackStats=da_GUI_moCheckBox'DA2.da_GUI_Tab_GameSettings.OnlineTrackStats'

     Begin Object Class=da_GUI_moCheckBox Name=NetworkDynamicNetspeed
         ComponentJustification=TXTA_Left
         CaptionWidth=0.940000
         Caption="Dynamic Netspeed"
         OnCreateComponent=NetworkDynamicNetspeed.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Netspeed is automatically adjusted based on the speed of your network connection"
         WinTop=0.166017
         WinLeft=0.528997
         WinWidth=0.419297
         TabOrder=9
         OnChange=da_GUI_Tab_GameSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_GameSettings.InternalOnLoadINI
     End Object
     ch_DynNetspeed=da_GUI_moCheckBox'DA2.da_GUI_Tab_GameSettings.NetworkDynamicNetspeed'

     Begin Object Class=da_GUI_moCheckBox Name=PrecacheSkins
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Preload all player skins"
         OnCreateComponent=PrecacheSkins.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Preloads all player skins, increasing level load time but reducing hitches during network games.  You must have at least 512 MB of system memory to use this option."
         WinTop=0.707553
         WinLeft=0.540058
         WinWidth=0.403353
         TabOrder=15
         OnChange=da_GUI_Tab_GameSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_GameSettings.InternalOnLoadINI
     End Object
     ch_Precache=da_GUI_moCheckBox'DA2.da_GUI_Tab_GameSettings.PrecacheSkins'

     Begin Object Class=da_GUI_moComboBox Name=OnlineNetSpeed
         bReadOnly=True
         ComponentJustification=TXTA_Left
         CaptionWidth=0.550000
         Caption="Connection"
         OnCreateComponent=OnlineNetSpeed.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="Cable Modem/DSL"
         Hint="How fast is your connection?"
         WinTop=0.122944
         WinLeft=0.528997
         WinWidth=0.419297
         TabOrder=8
         OnChange=da_GUI_Tab_GameSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_GameSettings.InternalOnLoadINI
     End Object
     co_Netspeed=da_GUI_moComboBox'DA2.da_GUI_Tab_GameSettings.OnlineNetSpeed'

     Begin Object Class=da_GUI_moEditBox Name=OnlineStatsName
         CaptionWidth=0.400000
         Caption="UserName"
         OnCreateComponent=OnlineStatsName.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Please select a name to use for UT Stats!"
         WinTop=0.373349
         WinLeft=0.524912
         WinWidth=0.419316
         TabOrder=11
         OnChange=da_GUI_Tab_GameSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_GameSettings.InternalOnLoadINI
     End Object
     ed_Name=da_GUI_moEditBox'DA2.da_GUI_Tab_GameSettings.OnlineStatsName'

     Begin Object Class=da_GUI_moEditBox Name=OnlineStatsPW
         CaptionWidth=0.400000
         Caption="Password"
         OnCreateComponent=OnlineStatsPW.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Please select a password that will secure your UT Stats!"
         WinTop=0.430677
         WinLeft=0.524912
         WinWidth=0.419316
         TabOrder=12
         OnChange=da_GUI_Tab_GameSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_GameSettings.InternalOnLoadINI
     End Object
     ed_Password=da_GUI_moEditBox'DA2.da_GUI_Tab_GameSettings.OnlineStatsPW'

     FadeInTime=0.000000
     WinHeight=0.780000
     bStandardized=True
     StandardHeight=0.780000
}
