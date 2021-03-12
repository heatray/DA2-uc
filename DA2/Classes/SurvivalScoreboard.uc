class SurvivalScoreboard extends da_game_ScoreBoard;

simulated function drawScores(Canvas c) {
	c.Reset();
	c.SetOrigin(0, 0);

   	drawTeam(c, 0);
    //drawTeam(c, 1);
}

function setListFont(Canvas c) {
	local int sh;

	// DIN = DIN7 8 9 10 11 13 14 16 18 20 22 25 31 40
	// All hail the insane font selection IF
	sh = c.ClipY;
	if (sh <= 384) {
		// 512x384-
		c.Font = font'DA2FontsDialog.DIN9';
	} else if (sh <= 480) {
		// 640x480-
		c.Font = font'DA2FontsDialog.DIN9';
	} else if (sh <= 600) {
		// 800x600-
		c.Font = font'DA2FontsDialog.DIN10';
	} else if (sh <= 768) {
		// 1024x768-
		c.Font = font'DA2FontsDialog.DIN11';
	} else if (sh <= 864) {
		// 1152x864-
		c.Font = font'DA2FontsDialog.DIN13';
	} else if (sh <= 900) {
		// 1280x900-
		c.Font = font'DA2FontsDialog.DIN13';
	} else if (sh <= 960) {
		// 1280x960-
		c.Font = font'DA2FontsDialog.DIN14';
	} else if (sh <= 1024) {
		// 1280x1024-
		c.Font = font'DA2FontsDialog.DIN16';
	} else if (sh <= 1200) {
		// 1600x1200-
		c.Font = font'DA2FontsDialog.DIN18';
	} else {
		// +1600x1200 (usually 2048x1536)
		c.Font = font'DA2FontsDialog.DIN18';
	}

}

simulated function drawTeam(Canvas c, int team) {
	local int i;
	local float posY;
	local float scTop, scLeft, scWidth, scHeight; // score position
	local int totalScore, teamTotalDamage;

	scTop = 0.162;
	scWidth = 0.932;
	scHeight = 0.796;
	scLeft = 0.032;

	c.Style = ERenderStyle.STY_Normal;

	// Team headers: TEAM x
	c.setDrawColor(255, 255, 255, 230);
	setTitleFont(c);
	if (team == 0) {
	   if (GRI.Winner != none && TeamInfo(GRI.Winner).TeamIndex == team)
            c.DrawTextJustified("DEFENDERS - WINNER", 1, scLeft * c.clipX, (scTop + 0.030) * c.clipY, (scLeft+scWidth) * c.clipX, (scTop + 0.058) * c.clipY); // x1 y1 x2 y2
       else
            c.DrawTextJustified("DEFENDERS", 1, scLeft * c.clipX, (scTop + 0.030) * c.clipY, (scLeft+scWidth) * c.clipX, (scTop + 0.058) * c.clipY); // x1 y1 x2 y2
	//} else {
    //   if (GRI.Winner != none && TeamInfo(GRI.Winner).TeamIndex == team)
    //        c.DrawTextJustified("ATTACKERS - WINNER", 1, scLeft * c.clipX, (scTop + 0.030) * c.clipY, (scLeft+scWidth) * c.clipX, (scTop + 0.058) * c.clipY); // x1 y1 x2 y2
    //   else
    //        c.DrawTextJustified("ATTACKERS", 1, scLeft * c.clipX, (scTop + 0.030) * c.clipY, (scLeft+scWidth) * c.clipX, (scTop + 0.058) * c.clipY); // x1 y1 x2 y2
	}

	// Headers: NAME CLASS SCORE PING
	setListFont(c);
	posY = scTop + 0.104;
	drawPlayerInfo2(c, none, scLeft, posY, scWidth, false, 0, 0);

	// Actual player list
	posY = scTop + 0.152;
	for (i = 0; i < GRI.PRIArray.length && posY < scTop + scHeight - 0.048; i++) {
		if (GRI.PRIArray[i].team != none && GRI.PRIArray[i].team.teamIndex == team) {
			drawPlayerInfo2(c, da_players_PRI(GRI.PRIArray[i]), scLeft, posY, scWidth, false, 0, 0);
			totalScore += int(da_players_PRI(GRI.PRIArray[i]).Score);
			teamTotalDamage += SurvivalPlayerReplicationInfo(GRI.PRIArray[i]).totalDamageDone;
			posY += 0.035;
		}
	}

	// Bottom: TOTAL
	posY = scTop + scHeight - 0.048;
	drawPlayerInfo2(c, none, scLeft, posY, scWidth, true, totalScore, teamTotalDamage);

}

simulated function drawPlayerInfo2(Canvas c, da_players_PRI PRI, float x, float y, float width, bool bIsScore, int totalScore, int totalDamage) {
	local float nameX, scoreX, classX, rankX, pingX, specialScoreX, HealthX;
	local string className, RankNr;

	nameX = (x + 0.044) * c.ClipX;
	classX = (x + 0.174) * c.ClipX;
	rankX = (x + 0.304) * c.ClipX;
	HealthX = (x + 0.434) * c.ClipX;
	scoreX = (x + 0.584) * c.ClipX;
	specialScoreX = (x + 0.724) * c.ClipX;
	pingX = (x + 0.864) * c.ClipX;

	y = y * c.ClipY;

//	c.FontScaleX = 2;
//  DA2Fonts.MainMenu22

	if (PRI != none && da_players_PRI(PlayerController(Owner).PlayerReplicationInfo) == PRI) 
	{
		// User highlight box
		c.Style = ERenderStyle.STY_Alpha;
		c.setDrawColor(179, 160, 100, 45);
		class'da_Utilities'.static.fillRect(c, (x + 0.01) * c.clipX, y - (0.0025 * c.clipY), (width - 0.02) * c.clipX, 0.029 * c.clipY); // left, top, width, height
		c.Style = ERenderStyle.STY_Normal;
	}

	if (PRI != none) 
	{
		// Normal player
		c.setDrawColor(255, 255, 255, 230);
	} else 
	{
		if (bIsScore) 
		{
			// Total score
			c.setDrawColor(255, 255, 255, 250);
		} 
		else 
		{
			// Header
			c.setDrawColor(255, 255, 255, 250);
		}
	}

	if (PRI != none && PRI.bOutOfLives)
	{
		c.SetDrawColor(255, 0, 0, 250);
		c.SetPos(nameX-38, y);
		c.DrawTile(Texture'InterfaceArt_tex.HUD.criticalmessages_icons', 26, 26, 128, 128, 64, 64);
		// InterfaceArt_tex.HUD.criticalmessages_icons
	}

	c.setPos(nameX, y);
	if (PRI != none) 
	{
		c.drawText(PRI.playerName);
	} 
	else 
	{
		if (bIsScore) 
		{
			c.drawText("TOTAL");
		} 
		else 
		{
			c.drawText("NAME");
		}
	}

	c.setPos(classX, y);
	if (PRI != none && PRI.team != none) 
	{
		if (da_players_PRI(PlayerController(Owner).PlayerReplicationInfo).team != none && PRI.team.teamIndex == da_players_PRI(PlayerController(Owner).PlayerReplicationInfo).team.teamIndex || PlayerController(Owner).PlayerReplicationInfo.bOnlySpectator) 
		{
			// Same team, shows classes
	        if (PRI.playerClass >= 0) 
	        {
	        	className = DAGRI.teamConfig[PRI.team.teamIndex].classSet.playerClasses[PRI.playerClass].name;
	        	// Short names for small screen
	        	if (c.ClipX <= 800) 
	        	{
		        	if (className == "Long Range Support") className = "Long Range";
	    	    	if (className == "Anti-Armor Infantry") className = "Anti-Armor";
	    	    }
	    		c.drawText(className);
	    	} 
	    	else 
	    	{
	            c.drawText("");
	    	}
        }
        else 
        {
    		// Different team (or spec), hides classes
    		c.drawText("?");
	    }
	}
	else 
	{
		if (!bIsScore) 
		{
			c.drawText("CLASS");
		}
	}

	c.setPos(scoreX, y);
	if (PRI != none) 
	{
		c.drawText(int(PRI.Score) $ " / " $ int(PRI.Deaths));
		//c.drawText(int(PRI.Score));
	} 
	else 
	{
		if (bIsScore) 
		{
			c.drawText(totalScore);
		} 
		else 
		{
			c.drawText("SCORE");
		}
	}

	c.setPos(specialScoreX, y);
	if (SurvivalPlayerReplicationInfo(PRI) != none)
	{
		c.DrawText(SurvivalPlayerReplicationInfo(PRI).totalDamageDone);
	}
	else 
	{
		if (bIsScore) 
		{
			c.drawText(totalDamage);
		}
		else
		{
			c.drawText("DAMAGE");
		}
	}
	
	c.setPos(pingX, y);
	if (PRI != none) 
	{
		c.DrawText(Min(999,4*PRI.Ping),true);
	} 
	else 
	{
		if (!bIsScore)
		{
			c.drawText("PING");
		}
	}
	
	c.setPos(rankX, y);
	if (PRI != none)
	{
		c.DrawText(PRI.playerRank);
	}
	else 
	{
		if (!bIsScore)
		{
			c.drawText("RANK");
		}
	}

	if (PRI != none && PRI.PlayerRank > 0)
	{
		c.SetDrawColor(255, 255, 255, 250);
		c.SetPos(rankX+25, y-2.2);
		
		switch(PRI.playerRank)
		{ 
			case 9: RankNr = "3"; c.DrawTile(Texture'DA2GUI.misc.Star', 32, 32, 0, 0, 256, 256); break;
			case 8: RankNr = "2"; c.DrawTile(Texture'DA2GUI.misc.Star', 32, 32, 0, 0, 256, 256); break;
			case 7: RankNr = "1"; c.DrawTile(Texture'DA2GUI.misc.Star', 32, 32, 0, 0, 256, 256); break;
			case 6: RankNr = "3"; c.DrawTile(Texture'DA2GUI.misc.Captain', 32, 32, 0, 0, 256, 256); break;
			case 5: RankNr = "2"; c.DrawTile(Texture'DA2GUI.misc.Captain', 32, 32, 0, 0, 256, 256); break;
			case 4: RankNr = "1"; c.DrawTile(Texture'DA2GUI.misc.Captain', 32, 32, 0, 0, 256, 256); break;
			case 3: RankNr = "3"; c.DrawTile(Texture'DA2GUI.misc.Private', 32, 32, 0, 0, 256, 256); break;
			case 2: RankNr = "2"; c.DrawTile(Texture'DA2GUI.misc.Private', 32, 32, 0, 0, 256, 256); break;
			case 1: RankNr = "1"; c.DrawTile(Texture'DA2GUI.misc.Private', 32, 32, 0, 0, 256, 256); break;	
		}
		
		c.Font = font'DA2FontsDialog.DIN10';
		c.setPos(Rankx+55, y-2);
		c.DrawText(RankNr);
		setListFont(c);
	}
	
	c.setPos(HealthX, y);
	if (PRI != none) 
	{
		c.SetDrawColor(fclamp((100 - PRI.PlayerHealth) / 33.0 * 255.0, 0, 255), 255 - fclamp((33 - PRI.PlayerHealth) / 33.0 * 255.0, 0, 255), 0);
		c.DrawText(PRI.PlayerHealth);
	} 
	else 
	{
		if (!bIsScore)
		{
			c.drawText("HEALTH");
		}
	}
	
	if (SurvivalPlayerReplicationInfo(PRI) != none && SurvivalPlayerReplicationInfo(PRI).totalDamageDone >= 75000)
	{
		if (SurvivalPlayerReplicationInfo(PRI).totalDamageDone >= 125000)
			c.SetDrawColor(255, 0, 0, 128);
		else 
			c.SetDrawColor(255, 255, 255, 128);
			
		c.SetPos(specialScoreX-38, y+0.3);
		c.DrawTile(Texture'InterfaceArt_tex.HUD.criticalmessages_icons', 24, 24, 192, 128, 64, 64);
	}
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
	//c.SetPos (c.clipX * 0.82, c.clipY * 0.163);
	//c.DrawTileStretched(middleMaterial, 0.0030 * c.clipX, 0.794 * c.clipY);

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
	c.DrawTextJustified(GRI.ServerName, 1, 0.218 * c.clipX, 0.063 * c.clipY, 0.782 * c.clipX, 0.099 * c.clipY); // x1 y1 x2 y2

}

defaultproperties
{
}
