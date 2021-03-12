// D:\mods\UT2004Script3339\XInterface\Classes\GUITreeListBox.uc
// D:\mods\UT2004Script3339\XInterface\Classes\GUIListBoxBase.uc

class da_GUI_TreeListBox extends GUITreeListBox;

defaultproperties
{
     SelectedStyleName="DA2Style_BodyTextSelected"
     DefaultListClass="DA2.da_GUI_TreeList"
     Begin Object Class=da_GUI_TreeScrollBar Name=TreeScrollbar
         bVisible=False
         OnPreDraw=TreeScrollbar.GripPreDraw
     End Object
     MyScrollBar=da_GUI_TreeScrollBar'DA2.da_GUI_TreeListBox.TreeScrollbar'

     StyleName="DA2Style_BodyText"
}
