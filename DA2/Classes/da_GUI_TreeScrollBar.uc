// D:\mods\UT2004Script3339\XInterface\Classes\GUITreeScrollBar.uc

class da_GUI_TreeScrollBar extends GUITreeScrollBar;

defaultproperties
{
     Begin Object Class=da_GUI_VertScrollZone Name=ScrollZone
         OnScrollZoneClick=da_GUI_TreeScrollBar.ZoneClick
         OnClick=ScrollZone.InternalOnClick
     End Object
     MyScrollZone=da_GUI_VertScrollZone'DA2.da_GUI_TreeScrollBar.ScrollZone'

     Begin Object Class=da_GUI_VertScrollButton Name=DownBut
         bIncreaseButton=True
         OnClick=da_GUI_TreeScrollBar.IncreaseClick
         OnKeyEvent=DownBut.InternalOnKeyEvent
     End Object
     MyIncreaseButton=da_GUI_VertScrollButton'DA2.da_GUI_TreeScrollBar.DownBut'

     Begin Object Class=da_GUI_VertScrollButton Name=UpBut
         OnClick=da_GUI_TreeScrollBar.DecreaseClick
         OnKeyEvent=UpBut.InternalOnKeyEvent
     End Object
     MyDecreaseButton=da_GUI_VertScrollButton'DA2.da_GUI_TreeScrollBar.UpBut'

     Begin Object Class=da_GUI_VertGripButton Name=Grip
         OnMousePressed=da_GUI_TreeScrollBar.GripPressed
         OnKeyEvent=Grip.InternalOnKeyEvent
     End Object
     MyGripButton=da_GUI_VertGripButton'DA2.da_GUI_TreeScrollBar.Grip'

}
