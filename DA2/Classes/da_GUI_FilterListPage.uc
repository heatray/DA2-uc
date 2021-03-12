class da_GUI_FilterListPage extends UT2K4_FilterListPage;

var	da_BrowserFilters 					AFM;

function InitComponent(GUIController MyC, GUIComponent MyO)
{
	Super.InitComponent(MyC, MyO);
	sb_Background.ManageComponent(lb_Filters);

	li_Filters = lb_Filters.List;
	li_Filters.ItemScaling = 0.04;
	li_Filters.ItemPadding = 0.3;
	li_Filters.OnChange=FilterChange;
	AFM = da_GUI_ServerBrowser(ParentPage).da_FilterMaster;
	InitFilterList();

	b_ExitButton.OnClick = CancelClick;
	li_Filters.OnDblClick=FilterDblClick;
}

function InitFilterList()
{
	local array<string> FilterNames;
	local moCheckbox ch;
	local int i;

	AFM = da_GUI_ServerBrowser(ParentPage).da_FilterMaster;

	li_Filters.Clear();
	FilterNames = AFM.GetFilterNames();
	for (i = 0; i < FilterNames.Length; i++)
	{
		ch = moCheckBox(li_Filters.AddItem("DA2.da_GUI_moCheckBoxTwo",,FilterNames[i]));
		if (ch != None)
			ch.Checked(AFM.IsActiveAt(i));
	}

	if (li_Filters.ItemCount==0)
		DisableComponent(b_Remove);
	else
		EnableComponent(b_Remove);

	li_Filters.SetIndex(0);

}

function FilterChange(GUIComponent Sender)
{
	local int i;
	local moCheckbox Sent;

	if (Sender == li_Filters)	// selected a different filter
	{
		if (li_Filters.ValidIndex(li_Filters.Index))
		{
			Sent = moCheckbox(li_Filters.Get());

			i = AFM.FindFilterIndex(Sent.Caption);
			if (Sent.IsChecked() != AFM.IsActiveAt(i))
				AFM.ActivateFilter(i,Sent.IsChecked());
		}
	}
}

function bool RemoveClick(GUIComponent Sender)
{

	if ( moCheckbox(li_Filters.Get()).Caption ~= "Default")
	{
		Controller.OpenMenu("GUI2K4.UT2K4GenericMessageBox",CantRemove);
		return true;
	}

	AFM.RemoveFilterAt( li_Filters.Index );
	InitFilterList();
}

function bool OKClick(GUIComponent Sender)
{
	local int i;
	local bool b;
	local UT2K4ServerBrowser Br;
	AFM.SaveFilters();

    b = false;
	for (i=0;i<AFM.AllFilters.Length;i++)
		if ( AFM.IsActiveAt(i) )
			b = true;

	if (b)
	{
		Br = UT2K4ServerBrowser(ParentPage);
		UT2K4Browser_Footer(Br.t_Footer).ch_Standard.Checked(false);
	}

	Controller.CloseMenu(true);



	return true;
}

function bool CancelClick(GUIComponent Sender)
{
	AFM.ResetFilters();
	Controller.CloseMenu(true);
	return true;
}

function AddSystemMenu()
{
	local eFontScale tFontScale;

	b_ExitButton = GUIButton(t_WindowTitle.AddComponent( "DA2.da_GUI_Button" ));
	b_ExitButton.Style = Controller.GetStyle("DA2Style_CloseButton",tFontScale);
	b_ExitButton.OnClick = XButtonClicked;
	b_ExitButton.bNeverFocus=true;
	b_ExitButton.FocusInstead = t_WindowTitle;
	b_ExitButton.RenderWeight=1;
	b_ExitButton.bScaleToParent=false;
	b_ExitButton.OnPreDraw = SystemMenuPreDraw;

	// Do not want OnClick() called from MousePressed()
	b_ExitButton.bRepeatClick = False;
}

//function bool SystemMenuPreDraw(canvas Canvas)
//{
//	b_ExitButton.SetPosition( t_WindowTitle.ActualLeft() + (t_WindowTitle.ActualWidth()-35), t_WindowTitle.ActualTop(), 24, 24, true);
//	return true;
//}

function bool CreateClick(GUIComponent Sender)
{
	local string FN;
	local int i,cnt;
	local moCheckbox cb;

	cnt = 0;
	for (i=0;i<li_Filters.ItemCount;i++)
	{
		cb = moCheckbox( li_Filters.GetItem(i) );
		if (inStr(cb.Caption,"New Filter")>=0)
			cnt++;
	}

	if (cnt==0)
		FN ="New Filter";
	else
		FN = "New Filter"@cnt;

	AFM.AddCustomFilter(FN);
	InitFilterList();
    i= AFM.FindFilterIndex(FN);
    Controller.OpenMenu("DA2.da_GUI_FilterEdit",""$i,FN);

    return true;
}

function bool EditClick(GUIComponent Sender)
{
	local string FN;
	local int i;
	local moCheckbox cb;

	cb = moCheckbox( li_Filters.Get() );
	FN = cb.Caption;
    i= AFM.FindFilterIndex(FN);
    Controller.OpenMenu("DA2.da_GUI_FilterEdit",""$i,FN);

    return true;
}

defaultproperties
{
     Begin Object Class=da_GUI_AltSectionBackground Name=sbBackground
         bFillClient=True
         bNoCaption=True
         Caption="Filters..."
         LeftPadding=0.002500
         RightPadding=0.002500
         TopPadding=0.002500
         BottomPadding=0.002500
         WinTop=0.103281
         WinLeft=0.262656
         WinWidth=0.343359
         WinHeight=0.766448
         OnPreDraw=sbBackground.InternalPreDraw
     End Object
     sb_Background=da_GUI_AltSectionBackground'DA2.da_GUI_FilterListPage.sbBackground'

     Begin Object Class=da_GUI_Button Name=bCreate
         Caption="Create"
         WinTop=0.126667
         WinLeft=0.610001
         WinWidth=0.168750
         WinHeight=0.050000
         OnClick=da_GUI_FilterListPage.CreateClick
         OnKeyEvent=bCreate.InternalOnKeyEvent
     End Object
     b_Create=da_GUI_Button'DA2.da_GUI_FilterListPage.bCreate'

     Begin Object Class=da_GUI_Button Name=bRemove
         Caption="Remove"
         WinTop=0.176666
         WinLeft=0.610001
         WinWidth=0.168750
         WinHeight=0.050000
         OnClick=da_GUI_FilterListPage.RemoveClick
         OnKeyEvent=bRemove.InternalOnKeyEvent
     End Object
     b_Remove=da_GUI_Button'DA2.da_GUI_FilterListPage.bRemove'

     Begin Object Class=da_GUI_Button Name=bEdit
         Caption="Edit"
         WinTop=0.266666
         WinLeft=0.610001
         WinWidth=0.168750
         WinHeight=0.050000
         OnClick=da_GUI_FilterListPage.EditClick
         OnKeyEvent=bEdit.InternalOnKeyEvent
     End Object
     b_Edit=da_GUI_Button'DA2.da_GUI_FilterListPage.bEdit'

     Begin Object Class=da_GUI_Button Name=bOk
         Caption="OK"
         WinTop=0.770000
         WinLeft=0.610001
         WinWidth=0.168750
         WinHeight=0.050000
         OnClick=da_GUI_FilterListPage.OkClick
         OnKeyEvent=bOk.InternalOnKeyEvent
     End Object
     b_OK=da_GUI_Button'DA2.da_GUI_FilterListPage.bOk'

     Begin Object Class=da_GUI_Button Name=bCancel
         Caption="Cancel"
         WinTop=0.820000
         WinLeft=0.610001
         WinWidth=0.168750
         WinHeight=0.050000
         OnClick=da_GUI_FilterListPage.CancelClick
         OnKeyEvent=bCancel.InternalOnKeyEvent
     End Object
     b_Cancel=da_GUI_Button'DA2.da_GUI_FilterListPage.bCancel'

     Begin Object Class=da_GUI_MultiOptionListBox Name=lbFilters
         OnCreateComponent=lbFilters.InternalOnCreateComponent
         WinTop=0.103281
         WinLeft=0.262656
         WinWidth=0.343359
         WinHeight=0.766448
     End Object
     lb_Filters=da_GUI_MultiOptionListBox'DA2.da_GUI_FilterListPage.lbFilters'

     Begin Object Class=da_GUI_Header Name=TitleBar
         bUseTextHeight=True
         FontScale=FNS_Small
         WinTop=0.028571
         WinHeight=0.041667
         RenderWeight=0.100000
         bBoundToParent=True
         bScaleToParent=True
         bAcceptsInput=True
         bNeverFocus=False
         ScalingType=SCALE_X
         OnMousePressed=da_GUI_FilterListPage.FloatingMousePressed
         OnMouseRelease=da_GUI_FilterListPage.FloatingMouseRelease
     End Object
     t_WindowTitle=da_GUI_Header'DA2.da_GUI_FilterListPage.TitleBar'

     Begin Object Class=FloatingImage Name=FloatingFrameBackground
         Image=Texture'DA2GUI.Dialog.window_1024x768'
         DropShadow=None
         ImageStyle=ISTY_Stretched
         ImageRenderStyle=MSTY_Normal
         WinTop=0.020000
         WinLeft=0.000000
         WinWidth=1.000000
         WinHeight=0.980000
         RenderWeight=0.000003
     End Object
     i_FrameBG=FloatingImage'DA2.da_GUI_FilterListPage.FloatingFrameBackground'

}
