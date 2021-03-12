class da_MapVotingPage extends MapVotingPage;

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

defaultproperties
{
     Begin Object Class=da_GUI_MapVoteMultiColumnListBox Name=MapListBox
         HeaderColumnPerc(0)=0.600000
         HeaderColumnPerc(1)=0.200000
         HeaderColumnPerc(2)=0.200000
         bVisibleWhenEmpty=True
         OnCreateComponent=MapListBox.InternalOnCreateComponent
         WinTop=0.400000
         WinLeft=0.020000
         WinWidth=0.960000
         WinHeight=0.270000
         bBoundToParent=True
         bScaleToParent=True
         OnRightClick=MapListBox.InternalOnRightClick
     End Object
     lb_MapListBox=da_GUI_MapVoteMultiColumnListBox'DA2.da_MapVotingPage.MapListBox'

     Begin Object Class=da_GUI_MapVoteCountMultiColumnListBox Name=VoteCountListBox
         HeaderColumnPerc(0)=0.400000
         HeaderColumnPerc(1)=0.400000
         bVisibleWhenEmpty=True
         OnCreateComponent=VoteCountListBox.InternalOnCreateComponent
         WinTop=0.110000
         WinLeft=0.020000
         WinWidth=0.960000
         WinHeight=0.270000
         bBoundToParent=True
         bScaleToParent=True
         OnRightClick=VoteCountListBox.InternalOnRightClick
     End Object
     lb_VoteCountListBox=da_GUI_MapVoteCountMultiColumnListBox'DA2.da_MapVotingPage.VoteCountListBox'

     Begin Object Class=da_GUI_moComboBox Name=GameTypeCombo
         CaptionWidth=0.350000
         Caption="Filter Game Type:"
         OnCreateComponent=GameTypeCombo.InternalOnCreateComponent
         WinTop=0.334309
         WinLeft=0.199219
         WinWidth=0.757809
         WinHeight=0.037500
         bScaleToParent=True
         bVisible=False
     End Object
     co_GameType=da_GUI_moComboBox'DA2.da_MapVotingPage.GameTypeCombo'

     Begin Object Class=GUIImage Name=MapListBackground
         Image=Texture'DA2GUI.Dialog.htab_tab_l'
         ImageStyle=ISTY_Stretched
         WinTop=0.371020
         WinLeft=0.010000
         WinWidth=0.980000
         WinHeight=0.316542
     End Object
     i_MapListBackground=GUIImage'DA2.da_MapVotingPage.MapListBackground'

     Begin Object Class=GUIImage Name=MapCountListBackground
         Image=Texture'DA2GUI.Dialog.htab_tab_l'
         ImageStyle=ISTY_Stretched
         WinTop=0.052930
         WinLeft=0.010000
         WinWidth=0.980000
         WinHeight=0.223770
         OnDraw=da_MapVotingPage.AlignBK
     End Object
     i_MapCountListBackground=GUIImage'DA2.da_MapVotingPage.MapCountListBackground'

     Begin Object Class=da_MapVoteFooter Name=MatchSetupFooter
         WinTop=0.690000
         WinHeight=0.300000
         TabOrder=10
     End Object
     f_Chat=da_MapVoteFooter'DA2.da_MapVotingPage.MatchSetupFooter'

     Begin Object Class=da_GUI_Header Name=TitleBar
         bUseTextHeight=True
         WinTop=0.038000
         WinHeight=0.043750
         RenderWeight=0.100000
         bBoundToParent=True
         bScaleToParent=True
         bAcceptsInput=True
         bNeverFocus=False
         ScalingType=SCALE_X
         OnMousePressed=da_MapVotingPage.FloatingMousePressed
         OnMouseRelease=da_MapVotingPage.FloatingMouseRelease
     End Object
     t_WindowTitle=da_GUI_Header'DA2.da_MapVotingPage.TitleBar'

     Begin Object Class=FloatingImage Name=MessageWindowFrameBackground
         Image=Texture'DA2GUI.Dialog.window_1024x768'
         DropShadowX=0
         DropShadowY=0
         WinLeft=0.000000
         WinWidth=1.000000
         WinHeight=1.000000
     End Object
     i_FrameBG=FloatingImage'DA2.da_MapVotingPage.MessageWindowFrameBackground'

}
