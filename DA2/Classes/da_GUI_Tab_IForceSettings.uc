// D:\mods\UT2004Script3339\GUI2K4\Classes\UT2K4Tab_IForceSettings.uc
// D:\mods\UT2004Script3339\GUI2K4\Classes\Settings_Tabs.uc
// D:\mods\UT2004Script3339\GUI2K4\Classes\UT2K4TabPanel.uc

class da_GUI_Tab_IForceSettings extends UT2K4Tab_IForceSettings;

defaultproperties
{
     Begin Object Class=da_GUI_SectionBackground Name=InputBK1
         Caption="Options"
         WinTop=0.028176
         WinLeft=0.021641
         WinWidth=0.381328
         WinHeight=0.655039
         OnPreDraw=InputBK1.InternalPreDraw
     End Object
     i_BG1=da_GUI_SectionBackground'DA2.da_GUI_Tab_IForceSettings.InputBK1'

     Begin Object Class=da_GUI_SectionBackground Name=InputBK2
         Caption="TouchSense Force Feedback"
         WinTop=0.730000
         WinLeft=0.021641
         WinWidth=0.957500
         WinHeight=0.240977
         OnPreDraw=InputBK2.InternalPreDraw
     End Object
     i_BG2=da_GUI_SectionBackground'DA2.da_GUI_Tab_IForceSettings.InputBK2'

     Begin Object Class=da_GUI_SectionBackground Name=InputBK3
         Caption="Fine Tuning"
         WinTop=0.028176
         WinLeft=0.451289
         WinWidth=0.527812
         WinHeight=0.655039
         OnPreDraw=InputBK3.InternalPreDraw
     End Object
     i_BG3=da_GUI_SectionBackground'DA2.da_GUI_Tab_IForceSettings.InputBK3'

     Begin Object Class=da_GUI_moCheckBox Name=InputAutoSlope
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Auto Slope"
         OnCreateComponent=InputAutoSlope.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="When enabled, your view will automatically pitch up/down when on a slope."
         WinTop=0.105365
         WinLeft=0.060937
         WinWidth=0.300000
         WinHeight=0.040000
         TabOrder=2
         OnChange=da_GUI_Tab_IForceSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_IForceSettings.InternalOnLoadINI
     End Object
     ch_AutoSlope=da_GUI_moCheckBox'DA2.da_GUI_Tab_IForceSettings.InputAutoSlope'

     Begin Object Class=da_GUI_moCheckBox Name=InputInvertMouse
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Invert Mouse"
         OnCreateComponent=InputInvertMouse.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="When enabled, the Y axis of your mouse will be inverted."
         WinTop=0.188698
         WinLeft=0.060938
         WinWidth=0.300000
         WinHeight=0.040000
         TabOrder=3
         OnChange=da_GUI_Tab_IForceSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_IForceSettings.InternalOnLoadINI
     End Object
     ch_InvertMouse=da_GUI_moCheckBox'DA2.da_GUI_Tab_IForceSettings.InputInvertMouse'

     Begin Object Class=da_GUI_moCheckBox Name=InputMouseSmoothing
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Mouse Smoothing"
         OnCreateComponent=InputMouseSmoothing.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Enable this option to automatically smooth out movements in your mouse."
         WinTop=0.324167
         WinLeft=0.060938
         WinWidth=0.300000
         WinHeight=0.040000
         TabOrder=4
         OnChange=da_GUI_Tab_IForceSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_IForceSettings.InternalOnLoadINI
     End Object
     ch_MouseSmoothing=da_GUI_moCheckBox'DA2.da_GUI_Tab_IForceSettings.InputMouseSmoothing'

     Begin Object Class=da_GUI_moCheckBox Name=InputUseJoystick
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Enable Joystick"
         OnCreateComponent=InputUseJoystick.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Enable this option to enable joystick support."
         WinTop=0.582083
         WinLeft=0.060938
         WinWidth=0.300000
         WinHeight=0.040000
         TabOrder=6
         OnChange=da_GUI_Tab_IForceSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_IForceSettings.InternalOnLoadINI
     End Object
     ch_Joystick=da_GUI_moCheckBox'DA2.da_GUI_Tab_IForceSettings.InputUseJoystick'

     Begin Object Class=da_GUI_moCheckBox Name=InputIFWeaponEffects
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Weapon Effects"
         OnCreateComponent=InputIFWeaponEffects.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Turn this option On/Off to feel the weapons you fire."
         WinTop=0.815333
         WinLeft=0.100000
         WinWidth=0.300000
         WinHeight=0.040000
         TabOrder=12
         OnChange=da_GUI_Tab_IForceSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_IForceSettings.InternalOnLoadINI
     End Object
     ch_WeaponEffects=da_GUI_moCheckBox'DA2.da_GUI_Tab_IForceSettings.InputIFWeaponEffects'

     Begin Object Class=da_GUI_moCheckBox Name=InputIFPickupEffects
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Pickup Effects"
         OnCreateComponent=InputIFPickupEffects.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Turn this option On/Off to feel the items you pick up."
         WinTop=0.906333
         WinLeft=0.100000
         WinWidth=0.300000
         WinHeight=0.040000
         TabOrder=13
         OnChange=da_GUI_Tab_IForceSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_IForceSettings.InternalOnLoadINI
     End Object
     ch_PickupEffects=da_GUI_moCheckBox'DA2.da_GUI_Tab_IForceSettings.InputIFPickupEffects'

     Begin Object Class=da_GUI_moCheckBox Name=InputIFDamageEffects
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Damage Effects"
         OnCreateComponent=InputIFDamageEffects.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Turn this option On/Off to feel the damage you take."
         WinTop=0.815333
         WinLeft=0.563867
         WinWidth=0.300000
         WinHeight=0.040000
         TabOrder=14
         OnChange=da_GUI_Tab_IForceSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_IForceSettings.InternalOnLoadINI
     End Object
     ch_DamageEffects=da_GUI_moCheckBox'DA2.da_GUI_Tab_IForceSettings.InputIFDamageEffects'

     Begin Object Class=da_GUI_moCheckBox Name=InputIFGUIEffects
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Vehicle Effects"
         OnCreateComponent=InputIFGUIEffects.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Turn this option On/Off to feel the vehicle effects."
         WinTop=0.906333
         WinLeft=0.563867
         WinWidth=0.300000
         WinHeight=0.040000
         TabOrder=15
         OnChange=da_GUI_Tab_IForceSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_IForceSettings.InternalOnLoadINI
     End Object
     ch_GUIEffects=da_GUI_moCheckBox'DA2.da_GUI_Tab_IForceSettings.InputIFGUIEffects'

     Begin Object Class=da_GUI_moCheckBox Name=InputMouseLag
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Reduce Mouse Lag"
         OnCreateComponent=InputMouseLag.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Enable this option will reduce the amount of lag in your mouse."
         WinTop=0.405000
         WinLeft=0.060938
         WinWidth=0.300000
         WinHeight=0.040000
         TabOrder=5
         OnChange=da_GUI_Tab_IForceSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_IForceSettings.InternalOnLoadINI
     End Object
     ch_MouseLag=da_GUI_moCheckBox'DA2.da_GUI_Tab_IForceSettings.InputMouseLag'

     Begin Object Class=da_GUI_moFloatEdit Name=InputMouseSensitivity
         MinValue=0.250000
         MaxValue=25.000000
         Step=0.250000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.725000
         Caption="Mouse Sensitivity (Game)"
         OnCreateComponent=InputMouseSensitivity.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Adjust mouse sensitivity"
         WinTop=0.105365
         WinLeft=0.502344
         WinWidth=0.421680
         WinHeight=0.045352
         TabOrder=7
         OnChange=da_GUI_Tab_IForceSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_IForceSettings.InternalOnLoadINI
     End Object
     fl_Sensitivity=da_GUI_moFloatEdit'DA2.da_GUI_Tab_IForceSettings.InputMouseSensitivity'

     Begin Object Class=da_GUI_moFloatEdit Name=InputMenuSensitivity
         MinValue=1.000000
         MaxValue=6.000000
         Step=0.250000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.725000
         Caption="Mouse Sensitivity (Menus)"
         OnCreateComponent=InputMenuSensitivity.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Adjust mouse speed within the menus"
         WinTop=0.188698
         WinLeft=0.502344
         WinWidth=0.421875
         WinHeight=0.045352
         TabOrder=8
         OnChange=da_GUI_Tab_IForceSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_IForceSettings.InternalOnLoadINI
     End Object
     fl_MenuSensitivity=da_GUI_moFloatEdit'DA2.da_GUI_Tab_IForceSettings.InputMenuSensitivity'

     Begin Object Class=da_GUI_moFloatEdit Name=InputMouseAccel
         MinValue=0.000000
         MaxValue=100.000000
         Step=5.000000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.725000
         Caption="Mouse Accel. Threshold"
         OnCreateComponent=InputMouseAccel.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Adjust to determine the amount of movement needed before acceleration is applied"
         WinTop=0.405000
         WinLeft=0.502344
         WinWidth=0.421875
         WinHeight=0.045352
         TabOrder=10
         OnChange=da_GUI_Tab_IForceSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_IForceSettings.InternalOnLoadINI
     End Object
     fl_MouseAccel=da_GUI_moFloatEdit'DA2.da_GUI_Tab_IForceSettings.InputMouseAccel'

     Begin Object Class=da_GUI_moFloatEdit Name=InputMouseSmoothStr
         MinValue=0.000000
         MaxValue=1.000000
         Step=0.050000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.725000
         Caption="Mouse Smoothing Strength"
         OnCreateComponent=InputMouseSmoothStr.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Adjust the amount of smoothing that is applied to mouse movements"
         WinTop=0.324167
         WinLeft=0.502344
         WinWidth=0.421875
         WinHeight=0.045352
         TabOrder=9
         OnChange=da_GUI_Tab_IForceSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_IForceSettings.InternalOnLoadINI
     End Object
     fl_SmoothingStrength=da_GUI_moFloatEdit'DA2.da_GUI_Tab_IForceSettings.InputMouseSmoothStr'

     Begin Object Class=da_GUI_moFloatEdit Name=InputDodgeTime
         MinValue=0.000000
         MaxValue=1.000000
         Step=0.050000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.725000
         Caption="Dodge Double-Click Time"
         OnCreateComponent=InputDodgeTime.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Determines how fast you have to double click to dodge"
         WinTop=0.582083
         WinLeft=0.502344
         WinWidth=0.421875
         WinHeight=0.045352
         TabOrder=11
         OnChange=da_GUI_Tab_IForceSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_IForceSettings.InternalOnLoadINI
     End Object
     fl_DodgeTime=da_GUI_moFloatEdit'DA2.da_GUI_Tab_IForceSettings.InputDodgeTime'

     Begin Object Class=da_GUI_Button Name=ControlBindButton
         Caption="Configure Controls"
         SizingCaption="XXXXXXXXXX"
         Hint="Configure controls and keybinds"
         WinTop=0.018333
         WinLeft=0.130000
         WinWidth=0.153281
         WinHeight=0.043750
         TabOrder=0
         OnClick=da_GUI_Tab_IForceSettings.InternalOnClick
         OnKeyEvent=ControlBindButton.InternalOnKeyEvent
     End Object
     b_Controls=da_GUI_Button'DA2.da_GUI_Tab_IForceSettings.ControlBindButton'

     Begin Object Class=da_GUI_Button Name=SpeechBindButton
         Caption="Speech Binder"
         SizingCaption="XXXXXXXXXX"
         Hint="Configure custom keybinds for in-game messages"
         WinTop=0.018333
         WinLeft=0.670000
         WinWidth=0.153281
         WinHeight=0.043750
         TabOrder=1
         OnClick=da_GUI_Tab_IForceSettings.InternalOnClick
         OnKeyEvent=SpeechBindButton.InternalOnKeyEvent
     End Object
     b_Speech=da_GUI_Button'DA2.da_GUI_Tab_IForceSettings.SpeechBindButton'

     ControlBindMenu="DA2.da_GUI_ControlBinder"
     SpeechBindMenu="DA2.da_GUI_SpeechBinder"
     FadeInTime=0.000000
     WinHeight=0.780000
     bStandardized=True
     StandardHeight=0.780000
}
