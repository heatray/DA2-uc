//Choose our class and let the game roll! :)

// D:\mods\UT2004Script3339\XInterface\Classes\GUIPage.uc

// D:\mods\UT2004Script3339\XInterface\Classes\GUIImage.uc
// D:\mods\UT2004Script3339\XInterface\Classes\GUIButton.uc
// D:\mods\UT2004Script3339\XInterface\Classes\GUIPage.uc
// D:\mods\UT2004Script3339\XInterface\Classes\GUILabel.uc

// TODO!!!! [zeh]
// * make the description use a scrollable text instead of a GUILabel (needs for 640x480). GUIScrollText is not working...
// * make it already get focus on the current class, if any is selected
// * allow shortcut keys for classes!

class da_GUI_chooseClass extends GUIPage;

//var(Menu)  editinlinenotify export array<GUIComponent>  Controls;       // An Array of Components that make up this Control

var automated GUILabel l_iDesc1, l_iDesc2, l_iDesc3;
var automated GUILabel l_iNum1, l_iNum2, l_iNum3;
var automated GUIImage i_weapon1, i_weapon2;
var automated GUILabel l_wdesc1, l_wdesc2;
var automated GUIImage i_info1, i_info2, i_info3;
var automated GUILabel l_CPreview, l_CDescription, l_Title;
var automated GUIImage i_WeapGrid1, i_WeapGrid2;
var automated GUIImage i_bg, i_bg1, i_bg2, i_bg3, i_bgClass;
var automated GUIButton b_Accept, b_Cancel;
var automated GUIButton b_Class1, b_Class2, b_Class3, b_Class4, b_Class5, b_Class6;

var int selectedClass;


function bool MyKeyEvent(out byte Key,out byte State,float delta) {
//	if(Key == 0x1B && state == 1)	// Escape pressed
//		bAllowClose = true;

//	log ("=== Key = " $ Key $ ", state = " $ state);

	if (Key == 49 && state == 1) {
		// Pressed 1
		da_players_PlayerController(PlayerOwner()).chooseclass(0,-1,60,280,100,false);
		da_players_PlayerController(PlayerOwner()).SendRanktoServer();
		Controller.CloseMenu();
	}

	if (Key == 50 && state == 1) {
		// Pressed 2
		da_players_PlayerController(PlayerOwner()).chooseclass(1,-1,40,260,100,false);
		da_players_PlayerController(PlayerOwner()).SendRanktoServer();
		Controller.CloseMenu();
	}

	if (Key == 51 && state == 1) {
		// Pressed 3
		da_players_PlayerController(PlayerOwner()).chooseclass(2,-1,30,300,100,false);
		da_players_PlayerController(PlayerOwner()).SendRanktoServer();
		Controller.CloseMenu();
	}

	if (Key == 52 && state == 1) {
		// Pressed 4
		da_players_PlayerController(PlayerOwner()).chooseclass(3,-1,20,270,100,false);
		da_players_PlayerController(PlayerOwner()).SendRanktoServer();
		Controller.CloseMenu();
	}

	if (Key == 53 && state == 1) {
		// Pressed 5
		da_players_PlayerController(PlayerOwner()).chooseclass(4,-1,0,250,100,false);
		da_players_PlayerController(PlayerOwner()).SendRanktoServer();
		Controller.CloseMenu();
	}

	if (Key == 54 && state == 1) {
		// Pressed 6
		da_players_PlayerController(PlayerOwner()).chooseclass(5,-1,70,240,100,false);
		da_players_PlayerController(PlayerOwner()).SendRanktoServer();
		Controller.CloseMenu();
	}

	return false;
}


function InitComponent(GUIController MyController, GUIComponent MyOwner) {
//    local int i;
    local da_players_ClassSet classSet;

    Controller = MyController;

	myController.RegisterStyle(class'da_GUI_daStyleButton');

    if (PlayerOwner().GameReplicationInfo != none && PlayerOwner().GameReplicationInfo.isA('da_game_ReplicationInfo')) {
        classSet = da_game_ReplicationInfo(PlayerOwner().GameReplicationInfo).teamConfig[PlayerOwner().PlayerReplicationInfo.Team.teamIndex].classSet;
		if (classSet == none) {
            closed(self, false);
            playerOwner().myHud.message(playerOwner().playerReplicationInfo, "Type showccmenu at console!", 'Say');
            return;
		}
    }

	Super.InitComponent(MyController, MyOwner);

}

/* Overrides AllowOpen
 * The original implementation does return true. This might be
 * the cause for the chooseclass menu opening several times.
 * It's a bit different then - instead of reopening, the menu
 * already was opened and on the stack (so you had like 3-4
 * opened menus on the stack)
 */
function bool AllowOpen(string MenuClass) {
    return false;
}

function bool InternalOnPreDraw(canvas c) {

	i_bg.Image = class'da_GUI_Utilities'.static.getCorrectBackground(c);

	return false;
}



function bool InternalOnClick(GUIComponent Sender) {

	local int i, j;
	local GUIComponent tempBut;
	local GUIComponent tab_l, tab_r, box_t, box_b;

	local GUIComponent classButtons[6];
	


	// [zeh] Pretty stupid/weird way to set buttons' click events using only one function, but whatever... it's working

	// Accept
	if (Sender == b_Accept) {
		if (selectedClass != -1) da_players_PlayerController(PlayerOwner()).chooseclass(selectedClass, -1 ,60,280,100,false);
		
		da_players_PlayerController(PlayerOwner()).SendRanktoServer();
		
		Controller.CloseMenu();
	}

	// Cancel
	if (Sender == b_Cancel) {
		Controller.CloseMenu();
	}

	// UGLY CRAP
    classButtons[0] = b_Class1;
    classButtons[1] = b_Class2;
    classButtons[2] = b_Class3;
    classButtons[3] = b_Class4;
    classButtons[4] = b_Class5;
    classButtons[5] = b_Class6;

	// Class buttons
	for (i=0; i<6; i++) {
		tempBut = classButtons[i];
		if (Sender == tempBut) {
	        // Disables all other buttons
			for (j=0; j<6; j++) {
				if (j != i) classButtons[j].EnableMe();
			}

			// Select this class
			selectedClass = i;

			// Hides the preview text
			l_CPreview.bVisible = false;

			// Disable this button
	        tempBut.DisableMe();

			// Properly sets the background positions
			tab_l = i_bgClass;
			tab_r = i_bg2;

			box_t = i_bg1;
			box_b = i_bg3;

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

			// Turn on weapon backgrounds
			i_WeapGrid1.bVisible = true;
			i_WeapGrid2.bVisible = true;

			// Set class specific data
			// This is really really TOO hardcoded. Ideally, it should get the information from the weapons' classes

			// Main textbox
			l_CDescription.bVisible = true;

			// Weapon pictures
			i_weapon1.bVisible = true;
			i_weapon2.bVisible = true;

			// Weapon descriptions
			l_wdesc1.bVisible = true;
			l_wdesc2.bVisible = true;

			// Info grids
			i_info1.bVisible = true;
			i_info2.bVisible = true;
			i_info3.bVisible = true;

			//Info grid description
			l_iDesc1.bVisible = true;
			l_iDesc2.bVisible = true;
			l_iDesc3.bVisible = true;

			// Info grid value
			l_iNum1.bVisible = true;
			l_iNum2.bVisible = true;
			l_iNum3.bVisible = true;

			if (i == 0) {
				// Infantry
				l_CDescription.Caption = "As a standard combat grunt, the Rifleman can pack some serious heat and has additional armor to make his task easier.";
				i_weapon1.Image = material'DA2GUI.sideviewXD40';
				l_wdesc1.Caption = "XD-40 Pistol";
				i_weapon2.Image = material'DA2GUI.sideviewMR56';
				l_wdesc2.Caption = "MR-56 Assault Rifle";

				l_iDesc1.Caption = "Frag";
				l_iNum1.Caption = "x3";
				i_info1.Image = material'DA2GUI.sideviewGrenade';

				l_iNum2.Caption = "60%";
				l_iNum3.Caption = "280";
			}
			if (i == 1) {
				// Mechanic
				l_CDescription.Caption = "With the ability to build and repair defensive structures and ammo boxes, the Mechanic is vital a part of any serious squad.";
				i_weapon1.Image = material'DA2GUI.sideviewP280';
				l_wdesc1.Caption = "P2-80 Pistol";
				i_weapon2.Image = material'DA2GUI.sideviewGK2';
				l_wdesc2.Caption = "GK2 Shotgun";

                l_iNum1.Caption = "x2";
                if(PlayerOwner().playerreplicationinfo!=none && PlayerOwner().playerreplicationinfo.team.teamindex==0) {
				    l_iDesc1.Caption = "Mine";
			    	i_info1.Image = material'DA2GUI.sideviewMine';
			    }
                else {
                    l_iNum1.Caption = "x1";
                    l_iDesc1.Caption = "Thermite";
			    	i_info1.Image = material'DA2GUI.sideviewThermite';
			    }

				l_iNum2.Caption = "40%";
				l_iNum3.Caption = "260";
			}
			if (i == 2) {
				// Medic
				l_CDescription.Caption = "Healing himself and nearby soldiers is the ability of the Medic. Soldiers in need should always have a Medic around.";
				i_weapon1.Image = material'DA2GUI.sideviewXD40';
				l_wdesc1.Caption = "XD-40 Pistol";
				i_weapon2.Image = material'DA2GUI.sideviewLK2';
				l_wdesc2.Caption = "LK2 AutoShotgun";

				l_iDesc1.Caption = "EMP";
				l_iNum1.Caption = "x2";
				i_info1.Image = material'DA2GUI.sideviewEMP';

				l_iNum2.Caption = "30%";
				l_iNum3.Caption = "300";
			}
			if (i == 3) {
				// Machine Gunner
				l_CDescription.Caption = "The Gunner can control defensive structures and provide a more focused defensive effort.";
				i_weapon1.Image = material'DA2GUI.sideviewP280';
				l_wdesc1.Caption = "P2-80 Pistol";
				i_weapon2.Image = material'DA2GUI.sideviewMR40';
				l_wdesc2.Caption = "MR-40 Machine Gun";

				l_iDesc1.Caption = "Thermite";
				l_iNum1.Caption = "x2";
				i_info1.Image = material'DA2GUI.sideviewThermite';

				l_iNum2.Caption = "20%";
				l_iNum3.Caption = "270";
			}
			if (i == 4) {
				// Long Range Support
				l_CDescription.Caption = "With automatic camouflage while standing, the Sniper provides long range offensive support.";
				i_weapon1.Image = material'DA2GUI.sideviewXD40';
				l_wdesc1.Caption = "XD-40 Pistol";
				i_weapon2.Image = material'DA2GUI.sideviewR86';
				l_wdesc2.Caption = "R86 Sniper Rifle";

				l_iNum1.Caption = "x2";
				if(PlayerOwner().playerreplicationinfo!=none && PlayerOwner().playerreplicationinfo.team.teamindex==0) {
				    l_iDesc1.Caption = "Frag";
			    	i_info1.Image = material'DA2GUI.sideviewGrenade';
			    }
                else {
                    l_iDesc1.Caption = "EMP";
			    	i_info1.Image = material'DA2GUI.sideviewEMP';
			    }

				l_iNum2.Caption = "0%";
				l_iNum3.Caption = "250";
			}
			if (i == 5) {
				// Anti-Armor Infantry
				l_CDescription.Caption = "With alternate fire-guided missiles, the Rocketeer provides heavy support for any combat situation.";
				i_weapon1.Image = material'DA2GUI.sideviewA9';
				l_wdesc1.Caption = "A9 Submachine Gun";
				i_weapon2.Image = material'DA2GUI.sideviewMS25';
				l_wdesc2.Caption = "MS-25 Rocket Launcher";

				if(PlayerOwner().playerreplicationinfo!=none && PlayerOwner().playerreplicationinfo.team.teamindex==0) {
				    l_iNum1.Caption = "x3";
                    l_iDesc1.Caption = "Frag";
			    	i_info1.Image = material'DA2GUI.sideviewGrenade';
			    }
                else {
                    l_iNum1.Caption = "x1";
                    l_iDesc1.Caption = "Plasma";
			    	i_info1.Image = material'DA2GUI.sideviewPLASMA';
			    }

				l_iNum2.Caption = "70%";
				l_iNum3.Caption = "240";
			}

//			GUIScrollText(Controls[19]).SetContent("This is a test|Yeah.");

		}
	}

	return true;

}

defaultproperties
{
     Begin Object Class=GUILabel Name=InfoName1
         Caption="Grenades"
         bMultiLine=True
         FontScale=FNS_Small
         StyleName="DA2Style_BodyText"
         WinTop=0.621000
         WinLeft=0.449000
         WinWidth=0.300000
         WinHeight=0.100000
         RenderWeight=0.800000
         bVisible=False
     End Object
     l_iDesc1=GUILabel'DA2.da_GUI_chooseClass.InfoName1'

     Begin Object Class=GUILabel Name=InfoName2
         Caption="Armor"
         bMultiLine=True
         FontScale=FNS_Small
         StyleName="DA2Style_BodyText"
         WinTop=0.621000
         WinLeft=0.539000
         WinWidth=0.300000
         WinHeight=0.100000
         RenderWeight=0.800000
         bVisible=False
     End Object
     l_iDesc2=GUILabel'DA2.da_GUI_chooseClass.InfoName2'

     Begin Object Class=GUILabel Name=InfoName3
         Caption="Speed"
         bMultiLine=True
         FontScale=FNS_Small
         StyleName="DA2Style_BodyText"
         WinTop=0.621000
         WinLeft=0.629000
         WinWidth=0.300000
         WinHeight=0.100000
         RenderWeight=0.800000
         bVisible=False
     End Object
     l_iDesc3=GUILabel'DA2.da_GUI_chooseClass.InfoName3'

     Begin Object Class=GUILabel Name=InfoNum1
         bMultiLine=True
         FontScale=FNS_Small
         StyleName="DA2Style_BodyText"
         WinTop=0.719000
         WinLeft=0.449000
         WinWidth=0.300000
         WinHeight=0.100000
         RenderWeight=0.800000
         bVisible=False
     End Object
     l_iNum1=GUILabel'DA2.da_GUI_chooseClass.InfoNum1'

     Begin Object Class=GUILabel Name=InfoNum2
         bMultiLine=True
         FontScale=FNS_Small
         StyleName="DA2Style_BodyText"
         WinTop=0.719000
         WinLeft=0.539000
         WinWidth=0.300000
         WinHeight=0.100000
         RenderWeight=0.800000
         bVisible=False
     End Object
     l_iNum2=GUILabel'DA2.da_GUI_chooseClass.InfoNum2'

     Begin Object Class=GUILabel Name=InfoNum3
         bMultiLine=True
         FontScale=FNS_Small
         StyleName="DA2Style_BodyText"
         WinTop=0.719000
         WinLeft=0.629000
         WinWidth=0.300000
         WinHeight=0.100000
         RenderWeight=0.800000
         bVisible=False
     End Object
     l_iNum3=GUILabel'DA2.da_GUI_chooseClass.InfoNum3'

     Begin Object Class=GUIImage Name=WeaponView1
         ImageStyle=ISTY_Scaled
         ImageRenderStyle=MSTY_Normal
         WinTop=0.359000
         WinLeft=0.462000
         WinWidth=0.243000
         WinHeight=0.150000
         RenderWeight=0.800000
         bVisible=False
     End Object
     i_weapon1=GUIImage'DA2.da_GUI_chooseClass.WeaponView1'

     Begin Object Class=GUIImage Name=WeaponView2
         ImageStyle=ISTY_Scaled
         ImageRenderStyle=MSTY_Normal
         WinTop=0.490000
         WinLeft=0.450000
         WinWidth=0.243000
         WinHeight=0.150000
         RenderWeight=0.800000
         bVisible=False
     End Object
     i_weapon2=GUIImage'DA2.da_GUI_chooseClass.WeaponView2'

     Begin Object Class=GUILabel Name=WeaponName1
         bMultiLine=True
         FontScale=FNS_Small
         StyleName="DA2Style_BodyText"
         WinTop=0.359000
         WinLeft=0.449000
         WinWidth=0.300000
         WinHeight=0.100000
         RenderWeight=0.800000
         bVisible=False
     End Object
     l_wdesc1=GUILabel'DA2.da_GUI_chooseClass.WeaponName1'

     Begin Object Class=GUILabel Name=WeaponName2
         bMultiLine=True
         FontScale=FNS_Small
         StyleName="DA2Style_BodyText"
         WinTop=0.490000
         WinLeft=0.449000
         WinWidth=0.300000
         WinHeight=0.100000
         RenderWeight=0.800000
         bVisible=False
     End Object
     l_wdesc2=GUILabel'DA2.da_GUI_chooseClass.WeaponName2'

     Begin Object Class=GUIImage Name=InfoGrid1
         Image=Texture'DA2GUI.Misc.sideviewGrenade'
         ImageStyle=ISTY_Scaled
         ImageRenderStyle=MSTY_Normal
         WinTop=0.621000
         WinLeft=0.446000
         WinWidth=0.079000
         WinHeight=0.115000
         RenderWeight=0.700000
         bVisible=False
     End Object
     i_info1=GUIImage'DA2.da_GUI_chooseClass.InfoGrid1'

     Begin Object Class=GUIImage Name=InfoGrid2
         Image=Texture'DA2GUI.Misc.sideviewArmor'
         ImageStyle=ISTY_Scaled
         ImageRenderStyle=MSTY_Normal
         WinTop=0.621000
         WinLeft=0.536000
         WinWidth=0.079000
         WinHeight=0.115000
         RenderWeight=0.700000
         bVisible=False
     End Object
     i_info2=GUIImage'DA2.da_GUI_chooseClass.InfoGrid2'

     Begin Object Class=GUIImage Name=InfoGrid3
         Image=Texture'DA2GUI.Misc.sideviewSpeed'
         ImageStyle=ISTY_Scaled
         ImageRenderStyle=MSTY_Normal
         WinTop=0.621000
         WinLeft=0.626000
         WinWidth=0.079000
         WinHeight=0.115000
         RenderWeight=0.700000
         bVisible=False
     End Object
     i_info3=GUIImage'DA2.da_GUI_chooseClass.InfoGrid3'

     Begin Object Class=GUILabel Name=CPreview
         Caption="CLICK A BUTTON OR PRESS 1-6 ON YOUR KEYBOARD TO SELECT A CLASS"
         TextAlign=TXTA_Center
         bMultiLine=True
         FontScale=FNS_Small
         StyleName="DA2Style_MainMenuText"
         WinTop=0.430000
         WinLeft=0.446000
         WinWidth=0.259000
         WinHeight=0.200000
     End Object
     l_CPreview=GUILabel'DA2.da_GUI_chooseClass.CPreview'

     Begin Object Class=GUILabel Name=CDescription
         bMultiLine=True
         FontScale=FNS_Small
         StyleName="DA2Style_BodyText"
         WinTop=0.261000
         WinLeft=0.446000
         WinWidth=0.259000
         WinHeight=0.100000
         RenderWeight=0.800000
         bVisible=False
     End Object
     l_CDescription=GUILabel'DA2.da_GUI_chooseClass.CDescription'

     Begin Object Class=GUILabel Name=CCTitle
         Caption="SELECT YOUR CLASS"
         TextAlign=TXTA_Center
         FontScale=FNS_Large
         StyleName="DA2Style_DialogText"
         WinTop=0.188000
         WinLeft=0.267500
         WinWidth=0.465000
         WinHeight=0.039000
         RenderWeight=0.300000
     End Object
     l_Title=GUILabel'DA2.da_GUI_chooseClass.CCTitle'

     Begin Object Class=GUIImage Name=WeaponGrid1
         Image=Texture'DA2GUI.Misc.grid_weapon'
         ImageStyle=ISTY_Scaled
         ImageRenderStyle=MSTY_Normal
         WinTop=0.359000
         WinLeft=0.446000
         WinWidth=0.259000
         WinHeight=0.115000
         RenderWeight=0.700000
         bVisible=False
     End Object
     i_WeapGrid1=GUIImage'DA2.da_GUI_chooseClass.WeaponGrid1'

     Begin Object Class=GUIImage Name=WeaponGrid2
         Image=Texture'DA2GUI.Misc.grid_weapon'
         ImageStyle=ISTY_Scaled
         ImageRenderStyle=MSTY_Normal
         WinTop=0.490000
         WinLeft=0.446000
         WinWidth=0.259000
         WinHeight=0.115000
         RenderWeight=0.700000
         bVisible=False
     End Object
     i_WeapGrid2=GUIImage'DA2.da_GUI_chooseClass.WeaponGrid2'

     Begin Object Class=GUIImage Name=DialogBackground
         Image=Texture'DA2GUI.Dialog.window_1024x768'
         ImageStyle=ISTY_Stretched
         ImageRenderStyle=MSTY_Normal
         WinTop=0.170000
         WinLeft=0.270000
         WinWidth=0.460000
         WinHeight=0.660000
     End Object
     i_BG=GUIImage'DA2.da_GUI_chooseClass.DialogBackground'

     Begin Object Class=GUIImage Name=ContentBGTop
         Image=Texture'DA2GUI.Dialog.htab_box_t'
         ImageStyle=ISTY_Stretched
         ImageRenderStyle=MSTY_Normal
         WinTop=0.254000
         WinLeft=0.433000
         WinWidth=0.285000
         WinHeight=0.040000
         RenderWeight=0.300000
         bVisible=False
     End Object
     i_BG1=GUIImage'DA2.da_GUI_chooseClass.ContentBGTop'

     Begin Object Class=GUIImage Name=ContentBGMiddle
         Image=Texture'DA2GUI.Dialog.htab_tab_r'
         ImageStyle=ISTY_Stretched
         ImageRenderStyle=MSTY_Normal
         WinTop=0.682000
         WinLeft=0.433000
         WinWidth=0.285000
         WinHeight=0.061000
         RenderWeight=0.300000
         bVisible=False
     End Object
     i_BG2=GUIImage'DA2.da_GUI_chooseClass.ContentBGMiddle'

     Begin Object Class=GUIImage Name=ContentBGBottom
         Image=Texture'DA2GUI.Dialog.htab_box_b'
         ImageStyle=ISTY_Stretched
         ImageRenderStyle=MSTY_Normal
         WinTop=0.700000
         WinLeft=0.433000
         WinWidth=0.285000
         WinHeight=0.040000
         RenderWeight=0.300000
         bVisible=False
     End Object
     i_BG3=GUIImage'DA2.da_GUI_chooseClass.ContentBGBottom'

     Begin Object Class=GUIImage Name=BGClass1
         Image=Texture'DA2GUI.Dialog.htab_tab_l'
         ImageStyle=ISTY_Stretched
         ImageRenderStyle=MSTY_Normal
         WinTop=0.261000
         WinLeft=0.280000
         WinWidth=0.153000
         WinHeight=0.061000
         RenderWeight=0.300000
         bVisible=False
     End Object
     i_bgClass=GUIImage'DA2.da_GUI_chooseClass.BGClass1'

     Begin Object Class=GUIButton Name=FAccept
         Caption="ACCEPT"
         StyleName="DA2Style_Button"
         WinTop=0.776000
         WinLeft=0.396000
         WinWidth=0.095000
         WinHeight=0.042000
         RenderWeight=0.800000
         TabOrder=7
         OnClick=da_GUI_chooseClass.InternalOnClick
         OnKeyEvent=FAccept.InternalOnKeyEvent
     End Object
     b_Accept=GUIButton'DA2.da_GUI_chooseClass.FAccept'

     Begin Object Class=GUIButton Name=FCancel
         Caption="CANCEL"
         StyleName="DA2Style_Button"
         WinTop=0.776000
         WinLeft=0.509000
         WinWidth=0.095000
         WinHeight=0.042000
         RenderWeight=0.800000
         TabOrder=0
         OnClick=da_GUI_chooseClass.InternalOnClick
         OnKeyEvent=FCancel.InternalOnKeyEvent
     End Object
     b_Cancel=GUIButton'DA2.da_GUI_chooseClass.FCancel'

     Begin Object Class=GUIButton Name=GBClass1
         Caption="1) RIFLEMAN"
         bWrapCaption=True
         StyleName="DA2Style_Button"
         WinTop=0.275000
         WinLeft=0.280000
         WinWidth=0.139000
         WinHeight=0.061000
         RenderWeight=0.800000
         TabOrder=1
         OnClick=da_GUI_chooseClass.InternalOnClick
         OnKeyEvent=GBClass1.InternalOnKeyEvent
     End Object
     b_Class1=GUIButton'DA2.da_GUI_chooseClass.GBClass1'

     Begin Object Class=GUIButton Name=GBClass2
         Caption="2) MECHANIC"
         bWrapCaption=True
         StyleName="DA2Style_Button"
         WinTop=0.350000
         WinLeft=0.280000
         WinWidth=0.139000
         WinHeight=0.061000
         RenderWeight=0.800000
         TabOrder=2
         OnClick=da_GUI_chooseClass.InternalOnClick
         OnKeyEvent=GBClass2.InternalOnKeyEvent
     End Object
     b_Class2=GUIButton'DA2.da_GUI_chooseClass.GBClass2'

     Begin Object Class=GUIButton Name=GBClass3
         Caption="3) MEDIC"
         bWrapCaption=True
         StyleName="DA2Style_Button"
         WinTop=0.425000
         WinLeft=0.280000
         WinWidth=0.139000
         WinHeight=0.061000
         RenderWeight=0.800000
         TabOrder=3
         OnClick=da_GUI_chooseClass.InternalOnClick
         OnKeyEvent=GBClass3.InternalOnKeyEvent
     End Object
     b_Class3=GUIButton'DA2.da_GUI_chooseClass.GBClass3'

     Begin Object Class=GUIButton Name=GBClass4
         Caption="4) GUNNER"
         bWrapCaption=True
         StyleName="DA2Style_Button"
         WinTop=0.500000
         WinLeft=0.280000
         WinWidth=0.139000
         WinHeight=0.061000
         RenderWeight=0.800000
         TabOrder=4
         OnClick=da_GUI_chooseClass.InternalOnClick
         OnKeyEvent=GBClass4.InternalOnKeyEvent
     End Object
     b_Class4=GUIButton'DA2.da_GUI_chooseClass.GBClass4'

     Begin Object Class=GUIButton Name=GBClass5
         Caption="5) SNIPER"
         bWrapCaption=True
         StyleName="DA2Style_Button"
         WinTop=0.575000
         WinLeft=0.280000
         WinWidth=0.139000
         WinHeight=0.061000
         RenderWeight=0.800000
         TabOrder=5
         OnClick=da_GUI_chooseClass.InternalOnClick
         OnKeyEvent=GBClass5.InternalOnKeyEvent
     End Object
     b_Class5=GUIButton'DA2.da_GUI_chooseClass.GBClass5'

     Begin Object Class=GUIButton Name=GBClass6
         Caption="6) ROCKETEER"
         bWrapCaption=True
         StyleName="DA2Style_Button"
         WinTop=0.650000
         WinLeft=0.280000
         WinWidth=0.139000
         WinHeight=0.061000
         RenderWeight=0.800000
         TabOrder=6
         OnClick=da_GUI_chooseClass.InternalOnClick
         OnKeyEvent=GBClass6.InternalOnKeyEvent
     End Object
     b_Class6=GUIButton'DA2.da_GUI_chooseClass.GBClass6'

     bRenderWorld=True
     bRequire640x480=False
     bAllowedAsLast=True
     OpenSound=Sound'ROMenuSounds.Generic.msfxEdit'
     OnPreDraw=da_GUI_chooseClass.InternalOnPreDraw
     OnKeyEvent=da_GUI_chooseClass.MyKeyEvent
}
