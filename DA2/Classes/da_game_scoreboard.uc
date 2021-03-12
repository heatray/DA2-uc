// ============================================================================
//  DA2.da_game_scoreboard:
//  By: Dante, zeh
// ============================================================================

// D:\mods\UT2004Script3339\XInterface\Classes\ScoreBoardDeathMatch.uc

// TODO
// * properly align the text vertically depending on the number of players
// * turn off additional HUD stuff that gets in the way (messages, objective hint, objective arrow)

class da_game_ScoreBoard extends ScoreBoard;

#exec OBJ LOAD FILE=..\Textures\DA2FontsDialog.utx PACKAGE=DA2FontsDialog

struct SWindow {
	var float left, top, width, height;
};

var da_game_ReplicationInfo DAGRI;

var localized string        OutFireText;
var() localized String      FPH, GameType,MapName, Restart, Continue, Ended, TimeLimit, Spacer;
var() localized string      FooterText;

var() Material topMaterial;
var() Material logoMaterial;
var() Material boxMaterial;
var() Material middleMaterial;

simulated function UpdateScoreBoard(Canvas Canvas) {
	DAGRI = da_game_ReplicationInfo(GRI);
	if (DAGRI == none || DAGRI.teamConfig[0] == none || DAGRI.teamConfig[1] == none) return;

	drawInfo(canvas, 0, 30, 0);
	drawBackGround(canvas);
	drawScores(canvas);
}

// ======================================================================

function DrawInfo(Canvas Canvas, float HeaderOffsetY, float PlayerAreaY, float PlayerBoxSizeY) {
    local string scoreinfostring,RestartString;
    local float ScoreInfoXL,YL;

    if (Canvas.ClipX < 512) return;

	Canvas.Style = ERenderStyle.STY_Normal;

    ScoreInfoString = GetDefaultScoreInfoString();
    Canvas.Font = Font(DynamicLoadObject("DA2FontsDialog.DIN10", class'Font'));
    Canvas.SetDrawColor(200,200,200,255);

    if (UnrealPlayer(Owner).bDisplayLoser) {
    	ScoreInfoString = class'HUDBase'.default.YouveLostTheMatch;
    } else if (UnrealPlayer(Owner).bDisplayWinner) {
        ScoreInfoString = class'HUDBase'.default.YouveWonTheMatch;
    } else if (PlayerController(Owner).IsDead()) {
        RestartString = GetRestartString();

        if ( Canvas.ClipY - HeaderOffsetY - PlayerAreaY >= 2.5 * YL ) {
            Canvas.StrLen(RestartString,ScoreInfoXL,YL);
            Canvas.SetPos(0.5*(Canvas.ClipX-ScoreInfoXL), Canvas.ClipY - 2.5 * YL);
            Canvas.DrawText(RestartString,true);
        } else {
            ScoreInfoString = RestartString;
        }
    }
    Canvas.StrLen(ScoreInfoString,ScoreInfoXL,YL);

    Canvas.SetPos(0.5*(Canvas.ClipX-ScoreInfoXL), Canvas.ClipY - 1.5 * YL);
    Canvas.DrawText(ScoreInfoString,true);
}

function String GetDefaultScoreInfoString() {
    local String ScoreInfoString;

    if (GRI == None) return "";

    if (GRI.TimeLimit != 0 && GRI.Winner == none) {
    	ScoreInfoString = ScoreInfoString@spacer@TimeLimit$FormatTime(GRI.RemainingTime);
    } else {
        ScoreInfoString = ScoreInfoString@spacer@FooterText@FormatTime(GRI.ElapsedTime);
    }

    return ScoreInfoString;
}

function String GetRestartString() {
    local string RestartString;

    RestartString = Restart;
    if ( PlayerController(Owner).PlayerReplicationInfo.bOutOfLives )
        RestartString = OutFireText;
    else if ( Level.TimeSeconds - UnrealPlayer(Owner).LastKickWarningTime < 2 )
        RestartString = class'GameMessage'.Default.KickWarning;
    return RestartString;
}



simulated function drawBackGround(Canvas c) 
{
	// Reset everything ====================

	c.Reset();
	c.SetDrawColor(255, 255, 255, 255);
	c.Style = ERenderStyle.STY_Normal;
	c.SetOrigin(0, 0);

	// Top ====================

	c.SetPos (c.clipX * 0, c.clipY * 0.042);
	c.DrawTileStretched(topMaterial, 1.0 * c.clipX, 0.077 * c.clipY);

	c.SetPos (c.clipX * 0.006, c.clipY * 0.053);
//	c.DrawTileScaled(logoMaterial, 0.138 * c.clipX, 0.059 * c.clipY);
	c.DrawTileScaled(logoMaterial, 0.0005379 * c.clipX, 0.000916 * c.clipY);

	// krazy kalculations for DrawTileScaled:
	// w = (the width of the image on the PSD [141] / the width of the image file [256]) / the PSD width [1024]
	// h = (the height of the image on the PSD [45] / the height of the image file [64]) / the PSD height [768]

	// Middle box ====================
	c.SetPos (c.clipX * 0.032, c.clipY * 0.162);
	c.DrawTileStretched(boxMaterial, 0.936 * c.clipX, 0.796 * c.clipY);

	// Separator
	c.SetPos (c.clipX * 0.4985, c.clipY * 0.163);
	c.DrawTileStretched(middleMaterial, 0.0030 * c.clipX, 0.794 * c.clipY);

	c.Style = ERenderStyle.STY_Alpha;

	// "Team" title box
	c.setDrawColor(179, 100, 100, 51);
	class'da_Utilities'.static.fillRect(c, 0.033 * c.clipX, 0.182 * c.clipY, 0.934 * c.clipX, 0.047 * c.clipY); // left, top, width, height

	// Player list header box
	c.setDrawColor(179, 100, 100, 25);
	class'da_Utilities'.static.fillRect(c, 0.033 * c.clipX, 0.262 * c.clipY, 0.934 * c.clipX, 0.031 * c.clipY);

	// Bottom box
	// (bottom @ 0.958)
	c.setDrawColor(179, 100, 100, 51);
	class'da_Utilities'.static.fillRect(c, 0.033 * c.clipX, 0.906 * c.clipY, 0.934 * c.clipX, 0.031 * c.clipY);

	// Title text ====================
	// Description below on the drawScores() function
	c.setDrawColor(255, 255, 255, 255);
	setTitleFont(c);
	c.DrawTextJustified("CURRENT SCORES", 1, 0.318 * c.clipX, 0.063 * c.clipY, 0.682 * c.clipX, 0.099 * c.clipY); // x1 y1 x2 y2

}

simulated function drawScores(Canvas c) {
	c.Reset();
	c.SetOrigin(0, 0);

   	drawTeam(c, 0);
    drawTeam(c, 1);
}

function setTitleFont(Canvas c) {
	local int sh;

	sh = c.ClipY;
	if (sh <= 384) {
		c.Font = font'DA2FontsDialog.DIN11';
	} else if (sh <= 480) {
		c.Font = font'DA2FontsDialog.DIN13';
	} else if (sh <= 600) {
		c.Font = font'DA2FontsDialog.DIN14';
	} else if (sh <= 768) {
		c.Font = font'DA2FontsDialog.DIN16';
	} else if (sh <= 864) {
		c.Font = font'DA2FontsDialog.DIN18';
	} else if (sh <= 900) {
		c.Font = font'DA2FontsDialog.DIN20';
	} else if (sh <= 960) {
		c.Font = font'DA2FontsDialog.DIN22';
	} else if (sh <= 1024) {
		c.Font = font'DA2FontsDialog.DIN25';
	} else if (sh <= 1200) {
		c.Font = font'DA2FontsDialog.DIN31';
	} else {
		c.Font = font'DA2FontsDialog.DIN40';
	}

}

function setListFont(Canvas c) {
	local int sh;

	// DIN = DIN7 8 9 10 11 13 14 16 18 20 22 25 31 40
	// All hail the insane font selection IF
	sh = c.ClipY;
	if (sh <= 384) {
		// 512x384-
		c.Font = font'DA2FontsDialog.DIN8';
	} else if (sh <= 480) {
		// 640x480-
		c.Font = font'DA2FontsDialog.DIN10';
	} else if (sh <= 600) {
		// 800x600-
		c.Font = font'DA2FontsDialog.DIN11';
	} else if (sh <= 768) {
		// 1024x768-
		c.Font = font'DA2FontsDialog.DIN13';
	} else if (sh <= 864) {
		// 1152x864-
		c.Font = font'DA2FontsDialog.DIN14';
	} else if (sh <= 900) {
		// 1280x900-
		c.Font = font'DA2FontsDialog.DIN14';
	} else if (sh <= 960) {
		// 1280x960-
		c.Font = font'DA2FontsDialog.DIN16';
	} else if (sh <= 1024) {
		// 1280x1024-
		c.Font = font'DA2FontsDialog.DIN18';
	} else if (sh <= 1200) {
		// 1600x1200-
		c.Font = font'DA2FontsDialog.DIN20';
	} else {
		// +1600x1200 (usually 2048x1536)
		c.Font = font'DA2FontsDialog.DIN22';
	}

}

simulated function drawTeam(Canvas c, int team) {
	local int i;
	local float posY;
	local float scTop, scLeft, scWidth, scHeight; // score position
	local int totalScore;

	scTop = 0.162;
	scWidth = 0.468;
	scHeight = 0.796;
	if (team == 0) {
		scLeft = 0.032;
	} else {
		scLeft = 0.5;
	}

	c.Style = ERenderStyle.STY_Normal;

	// Team headers: TEAM x
	c.setDrawColor(255, 255, 255, 230);
	setTitleFont(c);
	if (team == 0) {
	   if (GRI.Winner != none && TeamInfo(GRI.Winner).TeamIndex == team)
            c.DrawTextJustified("DEFENDERS - WINNER", 1, scLeft * c.clipX, (scTop + 0.030) * c.clipY, (scLeft+scWidth) * c.clipX, (scTop + 0.058) * c.clipY); // x1 y1 x2 y2
       else
            c.DrawTextJustified("DEFENDERS", 1, scLeft * c.clipX, (scTop + 0.030) * c.clipY, (scLeft+scWidth) * c.clipX, (scTop + 0.058) * c.clipY); // x1 y1 x2 y2
	} else {
       if (GRI.Winner != none && TeamInfo(GRI.Winner).TeamIndex == team)
            c.DrawTextJustified("ATTACKERS - WINNER", 1, scLeft * c.clipX, (scTop + 0.030) * c.clipY, (scLeft+scWidth) * c.clipX, (scTop + 0.058) * c.clipY); // x1 y1 x2 y2
       else
            c.DrawTextJustified("ATTACKERS", 1, scLeft * c.clipX, (scTop + 0.030) * c.clipY, (scLeft+scWidth) * c.clipX, (scTop + 0.058) * c.clipY); // x1 y1 x2 y2
	}

	// Headers: NAME CLASS SCORE PING
	setListFont(c);
	posY = scTop + 0.104;
	drawPlayerInfo(c, none, scLeft, posY, scWidth, false, 0);

	// Actual player list
	posY = scTop + 0.152;
	for (i = 0; i < GRI.PRIArray.length && posY < scTop + scHeight - 0.048; i++) {
		if (GRI.PRIArray[i].team != none && GRI.PRIArray[i].team.teamIndex == team) {
			drawPlayerInfo(c, da_players_PRI(GRI.PRIArray[i]), scLeft, posY, scWidth, false, 0);
			totalScore += int(da_players_PRI(GRI.PRIArray[i]).Score);
			posY += 0.05;
		}
	}

	// Bottom: TOTAL
	posY = scTop + scHeight - 0.048;
	drawPlayerInfo(c, none, scLeft, posY, scWidth, true, totalScore);

}

simulated function drawPlayerInfo(Canvas c, da_players_PRI PRI, float x, float y, float width, bool bIsScore, int totalScore) {
	local float nameX, scoreX, classX, pingX;
	local string className;

	nameX = (x + 0.024) * c.ClipX;
	classX = (x + 0.175) * c.ClipX;
	classX = (x + 0.175) * c.ClipX;
	scoreX = (x + 0.34) * c.ClipX;
	pingX = (x + 0.414) * c.ClipX;

	y = y * c.ClipY;

//	c.FontScaleX = 2;
//  DA2Fonts.MainMenu22

	if (PRI != none && da_players_PRI(PlayerController(Owner).PlayerReplicationInfo) == PRI) {
		// User highlight box
		c.Style = ERenderStyle.STY_Alpha;
		c.setDrawColor(179, 160, 100, 45);
		class'da_Utilities'.static.fillRect(c, (x + 0.01) * c.clipX, y - (0.003 * c.clipY), (width - 0.02) * c.clipX, 0.031 * c.clipY); // left, top, width, height
		c.Style = ERenderStyle.STY_Normal;
	}

	if (PRI != none) {
		// Normal player
		c.setDrawColor(255, 255, 255, 230);
	} else {
		if (bIsScore) {
			// Total score
			c.setDrawColor(255, 255, 255, 250);
		} else {
			// Header
			c.setDrawColor(255, 255, 255, 250);
		}
	}

	c.setPos(nameX, y);
	if (PRI != none) {
		c.drawText(PRI.playerName);
	} else {
		if (bIsScore) {
			c.drawText("TOTAL");
		} else {
			c.drawText("NAME");
		}
	}

	c.setPos(classX, y);
	if (PRI != none && PRI.team != none) {
		if (da_players_PRI(PlayerController(Owner).PlayerReplicationInfo).team != none && PRI.team.teamIndex == da_players_PRI(PlayerController(Owner).PlayerReplicationInfo).team.teamIndex || PlayerController(Owner).PlayerReplicationInfo.bOnlySpectator) {
			// Same team, shows classes
	        if (PRI.playerClass >= 0) {
	        	className = DAGRI.teamConfig[PRI.team.teamIndex].classSet.playerClasses[PRI.playerClass].name;
	        	// Short names for small screen
	        	if (c.ClipX <= 800) {
		        	if (className == "Long Range Support") className = "Long Range";
	    	    	if (className == "Anti-Armor Infantry") className = "Anti-Armor";
	    	    }
	    		c.drawText(className);
	    	} else {
	            c.drawText("");
	    	}
        } else {
    		// Different team (or spec), hides classes
    		c.drawText("?");
	    }
	} else {
		if (!bIsScore) {
			c.drawText("CLASS");
		}
	}

	c.setPos(scoreX, y);
	if (PRI != none) {
//		c.drawText(int(PRI.Score) $ " / " $ int(PRI.Deaths));
		c.drawText(int(PRI.Score));
	} else {
		if (bIsScore) {
			c.drawText(totalScore);
		} else {
			c.drawText("SCORE");
		}
	}

	c.setPos(pingX, y);
	if (PRI != none) {
		c.DrawText(Min(999,4*PRI.Ping),true);
	} else {
		if (!bIsScore) {
			c.drawText("PING");
		}
	}

}

// ======================================================================

defaultproperties
{
     OutFireText="   You are OUT. Fire to view other players."
     FPH="PPH"
     GameType="Defence Alliance"
     MapName=" in "
     Restart="   You were killed. Press Fire to respawn!"
     Continue=" Press [Fire] to continue!"
     Ended="The match has ended."
     TimeLimit="REMAINING TIME:"
     Spacer=" "
     FooterText="Elapsed Time:"
     topMaterial=Texture'DA2GUI.Dialog.scoreboardTop'
     logoMaterial=Texture'DA2GUI.Dialog.scoreboardLogo'
     BoxMaterial=Texture'DA2GUI.Dialog.scoreboardBox'
     middleMaterial=Texture'DA2GUI.Dialog.scoreboardMiddle'
     HudClass=Class'XInterface.HudBase'
}
