// D:\mods\UT2004Script3339\XInterface\Classes\GUIScrollTextBox.uc
// D:\mods\UT2004Script3339\XInterface\Classes\GUIListBoxBase.uc

class da_GUI_ScrollTextBox extends GUIScrollTextBox;

defaultproperties
{
     SelectedStyleName="DA2Style_BodyTextSelected"
     DefaultListClass="DA2.da_GUI_ScrollText"
     Begin Object Class=da_GUI_VertScrollBar Name=TheScrollbar
         bVisible=False
         OnPreDraw=TheScrollbar.GripPreDraw
     End Object
     MyScrollBar=da_GUI_VertScrollBar'DA2.da_GUI_ScrollTextBox.TheScrollbar'

     StyleName="DA2Style_BodyText"
}
