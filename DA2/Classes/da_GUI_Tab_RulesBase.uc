// D:\mods\UT2004Script3339\GUI2K4\Classes\UT2K4Tab_RulesBase.uc
// D:\mods\UT2004Script3339\GUI2K4\Classes\UT2K4GameTabBase.uc

class da_GUI_Tab_RulesBase extends UT2K4Tab_RulesBase;

function Refresh() {
	local int i, j;
	Super.Refresh();

	// Update the summary list when the new settings
//	li_Summary.GamePI = p_Anchor.RuleInfo;
//	li_Summary.Refresh();

	// First, find out if we need to remove any tabs
	// This is likely to be the case if we have mutators have been removed which were adding new groups to playinfo
	for (i = 0; i < c_Rules.TabStack.Length; i++)
	{
		j = FindGroupIndex(c_Rules.TabStack[i].Caption);
		if (j < 0)
			c_Rules.RemoveTab(,c_Rules.TabStack[i--]);
	}

	// Then, go through and tag all panels to refresh themselves the next time they are shown
	for (i = 0; i < c_Rules.TabStack.Length; i++)
		if (da_GUI_InstantActionRulesPanel(c_Rules.TabStack[i].MyPanel) != None)
		{
			da_GUI_InstantActionRulesPanel(c_Rules.TabStack[i].MyPanel).GamePI = p_Anchor.RuleInfo;
			da_GUI_InstantActionRulesPanel(c_Rules.TabStack[i].MyPanel).bRefresh = True;
		}

	// Next, find out if we need to add any tabs
	for (i = 0; i < p_Anchor.RuleInfo.Groups.Length; i++)
	{
		j = c_Rules.TabIndex(p_Anchor.RuleInfo.Groups[i]);
		if (j < 0)
			c_Rules.AddTab(p_Anchor.RuleInfo.Groups[i], "DA2.da_GUI_InstantActionRulesPanel",,p_Anchor.RuleInfo.Groups[i]@"Settings");
	}

	// Finally, go through and tag all panels to update themselves with the fresh
	// information from PlayInfo
	for (i = 0; i < c_Rules.TabStack.Length; i++)
		if (da_GUI_InstantActionRulesPanel(c_Rules.TabStack[i].MyPanel) != None)
			da_GUI_InstantActionRulesPanel(c_Rules.TabStack[i].MyPanel).bUpdate = True;
}

function InternalOnCreateComponent(GUIComponent NewComp, GUIComponent Sender)
{
	if (Sender == c_Rules)
	{
		if (da_GUI_InstantActionRulesPanel(NewComp) != None)
		{
			da_GUI_InstantActionRulesPanel(NewComp).tp_Anchor = Self;
			da_GUI_InstantActionRulesPanel(NewComp).GamePI = p_Anchor.RuleInfo;
		}
	}

//	else if (Sender == lb_Summary)
//	{
//		li_Summary = PlayInfoList(NewComp);
//		lb_Summary.InternalOnCreateComponent(NewComp, Sender);
//	}
}

defaultproperties
{
     Begin Object Class=da_GUI_TabControl Name=RuleTabControl
         bDockPanels=True
         bDrawTabAbove=False
         TabHeight=0.040000
         OnCreateComponent=da_GUI_Tab_RulesBase.InternalOnCreateComponent
         WinHeight=1.000000
         TabOrder=0
         bBoundToParent=True
         bScaleToParent=True
         OnActivate=RuleTabControl.InternalOnActivate
     End Object
     c_Rules=da_GUI_TabControl'DA2.da_GUI_Tab_RulesBase.RuleTabControl'

     WinHeight=0.780000
     bStandardized=True
     StandardHeight=0.780000
}
