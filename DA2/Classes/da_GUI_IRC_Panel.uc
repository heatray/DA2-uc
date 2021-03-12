// D:\mods\UT2004Script3339\GUI2K4\Classes\UT2K4IRC_Panel.uc


class da_GUI_IRC_Panel extends UT2K4IRC_Panel;

defaultproperties
{
     Begin Object Class=da_GUI_moComboBox Name=MyServerCombo
         CaptionWidth=0.250000
         Caption="Server"
         OnCreateComponent=MyServerCombo.InternalOnCreateComponent
         WinTop=0.102967
         WinLeft=0.150000
         WinWidth=0.400000
         WinHeight=0.300000
         RenderWeight=3.000000
         TabOrder=0
         bBoundToParent=True
         bScaleToParent=True
         OnChange=da_GUI_IRC_Panel.InternalOnChange
     End Object
     co_Server=da_GUI_moComboBox'DA2.da_GUI_IRC_Panel.MyServerCombo'

     Begin Object Class=da_GUI_moComboBox Name=MyChannelCombo
         CaptionWidth=0.250000
         Caption="Channel"
         OnCreateComponent=MyChannelCombo.InternalOnCreateComponent
         WinTop=0.500000
         WinLeft=0.150000
         WinWidth=0.400000
         WinHeight=0.300000
         RenderWeight=3.000000
         TabOrder=1
         bBoundToParent=True
         bScaleToParent=True
     End Object
     co_Channel=da_GUI_moComboBox'DA2.da_GUI_IRC_Panel.MyChannelCombo'

     Begin Object Class=da_GUI_Button Name=MyConnectButton
         Caption="CONNECT"
         WinTop=0.100000
         WinLeft=0.560000
         WinWidth=0.200000
         WinHeight=0.300000
         RenderWeight=3.000000
         TabOrder=2
         bBoundToParent=True
         bScaleToParent=True
         OnClick=da_GUI_IRC_Panel.InternalOnClick
         OnKeyEvent=MyConnectButton.InternalOnKeyEvent
     End Object
     b_Connect=da_GUI_Button'DA2.da_GUI_IRC_Panel.MyConnectButton'

     Begin Object Class=da_GUI_Button Name=MyRemoveServerButton
         Caption="REMOVE"
         WinTop=0.100000
         WinLeft=0.770000
         WinWidth=0.200000
         WinHeight=0.300000
         RenderWeight=3.000000
         TabOrder=4
         bBoundToParent=True
         bScaleToParent=True
         OnClick=da_GUI_IRC_Panel.InternalOnClick
         OnKeyEvent=MyRemoveServerButton.InternalOnKeyEvent
     End Object
     b_RemServer=da_GUI_Button'DA2.da_GUI_IRC_Panel.MyRemoveServerButton'

     Begin Object Class=da_GUI_Button Name=MyJoinChannelButton
         Caption="JOIN"
         WinTop=0.500000
         WinLeft=0.560000
         WinWidth=0.200000
         WinHeight=0.300000
         RenderWeight=3.000000
         TabOrder=3
         bBoundToParent=True
         bScaleToParent=True
         OnClick=da_GUI_IRC_Panel.InternalOnClick
         OnKeyEvent=MyJoinChannelButton.InternalOnKeyEvent
     End Object
     b_JoinChannel=da_GUI_Button'DA2.da_GUI_IRC_Panel.MyJoinChannelButton'

     Begin Object Class=da_GUI_Button Name=MyRemoveChannelButton
         Caption="REMOVE"
         WinTop=0.500000
         WinLeft=0.770000
         WinWidth=0.200000
         WinHeight=0.300000
         RenderWeight=3.000000
         TabOrder=5
         bBoundToParent=True
         bScaleToParent=True
         OnClick=da_GUI_IRC_Panel.InternalOnClick
         OnKeyEvent=MyRemoveChannelButton.InternalOnKeyEvent
     End Object
     b_RemChannel=da_GUI_Button'DA2.da_GUI_IRC_Panel.MyRemoveChannelButton'

     ServerHistory(0)="irc.gamesurge.net"
     ServerHistory(1)="irc.enterthegame.com"
     ServerHistory(2)="irc.utchat.com"
     LocalChannel="#da"
}
