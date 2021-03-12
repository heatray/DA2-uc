class da_GUI_FilterEdit extends ROUT2K4_FilterEdit;

var	da_BrowserFilters 	AFM;
var da_GUI_FilterListPage 	AFLP;


function InitComponent(GUIController MyC, GUIComponent MyO)
{
	Super.InitComponent(MyC, MyO);

	AFLP = da_GUI_FilterListPage(ParentPage);

	sb_Options.ManageComponent(ck_Full);
	sb_Options.ManageComponent(ck_Empty);
	sb_Options.ManageComponent(ck_Passworded);
	sb_Options.ManageComponent(ck_Bots);
	sb_Options.ManageComponent(ck_VACOnly);
	sb_Options.ManageComponent(ck_Hidden);
}

function bool InternalOnPreDraw(canvas c)
{
	local bool b;

	i_FrameBG.Image = class'da_GUI_Utilities'.static.getCorrectBackground(c);
	b = Super.InternalOnPreDraw(c);

//	b_Cancel.WinTop = 0.935;
//	b_OK.WinTop = 0.935;

	return b;
}

event HandleParameters(string Param1, string Param2)
{
	local int i;
	local array<CustomFilter.AFilterRule> Rules;
	local MasterServerClient.QueryData 	FilterItem;

	FilterIndex = int(Param1);
	eb_Name.SetComponentValue(Param2);

	if (Param2~="Default")
		eb_Name.DisableMe();
	else
		eb_Name.EnableMe();

	//Get the custom filter
 	Rules = AFLP.AFM.GetFilterRules(FilterIndex);

	for (i=0;i<Rules.Length;i++)
	{
		FilterItem = Rules[i].FilterItem;
		if ( FilterItem.Key~="currentplayers" && FilterItem.Value=="0" && FilterItem.QueryType==QT_GreaterThan )
			ck_Empty.Checked(true);

		if ( FilterItem.Key~="password" && FilterItem.Value=="false" && FilterItem.QueryType==QT_Equals )
			ck_Passworded.Checked(true);

		if ( FilterItem.Key~="freespace" && FilterItem.Value =="0" && FilterItem.QueryType==QT_GreaterThan )
			ck_Full.Checked(true);

		if ( FilterItem.Key~="nobots" && FilterItem.Value=="true" && FilterItem.QueryType==QT_Equals)
			ck_Bots.Checked(true);

		if ( FilterItem.Key~="vacsecure" && FilterItem.Value=="true" && FilterItem.QueryType==QT_Equals)
			ck_VACOnly.Checked(true);
	}
}

function bool OkClick(GUIComponent Server)
{
	local array<CustomFilter.AFilterRule> Rules;
	local int cnt;

	cnt = 0;

	// Build Query lists

	if ( ck_Empty.IsChecked() )
		Rules[Cnt++] = BuildRule("currentplayers","0",QT_GreaterThan);

	if ( ck_Full.IsChecked() )
		Rules[Cnt++] = BuildRule("freespace","0",QT_GreaterThan);

	if ( ck_Passworded.IsChecked() )
		Rules[Cnt++] = BuildRule("password","false",QT_Equals);

	if ( ck_Bots.IsChecked() )
		Rules[Cnt++] = BuildRule("nobots","true", QT_Equals);

	if ( ck_VACOnly.IsChecked() )
		Rules[Cnt++] = BuildRule("vacsecure","true", QT_Equals);

	AFLP.AFM.PostEdit(FilterIndex,eb_Name.GetComponentValue(),Rules);
	Controller.CloseMenu(true);
	AFLP.InitFilterList();

	AFLP.li_Filters.SetIndex(AFLP.li_Filters.Find(eb_Name.GetComponentValue()));

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

defaultproperties
{
     Begin Object Class=da_GUI_SectionBackground Name=sbOptions
         bFillClient=True
         Caption="Options..."
         LeftPadding=0.002500
         RightPadding=0.002500
         TopPadding=0.200000
         BottomPadding=0.002500
         NumColumns=2
         WinTop=0.257448
         WinLeft=0.086094
         WinWidth=0.827735
         WinHeight=0.427735
         OnPreDraw=sbOptions.InternalPreDraw
     End Object
     sb_Options=da_GUI_SectionBackground'DA2.da_GUI_FilterEdit.sbOptions'

     Begin Object Class=da_GUI_moEditBox Name=ebName
         ComponentWidth=0.700000
         Caption="Filter Name:"
         OnCreateComponent=ebName.InternalOnCreateComponent
         WinTop=0.124114
         WinLeft=0.184531
         WinWidth=0.654297
         TabOrder=0
         OnPreDraw=da_GUI_FilterEdit.ebPreDraw
     End Object
     eb_Name=da_GUI_moEditBox'DA2.da_GUI_FilterEdit.ebName'

     Begin Object Class=da_GUI_moCheckBoxTwo Name=ckFull
         ComponentWidth=0.100000
         Caption="No Full Servers"
         OnCreateComponent=ckFull.InternalOnCreateComponent
         WinTop=0.250000
         WinLeft=0.250000
         TabOrder=1
     End Object
     ck_Full=da_GUI_moCheckBoxTwo'DA2.da_GUI_FilterEdit.ckFull'

     Begin Object Class=da_GUI_moCheckBoxTwo Name=ckBots
         ComponentWidth=0.100000
         Caption="No Bots"
         OnCreateComponent=ckBots.InternalOnCreateComponent
         WinTop=0.250000
         WinLeft=0.250000
         TabOrder=2
     End Object
     ck_Bots=da_GUI_moCheckBoxTwo'DA2.da_GUI_FilterEdit.ckBots'

     Begin Object Class=da_GUI_moCheckBoxTwo Name=ckEmpty
         ComponentWidth=0.100000
         Caption="No Empty Servers"
         OnCreateComponent=ckEmpty.InternalOnCreateComponent
         WinTop=0.250000
         WinLeft=0.250000
         TabOrder=3
     End Object
     ck_Empty=da_GUI_moCheckBoxTwo'DA2.da_GUI_FilterEdit.ckEmpty'

     Begin Object Class=da_GUI_moCheckBoxTwo Name=ckPassworded
         ComponentWidth=0.100000
         Caption="No Passworded Servers"
         OnCreateComponent=ckPassworded.InternalOnCreateComponent
         WinTop=0.250000
         WinLeft=0.250000
         TabOrder=4
     End Object
     ck_Passworded=da_GUI_moCheckBoxTwo'DA2.da_GUI_FilterEdit.ckPassworded'

     Begin Object Class=da_GUI_moCheckBoxTwo Name=ckVACOnly
         ComponentWidth=0.100000
         Caption="Valve Anti-Cheat Protected Only"
         OnCreateComponent=ckVACOnly.InternalOnCreateComponent
         WinTop=0.250000
         WinLeft=0.250000
         TabOrder=5
     End Object
     ck_VACOnly=da_GUI_moCheckBoxTwo'DA2.da_GUI_FilterEdit.ckVACOnly'

     Begin Object Class=da_GUI_moCheckBoxTwo Name=ckHidden
         ComponentWidth=0.100000
         Caption="Hidden"
         OnCreateComponent=ckHidden.InternalOnCreateComponent
         WinTop=0.250000
         WinLeft=0.250000
         TabOrder=6
         bVisible=False
     End Object
     ck_Hidden=da_GUI_moCheckBoxTwo'DA2.da_GUI_FilterEdit.ckHidden'

     Begin Object Class=da_GUI_Button Name=bOk
         Caption="OK"
         WinTop=0.698612
         WinLeft=0.561564
         WinWidth=0.168750
         WinHeight=0.050000
         OnClick=da_GUI_FilterEdit.OkClick
         OnKeyEvent=bOk.InternalOnKeyEvent
     End Object
     b_OK=da_GUI_Button'DA2.da_GUI_FilterEdit.bOk'

     Begin Object Class=da_GUI_Button Name=bCancel
         Caption="Cancel"
         WinTop=0.698612
         WinLeft=0.742814
         WinWidth=0.168750
         WinHeight=0.050000
         OnClick=da_GUI_FilterEdit.CancelClick
         OnKeyEvent=bCancel.InternalOnKeyEvent
     End Object
     b_Cancel=da_GUI_Button'DA2.da_GUI_FilterEdit.bCancel'

     Begin Object Class=da_GUI_Header Name=TitleBar
         bUseTextHeight=True
         FontScale=FNS_Small
         WinTop=0.043860
         WinHeight=0.041667
         RenderWeight=0.100000
         bBoundToParent=True
         bScaleToParent=True
         bAcceptsInput=True
         bNeverFocus=False
         ScalingType=SCALE_X
         OnMousePressed=da_GUI_FilterEdit.FloatingMousePressed
         OnMouseRelease=da_GUI_FilterEdit.FloatingMouseRelease
     End Object
     t_WindowTitle=da_GUI_Header'DA2.da_GUI_FilterEdit.TitleBar'

}
