// D:\mods\UT2004Script3339\GUI2K4\Classes\FloatingWindow.uc

class da_GUI_FloatingWindow_MapVote extends Largewindow DependsOn (da_VotingHandler);

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
	b_ExitButton.bRepeatClick = False;
}

defaultproperties
{
     Begin Object Class=da_GUI_Header Name=TitleBar
         WinTop=0.072500
         WinLeft=0.100000
         WinWidth=0.800000
         OnMousePressed=da_GUI_FloatingWindow_MapVote.FloatingMousePressed
         OnMouseRelease=da_GUI_FloatingWindow_MapVote.FloatingMouseRelease
     End Object
     t_WindowTitle=da_GUI_Header'DA2.da_GUI_FloatingWindow_MapVote.TitleBar'

     OnPreDraw=da_GUI_FloatingWindow_MapVote.InternalOnPreDraw
}
