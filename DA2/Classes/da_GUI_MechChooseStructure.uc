// TODO!!!! [zeh]
// * make the description use a scrollable text instead of a GUILabel (needs for 640x480), same as da_GUI_chooseClass.uc

class da_GUI_mechChooseStructure extends GUIPage;

var automated GUIImage i_bg; // 0
var automated GUILabel l_Title; // 1
var automated GUIImage i_BGStruc; // 2
var automated GUIButton b_Struc1, b_Struc2, b_Struc3, b_Struc4; // 3, 4, 5, 6
var automated GUIButton b_Accept, b_Cancel; // 10, 11
var automated GUIImage i_CBGTop, i_CBGMiddle, i_CBGBottom; // 12, 13, 14
var automated GUILabel l_CPreview; // 15
var automated GUILabel l_CDesc; // 16
var automated GUIImage i_SGrid; // 17

var automated GUILabel l_AmmoC, l_AVeRC, l_CrushC, l_DFAC;

var string selectedStructure;

function bool MyKeyEvent(out byte Key,out byte State,float delta) {
//	if(Key == 0x1B && state == 1)	// Escape pressed
//		bAllowClose = true;

//	log ("=== Key = " $ Key $ ", state = " $ state);

	if (Key == 49 && state == 1) {
		// Pressed 1
		da_players_ClassPlayer(playerOwner().pawn).build('AmmoBox');
		Controller.CloseMenu();
	}

	if (Key == 50 && state == 1) {
		// Pressed 2
		da_players_ClassPlayer(playerOwner().pawn).build('aver');
		Controller.CloseMenu();
	}

	if (Key == 51 && state == 1) {
		// Pressed 3
		da_players_ClassPlayer(playerOwner().pawn).build('crusher');
		Controller.CloseMenu();
	}

	if (Key == 52 && state == 1) {
		// Pressed 4
		da_players_ClassPlayer(playerOwner().pawn).build('dfaturret');
		Controller.CloseMenu();
	}

	return false;
}



function bool InternalOnPreDraw(canvas c) {
	i_bg.Image = class'da_GUI_Utilities'.static.getCorrectBackground(c);

	return false;
}


//function CountTurrets(da_players_ClassPlayer dap)
//{
//    local da_players_TeamConfig cfg;
//
//    cfg = da_game_ReplicationInfo(dap.level.GRI).teamConfig[dap.PlayerReplicationInfo.team.teamindex];
//
//    l_AmmoC.Caption=cfg.numAmmoboxes@"allowed";
//	//l_AVeRC.Caption=(countTurrets(class'da_turrets_AVeRTurret') - cfg.numAVeRs)@"available";
//        l_AVeRC.Caption=cfg.numAVeRs@"allowed";
//	l_CrushC.Caption=cfg.numCrushers@"allowed";
//	l_DFAC.Caption=cfg.numDFAs@"allowed";
//}

//function InitComponent(GUIController MyController, GUIComponent MyOwner)
//{
//    Super.InitComponent(mycontroller, myowner);
//
//    CountTurrets(da_players_ClassPlayer(playerOwner().pawn));
//}

function bool InternalOnClick(GUIComponent Sender) {
	local int i, j;
	local GUIComponent tempBut;
	local GUIComponent tab_l, tab_r, box_t, box_b;
	local GUIComponent strucButtons[4];
	local da_players_ClassPlayer dap;


	dap = da_players_ClassPlayer(playerOwner().pawn);
    //CountTurrets(dap);

	// Accept
	if (Sender == b_Accept) {
		if (selectedStructure != "") {
			// WTF? different string types. Is this ugly or what?
			if (selectedStructure == "AmmoBox") dap.build('AmmoBox');
			if (selectedStructure == "aver") dap.build('aver');
			if (selectedStructure == "crusher") dap.build('crusher');
			if (selectedStructure == "dfaturret") dap.build('dfaturret');
		}
		Controller.CloseMenu();
	}

	// Cancel
	if (Sender == b_Cancel) {
		Controller.CloseMenu();
	}

	// UGLY CRAP
    strucButtons[0] = b_Struc1;
    strucButtons[1] = b_Struc2;
    strucButtons[2] = b_Struc3;
    strucButtons[3] = b_Struc4;

	// Class buttons
	for (i=0; i<4; i++) {
		tempBut = strucButtons[i];
		if (Sender == tempBut) {
	        // Disables all other buttons
			for (j=0; j<4; j++) {
				if (j != i) strucButtons[j].EnableMe();
			}

			// Hides the preview text
			l_CPreview.bVisible = false;

			// Disable this button
	        tempBut.DisableMe();

			// Properly sets the background positions
			tab_l = i_BGStruc;
			tab_r = i_CBGMiddle;

			box_t = i_CBGTop;
			box_b = i_CBGBottom;

			tab_l.bVisible = true;
			tab_l.WinTop = tempBut.WinTop;

			tab_r.bVisible = true;
			tab_r.WinTop = tempBut.WinTop;

			box_t.bVisible = true;
			box_t.WinHeight = tab_r.WinTop - box_t.WinTop;

			box_b.bVisible = true;
			box_b.WinTop = tab_r.WinTop + tab_r.WinHeight;
			box_b.WinHeight = 0.75 - box_b.WinTop;

			// Set the content

			// Set class specific data
			// This is really really TOO hardcoded. Ideally, it should get the information from the weapons' classes

			// Main textbox
			l_CDesc.bVisible = true;

			// Weapon pictures
			i_SGrid.bVisible = true;

			if (i == 0) {
				// Ammo box
				selectedStructure = "AmmoBox";
				l_CDesc.Caption = "A lightly armored box containing ammunition. Use it to refill ammunition and grenades. Caution: The ammunition is volatile!";
				i_SGrid.Image = material'DA2GUI.sideviewAmmobox';
			}
			if (i == 1) {
				// AVeR Turret
				selectedStructure = "aver";
				l_CDesc.Caption = "A rocket turret which launches guided HEAT rockets at a moderate rate of fire. Effective against armored targets.";
				i_SGrid.Image = material'DA2GUI.sideviewAver';
			}
			if (i == 2) {
				// Crusher Turret
				selectedStructure = "crusher";
				l_CDesc.Caption = "A dual-cannon turret with a slow rate of fire which fires HEDP shells. Effective against both armored and unarmored targets.";
				i_SGrid.Image = material'DA2GUI.sideviewCrusher';
			}
			if (i == 3) {
				// DFA Turret
				selectedStructure = "dfaturret";
				l_CDesc.Caption = "A rotation-cooled machinegun turret with a high rate of fire. Effective against unarmored targets.";
				i_SGrid.Image = material'DA2GUI.sideviewDFA';
			}
		}
	}

	return true;

}

defaultproperties
{
     Begin Object Class=GUIImage Name=DialogBackground
         Image=Texture'DA2GUI.Dialog.window_1024x768'
         ImageStyle=ISTY_Stretched
         ImageRenderStyle=MSTY_Normal
         WinTop=0.170000
         WinLeft=0.270000
         WinWidth=0.460000
         WinHeight=0.660000
     End Object
     i_BG=GUIImage'DA2.da_GUI_MechChooseStructure.DialogBackground'

     Begin Object Class=GUILabel Name=CCTitle
         Caption="SELECT A STRUCTURE TO BUILD"
         TextAlign=TXTA_Center
         FontScale=FNS_Large
         StyleName="DA2Style_DialogText"
         WinTop=0.188000
         WinLeft=0.267500
         WinWidth=0.465000
         WinHeight=0.039000
     End Object
     l_Title=GUILabel'DA2.da_GUI_MechChooseStructure.CCTitle'

     Begin Object Class=GUIImage Name=BGStructure
         Image=Texture'DA2GUI.Dialog.htab_tab_l'
         ImageStyle=ISTY_Stretched
         ImageRenderStyle=MSTY_Normal
         WinTop=0.261000
         WinLeft=0.280000
         WinWidth=0.153000
         WinHeight=0.061000
         bVisible=False
     End Object
     i_BGStruc=GUIImage'DA2.da_GUI_MechChooseStructure.BGStructure'

     Begin Object Class=GUIButton Name=GBStructure1
         Caption="1) AMMO BOX"
         bWrapCaption=True
         StyleName="DA2Style_Button"
         WinTop=0.275000
         WinLeft=0.280000
         WinWidth=0.139000
         WinHeight=0.061000
         TabOrder=1
         OnClick=da_GUI_MechChooseStructure.InternalOnClick
         OnKeyEvent=GBStructure1.InternalOnKeyEvent
     End Object
     b_Struc1=GUIButton'DA2.da_GUI_MechChooseStructure.GBStructure1'

     Begin Object Class=GUIButton Name=GBStructure2
         Caption="2) AVER TURRET"
         bWrapCaption=True
         StyleName="DA2Style_Button"
         WinTop=0.375000
         WinLeft=0.280000
         WinWidth=0.139000
         WinHeight=0.061000
         TabOrder=2
         OnClick=da_GUI_MechChooseStructure.InternalOnClick
         OnKeyEvent=GBStructure2.InternalOnKeyEvent
     End Object
     b_Struc2=GUIButton'DA2.da_GUI_MechChooseStructure.GBStructure2'

     Begin Object Class=GUIButton Name=GBStructure3
         Caption="3) CRUSHER TURRET"
         bWrapCaption=True
         StyleName="DA2Style_Button"
         WinTop=0.475000
         WinLeft=0.280000
         WinWidth=0.139000
         WinHeight=0.061000
         TabOrder=3
         OnClick=da_GUI_MechChooseStructure.InternalOnClick
         OnKeyEvent=GBStructure3.InternalOnKeyEvent
     End Object
     b_Struc3=GUIButton'DA2.da_GUI_MechChooseStructure.GBStructure3'

     Begin Object Class=GUIButton Name=GBStructure4
         Caption="4) DFA TURRET"
         bWrapCaption=True
         StyleName="DA2Style_Button"
         WinTop=0.575000
         WinLeft=0.280000
         WinWidth=0.139000
         WinHeight=0.061000
         TabOrder=4
         OnClick=da_GUI_MechChooseStructure.InternalOnClick
         OnKeyEvent=GBStructure4.InternalOnKeyEvent
     End Object
     b_Struc4=GUIButton'DA2.da_GUI_MechChooseStructure.GBStructure4'

     Begin Object Class=GUIButton Name=FAccept
         Caption="ACCEPT"
         StyleName="DA2Style_Button"
         WinTop=0.776000
         WinLeft=0.396000
         WinWidth=0.095000
         WinHeight=0.042000
         TabOrder=4
         OnClick=da_GUI_MechChooseStructure.InternalOnClick
         OnKeyEvent=FAccept.InternalOnKeyEvent
     End Object
     b_Accept=GUIButton'DA2.da_GUI_MechChooseStructure.FAccept'

     Begin Object Class=GUIButton Name=FCancel
         Caption="CANCEL"
         StyleName="DA2Style_Button"
         WinTop=0.776000
         WinLeft=0.509000
         WinWidth=0.095000
         WinHeight=0.042000
         TabOrder=0
         OnClick=da_GUI_MechChooseStructure.InternalOnClick
         OnKeyEvent=FCancel.InternalOnKeyEvent
     End Object
     b_Cancel=GUIButton'DA2.da_GUI_MechChooseStructure.FCancel'

     Begin Object Class=GUIImage Name=ContentBGTop
         Image=Texture'DA2GUI.Dialog.htab_box_t'
         ImageStyle=ISTY_Stretched
         ImageRenderStyle=MSTY_Normal
         WinTop=0.254000
         WinLeft=0.433000
         WinWidth=0.285000
         WinHeight=0.040000
         bVisible=False
     End Object
     i_CBGTop=GUIImage'DA2.da_GUI_MechChooseStructure.ContentBGTop'

     Begin Object Class=GUIImage Name=ContentBGMiddle
         Image=Texture'DA2GUI.Dialog.htab_tab_r'
         ImageStyle=ISTY_Stretched
         ImageRenderStyle=MSTY_Normal
         WinTop=0.682000
         WinLeft=0.433000
         WinWidth=0.285000
         WinHeight=0.061000
         bVisible=False
     End Object
     i_CBGMiddle=GUIImage'DA2.da_GUI_MechChooseStructure.ContentBGMiddle'

     Begin Object Class=GUIImage Name=ContentBGBottom
         Image=Texture'DA2GUI.Dialog.htab_box_b'
         ImageStyle=ISTY_Stretched
         ImageRenderStyle=MSTY_Normal
         WinTop=0.700000
         WinLeft=0.433000
         WinWidth=0.285000
         WinHeight=0.040000
         bVisible=False
     End Object
     i_CBGBottom=GUIImage'DA2.da_GUI_MechChooseStructure.ContentBGBottom'

     Begin Object Class=GUILabel Name=CPreview
         Caption="CLICK A BUTTON OR PRESS 1-3 ON YOUR KEYBOARD TO SELECT A STRUCTURE TO BUILD"
         TextAlign=TXTA_Center
         bMultiLine=True
         FontScale=FNS_Small
         StyleName="DA2Style_MainMenuText"
         WinTop=0.430000
         WinLeft=0.446000
         WinWidth=0.259000
         WinHeight=0.200000
     End Object
     l_CPreview=GUILabel'DA2.da_GUI_MechChooseStructure.CPreview'

     Begin Object Class=GUILabel Name=CDescription
         bMultiLine=True
         FontScale=FNS_Small
         StyleName="DA2Style_BodyText"
         WinTop=0.261000
         WinLeft=0.446000
         WinWidth=0.259000
         WinHeight=0.100000
         bVisible=False
     End Object
     l_CDesc=GUILabel'DA2.da_GUI_MechChooseStructure.CDescription'

     Begin Object Class=GUIImage Name=StructureGrid
         ImageStyle=ISTY_Scaled
         ImageRenderStyle=MSTY_Normal
         WinTop=0.359000
         WinLeft=0.446000
         WinWidth=0.259000
         WinHeight=0.377000
         bVisible=False
     End Object
     i_SGrid=GUIImage'DA2.da_GUI_MechChooseStructure.StructureGrid'

     Begin Object Class=GUILabel Name=AmmoCount
         TextAlign=TXTA_Center
         FontScale=FNS_Small
         StyleName="DA2Style_BodyText"
         WinTop=0.320000
         WinLeft=0.280000
         WinWidth=0.139000
         WinHeight=0.061000
     End Object
     l_AmmoC=GUILabel'DA2.da_GUI_MechChooseStructure.AmmoCount'

     Begin Object Class=GUILabel Name=AVeRCount
         TextAlign=TXTA_Center
         FontScale=FNS_Small
         StyleName="DA2Style_BodyText"
         WinTop=0.420000
         WinLeft=0.280000
         WinWidth=0.139000
         WinHeight=0.061000
     End Object
     l_AVeRC=GUILabel'DA2.da_GUI_MechChooseStructure.AVeRCount'

     Begin Object Class=GUILabel Name=CrushCount
         TextAlign=TXTA_Center
         FontScale=FNS_Small
         StyleName="DA2Style_BodyText"
         WinTop=0.520000
         WinLeft=0.280000
         WinWidth=0.139000
         WinHeight=0.061000
     End Object
     l_CrushC=GUILabel'DA2.da_GUI_MechChooseStructure.CrushCount'

     Begin Object Class=GUILabel Name=DFACount
         TextAlign=TXTA_Center
         FontScale=FNS_Small
         StyleName="DA2Style_BodyText"
         WinTop=0.620000
         WinLeft=0.280000
         WinWidth=0.139000
         WinHeight=0.061000
     End Object
     l_DFAC=GUILabel'DA2.da_GUI_MechChooseStructure.DFACount'

     bRenderWorld=True
     bRequire640x480=False
     bAllowedAsLast=True
     OpenSound=Sound'ROMenuSounds.Generic.msfxEdit'
     OnPreDraw=da_GUI_MechChooseStructure.InternalOnPreDraw
     OnKeyEvent=da_GUI_MechChooseStructure.MyKeyEvent
}
