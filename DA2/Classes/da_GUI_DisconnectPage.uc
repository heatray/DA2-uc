class da_GUI_DisconnectPage extends KFDisconnectPage;


function bool InternalOnClick(GUIComponent Sender)
{
	if ( Sender==Controls[1] ) // OK
    {
		Controller.OpenMenu("da2.da_gui_mainMenu");
	}

	return true;
}

defaultproperties
{
     Begin Object Class=da_GUI_Button Name=NetStatBackground
         WinTop=0.375000
         WinHeight=0.250000
         bAcceptsInput=False
         bNeverFocus=True
         OnKeyEvent=NetStatBackground.InternalOnKeyEvent
     End Object
     Controls(0)=da_GUI_Button'DA2.da_GUI_DisconnectPage.NetStatBackground'

     Begin Object Class=da_GUI_Button Name=NetStatOk
         Caption="OK"
         StyleName="MidGameButton"
         WinTop=0.675000
         WinLeft=0.375000
         WinWidth=0.250000
         WinHeight=0.050000
         bBoundToParent=True
         OnClick=da_GUI_DisconnectPage.InternalOnClick
         OnKeyEvent=NetStatOk.InternalOnKeyEvent
     End Object
     Controls(1)=da_GUI_Button'DA2.da_GUI_DisconnectPage.NetStatOk'

     Begin Object Class=GUILabel Name=NetStatLabel
         TextAlign=TXTA_Center
         TextColor=(B=255,G=255,R=255)
         TextFont="UT2HeaderFont"
         bMultiLine=True
         WinTop=0.125000
         WinHeight=0.500000
         bBoundToParent=True
     End Object
     Controls(2)=GUILabel'DA2.da_GUI_DisconnectPage.NetStatLabel'

}
