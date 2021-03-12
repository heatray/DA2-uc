// D:\mods\UT2004Script3339\GUI2K4\Classes\UT2K4Tab_ServerRulesPanel.uc
// D:\mods\UT2004Script3339\GUI2K4\Classes\IAMultiColumnRulesPanel.uc
// D:\mods\UT2004Script3339\GUI2K4\Classes\UT2K4PlayInfoPanel.uc

// Similar to E:\ut2k4\DA2\DA2\classes\da_GUI_IAMultiColumnRulesPanel.uc

/*
da_gui_gamepagemp
  da_gui_tabcontrol
    da_gui_tab_serverrulespanel
      GUIMultiOptionListBox 
        GUIMultiOptionList
*/

class da_GUI_Tab_ServerRulesPanel extends UT2K4Tab_ServerRulesPanel;

function InternalOnCreateComponent(GUIMenuOption NewComp, GUIMultiOptionList Sender) {
	if (Sender == li_Rules)
	{
		NewComp.ComponentJustification = TXTA_Right;
		NewComp.LabelJustification = TXTA_Left;
	    NewComp.CaptionWidth = 0.65;

	    if (moButton(NewComp) != None)
	    {
	        moButton(NewComp).ButtonStyleName = "DA2Style_Button";
	        moButton(NewComp).ButtonCaption = EditText;
	    }
	}
}

function LoadRules()
{
    Super.LoadRules();

	UpdateAdvancedCheckbox();
	UpdateSymbolButton();
}

function InternalOnChange(GUIComponent Sender)
{
	local class<GameInfo> GameClass;

    if (Sender == ch_Advanced)
    {
    	// Save our preference
        Controller.bExpertMode = ch_Advanced.IsChecked();
        Controller.SaveConfig();

		// Reload the playinfo settings and repopulate the MultiOptionList
        p_Anchor.SetRuleInfo();
        //reload maplist
        p_Anchor.p_Main.InitMaps();
        return;
    }

    else if ( Sender == b_Symbols )
    {
    	GameClass = class<GameInfo>(GamePI.InfoClasses[0]);

		if ( RedSym == "" )
			RedSym = string(GameClass.static.GetRandomTeamSymbol(0));
		if ( BlueSym == "" )
			BlueSym = string(GameClass.static.GetRandomTeamSymbol(10));

    	if ( Controller.OpenMenu(TeamSymbolPage, RedSym, BlueSym) )
    		Controller.ActivePage.OnClose = SymbolConfigClosed;

    	return;
    }

    Super.InternalOnChange(Sender);
}

function UpdateAdvancedCheckbox()
{
	if ( Controller != None && Controller.bExpertMode != ch_Advanced.IsChecked() )
		ch_Advanced.SetComponentValue( Controller.bExpertMode, true );
}

function AddRule(PlayInfo.PlayInfoData NewRule, int Index) {
    local bool bTemp;
    local string        Width, Op;
    local array<string> Range;
    local da_GUI_moComboBox    co;
    local da_GUI_moFloatEdit   fl;
    local da_GUI_moEditBox     ed;
    local da_GUI_moCheckbox    ch;
    local da_GUI_moNumericEdit nu;
    local da_GUI_moButton      bu;
    local int           i, pos;

    bTemp = Controller.bCurMenuInitialized;
    Controller.bCurMenuInitialized = False;

    switch (NewRule.RenderType)
    {
        case PIT_Check:
            ch = da_GUI_moCheckbox(li_Rules.AddItem("DA2.da_GUI_moCheckbox",,NewRule.DisplayName, True));
            if (ch == None)
                break;

            ch.Tag = Index;
            ch.bAutoSizeCaption = True;
            break;

        case PIT_Select:
            co = da_GUI_moComboBox(li_Rules.AddItem("DA2.da_GUI_moComboBox",,NewRule.DisplayName, True));
            if (co == None)
                break;

            co.ReadOnly(True);
            co.bAutoSizeCaption = True;
            co.Tag = Index;
            co.CaptionWidth=0.5;
            GamePI.SplitStringToArray(Range, NewRule.Data, ";");
            for (i = 0; i+1 < Range.Length; i += 2)
                co.AddItem(Range[i+1],,Range[i]);

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
            GamePI.SplitStringToArray(Range, Op, ":");
            if (Range.Length > 1)
            {
                // Ranged data
                if (InStr(Range[0], ".") != -1)
                {
                    // float edit
                    fl = da_GUI_moFloatEdit(li_Rules.AddItem("DA2.da_GUI_moFloatEdit",,NewRule.DisplayName, True));
                    if (fl == None) break;
                    fl.Tag = Index;
                    fl.bAutoSizeCaption = True;
                    fl.ComponentWidth = 0.25;
                    if (i != -1)
                        fl.Setup( float(Range[0]), float(Range[1]), fl.MyNumericEdit.Step);
                }

                else
                {
                    nu = da_GUI_moNumericEdit(li_Rules.AddItem("DA2.da_GUI_moNumericEdit",,NewRule.DisplayName, True));
                    if (nu == None) break;
                    nu.Tag = Index;
                    nu.bAutoSizeCaption = True;
                    nu.ComponentWidth = 0.25;
                    if (i != -1)
                        nu.Setup( int(Range[0]), int(Range[1]), nu.MyNumericEdit.Step);
                }
            }
            else if (NewRule.ArrayDim != -1)
            {
                bu = da_GUI_moButton(li_Rules.AddItem("DA2.da_GUI_moButton",,NewRule.DisplayName, True));
                if (bu == None) break;
                bu.Tag = Index;
                bu.bAutoSizeCaption = True;
                bu.ComponentWidth = 0.25;
                bu.OnChange = ArrayPropClicked;
            }

            else
            {
                ed = da_GUI_moEditBox(li_Rules.AddItem("DA2.da_GUI_moEditBox",,NewRule.DisplayName, True));
                if (ed == None) break;
                ed.Tag = Index;
                ed.bAutoSizeCaption = True;
                if (i != -1)
                    ed.MyEditBox.MaxWidth = i;
            }
            break;

        default:
            bu = da_GUI_moButton(li_Rules.AddItem("DA2.da_GUI_moButton",,NewRule.DisplayName, True));
            if (bu == None) break;
            bu.Tag = Index;
            bu.bAutoSizeCaption = True;
            bu.ComponentWidth = 0.25;
            bu.OnChange = CustomClicked;
    }

    Controller.bCurMenuInitialized = bTemp;
}

defaultproperties
{
     Begin Object Class=da_GUI_moCheckBox Name=EnableWebadmin
         Caption="Enable WebAdmin"
         OnCreateComponent=EnableWebadmin.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Enables remote web-based administration of the server"
         WinTop=0.893334
         WinLeft=0.586874
         WinWidth=0.295063
         WinHeight=0.043750
         TabOrder=4
         OnChange=da_GUI_Tab_ServerRulesPanel.Change
         OnLoadINI=da_GUI_Tab_ServerRulesPanel.InternalOnLoadINI
     End Object
     ch_Webadmin=da_GUI_moCheckBox'DA2.da_GUI_Tab_ServerRulesPanel.EnableWebadmin'

     Begin Object Class=da_GUI_moCheckBox Name=LANServer
         Caption="LAN Server"
         OnCreateComponent=LANServer.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Optimizes various engine and network settings for LAN-based play.  Enabling this option when running an internet server will cause EXTREME lag during the match!"
         WinTop=0.953334
         WinLeft=0.073126
         WinWidth=0.331250
         WinHeight=0.043750
         TabOrder=3
         OnChange=da_GUI_Tab_ServerRulesPanel.Change
         OnLoadINI=da_GUI_Tab_ServerRulesPanel.InternalOnLoadINI
     End Object
     ch_LANServer=da_GUI_moCheckBox'DA2.da_GUI_Tab_ServerRulesPanel.LANServer'

     Begin Object Class=da_GUI_moNumericEdit Name=WebadminPort
         MinValue=1
         MaxValue=65536
         CaptionWidth=0.700000
         ComponentWidth=0.300000
         Caption="WebAdmin Port"
         OnCreateComponent=WebadminPort.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Select which port should be used to connect to the remote web-based administration"
         WinTop=0.953334
         WinLeft=0.586874
         WinWidth=0.295063
         WinHeight=0.043750
         TabOrder=5
         OnChange=da_GUI_Tab_ServerRulesPanel.Change
         OnLoadINI=da_GUI_Tab_ServerRulesPanel.InternalOnLoadINI
     End Object
     nu_Port=da_GUI_moNumericEdit'DA2.da_GUI_Tab_ServerRulesPanel.WebadminPort'

     Begin Object Class=da_GUI_moCheckBox Name=AdvancedButton
         Caption="View Advanced Options"
         OnCreateComponent=AdvancedButton.InternalOnCreateComponent
         Hint="Toggles whether advanced properties are displayed"
         WinTop=0.948334
         WinLeft=0.136725
         WinWidth=0.300000
         WinHeight=0.040000
         RenderWeight=1.000000
         TabOrder=1
         bBoundToParent=True
         bScaleToParent=True
         OnChange=da_GUI_Tab_ServerRulesPanel.InternalOnChange
     End Object
     ch_Advanced=da_GUI_moCheckBox'DA2.da_GUI_Tab_ServerRulesPanel.AdvancedButton'

     Begin Object Class=da_GUI_moButton Name=SymbolButton
         ButtonCaption="Configure"
         ComponentWidth=0.400000
         Caption="Team Symbols"
         OnCreateComponent=SymbolButton.InternalOnCreateComponent
         Hint="Choose the banner symbols for each team."
         WinTop=0.936182
         WinLeft=0.523664
         WinWidth=0.329346
         WinHeight=0.056282
         TabOrder=2
         OnChange=da_GUI_Tab_ServerRulesPanel.InternalOnChange
     End Object
     b_Symbols=da_GUI_moButton'DA2.da_GUI_Tab_ServerRulesPanel.SymbolButton'

     Begin Object Class=GUIImage Name=Bk1
         Image=Texture'DA2GUI.Dialog.Display99'
         ImageStyle=ISTY_Stretched
         WinTop=0.014733
         WinLeft=0.000505
         WinWidth=0.996997
         WinHeight=0.907930
     End Object
     i_bk=GUIImage'DA2.da_GUI_Tab_ServerRulesPanel.Bk1'

     Begin Object Class=da_GUI_MultiOptionListBox Name=RuleListBox
         bVisibleWhenEmpty=True
         OnCreateComponent=da_GUI_Tab_ServerRulesPanel.ListBoxCreateComponent
         WinHeight=0.930009
         TabOrder=0
         bBoundToParent=True
         bScaleToParent=True
         OnChange=da_GUI_Tab_ServerRulesPanel.InternalOnChange
     End Object
     lb_Rules=da_GUI_MultiOptionListBox'DA2.da_GUI_Tab_ServerRulesPanel.RuleListBox'

     bStandardized=True
     StandardHeight=0.780000
}
