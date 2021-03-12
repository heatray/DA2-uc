class da_GUI_MapVoteMultiColumnListBox extends MapVoteMultiColumnListBox;

defaultproperties
{
     Begin Object Class=da_GUI_MultiColumnListHeader Name=MyHeader
     End Object
     Header=da_GUI_MultiColumnListHeader'DA2.da_GUI_MapVoteMultiColumnListBox.MyHeader'

     SelectedStyleName="DA2Style_BodyTextSelected"
     SectionStyleName="DA2Style_BodyText"
     OutlineStyleName="DA2Style_BodyText"
     Begin Object Class=da_GUI_VertScrollBar Name=TheScrollbar
         bVisible=False
         OnPreDraw=TheScrollbar.GripPreDraw
     End Object
     MyScrollBar=da_GUI_VertScrollBar'DA2.da_GUI_MapVoteMultiColumnListBox.TheScrollbar'

     StyleName="DA2Style_BodyText"
     ContextMenu=da_GUI_ContextMenu'DA2.da_GUI_MapVoteMultiColumnListBox.RCMenu'

     OnRightClick=da_GUI_MapVoteMultiColumnListBox.InternalOnRightClick
}
