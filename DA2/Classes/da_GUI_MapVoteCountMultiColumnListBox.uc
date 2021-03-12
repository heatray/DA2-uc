class da_GUI_MapVoteCountMultiColumnListBox extends MapVoteCountMultiColumnListBox;

defaultproperties
{
     Begin Object Class=da_GUI_MultiColumnListHeader Name=MyHeader
     End Object
     Header=da_GUI_MultiColumnListHeader'DA2.da_GUI_MapVoteCountMultiColumnListBox.MyHeader'

     SelectedStyleName="DA2Style_BodyTextSelected"
     SectionStyleName="DA2Style_BodyText"
     OutlineStyleName="DA2Style_BodyText"
     DefaultListClass="ROInterface.ROMapVoteCountMultiColumnList"
     Begin Object Class=da_GUI_VertScrollBar Name=TheScrollbar
         bVisible=False
         OnPreDraw=TheScrollbar.GripPreDraw
     End Object
     MyScrollBar=da_GUI_VertScrollBar'DA2.da_GUI_MapVoteCountMultiColumnListBox.TheScrollbar'

     StyleName="DA2Style_BodyText"
     Begin Object Class=da_GUI_ContextMenu Name=RCMenu
         OnSelect=da_GUI_MapVoteCountMultiColumnListBox.InternalOnClick
     End Object
     ContextMenu=da_GUI_ContextMenu'DA2.da_GUI_MapVoteCountMultiColumnListBox.RCMenu'

     OnRightClick=da_GUI_MapVoteCountMultiColumnListBox.InternalOnRightClick
}
