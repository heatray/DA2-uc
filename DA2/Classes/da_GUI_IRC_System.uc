// D:\mods\UT2004Script3339\GUI2K4\Classes\UT2k4IRC_System.uc
// D:\mods\UT2004Script3339\GUI2K4\Classes\UT2k4IRC_Page.uc

class da_GUI_IRC_System extends UT2K4IRC_System;

defaultproperties
{
     NewNickMenu="DA2.da_GUI_IRC_NewNick"
     ChanKeyMenu="DA2.da_GUI_IRC_ChanKey"
     Begin Object Class=da_GUI_moEditBox Name=EntryBox
         CaptionWidth=0.000000
         OnCreateComponent=EntryBox.InternalOnCreateComponent
         StyleName="IRCEntry"
         WinTop=0.950000
         WinLeft=0.000000
         WinWidth=1.000000
         WinHeight=0.050000
         TabOrder=0
         bBoundToParent=True
         bScaleToParent=True
         OnKeyEvent=da_GUI_IRC_System.InternalOnKeyEvent
     End Object
     ed_TextEntry=da_GUI_moEditBox'DA2.da_GUI_IRC_System.EntryBox'

     Begin Object Class=da_GUI_Splitter Name=SplitterA
         SplitPosition=0.800000
         bFixedSplitter=True
         DefaultPanels(0)="XInterface.GUIScrollTextBox"
         DefaultPanels(1)="DA2.da_GUI_IRC_Panel"
         OnCreateComponent=da_GUI_IRC_System.InternalOnCreateComponent
         WinHeight=0.950000
         TabOrder=1
     End Object
     sp_Main=da_GUI_Splitter'DA2.da_GUI_IRC_System.SplitterA'

}
