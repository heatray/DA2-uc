// ====================================================================
// Custom GUI Style for DA2 MainMenu buttons
// ====================================================================

// Text that's used on the main menu 'buttons'
// Reference: http://udn.epicgames.com/Two/GuiReference#GUIStyles

class da_GUI_daStyle_TabButton extends GUI2Styles;

defaultproperties
{
     KeyName="DA2Style_TabButton"
     FontNames(0)="DA2ButtonFont"
     FontNames(1)="DA2ButtonFont"
     FontNames(2)="DA2ButtonFont"
     FontNames(3)="DA2ButtonFont"
     FontNames(4)="DA2ButtonFont"
     FontNames(5)="DA2ButtonFont"
     FontNames(6)="DA2ButtonFont"
     FontNames(7)="DA2ButtonFont"
     FontNames(8)="DA2ButtonFont"
     FontNames(9)="DA2ButtonFont"
     FontNames(10)="DA2ButtonFont"
     FontNames(11)="DA2ButtonFont"
     FontNames(12)="DA2ButtonFont"
     FontNames(13)="DA2ButtonFont"
     FontNames(14)="DA2ButtonFont"
     FontColors(0)=(B=255,G=255,R=255)
     FontColors(2)=(B=255,G=255,R=255)
     FontColors(3)=(B=255,G=255,R=255)
     FontColors(4)=(B=255,G=255,R=255,A=63)
     RStyles(0)=MSTY_Alpha
     RStyles(1)=MSTY_Alpha
     RStyles(2)=MSTY_Alpha
     RStyles(3)=MSTY_Alpha
     RStyles(4)=MSTY_Alpha
     Images(0)=Texture'DA2GUI.Dialog.buttonTab_blurry'
     Images(1)=Texture'DA2GUI.Dialog.buttonTab_watched'
     Images(2)=Texture'DA2GUI.Dialog.buttonTab_focused'
     Images(3)=Texture'DA2GUI.Dialog.buttonTab_pressed'
     Images(4)=Texture'DA2GUI.Dialog.buttonTab_disabled'
}
