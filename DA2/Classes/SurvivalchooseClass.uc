class SurvivalchooseClass extends da_GUI_chooseClass;

var automated GUIButton b_Class7, b_Inc;
var automated GUIButton b_Nade1, b_Nade2, b_Nade3, b_Nade4, b_Nade5, b_Nade6;
var automated GUIButton b_extrahealthPlus, b_extrahealthMin, b_SpeedPlus, b_SpeedMin, b_ReloadPlus, b_ReloadMin;
var automated GUILabel l_cNade, l_cSkills, l_cPoints, l_iDesc4, l_iDesc5, l_iNum4;
var automated GUILabel l_CPreview2;
var automated GUIImage i_FireBullet, i_Info4;

var int selectedNade;

var bool incendiary;
var float extrahealth, speed, reload, total;
var int totalMax, extrahealthNul, speedNul, reloadNul;

var da_players_PRI  PRI;

function bool MyKeyEvent(out byte Key,out byte State,float delta) {

	if (Key == 49 && state == 1) {
		// Pressed 1
		da_players_PlayerController(PlayerOwner()).chooseclass(0,0,100,260,100,false);
		da_players_PlayerController(PlayerOwner()).SendRanktoServer();
		Controller.CloseMenu();
	}

	if (Key == 50 && state == 1) {
		// Pressed 2
		da_players_PlayerController(PlayerOwner()).chooseclass(1,0,100,240,100,false);
		da_players_PlayerController(PlayerOwner()).SendRanktoServer();
		Controller.CloseMenu();
	}

	if (Key == 51 && state == 1) {
		// Pressed 3
		da_players_PlayerController(PlayerOwner()).chooseclass(2,0,100,280,100,false);
		da_players_PlayerController(PlayerOwner()).SendRanktoServer();
		Controller.CloseMenu();
	}

	if (Key == 52 && state == 1) {
		// Pressed 4
		da_players_PlayerController(PlayerOwner()).chooseclass(3,0,100,250,100,false);
		da_players_PlayerController(PlayerOwner()).SendRanktoServer();
		Controller.CloseMenu();
	}

	if (Key == 53 && state == 1) {
		// Pressed 5
		da_players_PlayerController(PlayerOwner()).chooseclass(4,0,100,230,100,false);
		da_players_PlayerController(PlayerOwner()).SendRanktoServer();
		Controller.CloseMenu();
	}

	if (Key == 54 && state == 1) {
		// Pressed 6
		da_players_PlayerController(PlayerOwner()).chooseclass(5,0,100,220,100,false);
		da_players_PlayerController(PlayerOwner()).SendRanktoServer();
		Controller.CloseMenu();
	}

	if (Key == 55 && state == 1) {
		// Pressed 7
		da_players_PlayerController(PlayerOwner()).chooseclass(6,0,100,300,100,false);
		da_players_PlayerController(PlayerOwner()).SendRanktoServer();
		Controller.CloseMenu();
	}

	return false;
}

function bool InternalOnClick(GUIComponent Sender) {

	local int i, j, a, b;
	local GUIComponent tempBut, tempBut2;
	local GUIComponent tab_l, tab_r, box_t, box_b;

	local GUIComponent classButtons[7];
	local GUIComponent nadeButtons[6];

	PRI = da_players_PRI(PlayerOwner().PlayerReplicationInfo);

	// [zeh] Pretty stupid/weird way to set buttons' click events using only one function, but whatever... it's working

	// Accept
	if (Sender == b_Accept) {
	
	extrahealth += 100;
	speed += speedNul;
	reload += 100;
	
		log("SelectedClass:"@selectedClass@" SelectedNade:"@selectedNade@" Health:"@extrahealth@" Run Speed:"@speed@" Reload Speed:"@reload@" Incendiary:"@incendiary);
	
		if (selectedClass != -1 && extrahealth > 0 && speed > 0 && reload > 0) 
		da_players_PlayerController(PlayerOwner()).chooseclass(selectedClass,selectedNade,extrahealth,speed,reload,incendiary);
		
		else da_players_PlayerController(PlayerOwner()).chooseclass(selectedClass, 0 ,100,260,100,false);

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
    classButtons[6] = b_Class7;
	
	nadeButtons[0] = b_Nade1;
	nadeButtons[1] = b_Nade2;
	nadeButtons[2] = b_Nade3;
	nadeButtons[3] = b_Nade4;
	nadeButtons[4] = b_Nade5;
	nadeButtons[5] = b_Nade6;

	if (Sender == b_Inc && incendiary == false) incendiary = true;
	else if (Sender == b_Inc && incendiary == true) incendiary = false;
	
	else if (Sender == b_extrahealthPlus) 
	{ 
		if (extrahealth < 10)
		extrahealth += 10; 
		else if (extrahealth < 26)
		extrahealth += 8; 
		else if (extrahealth < 38)
		extrahealth += 6; 
		else if (extrahealth < 46)
		extrahealth += 4; 
		else 
		extrahealth += 2; 
		
		total -= 1; 
	}
	
	else if (Sender == b_extrahealthMin) 
	{ 
		if (extrahealth <= 10)
		extrahealth -= 10; 
		else if (extrahealth <= 26)
		extrahealth -= 8; 
		else if (extrahealth <= 38)
		extrahealth -= 6; 
		else if (extrahealth <= 46)
		extrahealth -= 4; 
		else 
		extrahealth -= 2; 
		
		total += 1; 
	}
	
	else if (Sender == b_SpeedPlus) 
	{
		if (speed < 10)
		speed += 10; 
		else if (speed < 26)
		speed += 8; 
		else if (speed < 38)
		speed += 6; 
		else if (speed < 46)
		speed += 4; 
		else 
		speed += 2; 
		
		total -= 1; 
	}
	
	else if (Sender == b_SpeedMin) 
	{
		if (speed <= 10)
		speed -= 10; 
		else if (speed <= 26)
		speed -= 8; 
		else if (speed <= 38)
		speed -= 6; 
		else if (speed <= 46)
		speed -= 4; 
		else 
		speed -= 2; 
		
		total += 1; 
	}
	
	else if (Sender == b_ReloadPlus)
	{
		if (reload < 10)
		reload += 10; 
		else if (reload < 26)
		reload += 8; 
		else if (reload < 38)
		reload += 6; 
		else if (reload < 46)
		reload += 4; 
		else 
		reload += 2; 
		
		total -= 1; 
	}
	
	else if (Sender == b_ReloadMin)
	{
		if (reload <= 10)
		reload -= 10; 
		else if (reload <= 26)
		reload -= 8; 
		else if (reload <= 38)
		reload -= 6; 
		else if (reload <= 46)
		reload -= 4; 
		else 
		reload -= 2; 
		
		total += 1; 
	}
					
	if (total == 0 || extrahealth >= 125) b_extrahealthPlus.DisableMe();
	else b_extrahealthPlus.EnableMe();
	
	if (total == 0) b_SpeedPlus.DisableMe(); 
	else b_SpeedPlus.EnableMe();
	
	if (total == 0 || reload >= 150) b_ReloadPlus.DisableMe(); 
	else b_ReloadPlus.EnableMe();
	
	if (extrahealth == 0 || total == totalMax) b_extrahealthMin.DisableMe();
	else b_extrahealthMin.EnableMe();
	
	if (speed == 0 || total == totalMax) b_SpeedMin.DisableMe(); 
	else b_SpeedMin.EnableMe(); 
	
	if (reload == 0 || total == totalMax) b_ReloadMin.DisableMe(); 
	else b_ReloadMin.EnableMe(); 
	
	if (incendiary == true) i_FireBullet.bVisible = true;
	else if (incendiary == false) i_FireBullet.bVisible = false;
	
	l_iNum3.Caption = ""@int(speed+speedNul);
	l_cPoints.Caption = ""@int(total);
	l_iNum2.Caption = ""@int(extrahealth+100);
	l_iNum4.Caption = ""@int(reload+100)@"%";

	// Class buttons
	for (i=0; i<7; i++) {
		tempBut = classButtons[i];
		if (Sender == tempBut) {
	        // Disables all other buttons
			for (j=0; j<7; j++) {
				if (j != i) classButtons[j].EnableMe();
			}
			
			if (PRI.PlayerRank >= 7)
			totalMax = 9;
			else if (PRI.PlayerRank >= 4)
			totalMax = 5;
			else if (PRI.PlayerRank >= 1)
			totalMax = 2;
			else
			totalMax = 0;
			
			if (da_SteamStatsAndAchievements(PlayerOwner().SteamStatsAndAchievements).GrenadeCompleted)
			b_Nade6.EnableMe();
			else b_Nade6.DisableMe();
			
			if (!da_SteamStatsAndAchievements(PlayerOwner().SteamStatsAndAchievements).IncendiaryCompleted)
			b_inc.DisableMe();
			
			extrahealthNul=100;
			reloadNul=100;
			
			// Select this class
			selectedClass = i;

			// Hides the preview text
			l_CPreview.bVisible = false;
			l_CPreview2.bVisible = false;

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
			box_b.WinHeight = 0.888 - box_b.WinTop;

			// Set the content

			// Turn on weapon backgrounds
			i_WeapGrid1.bVisible = true;
			i_WeapGrid2.bVisible = true;

			// Set class specific data
			// This is really really TOO hardcoded. Ideally, it should get the information from the weapons' classes

			// Main textbox
			l_CDescription.bVisible = true;
			l_cNade.bVisible = true;
			l_cSkills.bVisible = true;
			l_cPoints.bVisible = true;

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
			i_info4.bVisible = true;

			//Info grid description
			l_iDesc1.bVisible = true;
			l_iDesc2.bVisible = true;
			l_iDesc3.bVisible = true;
			l_iDesc4.bVisible = true;
			l_iDesc5.bVisible = true;

			// Info grid value
			l_iNum1.bVisible = true;
			l_iNum2.bVisible = true;
			l_iNum3.bVisible = true;
			l_iNum4.bVisible = true;
			
			// Grenade buttons
			b_Nade1.bVisible = true;
			b_Nade2.bVisible = true;
			b_Nade3.bVisible = true;
			b_Nade4.bVisible = true;
			b_Nade5.bVisible = true;
			b_Nade6.bVisible = true;
			
			// Customize buttons
			b_extrahealthPlus.bVisible = true;
			b_extrahealthMin.bVisible = true;
			b_SpeedPlus.bVisible = true;
			b_SpeedMin.bVisible = true;
			b_ReloadPlus.bVisible = true;
			b_ReloadMin.bVisible = true;
			
			b_Inc.bVisible = true;

			if (i == 0) {
				// Infantry
				l_CDescription.Caption = "As a standard combat grunt, the Rifleman can pack some serious heat and has additional armor to make his task easier.";
				i_weapon1.Image = material'DA2GUI.sideviewXD40';
				l_wdesc1.Caption = "XD-40 Pistol";
				i_weapon2.Image = material'DA2GUI.sideviewMR56';
				l_wdesc2.Caption = "MR-56 Assault Rifle";

				
				extrahealth=0;
				reload=0;
				speed=0;
				speedNul=260;
				total=totalMax;
				b_Nade4.DisableMe();
				
				If (selectedNade == 3){
				l_iDesc1.Caption = "Select a grenade";
				l_iNum1.Caption = "";
				i_info1.Image = material'DA2GUI.sideviewGrenade'; 
				selectedNade = 0;}
				
				if (da_SteamStatsAndAchievements(PlayerOwner().SteamStatsAndAchievements).IncendiaryCompleted)
				b_inc.EnableMe();
				
			}
			if (i == 1) {
				// Mechanic
				l_CDescription.Caption = "With the ability to build and repair defensive structures and ammo boxes, the Mechanic is vital a part of any serious squad.";
				i_weapon1.Image = material'DA2GUI.sideviewP280';
				l_wdesc1.Caption = "P2-80 Pistol";
				i_weapon2.Image = material'DA2GUI.sideviewGK2';
				l_wdesc2.Caption = "GK2 Shotgun";
                		

				extrahealth=0;
				reload=0;
				speed=0;
				speedNul=240;
				total=totalMax;
				b_Nade4.DisableMe();
				
				If (selectedNade == 3){
				l_iDesc1.Caption = "Select a grenade";
				l_iNum1.Caption = "";
				i_info1.Image = material'DA2GUI.sideviewGrenade'; 
				selectedNade = 0;}
				i_FireBullet.bVisible = false;
				
				if (da_SteamStatsAndAchievements(PlayerOwner().SteamStatsAndAchievements).IncendiaryCompleted)
				b_inc.EnableMe();
				
			}
			if (i == 2) {
				// Medic
				l_CDescription.Caption = "Healing himself and nearby soldiers is the ability of the Medic. Soldiers in need should always have a Medic around.";
				i_weapon1.Image = material'DA2GUI.sideviewXD40';
				l_wdesc1.Caption = "XD-40 Pistol";
				i_weapon2.Image = material'DA2GUI.sideviewLK2';
				l_wdesc2.Caption = "LK2 AutoShotgun";

				extrahealth=0;
				reload=0;
				speed=0;
				speedNul=280;
				total=totalMax;
				b_Nade4.DisableMe();
				
				If (selectedNade == 3){
				l_iDesc1.Caption = "Select a grenade";
				l_iNum1.Caption = "";
				i_info1.Image = material'DA2GUI.sideviewGrenade'; 
				selectedNade = 0;}
				i_FireBullet.bVisible = false;
				
				if (da_SteamStatsAndAchievements(PlayerOwner().SteamStatsAndAchievements).IncendiaryCompleted)
				b_inc.EnableMe();

			}
			if (i == 3) {
				// Machine Gunner
				l_CDescription.Caption = "The Gunner can control defensive structures and provide a more focused defensive effort.";
				i_weapon1.Image = material'DA2GUI.sideviewP280';
				l_wdesc1.Caption = "P2-80 Pistol";
				i_weapon2.Image = material'DA2GUI.sideviewMR40';
				l_wdesc2.Caption = "MR-40 Machine Gun";
				
				extrahealth=0;
				reload=0;
				speed=0;
				speedNul=250;
				total=totalMax;
				b_Nade4.DisableMe();
				
				If (selectedNade == 3){
				l_iDesc1.Caption = "Select a grenade";
				l_iNum1.Caption = "";
				i_info1.Image = material'DA2GUI.sideviewGrenade'; 
				selectedNade = 0;}
				
				if (da_SteamStatsAndAchievements(PlayerOwner().SteamStatsAndAchievements).IncendiaryCompleted)
				b_inc.EnableMe();

			}
			if (i == 4) {
				// Long Range Support
				l_CDescription.Caption = "With automatic camouflage while standing, the Sniper provides long range offensive support.";
				i_weapon1.Image = material'DA2GUI.sideviewXD40';
				l_wdesc1.Caption = "XD-40 Pistol";
				i_weapon2.Image = material'DA2GUI.sideviewR86';
				l_wdesc2.Caption = "R86 Sniper Rifle";
			

				extrahealth=0;
				reload=0;
				speed=0;
				speedNul=230;
				total=totalMax;
				b_Nade4.DisableMe();
				
				If (selectedNade == 3){
				l_iDesc1.Caption = "Select a grenade";
				l_iNum1.Caption = "";
				i_info1.Image = material'DA2GUI.sideviewGrenade'; 
				selectedNade = 0;}
				
				if (da_SteamStatsAndAchievements(PlayerOwner().SteamStatsAndAchievements).IncendiaryCompleted)
				b_inc.EnableMe();

			}
			if (i == 5) {
				// Anti-Armor Infantry
				l_CDescription.Caption = "With alternate fire-guided missiles, the Rocketeer provides heavy support for any combat situation.";
				i_weapon1.Image = material'DA2GUI.sideviewP280';
				l_wdesc1.Caption = "P2-80 Pistol";
				i_weapon2.Image = material'DA2GUI.sideviewMS25';
				l_wdesc2.Caption = "MS-25 Rocket Launcher";
			    

				extrahealth=0;
				reload=0;
				speed=0;
				speedNul=220;
				total=totalMax;
				b_Nade4.EnableMe();
				incendiary = false;
				b_inc.DisableMe();
				i_FireBullet.bVisible = false;

			}
			if (i == 6) {
				// Engineer
				l_CDescription.Caption = "With the ability to repair defensive structures and ammoboxes combinded with amazing speed, the Engineer proves to be an overall expert.";
				i_weapon1.Image = material'DA2GUI.sideviewXD40';
				l_wdesc1.Caption = "XD-40 Pistol";
				i_weapon2.Image = material'DA2GUI.sideviewA9';
				l_wdesc2.Caption = "A9 Submachine Gun";

			    
				extrahealth=0;
				reload=0;
				speed=0;
				speedNul=300;
				total=totalMax;
				b_Nade4.DisableMe();
				
				If (selectedNade == 3){
				l_iDesc1.Caption = "Select a grenade";
				l_iNum1.Caption = "";
				i_info1.Image = material'DA2GUI.sideviewGrenade';
				selectedNade = 0;}
				
				if (da_SteamStatsAndAchievements(PlayerOwner().SteamStatsAndAchievements).IncendiaryCompleted)
				b_inc.EnableMe();

			}
			
				l_iNum3.Caption = ""@int(speed+speedNul);
				l_cPoints.Caption = ""@int(total);
				l_iNum2.Caption = ""@int(extrahealth+100);
				l_iNum4.Caption = ""@int(reload+100)@"%";
				
					if (total == 0 ) { b_extrahealthPlus.DisableMe(); b_SpeedPlus.DisableMe(); b_ReloadPlus.DisableMe(); }
					else { b_extrahealthPlus.EnableMe(); b_SpeedPlus.EnableMe(); b_ReloadPlus.EnableMe(); }
									
					if (total == totalMax ) { b_extrahealthMin.DisableMe(); b_SpeedMin.DisableMe(); b_ReloadMin.DisableMe(); }
					else { b_extrahealthMin.EnableMe(); b_SpeedMin.EnableMe(); b_ReloadMin.EnableMe(); }
		}
	}
	
	for (a=0; a<6; a++)  
				{
				tempBut2 = nadeButtons[a];
				
				if (Sender == tempBut2) 
				
				{
					// Enable all other buttons
					for (b=0; b<6; b++) {
					if ((b != a && selectedClass != 5 && b != 3) || (b != a && selectedClass == 5)) nadeButtons[b].EnableMe(); 
					}
					
					if (da_SteamStatsAndAchievements(PlayerOwner().SteamStatsAndAchievements).GrenadeCompleted)
					b_Nade6.EnableMe();
					else b_Nade6.DisableMe();
					
					// Disable this button
					tempBut2.DisableMe();
					
					selectedNade = a;
					
					if (a == 0) {
					l_iDesc1.Caption = "Frag grenade";
					l_iNum1.Caption = "x3";
					i_info1.Image = material'DA2GUI.sideviewGrenade'; }
					
					if (a == 1) {
					l_iDesc1.Caption = "Thermite grenade";
					l_iNum1.Caption = "x2";
					i_info1.Image = material'DA2GUI.sideviewThermite'; }
					
					if (a == 2) {
					l_iDesc1.Caption = "EMP grenade";
					l_iNum1.Caption = "x2";
					i_info1.Image = material'DA2GUI.sideviewEMP'; }
					
					if (a == 3) {
					l_iDesc1.Caption = "Plasma bomb";
					l_iNum1.Caption = "x1";
					i_info1.Image = material'DA2GUI.sideviewPlasma'; }
					
					if (a == 4) {
					l_iDesc1.Caption = "Mines";
					l_iNum1.Caption = "x3";
					i_info1.Image = material'DA2GUI.sideviewMine'; }
					
					if (a == 5) {
					l_iDesc1.Caption = "Nuclear grenade";
					l_iNum1.Caption = "x3";
					i_info1.Image = material'DA2GUI.sideviewNuclearGrenade'; }
				}}

	return true;
}

defaultproperties
{
     Begin Object Class=GUIButton Name=GBClass7
         Caption="7) ENGINEER"
         bWrapCaption=True
         StyleName="DA2Style_Button"
         WinTop=0.700000
         WinLeft=0.280000
         WinWidth=0.139000
         WinHeight=0.061000
         RenderWeight=0.800000
         TabOrder=7
         OnClick=SurvivalchooseClass.InternalOnClick
         OnKeyEvent=GBClass7.InternalOnKeyEvent
     End Object
     b_Class7=GUIButton'DA2.SurvivalchooseClass.GBClass7'

     Begin Object Class=GUIButton Name=bIncendiary
         Caption="INCENDIARY"
         bWrapCaption=True
         FontScale=FNS_Small
         StyleName="DA2Style_Button"
         WinTop=0.437779
         WinLeft=0.626000
         WinWidth=0.079000
         WinHeight=0.037500
         RenderWeight=0.800000
         TabOrder=17
         bVisible=False
         OnClick=SurvivalchooseClass.InternalOnClick
         OnKeyEvent=bIncendiary.InternalOnKeyEvent
     End Object
     b_Inc=GUIButton'DA2.SurvivalchooseClass.bIncendiary'

     Begin Object Class=GUIButton Name=Nade1
         Caption="1) FRAG"
         bWrapCaption=True
         FontScale=FNS_Small
         StyleName="DA2Style_Button"
         WinTop=0.760000
         WinLeft=0.536000
         WinWidth=0.079000
         WinHeight=0.037500
         RenderWeight=0.800000
         TabOrder=7
         bVisible=False
         OnClick=SurvivalchooseClass.InternalOnClick
         OnKeyEvent=Nade1.InternalOnKeyEvent
     End Object
     b_Nade1=GUIButton'DA2.SurvivalchooseClass.Nade1'

     Begin Object Class=GUIButton Name=Nade2
         Caption="2) THERMITE"
         bWrapCaption=True
         FontScale=FNS_Small
         StyleName="DA2Style_Button"
         WinTop=0.802000
         WinLeft=0.536000
         WinWidth=0.079000
         WinHeight=0.037500
         RenderWeight=0.800000
         TabOrder=8
         bVisible=False
         OnClick=SurvivalchooseClass.InternalOnClick
         OnKeyEvent=Nade2.InternalOnKeyEvent
     End Object
     b_Nade2=GUIButton'DA2.SurvivalchooseClass.Nade2'

     Begin Object Class=GUIButton Name=Nade3
         Caption="3) EMP"
         bWrapCaption=True
         FontScale=FNS_Small
         StyleName="DA2Style_Button"
         WinTop=0.844000
         WinLeft=0.536000
         WinWidth=0.079000
         WinHeight=0.037500
         RenderWeight=0.800000
         TabOrder=9
         bVisible=False
         OnClick=SurvivalchooseClass.InternalOnClick
         OnKeyEvent=Nade3.InternalOnKeyEvent
     End Object
     b_Nade3=GUIButton'DA2.SurvivalchooseClass.Nade3'

     Begin Object Class=GUIButton Name=Nade4
         Caption="4) PLASMA"
         bWrapCaption=True
         FontScale=FNS_Small
         StyleName="DA2Style_Button"
         WinTop=0.760000
         WinLeft=0.626000
         WinWidth=0.079000
         WinHeight=0.037500
         RenderWeight=0.800000
         TabOrder=10
         bVisible=False
         OnClick=SurvivalchooseClass.InternalOnClick
         OnKeyEvent=Nade4.InternalOnKeyEvent
     End Object
     b_Nade4=GUIButton'DA2.SurvivalchooseClass.Nade4'

     Begin Object Class=GUIButton Name=Nade5
         Caption="5) MINES"
         bWrapCaption=True
         FontScale=FNS_Small
         StyleName="DA2Style_Button"
         WinTop=0.802000
         WinLeft=0.626000
         WinWidth=0.079000
         WinHeight=0.037500
         RenderWeight=0.800000
         TabOrder=11
         bVisible=False
         OnClick=SurvivalchooseClass.InternalOnClick
         OnKeyEvent=Nade5.InternalOnKeyEvent
     End Object
     b_Nade5=GUIButton'DA2.SurvivalchooseClass.Nade5'

     Begin Object Class=GUIButton Name=Nade6
         Caption="6) NUCLEAR"
         bWrapCaption=True
         FontScale=FNS_Small
         StyleName="DA2Style_Button"
         WinTop=0.844000
         WinLeft=0.626000
         WinWidth=0.079000
         WinHeight=0.037500
         RenderWeight=0.800000
         TabOrder=12
         bVisible=False
         OnClick=SurvivalchooseClass.InternalOnClick
         OnKeyEvent=Nade6.InternalOnKeyEvent
     End Object
     b_Nade6=GUIButton'DA2.SurvivalchooseClass.Nade6'

     Begin Object Class=GUIButton Name=extrahealthPlus
         Caption="+"
         bWrapCaption=True
         FontScale=FNS_Small
         StyleName="DA2Style_Button"
         WinTop=0.660000
         WinLeft=0.444232
         WinWidth=0.039000
         WinHeight=0.037500
         RenderWeight=0.800000
         TabOrder=13
         bVisible=False
         OnClick=SurvivalchooseClass.InternalOnClick
         OnKeyEvent=extrahealthPlus.InternalOnKeyEvent
     End Object
     b_extrahealthPlus=GUIButton'DA2.SurvivalchooseClass.extrahealthPlus'

     Begin Object Class=GUIButton Name=extrahealthMin
         Caption="-"
         bWrapCaption=True
         FontScale=FNS_Small
         StyleName="DA2Style_Button"
         WinTop=0.660000
         WinLeft=0.487460
         WinWidth=0.039000
         WinHeight=0.037500
         RenderWeight=0.800000
         TabOrder=14
         bVisible=False
         OnClick=SurvivalchooseClass.InternalOnClick
         OnKeyEvent=extrahealthMin.InternalOnKeyEvent
     End Object
     b_extrahealthMin=GUIButton'DA2.SurvivalchooseClass.extrahealthMin'

     Begin Object Class=GUIButton Name=SpeedPlus
         Caption="+"
         bWrapCaption=True
         FontScale=FNS_Small
         StyleName="DA2Style_Button"
         WinTop=0.660000
         WinLeft=0.534438
         WinWidth=0.039000
         WinHeight=0.037500
         RenderWeight=0.800000
         TabOrder=15
         bVisible=False
         OnClick=SurvivalchooseClass.InternalOnClick
         OnKeyEvent=SpeedPlus.InternalOnKeyEvent
     End Object
     b_SpeedPlus=GUIButton'DA2.SurvivalchooseClass.SpeedPlus'

     Begin Object Class=GUIButton Name=SpeedMin
         Caption="-"
         bWrapCaption=True
         FontScale=FNS_Small
         StyleName="DA2Style_Button"
         WinTop=0.660000
         WinLeft=0.577563
         WinWidth=0.039000
         WinHeight=0.037500
         RenderWeight=0.800000
         TabOrder=16
         bVisible=False
         OnClick=SurvivalchooseClass.InternalOnClick
         OnKeyEvent=SpeedMin.InternalOnKeyEvent
     End Object
     b_SpeedMin=GUIButton'DA2.SurvivalchooseClass.SpeedMin'

     Begin Object Class=GUIButton Name=ReloadPlus
         Caption="+"
         bWrapCaption=True
         FontScale=FNS_Small
         StyleName="DA2Style_Button"
         WinTop=0.660000
         WinLeft=0.624644
         WinWidth=0.039000
         WinHeight=0.037500
         RenderWeight=0.800000
         TabOrder=15
         bVisible=False
         OnClick=SurvivalchooseClass.InternalOnClick
         OnKeyEvent=ReloadPlus.InternalOnKeyEvent
     End Object
     b_ReloadPlus=GUIButton'DA2.SurvivalchooseClass.ReloadPlus'

     Begin Object Class=GUIButton Name=ReloadMin
         Caption="-"
         bWrapCaption=True
         FontScale=FNS_Small
         StyleName="DA2Style_Button"
         WinTop=0.660000
         WinLeft=0.667666
         WinWidth=0.039000
         WinHeight=0.037500
         RenderWeight=0.800000
         TabOrder=16
         bVisible=False
         OnClick=SurvivalchooseClass.InternalOnClick
         OnKeyEvent=ReloadMin.InternalOnKeyEvent
     End Object
     b_ReloadMin=GUIButton'DA2.SurvivalchooseClass.ReloadMin'

     Begin Object Class=GUILabel Name=CNade
         Caption="CHOOSE YOUR GRENADE"
         StyleName="DA2Style_DialogText"
         WinTop=0.716641
         WinLeft=0.446000
         WinWidth=0.250000
         WinHeight=0.039000
         RenderWeight=0.300000
         bVisible=False
     End Object
     l_cNade=GUILabel'DA2.SurvivalchooseClass.CNade'

     Begin Object Class=GUILabel Name=CSkills
         Caption="CUSTOMIZE YOUR CLASS"
         StyleName="DA2Style_DialogText"
         WinTop=0.490000
         WinLeft=0.446000
         WinWidth=0.250000
         WinHeight=0.039000
         RenderWeight=0.300000
         bVisible=False
     End Object
     l_cSkills=GUILabel'DA2.SurvivalchooseClass.CSkills'

     Begin Object Class=GUILabel Name=CPoints
         Caption="0"
         TextAlign=TXTA_Center
         StyleName="DA2Style_DialogText"
         WinTop=0.494374
         WinLeft=0.623000
         WinWidth=0.079000
         WinHeight=0.039000
         RenderWeight=0.300000
         bVisible=False
     End Object
     l_cPoints=GUILabel'DA2.SurvivalchooseClass.CPoints'

     Begin Object Class=GUILabel Name=InfoName4
         Caption="Points available"
         bMultiLine=True
         FontScale=FNS_Small
         StyleName="DA2Style_BodyText"
         WinTop=0.479149
         WinLeft=0.633269
         WinWidth=0.300000
         WinHeight=0.100000
         RenderWeight=0.800000
         bVisible=False
     End Object
     l_iDesc4=GUILabel'DA2.SurvivalchooseClass.InfoName4'

     Begin Object Class=GUILabel Name=InfoName5
         Caption="Reload speed"
         bMultiLine=True
         FontScale=FNS_Small
         StyleName="DA2Style_BodyText"
         WinTop=0.535593
         WinLeft=0.628194
         WinWidth=0.300000
         WinHeight=0.100000
         RenderWeight=0.800000
         bVisible=False
     End Object
     l_iDesc5=GUILabel'DA2.SurvivalchooseClass.InfoName5'

     Begin Object Class=GUILabel Name=InfoNum4
         bMultiLine=True
         FontScale=FNS_Small
         StyleName="DA2Style_BodyText"
         WinTop=0.632644
         WinLeft=0.627665
         WinWidth=0.300000
         WinHeight=0.100000
         RenderWeight=0.800000
         bVisible=False
     End Object
     l_iNum4=GUILabel'DA2.SurvivalchooseClass.InfoNum4'

     Begin Object Class=GUILabel Name=CPreview2
         Caption="CANCELING WILL GIVE YOU YOUR PREVIOUS CLASS LOADOUT"
         TextAlign=TXTA_Center
         bMultiLine=True
         FontScale=FNS_Small
         StyleName="DA2Style_MainMenuText"
         WinTop=0.830000
         WinLeft=0.370000
         WinWidth=0.259000
         WinHeight=0.200000
     End Object
     l_CPreview2=GUILabel'DA2.SurvivalchooseClass.CPreview2'

     Begin Object Class=GUIImage Name=FireBullet
         Image=Texture'DA2GUI.Misc.FireBullet'
         ImageStyle=ISTY_Scaled
         ImageRenderStyle=MSTY_Additive
         WinTop=0.355000
         WinLeft=0.675000
         WinWidth=0.029000
         WinHeight=0.050000
         RenderWeight=0.900000
         bVisible=False
     End Object
     i_firebullet=GUIImage'DA2.SurvivalchooseClass.FireBullet'

     Begin Object Class=GUIImage Name=InfoGrid4
         Image=Texture'DA2GUI.Misc.ReloadSpeed'
         ImageStyle=ISTY_Scaled
         ImageRenderStyle=MSTY_Normal
         WinTop=0.536000
         WinLeft=0.626000
         WinWidth=0.079000
         WinHeight=0.115000
         RenderWeight=0.700000
         bVisible=False
     End Object
     i_Info4=GUIImage'DA2.SurvivalchooseClass.InfoGrid4'

     Begin Object Class=GUILabel Name=InfoName1
         Caption="Select a grenade"
         bMultiLine=True
         FontScale=FNS_Small
         StyleName="DA2Style_BodyText"
         WinTop=0.763215
         WinLeft=0.449000
         WinWidth=0.300000
         WinHeight=0.100000
         RenderWeight=0.800000
         bVisible=False
     End Object
     l_iDesc1=GUILabel'DA2.SurvivalchooseClass.InfoName1'

     Begin Object Class=GUILabel Name=InfoName2
         Caption="Health"
         bMultiLine=True
         FontScale=FNS_Small
         StyleName="DA2Style_BodyText"
         WinTop=0.535593
         WinLeft=0.448186
         WinWidth=0.300000
         WinHeight=0.100000
         RenderWeight=0.800000
         bVisible=False
     End Object
     l_iDesc2=GUILabel'DA2.SurvivalchooseClass.InfoName2'

     Begin Object Class=GUILabel Name=InfoName3
         Caption="Run speed"
         bMultiLine=True
         FontScale=FNS_Small
         StyleName="DA2Style_BodyText"
         WinTop=0.535593
         WinLeft=0.538190
         WinWidth=0.300000
         WinHeight=0.100000
         RenderWeight=0.800000
         bVisible=False
     End Object
     l_iDesc3=GUILabel'DA2.SurvivalchooseClass.InfoName3'

     Begin Object Class=GUILabel Name=InfoNum1
         bMultiLine=True
         FontScale=FNS_Small
         StyleName="DA2Style_BodyText"
         WinTop=0.861215
         WinLeft=0.450000
         WinWidth=0.300000
         WinHeight=0.100000
         RenderWeight=0.800000
         bVisible=False
     End Object
     l_iNum1=GUILabel'DA2.SurvivalchooseClass.InfoNum1'

     Begin Object Class=GUILabel Name=InfoNum2
         bMultiLine=True
         FontScale=FNS_Small
         StyleName="DA2Style_BodyText"
         WinTop=0.633593
         WinLeft=0.447665
         WinWidth=0.300000
         WinHeight=0.100000
         RenderWeight=0.800000
         bVisible=False
     End Object
     l_iNum2=GUILabel'DA2.SurvivalchooseClass.InfoNum2'

     Begin Object Class=GUILabel Name=InfoNum3
         bMultiLine=True
         FontScale=FNS_Small
         StyleName="DA2Style_BodyText"
         WinTop=0.632644
         WinLeft=0.537665
         WinWidth=0.300000
         WinHeight=0.100000
         RenderWeight=0.800000
         bVisible=False
     End Object
     l_iNum3=GUILabel'DA2.SurvivalchooseClass.InfoNum3'

     Begin Object Class=GUIImage Name=WeaponView1
         ImageStyle=ISTY_Scaled
         ImageRenderStyle=MSTY_Normal
         WinTop=0.229000
         WinLeft=0.462000
         WinWidth=0.243000
         WinHeight=0.150000
         RenderWeight=0.800000
         bVisible=False
     End Object
     i_weapon1=GUIImage'DA2.SurvivalchooseClass.WeaponView1'

     Begin Object Class=GUIImage Name=WeaponView2
         ImageStyle=ISTY_Scaled
         ImageRenderStyle=MSTY_Normal
         WinTop=0.360000
         WinLeft=0.450000
         WinWidth=0.243000
         WinHeight=0.150000
         RenderWeight=0.800000
         bVisible=False
     End Object
     i_weapon2=GUIImage'DA2.SurvivalchooseClass.WeaponView2'

     Begin Object Class=GUILabel Name=WeaponName1
         bMultiLine=True
         FontScale=FNS_Small
         StyleName="DA2Style_BodyText"
         WinTop=0.229000
         WinLeft=0.449000
         WinWidth=0.300000
         WinHeight=0.100000
         RenderWeight=0.800000
         bVisible=False
     End Object
     l_wdesc1=GUILabel'DA2.SurvivalchooseClass.WeaponName1'

     Begin Object Class=GUILabel Name=WeaponName2
         bMultiLine=True
         FontScale=FNS_Small
         StyleName="DA2Style_BodyText"
         WinTop=0.360000
         WinLeft=0.449000
         WinWidth=0.300000
         WinHeight=0.100000
         RenderWeight=0.800000
         bVisible=False
     End Object
     l_wdesc2=GUILabel'DA2.SurvivalchooseClass.WeaponName2'

     Begin Object Class=GUIImage Name=InfoGrid1
         Image=Texture'DA2GUI.Misc.sideviewGrenade'
         ImageStyle=ISTY_Scaled
         ImageRenderStyle=MSTY_Normal
         WinTop=0.763215
         WinLeft=0.446000
         WinWidth=0.079000
         WinHeight=0.115000
         RenderWeight=0.700000
         bVisible=False
     End Object
     i_info1=GUIImage'DA2.SurvivalchooseClass.InfoGrid1'

     Begin Object Class=GUIImage Name=InfoGrid2
         Image=Texture'DA2GUI.Misc.sideviewHealth'
         ImageStyle=ISTY_Scaled
         ImageRenderStyle=MSTY_Normal
         WinTop=0.536000
         WinLeft=0.446000
         WinWidth=0.079000
         WinHeight=0.115000
         RenderWeight=0.700000
         bVisible=False
     End Object
     i_info2=GUIImage'DA2.SurvivalchooseClass.InfoGrid2'

     Begin Object Class=GUIImage Name=InfoGrid3
         Image=Texture'DA2GUI.Misc.sideviewSpeed'
         ImageStyle=ISTY_Scaled
         ImageRenderStyle=MSTY_Normal
         WinTop=0.536000
         WinLeft=0.536000
         WinWidth=0.079000
         WinHeight=0.115000
         RenderWeight=0.700000
         bVisible=False
     End Object
     i_info3=GUIImage'DA2.SurvivalchooseClass.InfoGrid3'

     Begin Object Class=GUILabel Name=CPreview
         Caption="CLICK A BUTTON OR PRESS 1-7 ON YOUR KEYBOARD TO SELECT A CLASS WITH DEFAULT LOADOUT"
         TextAlign=TXTA_Center
         bMultiLine=True
         FontScale=FNS_Small
         StyleName="DA2Style_MainMenuText"
         WinTop=0.446000
         WinLeft=0.446000
         WinWidth=0.259000
         WinHeight=0.200000
     End Object
     l_CPreview=GUILabel'DA2.SurvivalchooseClass.CPreview'

     Begin Object Class=GUILabel Name=CDescription
         bMultiLine=True
         FontScale=FNS_Small
         StyleName="DA2Style_BodyText"
         WinTop=0.161000
         WinLeft=0.446000
         WinWidth=0.259000
         WinHeight=0.100000
         RenderWeight=0.800000
         bVisible=False
     End Object
     l_CDescription=GUILabel'DA2.SurvivalchooseClass.CDescription'

     Begin Object Class=GUILabel Name=CCTitle
         Caption="SELECT YOUR CLASS"
         TextAlign=TXTA_Center
         FontScale=FNS_Large
         StyleName="DA2Style_DialogText"
         WinTop=0.088000
         WinLeft=0.267500
         WinWidth=0.465000
         WinHeight=0.039000
         RenderWeight=0.300000
     End Object
     l_Title=GUILabel'DA2.SurvivalchooseClass.CCTitle'

     Begin Object Class=GUIImage Name=WeaponGrid1
         Image=Texture'DA2GUI.Misc.grid_weapon'
         ImageStyle=ISTY_Scaled
         ImageRenderStyle=MSTY_Normal
         WinTop=0.229000
         WinLeft=0.446000
         WinWidth=0.259000
         WinHeight=0.115000
         RenderWeight=0.700000
         bVisible=False
     End Object
     i_WeapGrid1=GUIImage'DA2.SurvivalchooseClass.WeaponGrid1'

     Begin Object Class=GUIImage Name=WeaponGrid2
         Image=Texture'DA2GUI.Misc.grid_weapon'
         ImageStyle=ISTY_Scaled
         ImageRenderStyle=MSTY_Normal
         WinTop=0.360000
         WinLeft=0.446000
         WinWidth=0.259000
         WinHeight=0.115000
         RenderWeight=0.700000
         bVisible=False
     End Object
     i_WeapGrid2=GUIImage'DA2.SurvivalchooseClass.WeaponGrid2'

     Begin Object Class=GUIImage Name=DialogBackground
         Image=Texture'DA2GUI.Dialog.window_1024x768'
         ImageStyle=ISTY_Stretched
         ImageRenderStyle=MSTY_Normal
         WinTop=0.070000
         WinLeft=0.270000
         WinWidth=0.460000
         WinHeight=0.905000
     End Object
     i_BG=GUIImage'DA2.SurvivalchooseClass.DialogBackground'

     Begin Object Class=GUIImage Name=ContentBGTop
         Image=Texture'DA2GUI.Dialog.htab_box_t'
         ImageStyle=ISTY_Stretched
         ImageRenderStyle=MSTY_Normal
         WinTop=0.154000
         WinLeft=0.433000
         WinWidth=0.285000
         WinHeight=0.040000
         RenderWeight=0.300000
         bVisible=False
     End Object
     i_BG1=GUIImage'DA2.SurvivalchooseClass.ContentBGTop'

     Begin Object Class=GUIImage Name=ContentBGMiddle
         Image=Texture'DA2GUI.Dialog.htab_tab_r'
         ImageStyle=ISTY_Stretched
         ImageRenderStyle=MSTY_Normal
         WinTop=0.582000
         WinLeft=0.433000
         WinWidth=0.285000
         WinHeight=0.061000
         RenderWeight=0.300000
         bVisible=False
     End Object
     i_BG2=GUIImage'DA2.SurvivalchooseClass.ContentBGMiddle'

     Begin Object Class=GUIImage Name=ContentBGBottom
         Image=Texture'DA2GUI.Dialog.htab_box_b'
         ImageStyle=ISTY_Stretched
         ImageRenderStyle=MSTY_Normal
         WinTop=0.600000
         WinLeft=0.433000
         WinWidth=0.285000
         WinHeight=0.040000
         RenderWeight=0.300000
         bVisible=False
     End Object
     i_BG3=GUIImage'DA2.SurvivalchooseClass.ContentBGBottom'

     Begin Object Class=GUIImage Name=BGClass1
         Image=Texture'DA2GUI.Dialog.htab_tab_l'
         ImageStyle=ISTY_Stretched
         ImageRenderStyle=MSTY_Normal
         WinTop=0.161000
         WinLeft=0.280000
         WinWidth=0.153000
         WinHeight=0.061000
         RenderWeight=0.300000
         bVisible=False
     End Object
     i_bgClass=GUIImage'DA2.SurvivalchooseClass.BGClass1'

     Begin Object Class=GUIButton Name=FAccept
         Caption="ACCEPT"
         StyleName="DA2Style_Button"
         WinTop=0.915000
         WinLeft=0.396000
         WinWidth=0.095000
         WinHeight=0.042000
         RenderWeight=0.800000
         TabOrder=8
         OnClick=SurvivalchooseClass.InternalOnClick
         OnKeyEvent=FAccept.InternalOnKeyEvent
     End Object
     b_Accept=GUIButton'DA2.SurvivalchooseClass.FAccept'

     Begin Object Class=GUIButton Name=FCancel
         Caption="CANCEL"
         StyleName="DA2Style_Button"
         WinTop=0.915000
         WinLeft=0.509000
         WinWidth=0.095000
         WinHeight=0.042000
         RenderWeight=0.800000
         TabOrder=0
         OnClick=SurvivalchooseClass.InternalOnClick
         OnKeyEvent=FCancel.InternalOnKeyEvent
     End Object
     b_Cancel=GUIButton'DA2.SurvivalchooseClass.FCancel'

     Begin Object Class=GUIButton Name=GBClass1
         Caption="1) RIFLEMAN"
         bWrapCaption=True
         StyleName="DA2Style_Button"
         WinTop=0.250000
         WinLeft=0.280000
         WinWidth=0.139000
         WinHeight=0.061000
         RenderWeight=0.800000
         TabOrder=1
         OnClick=SurvivalchooseClass.InternalOnClick
         OnKeyEvent=GBClass1.InternalOnKeyEvent
     End Object
     b_Class1=GUIButton'DA2.SurvivalchooseClass.GBClass1'

     Begin Object Class=GUIButton Name=GBClass2
         Caption="2) MECHANIC"
         bWrapCaption=True
         StyleName="DA2Style_Button"
         WinTop=0.325000
         WinLeft=0.280000
         WinWidth=0.139000
         WinHeight=0.061000
         RenderWeight=0.800000
         TabOrder=2
         OnClick=SurvivalchooseClass.InternalOnClick
         OnKeyEvent=GBClass2.InternalOnKeyEvent
     End Object
     b_Class2=GUIButton'DA2.SurvivalchooseClass.GBClass2'

     Begin Object Class=GUIButton Name=GBClass3
         Caption="3) MEDIC"
         bWrapCaption=True
         StyleName="DA2Style_Button"
         WinTop=0.400000
         WinLeft=0.280000
         WinWidth=0.139000
         WinHeight=0.061000
         RenderWeight=0.800000
         TabOrder=3
         OnClick=SurvivalchooseClass.InternalOnClick
         OnKeyEvent=GBClass3.InternalOnKeyEvent
     End Object
     b_Class3=GUIButton'DA2.SurvivalchooseClass.GBClass3'

     Begin Object Class=GUIButton Name=GBClass4
         Caption="4) GUNNER"
         bWrapCaption=True
         StyleName="DA2Style_Button"
         WinTop=0.475000
         WinLeft=0.280000
         WinWidth=0.139000
         WinHeight=0.061000
         RenderWeight=0.800000
         TabOrder=4
         OnClick=SurvivalchooseClass.InternalOnClick
         OnKeyEvent=GBClass4.InternalOnKeyEvent
     End Object
     b_Class4=GUIButton'DA2.SurvivalchooseClass.GBClass4'

     Begin Object Class=GUIButton Name=GBClass5
         Caption="5) SNIPER"
         bWrapCaption=True
         StyleName="DA2Style_Button"
         WinTop=0.550000
         WinLeft=0.280000
         WinWidth=0.139000
         WinHeight=0.061000
         RenderWeight=0.800000
         TabOrder=5
         OnClick=SurvivalchooseClass.InternalOnClick
         OnKeyEvent=GBClass5.InternalOnKeyEvent
     End Object
     b_Class5=GUIButton'DA2.SurvivalchooseClass.GBClass5'

     Begin Object Class=GUIButton Name=GBClass6
         Caption="6) ROCKETEER"
         bWrapCaption=True
         StyleName="DA2Style_Button"
         WinTop=0.625000
         WinLeft=0.280000
         WinWidth=0.139000
         WinHeight=0.061000
         RenderWeight=0.800000
         TabOrder=6
         OnClick=SurvivalchooseClass.InternalOnClick
         OnKeyEvent=GBClass6.InternalOnKeyEvent
     End Object
     b_Class6=GUIButton'DA2.SurvivalchooseClass.GBClass6'

}
