// D:\mods\UT2004Script3339\GUI2K4\Classes\UT2K4Browser_Footer.uc
// D:\mods\UT2004Script3339\GUI2K4\Classes\ButtonFooter.uc

// Similar to E:\ut2k4\DA2\DA2\classes\da_GUI_GameFooter.uc

/*

TODO
 * Fix the 'standard servers' combo box [zeh]

*/

class da_GUI_Browser_Footer extends UT2K4Browser_Footer;

function PositionButtons( Canvas C ) {
//	local bool b;

//	b                 = b_Filter.bVisible;
//	b_Filter.bVisible = false;

//	b_Filter.bVisible = b;
//	b_Filter.WinLeft  = GetMargin();

/*
	b_Filter.AutoSizePadding.HorzPerc = 0.5;
	b_Back.AutoSizePadding.HorzPerc = 0.5;
	b_Refresh.AutoSizePadding.HorzPerc = 0.5;
	b_Join.AutoSizePadding.HorzPerc = 0.5;
	b_Spectate.AutoSizePadding.HorzPerc = 0.5;
*/

	super.PositionButtons(C);

	b_Filter.WinLeft = 0.012; //Margin; // 0.02;

	t_StatusBar.WinTop = 0.171876;
	ch_Standard.WinTop = -1.174219; //0.269532;

	b_Filter.WinTop = 0.171876;
	b_Back.WinTop = 0.171876;
	b_Refresh.WinTop = 0.171876;
	b_Join.WinTop = 0.171876;
	b_Spectate.WinTop = 0.171876;

}

defaultproperties
{
     Begin Object Class=da_GUI_moCheckBox Name=OnlyStandardCheckBox
         CaptionWidth=0.900000
         Caption="Standard Servers Only"
         OnCreateComponent=OnlyStandardCheckBox.InternalOnCreateComponent
         FontScale=FNS_Small
         Hint="Only display standard servers (no mutators) in the server browser.  This option overrides filter settings."
         WinLeft=0.020000
         WinWidth=0.220000
         WinHeight=0.656250
         TabOrder=5
         bBoundToParent=True
         bScaleToParent=True
     End Object
     ch_Standard=da_GUI_moCheckBox'DA2.da_GUI_Browser_Footer.OnlyStandardCheckBox'

     Begin Object Class=GUITitleBar Name=BrowserStatus
         bUseTextHeight=False
         Justification=TXTA_Left
         FontScale=FNS_Small
         StyleName="DA2Style_BodyText"
         WinLeft=0.150000
         WinWidth=0.500000
         WinHeight=0.656250
         bBoundToParent=True
         bScaleToParent=True
     End Object
     t_StatusBar=GUITitleBar'DA2.da_GUI_Browser_Footer.BrowserStatus'

     Begin Object Class=GUIButton Name=BrowserJoin
         Caption="JOIN"
         MenuState=MSAT_Disabled
         StyleName="DA2Style_Button"
         WinWidth=0.050000
         RenderWeight=2.000000
         TabOrder=2
         bBoundToParent=True
         OnClick=da_GUI_Browser_Footer.InternalOnClick
         OnKeyEvent=BrowserJoin.InternalOnKeyEvent
     End Object
     b_Join=GUIButton'DA2.da_GUI_Browser_Footer.BrowserJoin'

     Begin Object Class=GUIButton Name=BrowserSpec
         Caption="SPECTATE"
         MenuState=MSAT_Disabled
         StyleName="DA2Style_Button"
         WinWidth=0.050000
         RenderWeight=2.000000
         TabOrder=1
         bBoundToParent=True
         OnClick=da_GUI_Browser_Footer.InternalOnClick
         OnKeyEvent=BrowserSpec.InternalOnKeyEvent
     End Object
     b_Spectate=GUIButton'DA2.da_GUI_Browser_Footer.BrowserSpec'

     Begin Object Class=GUIButton Name=BrowserBack
         Caption="BACK"
         StyleName="DA2Style_Button"
         Hint="Return to the previous menu"
         WinWidth=0.050000
         RenderWeight=2.000000
         TabOrder=4
         bBoundToParent=True
         OnClick=da_GUI_Browser_Footer.InternalOnClick
         OnKeyEvent=BrowserBack.InternalOnKeyEvent
     End Object
     b_Back=GUIButton'DA2.da_GUI_Browser_Footer.BrowserBack'

     Begin Object Class=GUIButton Name=BrowserRefresh
         Caption="REFRESH"
         MenuState=MSAT_Disabled
         StyleName="DA2Style_Button"
         WinWidth=0.050000
         RenderWeight=2.000000
         TabOrder=3
         bBoundToParent=True
         OnClick=da_GUI_Browser_Footer.InternalOnClick
         OnKeyEvent=BrowserRefresh.InternalOnKeyEvent
     End Object
     b_Refresh=GUIButton'DA2.da_GUI_Browser_Footer.BrowserRefresh'

     Begin Object Class=GUIButton Name=BrowserFilter
         Caption="FILTERS"
         StyleName="DA2Style_Button"
         Hint="Filters allow more control over which servers will appear in the server browser lists."
         WinWidth=0.050000
         RenderWeight=2.000000
         TabOrder=0
         bBoundToParent=True
         OnClick=da_GUI_Browser_Footer.InternalOnClick
         OnKeyEvent=BrowserFilter.InternalOnKeyEvent
     End Object
     b_Filter=GUIButton'DA2.da_GUI_Browser_Footer.BrowserFilter'

     ButtonHeight=0.042000
     Padding=1.000000
     Margin=0.020000
     Spacer=0.010000
     StyleName="DA2Style_Footer"
     WinHeight=0.064000
}
