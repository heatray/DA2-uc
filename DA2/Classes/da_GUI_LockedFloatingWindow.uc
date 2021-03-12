class da_GUI_LockedFloatingWindow extends LockedFloatingWindow;

defaultproperties
{
     Begin Object Class=da_GUI_AltSectionBackground Name=InternalFrameImage
         WinTop=0.177500
         WinLeft=0.040000
         WinWidth=0.675859
         WinHeight=0.490000
         OnPreDraw=InternalFrameImage.InternalPreDraw
     End Object
     sb_Main=da_GUI_AltSectionBackground'DA2.da_GUI_LockedFloatingWindow.InternalFrameImage'

     Begin Object Class=da_GUI_Button Name=LockedCancelButton
         Caption="Cancel"
         bAutoShrink=False
         WinTop=0.872397
         WinLeft=0.512695
         WinWidth=0.159649
         TabOrder=99
         bBoundToParent=True
         OnClick=da_GUI_LockedFloatingWindow.InternalOnClick
         OnKeyEvent=LockedCancelButton.InternalOnKeyEvent
     End Object
     b_Cancel=da_GUI_Button'DA2.da_GUI_LockedFloatingWindow.LockedCancelButton'

     Begin Object Class=da_GUI_Button Name=LockedOKButton
         Caption="OK"
         bAutoShrink=False
         WinTop=0.872397
         WinLeft=0.742188
         WinWidth=0.159649
         TabOrder=100
         bBoundToParent=True
         OnClick=da_GUI_LockedFloatingWindow.InternalOnClick
         OnKeyEvent=LockedOKButton.InternalOnKeyEvent
     End Object
     b_OK=da_GUI_Button'DA2.da_GUI_LockedFloatingWindow.LockedOKButton'

     t_WindowTitle=da_GUI_Header'DA2.da_GUI_LockedFloatingWindow.TitleBar'

}
