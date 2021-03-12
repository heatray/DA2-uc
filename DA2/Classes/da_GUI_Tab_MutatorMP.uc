// D:\mods\UT2004Script3339\GUI2K4\Classes\UT2K4Tab_MutatorMP.uc
// D:\mods\UT2004Script3339\GUI2K4\Classes\UT2K4Tab_MutatorBase.uc

class da_GUI_Tab_MutatorMP extends UT2K4Tab_MutatorMP;

defaultproperties
{
     Begin Object Class=da_GUI_SectionBackground Name=AvailBackground
         Caption="Available Mutators"
         LeftPadding=0.002500
         RightPadding=0.002500
         TopPadding=0.002500
         BottomPadding=0.002500
         WinTop=0.036614
         WinLeft=0.025156
         WinWidth=0.380859
         WinHeight=0.547697
         OnPreDraw=AvailBackground.InternalPreDraw
     End Object
     sb_Avail=da_GUI_SectionBackground'DA2.da_GUI_Tab_MutatorMP.AvailBackground'

     Begin Object Class=da_GUI_SectionBackground Name=ActiveBackground
         Caption="Active Mutators"
         LeftPadding=0.002500
         RightPadding=0.002500
         TopPadding=0.002500
         BottomPadding=0.002500
         WinTop=0.036614
         WinLeft=0.586876
         WinWidth=0.380859
         WinHeight=0.547697
         OnPreDraw=ActiveBackground.InternalPreDraw
     End Object
     sb_Active=da_GUI_SectionBackground'DA2.da_GUI_Tab_MutatorMP.ActiveBackground'

     Begin Object Class=da_GUI_SectionBackground Name=DescriptionBackground
         Caption="Mutator Details"
         LeftPadding=0.002500
         RightPadding=0.002500
         TopPadding=0.002500
         BottomPadding=0.002500
         WinTop=0.610678
         WinLeft=0.025976
         WinWidth=0.942969
         WinHeight=0.291796
         OnPreDraw=DescriptionBackground.InternalPreDraw
     End Object
     sb_Description=da_GUI_SectionBackground'DA2.da_GUI_Tab_MutatorMP.DescriptionBackground'

     Begin Object Class=da_GUI_ListBox Name=IAMutatorAvailList
         bVisibleWhenEmpty=True
         bSorted=True
         HandleContextMenuOpen=da_GUI_Tab_MutatorMP.ContextMenuOpen
         OnCreateComponent=IAMutatorAvailList.InternalOnCreateComponent
         Hint="These are the available mutators."
         WinTop=0.144937
         WinLeft=0.026108
         WinWidth=0.378955
         WinHeight=0.501446
         TabOrder=0
         Begin Object Class=da_GUI_ContextMenu Name=RCMenu
             ContextItems(0)="Vote for this Map"
             ContextItems(1)="View Screenshot and Description"
             OnSelect=da_GUI_MapVoteMultiColumnListBox.InternalOnClick
         End Object
         ContextMenu=da_GUI_ContextMenu'DA2.da_GUI_MapVoteMultiColumnListBox.RCMenu'

         OnChange=da_GUI_Tab_MutatorMP.ListChange
     End Object
     lb_Avail=da_GUI_ListBox'DA2.da_GUI_Tab_MutatorMP.IAMutatorAvailList'

     Begin Object Class=da_GUI_ListBox Name=IAMutatorSelectedList
         bVisibleWhenEmpty=True
         bSorted=True
         OnCreateComponent=IAMutatorSelectedList.InternalOnCreateComponent
         Hint="These are the current selected mutators."
         WinTop=0.144937
         WinLeft=0.584376
         WinWidth=0.378955
         WinHeight=0.501446
         TabOrder=5
         ContextMenu=da_GUI_ContextMenu'DA2.da_GUI_MapVoteMultiColumnListBox.RCMenu'

         OnChange=da_GUI_Tab_MutatorMP.ListChange
     End Object
     lb_Active=da_GUI_ListBox'DA2.da_GUI_Tab_MutatorMP.IAMutatorSelectedList'

     Begin Object Class=da_GUI_ScrollTextBox Name=IAMutatorScroll
         CharDelay=0.002500
         EOLDelay=0.500000
         bVisibleWhenEmpty=True
         OnCreateComponent=IAMutatorScroll.InternalOnCreateComponent
         WinTop=0.648595
         WinLeft=0.028333
         WinWidth=0.938254
         WinHeight=0.244296
         bTabStop=False
         bNeverFocus=True
     End Object
     lb_MutDesc=da_GUI_ScrollTextBox'DA2.da_GUI_Tab_MutatorMP.IAMutatorScroll'

     Begin Object Class=da_GUI_Button Name=IAMutatorConfig
         Caption="Configure Mutators"
         Hint="Configure the selected mutators"
         WinTop=0.933490
         WinLeft=0.729492
         WinWidth=0.239063
         WinHeight=0.054648
         TabOrder=6
         bVisible=False
         OnClick=da_GUI_Tab_MutatorMP.MutConfigClick
         OnKeyEvent=IAMutatorConfig.InternalOnKeyEvent
     End Object
     b_Config=da_GUI_Button'DA2.da_GUI_Tab_MutatorMP.IAMutatorConfig'

     Begin Object Class=da_GUI_Button Name=IAMutatorAdd
         Caption="Add"
         Hint="Adds the selection to the list of mutators to play with."
         WinTop=0.194114
         WinLeft=0.425000
         WinWidth=0.145000
         WinHeight=0.050000
         TabOrder=1
         OnClickSound=CS_Up
         OnClick=da_GUI_Tab_MutatorMP.AddMutator
         OnKeyEvent=IAMutatorAdd.InternalOnKeyEvent
     End Object
     b_Add=da_GUI_Button'DA2.da_GUI_Tab_MutatorMP.IAMutatorAdd'

     Begin Object Class=da_GUI_Button Name=IAMutatorAll
         Caption="Add All"
         Hint="Adds all mutators to the list of mutators to play with."
         WinTop=0.259218
         WinLeft=0.425000
         WinWidth=0.145000
         WinHeight=0.050000
         TabOrder=2
         OnClickSound=CS_Up
         OnClick=da_GUI_Tab_MutatorMP.AddAllMutators
         OnKeyEvent=IAMutatorAll.InternalOnKeyEvent
     End Object
     b_AddAll=da_GUI_Button'DA2.da_GUI_Tab_MutatorMP.IAMutatorAll'

     Begin Object Class=da_GUI_Button Name=IAMutatorRemove
         Caption="Remove"
         Hint="Removes the selection from the list of mutators to play with."
         WinTop=0.424322
         WinLeft=0.425000
         WinWidth=0.145000
         WinHeight=0.050000
         TabOrder=4
         OnClickSound=CS_Down
         OnClick=da_GUI_Tab_MutatorMP.RemoveMutator
         OnKeyEvent=IAMutatorRemove.InternalOnKeyEvent
     End Object
     b_Remove=da_GUI_Button'DA2.da_GUI_Tab_MutatorMP.IAMutatorRemove'

     Begin Object Class=da_GUI_Button Name=IAMutatorClear
         Caption="Remove All"
         Hint="Removes all mutators from the list of mutators to play with."
         WinTop=0.360259
         WinLeft=0.425000
         WinWidth=0.145000
         WinHeight=0.050000
         TabOrder=3
         OnClickSound=CS_Down
         OnClick=da_GUI_Tab_MutatorMP.RemoveAllMutators
         OnKeyEvent=IAMutatorClear.InternalOnKeyEvent
     End Object
     b_RemoveAll=da_GUI_Button'DA2.da_GUI_Tab_MutatorMP.IAMutatorClear'

     MutConfigMenu="DA2.da_GUI_MutatorConfigMenu"
     bStandardized=True
     StandardHeight=0.780000
}
