// D:\mods\UT2004Script3339\GUI2K4\Classes\UT2K4VideoChangeOK.uc
// D:\mods\UT2004Script3339\GUI2K4\Classes\UT2K4GenericMessageBox.uc

class da_GUI_VideoChangeOk extends UT2K4VideoChangeOK;

function bool InternalOnPreDraw(canvas c) {
	local bool b;

	i_FrameBG.Image = class'da_GUI_Utilities'.static.getCorrectBackground(c);
	b = Super.InternalOnPreDraw(c);

	// Damn predraw redrawing
	
	b_Ok.WinWidth=0.15;
	b_Ok.WinHeight=0.042;
	b_Ok.WinLeft=0.3;
	b_Ok.WinTop=0.571;

	b_Cancel.WinWidth=0.15;
	b_Cancel.WinHeight=0.042;
	b_Cancel.WinLeft=0.55;
	b_Cancel.WinTop=0.571;

	return b;
}

defaultproperties
{
     RestoreText="Keep these settings? (Original settings will be restored in %count% %seconds%)"
     Begin Object Class=da_GUI_Button Name=bCancel
         Caption="Restore Settings"
         WinTop=0.558334
         WinLeft=0.650000
         WinWidth=0.200000
         bBoundToParent=True
         OnClick=da_GUI_VideoChangeOk.InternalOnClick
         OnKeyEvent=bCancel.InternalOnKeyEvent
     End Object
     b_Cancel=da_GUI_Button'DA2.da_GUI_VideoChangeOk.bCancel'

     Begin Object Class=da_GUI_Button Name=bOk
         Caption="Keep Settings"
         WinTop=0.558334
         WinLeft=0.175000
         WinWidth=0.200000
         bBoundToParent=True
         OnClick=da_GUI_VideoChangeOk.InternalOnClick
         OnKeyEvent=bOk.InternalOnKeyEvent
     End Object
     b_OK=da_GUI_Button'DA2.da_GUI_VideoChangeOk.bOk'

     Begin Object Class=GUILabel Name=IPDesc
         Caption="APPLY SETTINGS"
         TextAlign=TXTA_Center
         FontScale=FNS_Large
         StyleName="DA2Style_DialogText"
         WinTop=0.393000
         WinLeft=0.200000
         WinWidth=0.600000
         WinHeight=0.039000
     End Object
     l_Text=GUILabel'DA2.da_GUI_VideoChangeOk.IPDesc'

     Begin Object Class=GUILabel Name=lbText2
         Caption="Keep these settings? (Original settings will be restored in 15 seconds)"
         TextAlign=TXTA_Center
         StyleName="DA2Style_BodyText"
         WinTop=0.470000
         WinLeft=0.200000
         WinWidth=0.600000
         WinHeight=0.050000
     End Object
     l_Text2=GUILabel'DA2.da_GUI_VideoChangeOk.lbText2'

     Begin Object Class=FloatingImage Name=MessageWindowFrameBackground
         Image=Texture'DA2GUI.Dialog.window_1024x768'
         DropShadowX=0
         DropShadowY=0
         WinLeft=0.200000
         WinWidth=0.600000
         WinHeight=0.250000
     End Object
     i_FrameBG=FloatingImage'DA2.da_GUI_VideoChangeOk.MessageWindowFrameBackground'

     WinTop=0.000000
     WinHeight=1.000000
}
