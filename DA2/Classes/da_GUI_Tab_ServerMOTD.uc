class da_GUI_Tab_ServerMOTD extends UT2K4Tab_ServerMOTD;

defaultproperties
{
     Begin Object Class=da_GUI_AltSectionBackground Name=sbMOTD
         Caption="Message of the Day"
         WinTop=0.030325
         WinLeft=0.035693
         WinWidth=0.922427
         WinHeight=0.644637
         bBoundToParent=True
         bScaleToParent=True
         OnPreDraw=sbMOTD.InternalPreDraw
     End Object
     sb_MOTD=da_GUI_AltSectionBackground'DA2.da_GUI_Tab_ServerMOTD.sbMOTD'

     Begin Object Class=da_GUI_AltSectionBackground Name=sbAdmin
         Caption="Your Admin is"
         WinTop=0.700000
         WinLeft=0.035693
         WinWidth=0.922427
         WinHeight=0.258224
         bBoundToParent=True
         bScaleToParent=True
         OnPreDraw=sbAdmin.InternalPreDraw
     End Object
     sb_Admin=da_GUI_AltSectionBackground'DA2.da_GUI_Tab_ServerMOTD.sbAdmin'

     Begin Object Class=da_GUI_ScrollTextBox Name=MOTDText
         bNoTeletype=True
         CharDelay=0.002500
         EOLDelay=0.000000
         TextAlign=TXTA_Center
         OnCreateComponent=MOTDText.InternalOnCreateComponent
         WinTop=0.441667
         WinHeight=0.558333
         bBoundToParent=True
         bScaleToParent=True
         bNeverFocus=True
     End Object
     lb_Text=da_GUI_ScrollTextBox'DA2.da_GUI_Tab_ServerMOTD.MOTDText'

}
