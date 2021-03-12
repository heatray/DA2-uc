// D:\mods\UT2004Script3339\XInterface\Classes\GUIVertScrollBar.uc

class da_GUI_VertScrollBar extends GUIVertScrollBar;

defaultproperties
{
     Begin Object Class=da_GUI_VertScrollZone Name=ScrollZone
         OnScrollZoneClick=da_GUI_VertScrollBar.ZoneClick
         OnClick=ScrollZone.InternalOnClick
     End Object
     MyScrollZone=da_GUI_VertScrollZone'DA2.da_GUI_VertScrollBar.ScrollZone'

     Begin Object Class=da_GUI_VertScrollButton Name=DownBut
         bIncreaseButton=True
         OnClick=da_GUI_VertScrollBar.IncreaseClick
         OnKeyEvent=DownBut.InternalOnKeyEvent
     End Object
     MyIncreaseButton=da_GUI_VertScrollButton'DA2.da_GUI_VertScrollBar.DownBut'

     Begin Object Class=da_GUI_VertScrollButton Name=UpBut
         OnClick=da_GUI_VertScrollBar.DecreaseClick
         OnKeyEvent=UpBut.InternalOnKeyEvent
     End Object
     MyDecreaseButton=da_GUI_VertScrollButton'DA2.da_GUI_VertScrollBar.UpBut'

     Begin Object Class=da_GUI_VertGripButton Name=Grip
         OnMousePressed=da_GUI_VertScrollBar.GripPressed
         OnKeyEvent=Grip.InternalOnKeyEvent
     End Object
     MyGripButton=da_GUI_VertGripButton'DA2.da_GUI_VertScrollBar.Grip'

}
