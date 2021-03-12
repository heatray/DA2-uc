// D:\mods\UT2004Script3339\GUI2K4\Classes\UT2k4IRC_Channel.uc
// D:\mods\UT2004Script3339\GUI2K4\Classes\UT2k4IRC_Page.uc

class da_GUI_IRC_Channel extends UT2K4IRC_Channel;

defaultproperties
{
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
         OnKeyEvent=da_GUI_IRC_Channel.InternalOnKeyEvent
     End Object
     ed_TextEntry=da_GUI_moEditBox'DA2.da_GUI_IRC_Channel.EntryBox'

     Begin Object Class=da_GUI_Splitter Name=SplitterA
         SplitOrientation=SPLIT_Horizontal
         SplitPosition=0.750000
         DefaultPanels(0)="XInterface.GUIScrollTextBox"
         DefaultPanels(1)="DA2.da_GUI_ListBox"
         OnReleaseSplitter=da_GUI_IRC_Channel.InternalOnReleaseSplitter
         OnCreateComponent=da_GUI_IRC_Channel.InternalOnCreateComponent
         IniOption="@Internal"
         WinHeight=0.950000
         OnLoadINI=da_GUI_IRC_Channel.InternalOnLoadINI
     End Object
     sp_Main=da_GUI_Splitter'DA2.da_GUI_IRC_Channel.SplitterA'

}
