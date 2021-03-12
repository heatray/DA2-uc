// D:\mods\UT2004Script3339\GUI2K4\Classes\MaplistEditor.uc

class da_GUI_MaplistEditor extends MaplistEditor;

function bool InternalOnPreDraw(canvas c) {
	i_FrameBG.Image = class'da_GUI_Utilities'.static.getCorrectBackground(c);
	Super.InternalOnPreDraw(c);
	return false;
}

function bool ButtonPreDraw(Canvas C) {
	Super.ButtonPreDraw(C);

	/*
	local float X,W,BW,L;

	W = sb_MapList.ActualWidth() - sb_MapList.ImageOffset[0] - sb_MapList.ImageOffset[2];
	X = W - sb_MapList.ImageOffset[2];

	BW = b_New.ActualWidth() + b_Rename.ActualWidth() + b_Delete.ActualWidth() + 6;

	L = X - BW;
	b_New.WinLeft=L;
	L+= b_New.ActualWidth()+3;
	b_Rename.WinLeft=L;
	L+= b_Rename.ActualWidth()+3;
	b_Delete.WinLeft=L;
	*/

    b_New.WinTop=0.193000 - 0.005; // adjustments...
    b_Rename.WinTop=0.193000 - 0.005;
    b_Delete.WinTop=0.193000 - 0.005;

	co_MapList.WinLeft = 0.05; //sb_MapList.ActualLeft() + sb_MapList.ImageOffset[0];
	co_MapList.WinTop=0.193000;
	co_MapList.WinWidth=0.48; //0.802485;

	b_New.WinLeft = 0.54 + 0.01;
	b_Rename.WinLeft = b_New.WinLeft + 0.13 + 0.005;
	b_Delete.WinLeft = b_Rename.WinLeft + 0.13 + 0.005;

	return false;
}

// START =============================================================
// Comes from da_GUI_FloatingWindow ----------------------------------

function AddSystemMenu() {
	local eFontScale tFontScale;

	b_ExitButton = GUIButton(t_WindowTitle.AddComponent("DA2.da_GUI_Button"));
	b_ExitButton.Style = Controller.GetStyle("DA2Style_CloseButton",tFontScale);
	b_ExitButton.OnClick = XButtonClicked;
	b_ExitButton.bNeverFocus=true;
	b_ExitButton.FocusInstead = t_WindowTitle;
	b_ExitButton.RenderWeight=1;
	b_ExitButton.bScaleToParent=false;
	b_ExitButton.OnPreDraw = SystemMenuPreDraw;

	// Do not want OnClick() called from MousePressed()
	b_ExitButton.bRepeatClick = False;

//	t_WindowTitle.
}

// END ===============================================================

defaultproperties
{
     Begin Object Class=da_GUI_TreeListBox Name=ActiveMaps
         bVisibleWhenEmpty=True
         OnCreateComponent=ActiveMaps.InternalOnCreateComponent
         WinTop=0.108021
         WinLeft=0.605861
         WinWidth=0.368359
         TabOrder=7
     End Object
     lb_ActiveMaps=da_GUI_TreeListBox'DA2.da_GUI_MaplistEditor.ActiveMaps'

     Begin Object Class=da_GUI_TreeListBox Name=InactiveMaps
         bVisibleWhenEmpty=True
         bSorted=True
         OnCreateComponent=InactiveMaps.InternalOnCreateComponent
         WinTop=0.138078
         WinLeft=0.113794
         WinWidth=0.380394
         WinHeight=0.662671
         TabOrder=4
     End Object
     lb_AllMaps=da_GUI_TreeListBox'DA2.da_GUI_MaplistEditor.InactiveMaps'

     Begin Object Class=da_GUI_Button Name=AddButton
         Caption="> Add >"
         Hint="Add the selected maps to your map list"
         WinTop=0.850000
         WinLeft=0.263743
         WinWidth=0.203807
         WinHeight=0.056312
         TabOrder=6
         bScaleToParent=True
         bRepeatClick=True
         OnClickSound=CS_Up
         OnClick=da_GUI_MaplistEditor.ModifyMapList
         OnKeyEvent=AddButton.InternalOnKeyEvent
     End Object
     b_Add=da_GUI_Button'DA2.da_GUI_MaplistEditor.AddButton'

     Begin Object Class=da_GUI_Button Name=AddAllButton
         Caption=">>> Add All >>>"
         Hint="Add all maps to your map list"
         WinTop=0.850000
         WinLeft=0.045006
         WinWidth=0.190232
         WinHeight=0.056312
         TabOrder=5
         bScaleToParent=True
         OnClickSound=CS_Up
         OnClick=da_GUI_MaplistEditor.ModifyMapList
         OnKeyEvent=AddAllButton.InternalOnKeyEvent
     End Object
     b_AddAll=da_GUI_Button'DA2.da_GUI_MaplistEditor.AddAllButton'

     Begin Object Class=da_GUI_Button Name=RemoveButton
         Caption="< Remove <"
         AutoSizePadding=(HorzPerc=0.500000)
         Hint="Remove the selected maps from your map list"
         WinTop=0.850000
         WinLeft=0.543747
         WinWidth=0.191554
         WinHeight=0.056312
         TabOrder=10
         bScaleToParent=True
         bRepeatClick=True
         OnClickSound=CS_Down
         OnClick=da_GUI_MaplistEditor.ModifyMapList
         OnKeyEvent=RemoveButton.InternalOnKeyEvent
     End Object
     b_Remove=da_GUI_Button'DA2.da_GUI_MaplistEditor.RemoveButton'

     Begin Object Class=da_GUI_Button Name=RemoveAllButton
         Caption="<<< Remove All <<<"
         Hint="Remove all maps from your map list"
         WinTop=0.850000
         WinLeft=0.772577
         WinWidth=0.191554
         WinHeight=0.056312
         TabOrder=11
         bScaleToParent=True
         OnClickSound=CS_Down
         OnClick=da_GUI_MaplistEditor.ModifyMapList
         OnKeyEvent=RemoveAllButton.InternalOnKeyEvent
     End Object
     b_RemoveAll=da_GUI_Button'DA2.da_GUI_MaplistEditor.RemoveAllButton'

     Begin Object Class=da_GUI_Button Name=MoveUpButton
         Caption="Up"
         Hint="Move this map higher up in the list"
         WinTop=0.770000
         WinLeft=0.772577
         WinWidth=0.191554
         WinHeight=0.056312
         TabOrder=9
         bScaleToParent=True
         bRepeatClick=True
         OnClickSound=CS_Up
         OnClick=da_GUI_MaplistEditor.ModifyMapList
         OnKeyEvent=MoveUpButton.InternalOnKeyEvent
     End Object
     b_MoveUp=da_GUI_Button'DA2.da_GUI_MaplistEditor.MoveUpButton'

     Begin Object Class=da_GUI_Button Name=MoveDownButton
         Caption="Down"
         Hint="Move this map lower down in the list"
         WinTop=0.770000
         WinLeft=0.543747
         WinWidth=0.191554
         WinHeight=0.056312
         TabOrder=8
         bScaleToParent=True
         bRepeatClick=True
         OnClickSound=CS_Down
         OnClick=da_GUI_MaplistEditor.ModifyMapList
         OnKeyEvent=MoveDownButton.InternalOnKeyEvent
     End Object
     b_MoveDown=da_GUI_Button'DA2.da_GUI_MaplistEditor.MoveDownButton'

     Begin Object Class=da_GUI_Button Name=NewMaplistButton
         Caption="NEW"
         Hint="Create a new custom maplist"
         WinWidth=0.130000
         WinHeight=0.057000
         TabOrder=1
         OnClick=da_GUI_MaplistEditor.CustomMaplistClick
         OnKeyEvent=NewMaplistButton.InternalOnKeyEvent
     End Object
     b_New=da_GUI_Button'DA2.da_GUI_MaplistEditor.NewMaplistButton'

     Begin Object Class=da_GUI_Button Name=DeleteMaplistButton
         Caption="DELETE"
         Hint="Delete the currently selected maplist.  If this is the last maplist for this gametype, a new default maplist will be generated."
         WinWidth=0.130000
         WinHeight=0.057000
         TabOrder=3
         OnPreDraw=da_GUI_MaplistEditor.ButtonPreDraw
         OnClick=da_GUI_MaplistEditor.CustomMaplistClick
         OnKeyEvent=DeleteMaplistButton.InternalOnKeyEvent
     End Object
     b_Delete=da_GUI_Button'DA2.da_GUI_MaplistEditor.DeleteMaplistButton'

     Begin Object Class=da_GUI_Button Name=RenameMaplistButton
         Caption="RENAME"
         Hint="Rename the currently selected maplist"
         WinWidth=0.130000
         WinHeight=0.057000
         TabOrder=2
         OnClick=da_GUI_MaplistEditor.CustomMaplistClick
         OnKeyEvent=RenameMaplistButton.InternalOnKeyEvent
     End Object
     b_Rename=da_GUI_Button'DA2.da_GUI_MaplistEditor.RenameMaplistButton'

     Begin Object Class=da_GUI_ComboBox Name=SelectMaplistCombo
         bReadOnly=True
         Hint="Load a existing custom maplist"
         WinTop=0.109808
         WinLeft=0.471550
         WinWidth=0.441384
         WinHeight=0.045083
         TabOrder=0
         OnChange=da_GUI_MaplistEditor.MaplistSelectChange
         OnKeyEvent=SelectMaplistCombo.InternalOnKeyEvent
     End Object
     co_Maplist=da_GUI_ComboBox'DA2.da_GUI_MaplistEditor.SelectMaplistCombo'

     Begin Object Class=da_GUI_AltSectionBackground Name=MapListSectionBackground
         Caption="Map Presets"
         WinTop=0.120000
         WinLeft=0.020000
         WinWidth=0.960000
         WinHeight=0.190000
         OnPreDraw=MapListSectionBackground.InternalPreDraw
     End Object
     sb_MapList=da_GUI_AltSectionBackground'DA2.da_GUI_MaplistEditor.MapListSectionBackground'

     Begin Object Class=da_GUI_SectionBackground Name=InactiveBackground
         bFillClient=True
         Caption="Inactive Maps"
         WinTop=0.330000
         WinLeft=0.020000
         WinWidth=0.470000
         WinHeight=0.500000
         bBoundToParent=True
         bScaleToParent=True
         OnPreDraw=InactiveBackground.InternalPreDraw
     End Object
     sb_Avail=da_GUI_SectionBackground'DA2.da_GUI_MaplistEditor.InactiveBackground'

     Begin Object Class=da_GUI_SectionBackground Name=ActiveBackground
         bFillClient=True
         Caption="Active Maps"
         WinTop=0.330000
         WinLeft=0.510000
         WinWidth=0.470000
         WinHeight=0.500000
         bBoundToParent=True
         bScaleToParent=True
         OnPreDraw=ActiveBackground.InternalPreDraw
     End Object
     sb_Active=da_GUI_SectionBackground'DA2.da_GUI_MaplistEditor.ActiveBackground'

     Begin Object Class=da_GUI_Header Name=TitleBar
         bUseTextHeight=True
         Caption="Defence Alliance 2"
         FontScale=FNS_Small
         WinTop=0.037000
         RenderWeight=0.100000
         bBoundToParent=True
         bScaleToParent=True
         bAcceptsInput=True
         bNeverFocus=False
         ScalingType=SCALE_X
         OnMousePressed=da_GUI_MaplistEditor.FloatingMousePressed
         OnMouseRelease=da_GUI_MaplistEditor.FloatingMouseRelease
     End Object
     t_WindowTitle=da_GUI_Header'DA2.da_GUI_MaplistEditor.TitleBar'

     Begin Object Class=FloatingImage Name=FFrameBackground
         Image=Texture'DA2GUI.Dialog.window_1024x768'
         DropShadow=None
         ImageStyle=ISTY_Stretched
         ImageRenderStyle=MSTY_Normal
         WinTop=0.000000
         WinLeft=0.000000
         WinWidth=1.000000
         WinHeight=1.000000
         RenderWeight=0.000003
     End Object
     i_FrameBG=FloatingImage'DA2.da_GUI_MaplistEditor.FFrameBackground'

}
