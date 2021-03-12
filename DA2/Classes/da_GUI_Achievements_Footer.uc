class da_GUI_Achievements_Footer extends ButtonFooter;

var automated GUIButton b_Back;

function bool InternalOnClick(GUIComponent Sender)
{
	if (Sender == b_Back )
	{
		Controller.CloseMenu(true);
		return true;
	}
}

defaultproperties
{
     Begin Object Class=GUIButton Name=BackButton
         Caption="BACK"
         StyleName="DA2Style_Button"
         Hint="Return to Previous Menu"
         WinTop=0.966146
         WinWidth=0.120000
         WinHeight=0.033203
         RenderWeight=2.000000
         TabOrder=1
         bBoundToParent=True
         OnClick=da_GUI_Achievements_Footer.InternalOnClick
         OnKeyEvent=BackButton.InternalOnKeyEvent
     End Object
     b_Back=GUIButton'DA2.da_GUI_Achievements_Footer.BackButton'

     ButtonHeight=0.042000
     Padding=1.000000
     Margin=0.020000
     Spacer=0.010000
     bAutoSize=False
     StyleName="DA2Style_Footer"
     WinHeight=0.064000
}
