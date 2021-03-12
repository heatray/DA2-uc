// D:\mods\UT2004Script3339\GUI2K4\Classes\FloatingWindow.uc

class da_GUI_FloatingWindow extends FloatingWindow; // UT2K4PlayerLoginMenu;
     
function bool InternalOnPreDraw(canvas c) {
  i_FrameBG.Image = class'da_GUI_Utilities'.static.getCorrectBackground(c);
  Super.InternalOnPreDraw(c);
  return false;
}

function AddSystemMenu() {
  local eFontScale tFontScale;

  b_ExitButton = GUIButton(t_WindowTitle.AddComponent("DA2.da_GUI_Button"));
  b_ExitButton.Style = Controller.GetStyle("DA2Style_CloseButton",tFontScale);
  b_ExitButton.OnClick = XButtonClicked;
  b_ExitButton.bNeverFocus=true;
  b_ExitButton.FocusInstead = t_WindowTitle;
  b_ExitButton.RenderWeight=1;
  b_ExitButton.bScaleToParent=false;
  b_ExitButton.OnPreDraw = SystemMenuPreDraw;

  // Do not want OnClick() called from MousePressed()
  b_ExitButton.bRepeatClick = False;

//  t_WindowTitle.
}

defaultproperties
{
     Begin Object Class=da_GUI_Header Name=TitleBar
         bUseTextHeight=True
         Caption="Defence Alliance 2"
         FontScale=FNS_Small
         WinTop=0.065500
         RenderWeight=0.100000
         bBoundToParent=True
         bScaleToParent=True
         bNeverFocus=False
         ScalingType=SCALE_X
         OnMousePressed=da_GUI_FloatingWindow.FloatingMousePressed
         OnMouseRelease=da_GUI_FloatingWindow.FloatingMouseRelease
     End Object
     t_WindowTitle=da_GUI_Header'DA2.da_GUI_FloatingWindow.TitleBar'

     Begin Object Class=FloatingImage Name=FFrameBackground
         Image=Texture'DA2GUI.Dialog.window_1024x768'
         DropShadow=None
         ImageStyle=ISTY_Stretched
         ImageRenderStyle=MSTY_Normal
         WinTop=0.000000
         WinLeft=0.000000
         WinWidth=1.000000
         WinHeight=1.000000
         RenderWeight=0.000003
     End Object
     i_FrameBG=FloatingImage'DA2.da_GUI_FloatingWindow.FFrameBackground'

     WinTop=0.250000
     WinLeft=0.150000
     WinWidth=0.700000
     bAcceptsInput=False
     OnPreDraw=da_GUI_FloatingWindow.InternalOnPreDraw
}
