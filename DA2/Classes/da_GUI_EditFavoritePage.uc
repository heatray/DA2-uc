// D:\mods\UT2004Script3339\GUI2K4\Classes\EditFavoritePage.uc
// D:\mods\UT2004Script3339\GUI2K4\Classes\UT2K4Browser_OpenIP.uc
// D:\mods\UT2004Script3339\GUI2K4\Classes\UT2K4GetDataMenu.uc
// D:\mods\UT2004Script3339\GUI2K4\Classes\UT2K4GenericMessageBox.uc
// D:\mods\UT2004Script3339\GUI2K4\Classes\MessageWindow.uc

class da_GUI_EditFavoritePage extends EditFavoritePage;

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
     Begin Object Class=GUILabel Name=ServerName
         TextAlign=TXTA_Center
         StyleName="DA2Style_BodyText"
         WinTop=0.456000
         WinLeft=0.200000
         WinWidth=0.600000
         WinHeight=0.050000
     End Object
     l_name=GUILabel'DA2.da_GUI_EditFavoritePage.ServerName'

     Begin Object Class=da_GUI_Button Name=CancelButton
         Caption="CANCEL"
         WinTop=0.571000
         WinLeft=0.550000
         WinWidth=0.150000
         WinHeight=0.042000
         bBoundToParent=True
         OnClick=da_GUI_EditFavoritePage.InternalOnClick
         OnKeyEvent=CancelButton.InternalOnKeyEvent
     End Object
     b_Cancel=da_GUI_Button'DA2.da_GUI_EditFavoritePage.CancelButton'

     Begin Object Class=da_GUI_moEditBox Name=IpEntryBox
         LabelJustification=TXTA_Right
         CaptionWidth=0.550000
         Caption="IP Address: "
         OnCreateComponent=IpEntryBox.InternalOnCreateComponent
         WinTop=0.505000
         WinLeft=0.160000
         WinHeight=0.040000
         TabOrder=0
     End Object
     ed_Data=da_GUI_moEditBox'DA2.da_GUI_EditFavoritePage.IpEntryBox'

     Begin Object Class=da_GUI_Button Name=OkButton
         Caption="OK"
         WinTop=0.571000
         WinLeft=0.300000
         WinWidth=0.150000
         WinHeight=0.042000
         bBoundToParent=True
         OnClick=da_GUI_EditFavoritePage.InternalOnClick
         OnKeyEvent=OkButton.InternalOnKeyEvent
     End Object
     b_OK=da_GUI_Button'DA2.da_GUI_EditFavoritePage.OkButton'

     Begin Object Class=GUILabel Name=IPDesc
         Caption="SET IP ADDRESS"
         TextAlign=TXTA_Center
         FontScale=FNS_Large
         StyleName="DA2Style_DialogText"
         WinTop=0.393000
         WinLeft=0.200000
         WinWidth=0.600000
         WinHeight=0.039000
     End Object
     l_Text=GUILabel'DA2.da_GUI_EditFavoritePage.IPDesc'

     Begin Object Class=FloatingImage Name=MessageWindowFrameBackground
         Image=Texture'DA2GUI.Dialog.window_1024x768'
         DropShadowX=0
         DropShadowY=0
         WinLeft=0.200000
         WinWidth=0.600000
         WinHeight=0.250000
     End Object
     i_FrameBG=FloatingImage'DA2.da_GUI_EditFavoritePage.MessageWindowFrameBackground'

     WinTop=0.000000
     WinHeight=1.000000
}
