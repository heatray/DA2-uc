// D:\mods\UT2004Script3339\GUI2K4\Classes\GUIMultiColumnListBox.uc

class da_GUI_MultiColumnListBox extends GUIMultiColumnListBox;

defaultproperties
{
     Begin Object Class=da_GUI_MultiColumnListHeader Name=MyHeader
     End Object
     Header=da_GUI_MultiColumnListHeader'DA2.da_GUI_MultiColumnListBox.MyHeader'

     SelectedStyleName="DA2Style_BodyTextSelected"
     SectionStyleName="DA2Style_BodyText"
     DefaultListClass="DA2.da_GUI_MultiColumnList"
     Begin Object Class=da_GUI_VertScrollBar Name=TheScrollbar
         bVisible=False
         OnPreDraw=TheScrollbar.GripPreDraw
     End Object
     MyScrollBar=da_GUI_VertScrollBar'DA2.da_GUI_MultiColumnListBox.TheScrollbar'

     StyleName="DA2Style_BodyText"
}
