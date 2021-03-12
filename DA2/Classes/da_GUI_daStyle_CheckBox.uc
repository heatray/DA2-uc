// ====================================================================
// Custom GUI Style for DA2 MainMenu buttons
// ====================================================================

// Text that's used on the main menu 'buttons'
// Reference: http://udn.epicgames.com/Two/GuiReference#GUIStyles

class da_GUI_daStyle_CheckBox extends GUI2Styles;

defaultproperties
{
     KeyName="DA2Style_CheckBox"
     Images(0)=Texture'DA2GUI.Dialog.checkbox_blurry'
     Images(1)=Texture'DA2GUI.Dialog.checkbox_watched'
     Images(2)=Texture'DA2GUI.Dialog.checkbox_focused'
     Images(3)=Texture'DA2GUI.Dialog.checkbox_pressed'
     Images(4)=Texture'DA2GUI.Dialog.checkbox_disabled'
}
