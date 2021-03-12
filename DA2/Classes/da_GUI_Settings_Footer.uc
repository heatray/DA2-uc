// D:\mods\UT2004Script3339\GUI2K4\Classes\UT2K4Settings_Footer.uc
// D:\mods\UT2004Script3339\GUI2K4\Classes\ButtonFooter.uc

class da_GUI_Settings_Footer extends UT2K4Settings_Footer;

defaultproperties
{
     Begin Object Class=GUIButton Name=GameBackButton
         Caption="BACK"
         StyleName="DA2Style_Button"
         Hint="Return to Previous Menu"
         RenderWeight=2.000000
         TabOrder=1
         bBoundToParent=True
         OnClick=da_GUI_Settings_Footer.InternalOnClick
         OnKeyEvent=GameBackButton.InternalOnKeyEvent
     End Object
     b_Back=GUIButton'DA2.da_GUI_Settings_Footer.GameBackButton'

     Begin Object Class=GUIButton Name=DefaultB
         Caption="DEFAULTS"
         StyleName="DA2Style_Button"
         Hint="Reset all settings on this page to their default values"
         RenderWeight=2.000000
         TabOrder=0
         bBoundToParent=True
         OnClick=da_GUI_Settings_Footer.InternalOnClick
         OnKeyEvent=DefaultB.InternalOnKeyEvent
     End Object
     b_Defaults=GUIButton'DA2.da_GUI_Settings_Footer.DefaultB'

     ButtonHeight=0.042000
     Padding=1.000000
     Margin=0.020000
     Spacer=0.010000
     StyleName="DA2Style_Footer"
     WinHeight=0.064000
}
