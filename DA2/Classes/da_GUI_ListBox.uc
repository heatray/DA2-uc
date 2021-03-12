// D:\mods\UT2004Script3339\XInterface\Classes\GUIListBox.uc

class da_GUI_ListBox extends GUIListBox;

defaultproperties
{
     SelectedStyleName="DA2Style_BodyTextSelected"
     DefaultListClass="DA2.da_GUI_List"
     Begin Object Class=da_GUI_VertScrollBar Name=TheScrollbar
         bVisible=False
         OnPreDraw=TheScrollbar.GripPreDraw
     End Object
     MyScrollBar=da_GUI_VertScrollBar'DA2.da_GUI_ListBox.TheScrollbar'

     StyleName="DA2Style_BodyText"
}
