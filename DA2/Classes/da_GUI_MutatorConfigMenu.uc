class da_GUI_MutatorConfigMenu extends MutatorConfigMenu;

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
	b_ExitButton.bRepeatClick = False;
}

function GUIMenuOption AddRule(PlayInfo.PlayInfoData NewRule)
{
  local bool bTemp;
  local string    Width, Op;
  local array<string>  Range;
  local GUIMenuOption NewComp;
  local int      i, pos;

  bTemp = Controller.bCurMenuInitialized;
  Controller.bCurMenuInitialized = False;

  switch (NewRule.RenderType)
  {
    case PIT_Check:
      NewComp = li_Config.AddItem("DA2.da_GUI_moCheckbox",,NewRule.DisplayName);
      if (NewComp == None)
        break;

      NewComp.bAutoSizeCaption = True;
      break;

    case PIT_Select:
      NewComp = li_Config.AddItem("DA2.da_GUI_moComboBox",,NewRule.DisplayName);
      if (NewComp == None)
        break;

      moCombobox(NewComp).ReadOnly(True);
      NewComp.bAutoSizeCaption = True;

      Split(NewRule.Data, ";", Range);
      for (i = 0; i+1 < Range.Length; i += 2)
        moComboBox(NewComp).AddItem(Range[i+1],,Range[i]);

      break;

    case PIT_Text:
      if ( !Divide(NewRule.Data, ";", Width, Op) )
        Width = NewRule.Data;

      pos = InStr(Width, ",");
      if (pos != -1)
        Width = Left(Width, pos);

      if (Width != "")
        i = int(Width);
      else i = -1;
      Split(Op, ":", Range);
      if (Range.Length > 1)
      {
        // Ranged data
        if (InStr(Range[0], ".") != -1)
        {
          // float edit
          NewComp = li_Config.AddItem("DA2.da_GUI_moFloatEdit",,NewRule.DisplayName);
          if (NewComp == None) break;

          NewComp.bAutoSizeCaption = True;
          NewComp.ComponentWidth = 0.25;
          if (i != -1)
            moFloatEdit(NewComp).Setup( float(Range[0]), float(Range[1]), moFloatEdit(NewComp).MyNumericEdit.Step );
        }

        else
        {
          NewComp = li_Config.AddItem("DA2.da_GUI_moNumericEdit",,NewRule.DisplayName);
          if (NewComp == None) break;

          moNumericEdit(NewComp).bAutoSizeCaption = True;
          NewComp.ComponentWidth = 0.25;
          if (i != -1)
            moNumericEdit(NewComp).Setup( int(Range[0]), int(Range[1]), moNumericEdit(NewComp).MyNumericEdit.Step);
        }
      }
      else if (NewRule.ArrayDim != -1)
      {
        NewComp = li_Config.AddItem("DA2.da_GUI_moButton",,NewRule.DisplayName);
        if (NewComp == None) break;

        NewComp.bAutoSizeCaption = True;
        NewComp.ComponentWidth = 0.25;
        NewComp.OnChange = ArrayPropClicked;
      }

      else
      {
        NewComp = li_Config.AddItem("DA2.da_GUI_moEditBox",,NewRule.DisplayName);
        if (NewComp == None) break;

        NewComp.bAutoSizeCaption = True;
        if (i != -1)
          moEditbox(NewComp).MyEditBox.MaxWidth = i;
      }
      break;
  }

  NewComp.SetHint(NewRule.Description);
  Controller.bCurMenuInitialized = bTemp;
  return NewComp;
}

function ArrayPropClicked(GUIComponent Sender)
{
  local int i;
  local GUIArrayPropPage ArrayPage;
  local string ArrayMenu;

  i = Sender.Tag;
  if (i < 0)
    return;

  if (MutInfo.Settings[i].ArrayDim > 1)
    ArrayMenu = Controller.ArrayPropertyMenu;
  else
    ArrayMenu = Controller.DynArrayPropertyMenu;

  if (Controller.OpenMenu(ArrayMenu, MutInfo.Settings[i].DisplayName, MutInfo.Settings[i].Value))
  {
    ArrayPage = GUIArrayPropPage(Controller.ActivePage);
    ArrayPage.Item = MutInfo.Settings[i];
    ArrayPage.OnClose = ArrayPageClosed;
    ArrayPage.SetOwner(Sender);
  }
}

function ArrayPageClosed(optional bool bCancelled)
{
  local GUIArrayPropPage ArrayPage;
  local GUIComponent CompOwner;

  if (!bCancelled)
  {
    ArrayPage = GUIArrayPropPage(Controller.ActivePage);
    if (ArrayPage != None)
    {
      CompOwner = ArrayPage.GetOwner();
      if (moButton(CompOwner) != None)
      {
        moButton(CompOwner).SetComponentValue(ArrayPage.GetDataString(), true);
        InternalOnChange(CompOwner);
      }
    }
  }
}

function InternalOnChange(GUIComponent Sender)
{
    if (Sender == ch_Advanced)
    {
    	// Save our preference
        Controller.bExpertMode = ch_Advanced.IsChecked();
        Controller.SaveConfig();
        return;
    }
    else
    {
    	super.InternalOnChange(Sender);
    }
}

defaultproperties
{
     Begin Object Class=da_GUI_MultiOptionListBox Name=ConfigList
         bVisibleWhenEmpty=True
         OnCreateComponent=da_GUI_MutatorConfigMenu.InternalOnCreateComponent
         WinTop=0.143333
         WinLeft=0.037500
         WinWidth=0.918753
         WinHeight=0.697502
         RenderWeight=0.900000
         TabOrder=1
         bBoundToParent=True
         bScaleToParent=True
         OnChange=da_GUI_MutatorConfigMenu.InternalOnChange
     End Object
     lb_Config=da_GUI_MultiOptionListBox'DA2.da_GUI_MutatorConfigMenu.ConfigList'

     Begin Object Class=da_GUI_moCheckBox Name=AdvancedButton
         Caption="View Advanced Options"
         OnCreateComponent=AdvancedButton.InternalOnCreateComponent
         Hint="Toggles whether advanced properties are displayed"
         WinTop=0.911982
         WinLeft=0.037500
         WinWidth=0.310000
         WinHeight=0.040000
         RenderWeight=1.000000
         TabOrder=1
         bBoundToParent=True
         OnChange=da_GUI_MutatorConfigMenu.InternalOnChange
     End Object
     ch_Advanced=da_GUI_moCheckBox'DA2.da_GUI_MutatorConfigMenu.AdvancedButton'

     Begin Object Class=da_GUI_AltSectionBackground Name=InternalFrameImage
         WinTop=0.177500
         WinLeft=0.040000
         WinWidth=0.675859
         WinHeight=0.490000
         OnPreDraw=InternalFrameImage.InternalPreDraw
     End Object
     sb_Main=da_GUI_AltSectionBackground'DA2.da_GUI_MutatorConfigMenu.InternalFrameImage'

     Begin Object Class=da_GUI_Button Name=LockedCancelButton
         Caption="Cancel"
         bAutoShrink=False
         WinTop=0.872397
         WinLeft=0.512695
         WinWidth=0.159649
         TabOrder=99
         bBoundToParent=True
         OnClick=da_GUI_MutatorConfigMenu.InternalOnClick
         OnKeyEvent=LockedCancelButton.InternalOnKeyEvent
     End Object
     b_Cancel=da_GUI_Button'DA2.da_GUI_MutatorConfigMenu.LockedCancelButton'

     Begin Object Class=da_GUI_Button Name=LockedOKButton
         Caption="OK"
         bAutoShrink=False
         WinTop=0.872397
         WinLeft=0.742188
         WinWidth=0.159649
         TabOrder=100
         bBoundToParent=True
         OnClick=da_GUI_MutatorConfigMenu.InternalOnClick
         OnKeyEvent=LockedOKButton.InternalOnKeyEvent
     End Object
     b_OK=da_GUI_Button'DA2.da_GUI_MutatorConfigMenu.LockedOKButton'

     Begin Object Class=da_GUI_Header Name=TitleBar
         WinTop=0.053750
         WinWidth=0.740000
     End Object
     t_WindowTitle=da_GUI_Header'DA2.da_GUI_LockedFloatingWindow.TitleBar'

     bMoveAllowed=False
     Begin Object Class=FloatingImage Name=MessageWindowFrameBackground
         Image=Texture'DA2GUI.Dialog.window_1024x768'
         DropShadowX=0
         DropShadowY=0
         WinLeft=0.000000
         WinWidth=1.000000
         WinHeight=1.000000
     End Object
     i_FrameBG=FloatingImage'DA2.da_GUI_MutatorConfigMenu.MessageWindowFrameBackground'

}
