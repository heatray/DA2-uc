// ====================================================================
//  Class:  XInterface.UT2QuitPage
//  Parent: XInterface.GUIMultiComponent
//
//  <Enter a description here>
// ====================================================================

class da_GUI_QuitPage extends UT2K3GUIPage;


function bool InternalOnClick(GUIComponent Sender) {
	if (Sender==Controls[1]) {
		PlayerOwner().ConsoleCommand("exit");
	} else {
		Controller.CloseMenu(false);
	}
	
	return true;
}

function bool InternalOnPreDraw(canvas c) {
	GUIImage(Controls[0]).Image = class'da_GUI_Utilities'.static.getCorrectBackground(c);
	return false;
}

defaultproperties
{
     bRenderWorld=True
     bRequire640x480=False
     Begin Object Class=GUIImage Name=DialogBackground
         Image=Texture'DA2GUI.Dialog.window_1024x768'
         ImageStyle=ISTY_Stretched
         ImageRenderStyle=MSTY_Normal
         WinTop=0.375000
         WinLeft=0.200000
         WinWidth=0.600000
         WinHeight=0.250000
         bBoundToParent=True
         bScaleToParent=True
     End Object
     Controls(0)=GUIImage'DA2.da_GUI_QuitPage.DialogBackground'

     Begin Object Class=GUIButton Name=YesButton
         Caption="YES"
         StyleName="DA2Style_Button"
         WinTop=0.571000
         WinLeft=0.300000
         WinWidth=0.150000
         WinHeight=0.042000
         bBoundToParent=True
         OnClick=da_GUI_QuitPage.InternalOnClick
         OnKeyEvent=YesButton.InternalOnKeyEvent
     End Object
     Controls(1)=GUIButton'DA2.da_GUI_QuitPage.YesButton'

     Begin Object Class=GUIButton Name=NoButton
         Caption="NO"
         StyleName="DA2Style_Button"
         WinTop=0.571000
         WinLeft=0.550000
         WinWidth=0.150000
         WinHeight=0.042000
         bBoundToParent=True
         OnClick=da_GUI_QuitPage.InternalOnClick
         OnKeyEvent=NoButton.InternalOnKeyEvent
     End Object
     Controls(2)=GUIButton'DA2.da_GUI_QuitPage.NoButton'

     Begin Object Class=GUILabel Name=QuitDesc
         Caption="Are you sure you wish to quit?"
         TextAlign=TXTA_Center
         TextColor=(B=0,G=180,R=220)
         StyleName="DA2Style_BodyText"
         WinTop=0.460000
         WinLeft=0.200000
         WinWidth=0.600000
         WinHeight=32.000000
     End Object
     Controls(3)=GUILabel'DA2.da_GUI_QuitPage.QuitDesc'

     Begin Object Class=GUILabel Name=CCTitle
         Caption="CONFIRM QUIT"
         TextAlign=TXTA_Center
         FontScale=FNS_Large
         StyleName="DA2Style_DialogText"
         WinTop=0.393000
         WinLeft=0.200000
         WinWidth=0.600000
         WinHeight=0.039000
     End Object
     Controls(4)=GUILabel'DA2.da_GUI_QuitPage.CCTitle'

     WinHeight=1.000000
     OnPreDraw=da_GUI_QuitPage.InternalOnPreDraw
}
