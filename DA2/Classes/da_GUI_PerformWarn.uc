class da_GUI_PerformWarn extends UT2K4PerformWarn;

defaultproperties
{
     Begin Object Class=da_GUI_moCheckBox Name=HideCheckbox
         bFlipped=True
         ComponentJustification=TXTA_Left
         CaptionWidth=0.930000
         ComponentWidth=0.070000
         Caption="  do not display this warning again"
         OnCreateComponent=HideCheckbox.InternalOnCreateComponent
         FontScale=FNS_Small
         IniOption="@Internal"
         Hint="Check this to disable showing warning messages when adjusting properties in the Settings menu"
         WinTop=0.499479
         WinLeft=0.312500
         WinWidth=0.370000
         TabOrder=1
         OnChange=da_GUI_PerformWarn.CheckBoxClick
         OnLoadINI=da_GUI_PerformWarn.InternalOnLoadINI
     End Object
     ch_NeverShowAgain=da_GUI_moCheckBox'DA2.da_GUI_PerformWarn.HideCheckbox'

     Begin Object Class=da_GUI_Button Name=OkButton
         Caption="OK"
         WinTop=0.550000
         WinLeft=0.439063
         WinWidth=0.121875
         TabOrder=0
         OnClick=da_GUI_PerformWarn.InternalOnClick
         OnKeyEvent=OkButton.InternalOnKeyEvent
     End Object
     b_OK=da_GUI_Button'DA2.da_GUI_PerformWarn.OkButton'

     Begin Object Class=FloatingImage Name=MessageWindowFrameBackground
         Image=Texture'DA2GUI.Dialog.window_1024x768'
         DropShadowX=0
         DropShadowY=0
         WinTop=0.077193
         WinLeft=0.155952
         WinWidth=0.700000
         WinHeight=0.700000
     End Object
     i_FrameBG=FloatingImage'DA2.da_GUI_PerformWarn.MessageWindowFrameBackground'

}
