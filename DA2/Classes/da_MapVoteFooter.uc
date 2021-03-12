class da_MapVoteFooter extends MapVoteFooter;

defaultproperties
{
     Begin Object Class=da_GUI_AltSectionBackground Name=MapvoteFooterBackground
         bFillClient=True
         Caption="Chat"
         LeftPadding=0.010000
         RightPadding=0.010000
         WinHeight=0.820000
         bBoundToParent=True
         bScaleToParent=True
         OnPreDraw=MapvoteFooterBackground.InternalPreDraw
     End Object
     sb_Background=da_GUI_AltSectionBackground'DA2.da_MapVoteFooter.MapvoteFooterBackground'

     Begin Object Class=da_GUI_ScrollTextBox Name=ChatScrollBox
         bNoTeletype=True
         CharDelay=0.002500
         EOLDelay=0.000000
         bVisibleWhenEmpty=True
         OnCreateComponent=ChatScrollBox.InternalOnCreateComponent
         WinTop=0.223580
         WinLeft=0.043845
         WinWidth=0.918970
         WinHeight=0.582534
         TabOrder=2
         bBoundToParent=True
         bScaleToParent=True
         bNeverFocus=True
     End Object
     lb_Chat=da_GUI_ScrollTextBox'DA2.da_MapVoteFooter.ChatScrollBox'

     Begin Object Class=da_GUI_moEditBox Name=ChatEditbox
         CaptionWidth=0.150000
         Caption="Say"
         OnCreateComponent=ChatEditbox.InternalOnCreateComponent
         WinTop=0.868598
         WinLeft=0.007235
         WinWidth=0.700243
         WinHeight=0.106609
         TabOrder=0
         OnKeyEvent=da_MapVoteFooter.InternalOnKeyEvent
     End Object
     ed_Chat=da_GUI_moEditBox'DA2.da_MapVoteFooter.ChatEditbox'

     Begin Object Class=da_GUI_Button Name=AcceptButton
         Caption="Accept"
         Hint="Click once you are satisfied with all settings and wish to offer no further modifications"
         WinTop=0.906173
         WinLeft=0.562577
         WinWidth=0.191554
         WinHeight=0.071145
         TabOrder=1
         bVisible=False
         bStandardized=True
         OnClick=MapVoteFooter.InternalOnClick
         OnKeyEvent=AcceptButton.InternalOnKeyEvent
     End Object
     b_Accept=da_GUI_Button'DA2.da_MapVoteFooter.AcceptButton'

     Begin Object Class=da_GUI_Button Name=SubmitButton
         Caption="Submit"
         WinTop=0.849625
         WinLeft=0.704931
         WinWidth=0.160075
         WinHeight=0.165403
         TabOrder=1
         bStandardized=True
         OnClick=MapVoteFooter.InternalOnClick
         OnKeyEvent=SubmitButton.InternalOnKeyEvent
     End Object
     b_Submit=da_GUI_Button'DA2.da_MapVoteFooter.SubmitButton'

     Begin Object Class=da_GUI_Button Name=CloseButton
         Caption="Close"
         WinTop=0.849625
         WinLeft=0.861895
         WinWidth=0.137744
         WinHeight=0.165403
         TabOrder=1
         bStandardized=True
         OnClick=MapVoteFooter.InternalOnClick
         OnKeyEvent=CloseButton.InternalOnKeyEvent
     End Object
     b_Close=da_GUI_Button'DA2.da_MapVoteFooter.CloseButton'

     WinTop=0.701735
     WinLeft=0.019921
     WinWidth=0.962109
     WinHeight=0.291406
}
