// D:\mods\UT2004Script3339\GUI2K4\Classes\UT2K4Browser_ServerListBox.uc
// D:\mods\UT2004Script3339\GUI2K4\Classes\ServerBrowserMCListBox.uc
// D:\mods\UT2004Script3339\XInterface\Classes\GUIMultiColumnListBox.uc

class da_GUI_Browser_ServerListBox extends UT2K4Browser_ServerListBox;

/*
function AddFavClosed( bool bCancelled ) {
  tp_Anchor.Browser.OnAddFavorite(da_GUI_EditFavoritePage(Controller.ActivePage).Server);
}
*/

defaultproperties
{
     OpenIPPage="DA2.da_GUI_Browser_OpenIP"
     Begin Object Class=da_GUI_MultiColumnListHeader Name=MyHeader
     End Object
     Header=da_GUI_MultiColumnListHeader'DA2.da_GUI_Browser_ServerListBox.MyHeader'

     SelectedStyleName="DA2Style_BodyTextSelected"
     DefaultListClass="DA2.da_GUI_Browser_ServersList"
     Begin Object Class=da_GUI_VertScrollBar Name=TheScrollbar
         bVisible=False
         OnPreDraw=TheScrollbar.GripPreDraw
     End Object
     MyScrollBar=da_GUI_VertScrollBar'DA2.da_GUI_Browser_ServerListBox.TheScrollbar'

     StyleName="DA2Style_BodyText"
     Begin Object Class=GUIContextMenu Name=RCMenu
         ContextItems(0)="Join Server"
         ContextItems(1)="Join As Spectator"
         ContextItems(2)="-"
         ContextItems(3)="Refresh Server Info"
         ContextItems(4)="Refresh List"
         ContextItems(5)="-"
         ContextItems(6)="Configure Filters"
         ContextItems(7)="Create Template"
         ContextItems(8)="Deactivate All Filters"
         ContextItems(9)="-"
         ContextItems(10)="Add To Favorites"
         ContextItems(11)="Copy server address"
         ContextItems(12)="Open IP"
         SelectionStyleName="DA2Style_BodyTextSelected"
         OnOpen=da_GUI_Browser_ServerListBox.InternalOnOpen
         OnClose=da_GUI_Browser_ServerListBox.InternalOnClose
         OnSelect=da_GUI_Browser_ServerListBox.InternalOnClick
         StyleName="DA2Style_BodyTextSelected"
     End Object
     ContextMenu=GUIContextMenu'DA2.da_GUI_Browser_ServerListBox.RCMenu'

}
