// D:\mods\UT2004Script3339\GUI2K4\Classes\UT2K4GUIController.uc
// D:\mods\UT2004Script3339\XInterface\Classes\GUIController.uc

class da_GUI_Controller extends UT2K4GUIController;

#exec OBJ LOAD FILE=DA2GUIAudio.uax
#exec OBJ LOAD FILE=ROMenuSounds.uax
//#exec OBJ LOAD FILE=..\Textures\DA2Fonts.utx PACKAGE=DA2Fonts
//#exec OBJ LOAD FILE=..\Textures\DA2FontsBody.utx PACKAGE=DA2FontsBody
//#exec OBJ LOAD FILE=..\Textures\DA2FontsDialog.utx PACKAGE=DA2FontsDialog

defaultproperties
{
     STYLE_NUM=79
     MouseCursorOffset(0)=(X=0.031250,Y=0.015625)
     FontStack(11)=da_GUI_fontMainMenu'DA2.da_GUI_Controller.DA2MainMenuFont'
     FontStack(12)=da_GUI_fontMainMenuDescription'DA2.da_GUI_Controller.DA2MainMenuDescriptionFont'
     FontStack(13)=da_GUI_fontBody'DA2.da_GUI_Controller.DA2BodyFont'
     FontStack(14)=da_GUI_fontBodyBig'DA2.da_GUI_Controller.DA2BodyFontBig'
     FontStack(15)=da_GUI_fontDialogTitle'DA2.da_GUI_Controller.DA2DialogTitleFont'
     FontStack(16)=da_GUI_fontButton'DA2.da_GUI_Controller.DA2ButtonFont'
     FontStack(17)=da_GUI_font'DA2.da_GUI_Controller.DA2Font'
     MouseCursors(0)=Texture'DA2GUI.Cursors.Pointer'
     MouseCursors(1)=Texture'DA2GUI.Cursors.All'
     MouseCursors(2)=Texture'DA2GUI.Cursors.nesw'
     MouseCursors(3)=Texture'DA2GUI.Cursors.ns'
     MouseCursors(4)=Texture'DA2GUI.Cursors.nwse'
     MouseCursors(5)=Texture'DA2GUI.Cursors.ew'
     MouseCursors(6)=Texture'DA2GUI.Cursors.Pointer_old'
     ImageList(1)=Texture'DA2GUI.Dialog.DownMark'
     ImageList(2)=Texture'DA2GUI.Dialog.LeftMark'
     ImageList(3)=Texture'DA2GUI.Dialog.RightMark'
     ImageList(6)=Texture'DA2GUI.Dialog.UpMark'
     ImageList(7)=Texture'DA2GUI.Dialog.DownMark'
     DefaultStyleNames(37)="ROInterface.ROSTY2SliderKnob"
     DefaultStyleNames(42)="DA2.da_GUI_STY2MouseOverLabel"
     DefaultStyleNames(43)="ROInterface.ROSTY2SliderBar"
     DefaultStyleNames(60)="DA2.da_GUI_daStyle_MainMenuText"
     DefaultStyleNames(61)="DA2.da_GUI_daStyle_BodyText"
     DefaultStyleNames(62)="DA2.da_GUI_daStyle_BodyTextBig"
     DefaultStyleNames(63)="DA2.da_GUI_daStyle_BodyTextSelected"
     DefaultStyleNames(64)="DA2.da_GUI_daStyle_Button"
     DefaultStyleNames(65)="DA2.da_GUI_daStyle_CheckBox"
     DefaultStyleNames(66)="DA2.da_GUI_daStyle_ComboButton"
     DefaultStyleNames(67)="DA2.da_GUI_daStyle_TabButton"
     DefaultStyleNames(68)="DA2.da_GUI_daStyle_DialogText"
     DefaultStyleNames(69)="DA2.da_GUI_daStyle_ScoreboardText"
     DefaultStyleNames(70)="DA2.da_GUI_daStyle_Footer"
     DefaultStyleNames(71)="DA2.da_GUI_daStyle_EditBox"
     DefaultStyleNames(72)="DA2.da_GUI_daStyle_SpinnerButton"
     DefaultStyleNames(73)="DA2.da_GUI_daStyle_HiliteText"
     DefaultStyleNames(74)="DA2.da_GUI_daStyle_Raised"
     DefaultStyleNames(75)="DA2.da_GUI_daStyle_Lowered"
     DefaultStyleNames(76)="DA2.da_GUI_daStyle_VertDownButton"
     DefaultStyleNames(77)="DA2.da_GUI_daStyle_VertUpButton"
     DefaultStyleNames(78)="DA2.da_GUI_daStyle_CloseButton"
     MouseOverSound=Sound'DA2GUIAudio.MouseOver'
     ClickSound=Sound'DA2GUIAudio.click'
     RequestDataMenu="DA2.da_GUI_GetDataMenu"
     FilterMenu="DA2.da_GUI_FilterListPage"
     MapVotingMenu="DA2.da_MapVotingPage"
     EditFavoriteMenu="DA2.da_GUI_EditFavoritePage"
     MainMenuOptions(0)="GUI2K4.UT2K4SP_Main"
     MainMenuOptions(1)="DA2.da_gui_ServerBrowser"
     MainMenuOptions(2)="DA2.da_gui_GamePageMP"
     MainMenuOptions(3)="DA2.da_gui_GamePageSP"
     MainMenuOptions(5)="DA2.da_gui_SettingsPage"
     MainMenuOptions(6)="DA2.da_gui_QuitPage"
     bFixedMouseSize=True
     QuestionMenuClass="DA2.da_GUI_QuestionPage"
}
