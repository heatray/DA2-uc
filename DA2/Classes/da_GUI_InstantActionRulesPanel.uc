// D:\mods\UT2004Script3339\GUI2K4\Classes\InstantActionRulesPanel.uc

class da_GUI_InstantActionRulesPanel extends InstantActionRulesPanel;

defaultproperties
{
     Begin Object Class=da_GUI_MultiOptionListBox Name=RuleListBox
         OnCreateComponent=RuleListBox.InternalOnCreateComponent
         WinHeight=1.000000
         TabOrder=0
         bBoundToParent=True
         bScaleToParent=True
         OnChange=da_GUI_InstantActionRulesPanel.InternalOnChange
     End Object
     lb_Rules=da_GUI_MultiOptionListBox'DA2.da_GUI_InstantActionRulesPanel.RuleListBox'

}
