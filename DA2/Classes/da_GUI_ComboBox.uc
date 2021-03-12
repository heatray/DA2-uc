// D:\mods\UT2004Script3339\XInterface\Classes\GUIComboBox.uc

class da_GUI_ComboBox extends GUIComboBox;

defaultproperties
{
     Begin Object Class=da_GUI_EditBox Name=EditBox1
         bNeverScale=True
         OnActivate=EditBox1.InternalActivate
         OnDeActivate=EditBox1.InternalDeactivate
         OnKeyType=EditBox1.InternalOnKeyType
         OnKeyEvent=EditBox1.InternalOnKeyEvent
     End Object
     Edit=da_GUI_EditBox'DA2.da_GUI_ComboBox.EditBox1'

     Begin Object Class=da_GUI_ComboButton Name=ShowList
         RenderWeight=0.600000
         bNeverScale=True
         OnKeyEvent=ShowList.InternalOnKeyEvent
     End Object
     MyShowListBtn=da_GUI_ComboButton'DA2.da_GUI_ComboBox.ShowList'

     Begin Object Class=da_GUI_ListBox Name=ListBox1
         OnCreateComponent=ListBox1.InternalOnCreateComponent
         StyleName="DA2Style_Lowered"
         RenderWeight=0.700000
         bTabStop=False
         bVisible=False
         bNeverScale=True
     End Object
     MyListBox=da_GUI_ListBox'DA2.da_GUI_ComboBox.ListBox1'

}
