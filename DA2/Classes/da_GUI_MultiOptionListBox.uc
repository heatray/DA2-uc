// D:\mods\UT2004Script3339\XInterface\Classes\GUIMultiOptionListBox.uc
// D:\mods\UT2004Script3339\XInterface\Classes\GUIListBoxBase.uc

class da_GUI_MultiOptionListBox extends GUIMultiOptionListBox;

defaultproperties
{
     SelectedStyleName="DA2Style_BodyText"
     SectionStyleName="DA2Style_BodyText"
     OutlineStyleName="DA2Style_BodyText"
     DefaultListClass="DA2.da_GUI_MultiOptionList"
     Begin Object Class=da_GUI_VertScrollBar Name=TheScrollbar
         bVisible=False
         OnPreDraw=TheScrollbar.GripPreDraw
     End Object
     MyScrollBar=da_GUI_VertScrollBar'DA2.da_GUI_MultiOptionListBox.TheScrollbar'

     StyleName="DA2Style_BodyText"
     Begin Object Class=GUIToolTip Name=GUIListBoxBaseToolTip
     End Object
     ToolTip=GUIToolTip'DA2.da_GUI_MultiOptionListBox.GUIListBoxBaseToolTip'

}
