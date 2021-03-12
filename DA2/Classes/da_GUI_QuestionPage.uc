class da_GUI_QuestionPage extends GUI2K4QuestionPage;

function GUIButton AddButton(coerce byte idesc)
{
	local GUIButton btn;
	local byte mask;
	local int cnt;

	if ( idesc == 0 )
		return None;

	mask = 1;
	while ( !bool(mask & idesc) )
	{
		cnt++;
		mask = mask << 1;
	}

	if ( cnt >= ButtonNames.Length )
	{
		log("GUIQuestionPage.AddButton() button mask was larger than button name array!");
		return None;
	}

	btn = GUIButton(AddComponent("DA2.da_GUI_Button"));
	if ( btn == None )
		return None;

	btn.Tag = idesc;
	btn.TabOrder = Components.Length;
	btn.Caption = ButtonNames[cnt];
	btn.OnClick = ButtonClick;

	Buttons[Buttons.Length] = btn;
	return btn;
}

defaultproperties
{
     Begin Object Class=GUIImage Name=imgBack
         Image=Texture'DA2GUI.Dialog.window_1024x768'
         ImageStyle=ISTY_Stretched
         ImageRenderStyle=MSTY_Normal
         DropShadowY=10
         WinTop=0.375000
         WinLeft=0.200000
         WinWidth=0.600000
         WinHeight=0.250000
     End Object
     Controls(0)=GUIImage'DA2.da_GUI_QuestionPage.imgBack'

     Begin Object Class=GUILabel Name=lblQuestion
         TextAlign=TXTA_Center
         bMultiLine=True
         StyleName="TextLabel"
         WinTop=0.366483
         WinLeft=0.150000
         WinWidth=0.700000
         WinHeight=0.065714
     End Object
     Controls(1)=GUILabel'DA2.da_GUI_QuestionPage.lblQuestion'

     Begin Object Class=GUILabel Name=CCTitle
         Caption="ERROR"
         TextAlign=TXTA_Center
         FontScale=FNS_Large
         StyleName="DA2Style_DialogText"
         WinTop=0.379000
         WinLeft=0.200000
         WinWidth=0.600000
         WinHeight=0.039000
     End Object
     Controls(2)=GUILabel'DA2.da_GUI_QuestionPage.CCTitle'

}
