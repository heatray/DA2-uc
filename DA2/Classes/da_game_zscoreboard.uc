//=============================================================================
// da_game_zscoreboard.
//=============================================================================
class da_game_zscoreboard extends da_game_scoreboard
	placeable;



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
	            c.drawText("none");
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
        if(pri.boutoflives==false)
		c.drawText(int(PRI.Score));
        else c.drawtext(" OUT");
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

defaultproperties
{
}
