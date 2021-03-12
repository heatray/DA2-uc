//-----------------------------------------------------------
//
//-----------------------------------------------------------
class da_GUI_mainMenu extends GUIPage;

// D:\mods\UT2004Script3339\XInterface\Classes\GUIImage.uc

#EXEC OBJ LOAD FILE=DA2Textures.utx
#EXEC OBJ LOAD FILE=DA2FontsBody.utx PACKAGE=DA2FontsBody

const MAXCREDITS = 50;
const CREDITSRATE = 0.01;

var bool  AllowClose;
var bool    bFirstLoad;

var float   creditsDelay, creditsSpeed;
var int     credits_line;
var float   credits_lineProgress;
var bool    bShowCredits;
var bool    bNoText;

var config bool bLoadMenuMap;

var  int    alphaHint8, targetAlphaHint8;

var automated GUIImage i_Logo, i_bg, i_bg2;
var automated GUIButton b_Multiplayer, b_Host, b_Instant, b_Achievements, b_Settings, b_Quit;
var automated GUILabel  l_Multiplayer, l_Host, l_Instant, l_Achievements, l_Settings, l_Quit, l_Version;

var array<String> menuMaps;

var localized 	string 				SteamMustBeRunningText;
var localized 	string 				UnknownSteamErrorText;

event MyOpened() {
  local int mapBG;

    super.onOpen();

    playerOwner().ClientSetMusic("da2_maintheme", playerOwner().EMusicTransition.MTRAN_FastFade);

// bLoadMenuMap=true;

    if (!bLoadMenuMap) {
        bRenderWorld = false;
        playerOwner().level.serverTravel("Entry.ut2", false);
        i_bg2.bVisible = true;

    mapBG = rand(3);
    //if (mapBG == 0) i_bg2.Image=texture'DA2Objectives.mov-menu2OBJ';
    //if (mapBG == 1) i_bg2.Image=texture'DA2Objectives.mov-menu4OBJ';
    //if (mapBG == 2) i_bg2.Image=texture'DA2Objectives.mov-menuOBJ';
        i_bg2.X1=0;
        i_bg2.Y1=0;
        i_bg2.X2=1023;
    i_bg2.Y2=767;

        /*
        others:
        da2-blackgoldOBJ
        da2-classic-egyptOBJ
        da2-lasthopeOBJ
        da2-refineryOBJ
        da2-triumph2OBJ
        da2-triumphOBJ
        da2-unexpectedOBJ
        mov-menu3OBJ // similar to mov-menu
        */

    }

  if (bLoadMenuMap && (bFirstLoad || InStr(playerOwner().Level.GetLocalURL(), "Menu") < 0 || playerOwner().Level.netMode == NM_Client)) {
        default.bFirstLoad = false;

    // Check if there are any menu maps available
    if (menuMaps.length == 0)
      return;

        playerOwner().Player.Console.delayedConsoleCommand("open" @ menuMaps[0] $ "?game=da_menu_GameInfo");
    }
    alphaHint8 = 1;
    targetAlphaHint8 = 1;
    setTimer(creditsDelay);

}

function myTimer(GUIComponent sender) {
    bShowCredits = true;
    credits_lineProgress += creditsSpeed;
    while (credits_lineProgress > 1.0) {
        credits_line++;
        credits_lineProgress -= 1.0;
    }
    setTimer(CREDITSRATE, true);
    if (bNoText) {
        bNoText = false;
        credits_line = 0;
        credits_lineProgress = 0;
        bShowCredits = false;
        setTimer(creditsDelay, true);
    } else {
        bNoText = true;
    }

  // [zeh] animation for text fade
  /*
  if (alphaHint8 != targetAlphaHint8) {
    // Not there yet; animate
    if (alphaHint8 < targetAlphaHint8) {
      alphaHint8 += 15;
      if (alphaHint8 > targetAlphaHint8) alphaHint8 = targetAlphaHint8;
    } else {
      alphaHint8 -= 20;
      if (alphaHint8 < targetAlphaHint8) alphaHint8 = targetAlphaHint8;
    }
    GUILabel(Controls[8]).TextColor = class'Canvas'.static.MakeColor(255, 255, 255, alphaHint8);
  }
  */

}

function string creditLine(int i) {
    local array<string> lines;
    lines[lines.length] = "_Project Lead";
    lines[lines.length] = "Ruben (Dest) van Schieveen";
    lines[lines.length] = "Dimitris (aBsOlUt) Koutsogiorgas (retired)" ;

    lines[lines.length] = "";
    lines[lines.length] = "";
    lines[lines.length] = "_Coders";
    lines[lines.length] = "John (Ramm-Jaeger) Gibson";
    lines[lines.length] = "Gershom (BlackCheetah) Ikpe";
    lines[lines.length] = "Christian (Cralex NS) Hauberg";
    lines[lines.length] = "Dennis (Dante) Waldherr (retired)" ;
    lines[lines.length] = "Dimitris (aBsOlUt) Koutsogiorgas (retired)";
    lines[lines.length] = "Johannes (Leviathan) Sievert (retired)";

    lines[lines.length] = "";
    lines[lines.length] = "";
    lines[lines.length] = "_Level Design";
    lines[lines.length] = "Ruben (Dest) van Schieveen";
    lines[lines.length] = "Mark (FluXs) Briscoe (retired)";
    lines[lines.length] = "Nick (Spec) Hamilton (retired)";

    lines[lines.length] = "";
    lines[lines.length] = "";
    lines[lines.length] = "_Graphics & Textures";
    lines[lines.length] = "Jeff (Xealous) Hart (retired)";
    lines[lines.length] = "Niels (LeSaint) van Aken (retired)";
    lines[lines.length] = "Johannes (Leviathan) Sievert (retired)";
    lines[lines.length] = "Zeh (Zeh) Fernando (retired)";
    lines[lines.length] = "Andreas (FoxDF) Reiswig, GreyfoxStudios (retired)";

    lines[lines.length] = "";
    lines[lines.length] = "";
    lines[lines.length] = "_3D Modelling & Animation";
    lines[lines.length] = "Tim (UnderTOW) Brooks (retired)";
    lines[lines.length] = "Fabian (Acumen) Schmidt (retired)";
    lines[lines.length] = "Scott (Scott) Wilson (retired)";

    lines[lines.length] = "";
    lines[lines.length] = "";
    lines[lines.length] = "_Sounds";
    lines[lines.length] = "Johannes (Leviathan) Sievert (retired)";
    lines[lines.length] = "James (JUIM) Boyd (retired)";

    lines[lines.length] = "";
    lines[lines.length] = "";
    lines[lines.length] = "_Music";
    lines[lines.length] = "Ripley & Jenson";
    lines[lines.length] = "www.Ripley-Jenson.com";

    lines[lines.length] = "";
    lines[lines.length] = "";
    lines[lines.length] = "_Concept";
    lines[lines.length] = "Michael (Legato) Kingery (retired)";

    lines[lines.length] = "";
    lines[lines.length] = "";
    lines[lines.length] = "_Beta Testing (Killing Floor)";
    lines[lines.length] = "Andrew (HAMMERSTIEN) Wade";
    lines[lines.length] = "Shah (Rambo) Ali";
    lines[lines.length] = "Matt (Boxiii) Walker";
    lines[lines.length] = "James (xjames0x) Oseman";
    lines[lines.length] = "Jano (Tj@vo) Vogt";
    lines[lines.length] = "Hayden (Hayden493) Cerecke";
    lines[lines.length] = "Will (Morello) New";
    lines[lines.length] = "(arramus)";
    lines[lines.length] = "(Gregs2k2)";
    lines[lines.length] = "(Neotolemus)";
    lines[lines.length] = "(KevGuy378)";
    lines[lines.length] = "(shah32111)";
    lines[lines.length] = "(George)";
    lines[lines.length] = "(aznstealthmarv)";
    lines[lines.length] = "(TehCheeseMaster)";

    lines[lines.length] = "";
    lines[lines.length] = "";
    lines[lines.length] = "Web - http://steamcommunity.com/games/da2";

    lines[lines.length] = "";
    lines[lines.length] = "";
    lines[lines.length] = "_Music Copyright";
    lines[lines.length] = "The copyright in the musical recordings is";
    lines[lines.length] = "owned by the composers and has been exclusively";
    lines[lines.length] = "licensed for non-commercial use to DA2 for";
    lines[lines.length] = "version 1.1. Any other use of the recorded musical";
    lines[lines.length] = "material for software versions other than that";
    lines[lines.length] = "mentioned above, commercial advertising,";
    lines[lines.length] = "or promotion not related to the product mentioned";
    lines[lines.length] = "above requires the written consent of the composers";
    lines[lines.length] = "prior to publishing, editing, selling and";
    lines[lines.length] = "distributing in physical and non-physical form.";

    lines[lines.length] = "";
    lines[lines.length] = "";
    lines[lines.length] = "_TRIPWIRE INTERACTIVE";
    lines[lines.length] = "http://www.tripwireinteractive.com";

    lines[lines.length] = "";
    lines[lines.length] = "";
    lines[lines.length] = "_Copyright 2011";
    lines[lines.length] = "All 3D Artwork, Levels, Sounds, Textures";
    lines[lines.length] = "and code belong to their corresponding";
    lines[lines.length] = "owners.";

    if (i < 0 || i >= lines.length)
        return "";
    else
        return lines[i];
}

function bool myPreDraw(Canvas c) {
    local float posy;
    local float sX, sY, tY;
    local int i;
    local string line;
    local float colorFactor;

/*
USED FOR TESTING! Do not erase
  c.font = Font(DynamicLoadObject("DA2FontsDialog.DIN14", class'Font'));
  c.setPos(0, 0);
  c.drawText(" !#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_abcdefghijklmnopqrstuvwxyz{|}~");
*/

    if (bShowCredits) {
//        c.font = class'HudBase'.static.loadFontStatic(7);
//        c.font = Font(DynamicLoadObject("DA2FontsBody.DropTrebuchet10", class'Font'));
        c.font = Font(DynamicLoadObject("DA2FontsDialog.DIN9", class'Font'));
        c.textSize("DUMMY", sX, sY);
        posy = c.clipY;
        i = 0;
        while (posy > 0) {
            colorFactor = fclamp(fmin(posy - credits_lineProgress * sY, c.clipY - posY + credits_lineProgress * sY) / c.clipY * 5.0, 0.0, 1.0);
            line = creditLine(i + credits_line);
            if (len(line) > 0)
                bNoText = false;
            if (left(line, 1) == "_") {
                line = mid(line, 1);
                c.setDrawColor(255, 0, 0, 254 * colorFactor + 1);
            } else {
                c.setDrawColor(255, 255, 255, 254 * colorFactor + 1);
            }
            c.textSize(line, sX, tY);
            c.setPos(c.clipx - sX - c.clipX * 0.07040, posY - credits_lineProgress * sY);
            c.drawText(line);
            posy -= sY;
            i--;
        }
        c.reset();
    }
    return false;
}

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
    MyController.RegisterStyle(class'da_GUI_daStyle'); // [zeh] this shouldn't be used: the class must be added to da_GUI_Controller.uc in the default class array
  Super.InitComponent(MyController, MyOwner);
}

function OnClose(optional Bool bCanceled)
{
}

function bool MyKeyEvent(out byte Key,out byte State,float delta)
{
  if(Key == 0x1B && State == 1)  // Escape pressed
  {
    AllowClose = true;
    return true;
  }
  else
    return false;
}

function bool CanClose(optional Bool bCanceled) {
  if(AllowClose) Controller.OpenMenu("da_GUI_QuitPage");

  return false;
}

function bool ButtonClick(GUIComponent Sender) {

switch ( Sender )
	{
	Case b_Multiplayer:
		Controller.OpenMenu(Controller.GetServerBrowserPage());
		Break;

	Case b_Host:
		Controller.OpenMenu(Controller.GetMultiplayerPage());
		Break;

	Case b_Instant:
		Controller.OpenMenu(Controller.GetInstantActionPage());	
		Break;

	Case b_Achievements:
        		/*if( !Controller.CheckSteam() )
        		{
            		Controller.OpenMenu(Controller.QuestionMenuClass);
			    	GUIQuestionPage(Controller.TopPage()).SetupQuestion(SteamMustBeRunningText, QBTN_Ok, QBTN_Ok);
			    	Break;
        		}
				
        		if ( PlayerOwner() != none )
        		{
        			if ( PlayerOwner().SteamStatsAndAchievements == none )
        			{
        				PlayerOwner().SteamStatsAndAchievements = PlayerOwner().Spawn(PlayerOwner().default.SteamStatsAndAchievementsClass, PlayerOwner());
						if ( !PlayerOwner().SteamStatsAndAchievements.Initialize(PlayerOwner()) )
						{
		  	          			Controller.OpenMenu(Controller.QuestionMenuClass);
					    		GUIQuestionPage(Controller.TopPage()).SetupQuestion(UnknownSteamErrorText, QBTN_Ok, QBTN_Ok);
							PlayerOwner().SteamStatsAndAchievements.Destroy();
							PlayerOwner().SteamStatsAndAchievements = none;
        				}
        				else
        					{
        						PlayerOwner().SteamStatsAndAchievements.OnDataInitialized = OnSteamStatsAndAchievementsReady;
        					}

       							Break;
        			}
	    			else if ( !PlayerOwner().SteamStatsAndAchievements.bInitialized )
	    			{
	   					PlayerOwner().SteamStatsAndAchievements.OnDataInitialized = OnSteamStatsAndAchievementsReady;
	   					PlayerOwner().SteamStatsAndAchievements.GetStatsAndAchievements();
	   					Break;
					}
				} */
			Controller.OpenMenu("DA2.da_GUI_Achievements");
			Break;
	
	Case b_Settings:
		Controller.OpenMenu(Controller.GetSettingsPage());
		Break;

	Case b_Quit:
		Controller.OpenMenu(Controller.GetQuitPage());
		Break;

  	return true;

	}
}

function OnSteamStatsAndAchievementsReady()
{
    Controller.OpenMenu("DA2.da_GUI_Achievements");
}

function bool ButtonHover(GUIComponent Sender) {
  // Hides all...
  l_Multiplayer.bVisible = false;
  l_Host.bVisible = false;
  l_Instant.bVisible = false;
  l_Achievements.bVisible = false;
  l_Settings.bVisible = false;
//  GUILabel(Controls[12]).bVisible = false;
  l_Quit.bVisible = false;

  // ...then shows the current one
  if (Sender == b_Multiplayer)   l_Multiplayer.bVisible = true;
  if (Sender == b_Host)       l_Host.bVisible = true;
  if (Sender == b_Instant)     l_Instant.bVisible = true;
  if (Sender == b_Achievements)     l_Achievements.bVisible = true;
  if (Sender == b_Settings)     l_Settings.bVisible = true;
//   if (Sender == Controls[5]) GUILabel(Controls[12]).bVisible = true;
  if (Sender == b_Quit)       l_Quit.bVisible = true;

  return true;
}

defaultproperties
{
     bFirstLoad=True
     creditsDelay=4.000000
     creditsSpeed=0.064000
     bLoadMenuMap=True
     Begin Object Class=GUIImage Name=ImgDA2Logo
         Image=Texture'DA2GUI.Generic.logoMainMenu'
         ImageStyle=ISTY_Scaled
         ImageRenderStyle=MSTY_Normal
         WinTop=0.068000
         WinLeft=0.043200
         WinWidth=0.256000
         WinHeight=0.171000
         RenderWeight=0.900000
     End Object
     i_Logo=GUIImage'DA2.da_GUI_MainMenu.ImgDA2Logo'

     Begin Object Class=GUIImage Name=ImgMenuBG
         Image=Texture'DA2GUI.Generic.whiteBox'
         ImageColor=(B=31,G=31,R=31)
         ImageStyle=ISTY_Tiled
         ImageRenderStyle=MSTY_Subtractive
         WinWidth=0.316000
         WinHeight=1.000000
     End Object
     i_BG=GUIImage'DA2.da_GUI_MainMenu.ImgMenuBG'

     Begin Object Class=GUIImage Name=ImgBG
         Image=Texture'DA2GUI.Generic.blackBox'
         ImageStyle=ISTY_Scaled
         ImageRenderStyle=MSTY_Normal
         WinHeight=1.000000
         RenderWeight=0.001000
         bVisible=False
     End Object
     i_BG2=GUIImage'DA2.da_GUI_MainMenu.ImgBG'

     Begin Object Class=GUIButton Name=MultiplayerButton
         CaptionAlign=TXTA_Right
         Caption="PLAY ONLINE"
         FontScale=FNS_Large
         StyleName="DA2Style_MainMenuText"
         WinTop=0.320000
         WinLeft=0.040000
         WinWidth=0.260000
         WinHeight=0.034000
         bFocusOnWatch=True
         OnHover=da_GUI_MainMenu.ButtonHover
         OnClick=da_GUI_MainMenu.ButtonClick
         OnKeyEvent=MultiplayerButton.InternalOnKeyEvent
     End Object
     b_MultiPlayer=GUIButton'DA2.da_GUI_MainMenu.MultiplayerButton'

     Begin Object Class=GUIButton Name=HostButton
         CaptionAlign=TXTA_Right
         Caption="HOST MULTIPLAYER GAME"
         FontScale=FNS_Large
         StyleName="DA2Style_MainMenuText"
         WinTop=0.380000
         WinLeft=0.040000
         WinWidth=0.260000
         WinHeight=0.034000
         bFocusOnWatch=True
         OnHover=da_GUI_MainMenu.ButtonHover
         OnClick=da_GUI_MainMenu.ButtonClick
         OnKeyEvent=HostButton.InternalOnKeyEvent
     End Object
     b_Host=GUIButton'DA2.da_GUI_MainMenu.HostButton'

     Begin Object Class=GUIButton Name=InstantActionButton
         CaptionAlign=TXTA_Right
         Caption="OFFLINE GAME"
         FontScale=FNS_Large
         StyleName="DA2Style_MainMenuText"
         WinTop=0.440000
         WinLeft=0.040000
         WinWidth=0.260000
         WinHeight=0.034000
         bFocusOnWatch=True
         OnHover=da_GUI_MainMenu.ButtonHover
         OnClick=da_GUI_MainMenu.ButtonClick
         OnKeyEvent=InstantActionButton.InternalOnKeyEvent
     End Object
     b_Instant=GUIButton'DA2.da_GUI_MainMenu.InstantActionButton'

     Begin Object Class=GUIButton Name=AchievementsButton
         CaptionAlign=TXTA_Right
         Caption="ACHIEVEMENTS"
         FontScale=FNS_Large
         StyleName="DA2Style_MainMenuText"
         WinTop=0.500000
         WinLeft=0.040000
         WinWidth=0.260000
         WinHeight=0.034000
         bFocusOnWatch=True
         OnHover=da_GUI_MainMenu.ButtonHover
         OnClick=da_GUI_MainMenu.ButtonClick
         OnKeyEvent=SettingsButton.InternalOnKeyEvent
     End Object
     b_Achievements=GUIButton'DA2.da_GUI_MainMenu.AchievementsButton'

     Begin Object Class=GUIButton Name=SettingsButton
         CaptionAlign=TXTA_Right
         Caption="SETTINGS"
         FontScale=FNS_Large
         StyleName="DA2Style_MainMenuText"
         WinTop=0.560000
         WinLeft=0.040000
         WinWidth=0.260000
         WinHeight=0.034000
         bFocusOnWatch=True
         OnHover=da_GUI_MainMenu.ButtonHover
         OnClick=da_GUI_MainMenu.ButtonClick
         OnKeyEvent=SettingsButton.InternalOnKeyEvent
     End Object
     b_Settings=GUIButton'DA2.da_GUI_MainMenu.SettingsButton'

     Begin Object Class=GUIButton Name=QuitButton
         CaptionAlign=TXTA_Right
         Caption="QUIT"
         FontScale=FNS_Large
         StyleName="DA2Style_MainMenuText"
         WinTop=0.680000
         WinLeft=0.040000
         WinWidth=0.260000
         WinHeight=0.034000
         bFocusOnWatch=True
         OnHover=da_GUI_MainMenu.ButtonHover
         OnClick=da_GUI_MainMenu.ButtonClick
         OnKeyEvent=QuitButton.InternalOnKeyEvent
     End Object
     b_Quit=GUIButton'DA2.da_GUI_MainMenu.QuitButton'

     Begin Object Class=GUILabel Name=MultiplayerHint
         Caption="PLAY WITH OTHER HUMAN PLAYERS OVER A NETWORK"
         FontScale=FNS_Small
         StyleName="DA2Style_MainMenuText"
         WinTop=0.323500
         WinLeft=0.330000
         WinWidth=0.600000
         WinHeight=0.030000
         bVisible=False
     End Object
     l_Multiplayer=GUILabel'DA2.da_GUI_MainMenu.MultiplayerHint'

     Begin Object Class=GUILabel Name=HostHint
         Caption="START A DEFENCE ALLIANCE 2 SERVER"
         FontScale=FNS_Small
         StyleName="DA2Style_MainMenuText"
         WinTop=0.383500
         WinLeft=0.330000
         WinWidth=0.600000
         WinHeight=0.030000
         bVisible=False
     End Object
     l_Host=GUILabel'DA2.da_GUI_MainMenu.HostHint'

     Begin Object Class=GUILabel Name=InstantActionHint
         Caption="PLAY WITH SOLDIERS UNDER YOUR COMMAND"
         FontScale=FNS_Small
         StyleName="DA2Style_MainMenuText"
         WinTop=0.443500
         WinLeft=0.330000
         WinWidth=0.600000
         WinHeight=0.030000
         bVisible=False
     End Object
     l_Instant=GUILabel'DA2.da_GUI_MainMenu.InstantActionHint'

     Begin Object Class=GUILabel Name=AchievementsHint
         Caption="VIEW YOUR STATISTICS AND ACHIEVEMENTS"
         FontScale=FNS_Small
         StyleName="DA2Style_MainMenuText"
         WinTop=0.503500
         WinLeft=0.330000
         WinWidth=0.600000
         WinHeight=0.030000
         bVisible=False
     End Object
     l_Achievements=GUILabel'DA2.da_GUI_MainMenu.AchievementsHint'

     Begin Object Class=GUILabel Name=SettingsHint
         Caption="CHANGE YOUR CONTROLS AND SETTINGS"
         FontScale=FNS_Small
         StyleName="DA2Style_MainMenuText"
         WinTop=0.563500
         WinLeft=0.330000
         WinWidth=0.600000
         WinHeight=0.030000
         bVisible=False
     End Object
     l_Settings=GUILabel'DA2.da_GUI_MainMenu.SettingsHint'

     Begin Object Class=GUILabel Name=QuitHint
         Caption="QUIT DEFENCE ALLIANCE 2"
         FontScale=FNS_Small
         StyleName="DA2Style_MainMenuText"
         WinTop=0.693500
         WinLeft=0.330000
         WinWidth=0.600000
         WinHeight=0.030000
         bVisible=False
     End Object
     l_Quit=GUILabel'DA2.da_GUI_MainMenu.QuitHint'

     Begin Object Class=GUILabel Name=Version
         Caption="Beta 3.00 [Build 2011.10.14] KF Edition"
         TextAlign=TXTA_Right
         TextStyle=MSTY_Alpha
         FontScale=FNS_Small
         StyleName="DA2Style_MainMenuText"
         WinTop=0.960000
         WinWidth=0.300000
         WinHeight=0.040000
     End Object
     l_Version=GUILabel'DA2.da_GUI_MainMenu.Version'

     menuMaps(0)="MOV-Menu"
     menuMaps(1)="MOV-Menu2"
     menuMaps(2)="MOV-Menu3"
     menuMaps(3)="MOV-Menu4"
     SteamMustBeRunningText="Steam must be running and you must have an active internet connection to access this"
     UnknownSteamErrorText="Unknown Steam error prevented access to this"
     bRenderWorld=True
     bAllowedAsLast=True
     OnOpen=da_GUI_MainMenu.MyOpened
     OnCanClose=da_GUI_MainMenu.CanClose
     OnPreDraw=da_GUI_MainMenu.myPreDraw
     OnTimer=da_GUI_MainMenu.myTimer
     OnKeyEvent=da_GUI_MainMenu.MyKeyEvent
}
