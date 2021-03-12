// D:\mods\UT2004Script3339\GUI2K4\Classes\UT2K4Browser_PlayersListBox.uc
// D:\mods\UT2004Script3339\GUI2K4\Classes\ServerBrowserMCListBox.uc
// D:\mods\UT2004Script3339\XInterface\Classes\GUIMultiColumnListBox.uc

class da_GUI_Browser_PlayersListBox extends UT2K4Browser_PlayersListBox;

defaultproperties
{
     Begin Object Class=da_GUI_MultiColumnListHeader Name=MyHeader
     End Object
     Header=da_GUI_MultiColumnListHeader'DA2.da_GUI_Browser_PlayersListBox.MyHeader'

     SelectedStyleName="DA2Style_BodyTextSelected"
     DefaultListClass="DA2.da_GUI_Browser_PlayersList"
     Begin Object Class=da_GUI_VertScrollBar Name=TheScrollbar
         bVisible=False
         OnPreDraw=TheScrollbar.GripPreDraw
     End Object
     MyScrollBar=da_GUI_VertScrollBar'DA2.da_GUI_Browser_PlayersListBox.TheScrollbar'

     StyleName="DA2Style_BodyText"
}
