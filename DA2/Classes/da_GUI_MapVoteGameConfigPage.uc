class da_GUI_MapVoteGameConfigPage extends MapVoteGameConfigPage;

defaultproperties
{
     Begin Object Class=da_GUI_AltSectionBackground Name=SBList
         bFillClient=True
         Caption="GameTypes"
         WinTop=0.044272
         WinLeft=0.042969
         WinWidth=0.377929
         WinHeight=0.753907
         OnPreDraw=SBList.InternalPreDraw
     End Object
     sb_List=da_GUI_AltSectionBackground'DA2.da_GUI_MapVoteGameConfigPage.SBList'

     Begin Object Class=da_GUI_AltSectionBackground Name=SBList2
         Caption="Mutators"
         TopPadding=0.100000
         BottomPadding=0.100000
         WinTop=0.540159
         WinLeft=0.483359
         WinWidth=0.451250
         WinHeight=0.295899
         RenderWeight=0.490000
         OnPreDraw=SBList2.InternalPreDraw
     End Object
     sb_List2=da_GUI_AltSectionBackground'DA2.da_GUI_MapVoteGameConfigPage.SBList2'

     Begin Object Class=da_GUI_ListBox Name=GameConfigListBox
         bVisibleWhenEmpty=True
         OnCreateComponent=GameConfigListBox.InternalOnCreateComponent
         Hint="Select a game configuration to edit or delete."
         WinTop=0.160775
         WinLeft=0.626758
         WinWidth=0.344087
         WinHeight=0.727759
         TabOrder=0
     End Object
     lb_GameConfigList=da_GUI_ListBox'DA2.da_GUI_MapVoteGameConfigPage.GameConfigListBox'

     Begin Object Class=da_GUI_moComboBox Name=GameClassComboBox
         CaptionWidth=0.400000
         ComponentWidth=0.600000
         Caption="Game Class"
         OnCreateComponent=GameClassComboBox.InternalOnCreateComponent
         Hint="Select a game type for the select game configuration."
         WinTop=0.136135
         WinLeft=0.028955
         WinWidth=0.592970
         WinHeight=0.076855
         TabOrder=4
         OnChange=da_GUI_MapVoteGameConfigPage.FieldChange
     End Object
     co_GameClass=da_GUI_moComboBox'DA2.da_GUI_MapVoteGameConfigPage.GameClassComboBox'

     Begin Object Class=da_GUI_moEditBox Name=GameTitleEditBox
         CaptionWidth=0.400000
         ComponentWidth=0.600000
         Caption="Game Title"
         OnCreateComponent=GameTitleEditBox.InternalOnCreateComponent
         Hint="Enter a custom game configuration title."
         WinTop=0.223844
         WinLeft=0.028955
         WinWidth=0.592970
         WinHeight=0.074249
         TabOrder=3
         OnChange=da_GUI_MapVoteGameConfigPage.FieldChange
     End Object
     ed_GameTitle=da_GUI_moEditBox'DA2.da_GUI_MapVoteGameConfigPage.GameTitleEditBox'

     Begin Object Class=da_GUI_moEditBox Name=AcronymEditBox
         CaptionWidth=0.400000
         ComponentWidth=0.600000
         Caption="Abbreviation"
         OnCreateComponent=AcronymEditBox.InternalOnCreateComponent
         Hint="A short abbreviation, description, or acronym that identifies the game configuration. This will be appended to the map name in vote messages."
         WinTop=0.306343
         WinLeft=0.028955
         WinWidth=0.592970
         WinHeight=0.076855
         TabOrder=5
         OnChange=da_GUI_MapVoteGameConfigPage.FieldChange
     End Object
     ed_Acronym=da_GUI_moEditBox'DA2.da_GUI_MapVoteGameConfigPage.AcronymEditBox'

     Begin Object Class=da_GUI_moEditBox Name=PrefixEditBox
         CaptionWidth=0.400000
         ComponentWidth=0.600000
         Caption="Map Prefixes"
         OnCreateComponent=PrefixEditBox.InternalOnCreateComponent
         Hint="List of map name prefixes. Separate each with commas."
         WinTop=0.393185
         WinLeft=0.028955
         WinWidth=0.592970
         WinHeight=0.074249
         TabOrder=6
         OnChange=da_GUI_MapVoteGameConfigPage.FieldChange
     End Object
     ed_Prefix=da_GUI_moEditBox'DA2.da_GUI_MapVoteGameConfigPage.PrefixEditBox'

     Begin Object Class=da_GUI_moEditBox Name=ParameterEditBox
         CaptionWidth=0.400000
         ComponentWidth=0.600000
         Caption="Parameters"
         OnCreateComponent=ParameterEditBox.InternalOnCreateComponent
         Hint="(Advanced) List of game parameters with values. Separated each with a comma. (ex. GoalScore=4,MinPlayers=4)"
         WinTop=0.826949
         WinLeft=0.077783
         WinWidth=0.490431
         TabOrder=7
         OnChange=da_GUI_MapVoteGameConfigPage.FieldChange
     End Object
     ed_Parameter=da_GUI_moEditBox'DA2.da_GUI_MapVoteGameConfigPage.ParameterEditBox'

     Begin Object Class=da_GUI_Button Name=NewButton
         Caption="New"
         Hint="Create a new game configuration."
         WinTop=0.913925
         WinLeft=0.060047
         WinWidth=0.158281
         TabOrder=1
         OnClick=da_GUI_MapVoteGameConfigPage.NewButtonClick
         OnKeyEvent=NewButton.InternalOnKeyEvent
     End Object
     b_New=da_GUI_Button'DA2.da_GUI_MapVoteGameConfigPage.NewButton'

     Begin Object Class=da_GUI_Button Name=DeleteButton
         Caption="Delete"
         Hint="Delete the selected game configuration."
         WinTop=0.913925
         WinLeft=0.268403
         WinWidth=0.159531
         TabOrder=2
         OnClick=da_GUI_MapVoteGameConfigPage.DeleteButtonClick
         OnKeyEvent=DeleteButton.InternalOnKeyEvent
     End Object
     b_Delete=da_GUI_Button'DA2.da_GUI_MapVoteGameConfigPage.DeleteButton'

     Begin Object Class=da_GUI_moCheckBox Name=DefaultCheckBox
         ComponentWidth=0.200000
         Caption="Default"
         OnCreateComponent=DefaultCheckBox.InternalOnCreateComponent
         Hint="The selected game configuration will be the default if all the players leave the server"
         WinTop=0.826949
         WinLeft=0.659814
         WinWidth=0.194922
         TabOrder=8
         OnChange=da_GUI_MapVoteGameConfigPage.FieldChange
     End Object
     ch_Default=da_GUI_moCheckBox'DA2.da_GUI_MapVoteGameConfigPage.DefaultCheckBox'

}
