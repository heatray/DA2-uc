// D:\mods\UT2004Script3339\GUI2K4\Classes\UT2K4Browser_BuddyListBox.uc
// D:\mods\UT2004Script3339\GUI2K4\Classes\ServerBrowserMCListBox.uc

class da_GUI_Browser_BuddyListBox extends UT2K4Browser_BuddyListBox;

defaultproperties
{
     Begin Object Class=da_GUI_MultiColumnListHeader Name=MyHeader
     End Object
     Header=da_GUI_MultiColumnListHeader'DA2.da_GUI_Browser_BuddyListBox.MyHeader'

     SelectedStyleName="DA2Style_BodyTextSelected"
     DefaultListClass="DA2.da_GUI_Browser_BuddyList"
     Begin Object Class=da_GUI_VertScrollBar Name=TheScrollbar
         bVisible=False
         OnPreDraw=TheScrollbar.GripPreDraw
     End Object
     MyScrollBar=da_GUI_VertScrollBar'DA2.da_GUI_Browser_BuddyListBox.TheScrollbar'

     StyleName="DA2Style_BodyText"
}
