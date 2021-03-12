class SurvivalHud extends da_players_Hud;

var int bossPreviousHealth, bossHealthPositionY, bossHealDisplayTime, previousLifeCount, lifeGainFlashTime;
var array<int> timersCounter;
var array<string> timersIndex;
var array<int> timersMax;

var SurvivalPlayerReplicationInfo SPRI;
var SurvivalGameReplicationInfo SGRI;

var()   SpriteWidget            HealthIcon;

var		float					HealthIconSize;


simulated function checkDrawHealthInfo(Canvas C) { }

simulated function LinkActors()
{
	Super.LinkActors();

    if (SurvivalPlayerReplicationInfo(PlayerOwner.PlayerReplicationInfo) != none)
		SPRI = SurvivalPlayerReplicationInfo(PlayerOwner.PlayerReplicationInfo);
	if (SurvivalGameReplicationInfo(PlayerOwner.GameReplicationInfo) != none)
		SGRI = SurvivalGameReplicationInfo(PlayerOwner.GameReplicationInfo);
}

simulated function DisplayEventMessage(Canvas c)
{
	if (SPRI != none && SPRI.eventTime >= Level.TimeSeconds)
	{
		c.DrawColor = SPRI.eventColor;
		c.Font = super.GetMyMediumFont(c);
		c.DrawTextJustified(SPRI.eventMessage, 1, 0, 0, c.ClipX, c.ClipY/2);
	}
}

simulated function int Interval(string timerName, optional int runTime, optional int mod)
{
	local int timerCount, timerIndex, i, newIndex;

	timerIndex = -1;
	for (i=0; i<timersIndex.Length; i++)
	{
		if (timersIndex[i] == timerName)
		{
			timerIndex = i;
			break;
		}
	}

	if (timerIndex < 0)
	{
		newIndex = timersIndex.Length;
		timersIndex[newIndex] = timerName;
		timersCounter[newIndex] = 0;
		timersMax[newIndex] = runTime;
	}
	else if (timersCounter[timerIndex] == 0 && runTime == 0)
	{
		timersCounter[timerIndex] = timersMax[timerIndex];
	}
	else
	{
		timerCount=timersCounter[timerIndex];

		if (runTime <= 0)
		{
			if (mod == 0)
			timersCounter[timerIndex]--;
			else timersCounter[timerIndex] = timerCount-mod;
		}
		return timerCount;
	}
	return 0;
}

simulated event PostRender(canvas c)
{
	Super.PostRender(c);

	if (SGRI != none && !bShowScoreBoard)
	{
		c.SetPos(0, 0);
		c.DrawColor.R = 255;
		c.DrawColor.G = 255;
		c.DrawColor.B = 255;
		c.DrawColor.A = 255;

		// DA2HUD.HUD.HUDIR5
		//c.DrawTile(texture'DA2HUD.HUD.HUDIR5',c.ClipX,50,164,254,175,75);
		//c.DrawTileStretched(Texture'DA2GUI.Dialog.Display98', c.ClipX, 50);
		c.DrawTile(texture'DA2GUI.Dialog.Display98', c.ClipX, 50, 30, 20, 50, 100);
		c.Font = super.GetMyMediumFont(c);

		DrawZombieKillCounter(c);
		DrawZombieDensity(c);
		DrawLifeCounter(c);
		DrawDifficulty(c);
	    checkDrawInfoBox(c);
		drawNameInfoBox(c);
		DrawWaveCount(c);

			
		if (SurvivalGameReplicationInfo(PlayerOwner.GameReplicationInfo).bossAlive)
		{
			DrawBossHealth(c, SurvivalGameReplicationInfo(PlayerOwner.GameReplicationInfo).bossHealth, SurvivalGameReplicationInfo(PlayerOwner.GameReplicationInfo).bossMaxHealth);
		}

		DrawChampionHealthBar(c, 4000);


		// Now does DrawBuildingLimits in da_players_HUD
		//if (da_players_ClassPlayer(PlayerOwner.Pawn) != none && SPRI.playerClass == 1)
		//{
		//	DrawBuildingLimits(c, da_players_ClassPlayer(PlayerOwner.Pawn), c.ClipX-90, c.ClipY*0.30, 80, 80);
		//}
		drawGameTime(c);
		//drawRadar(c);
		DisplayEventMessage(c);
		// FOR SCOREBOARD
		// HUD collection with SKULL: InterfaceArt_tex.HUD.criticalmessages_icons

		// FOR HUD
		// Zombie Icon from KF. KillingFloor2HUD.Achievements.Achievement_60 (DOESNT WORK HAS NUMBER ON IT! meh)
		// Star KillingFloor2HUD.Perk_Icons.Hud_Perk_Star_Gold
	}
}

/*

simulated function DrawBuildingLimits(Canvas c, da_players_ClassPlayer playerPawn, int x, int y, int height, int width)
{
	// DA2GUI.Misc.sideviewAmmobox
	// -- .sideviewAver
	// -- .sideviewCrusher
	// -- .sideviewDFA
	local int i, boxY, amount, limit;
	local Texture bTexture;
	if (playerPawn != none)
	{
		//nAmmo = playerPawn.countAmmobox();
		//nAver = playerPawn.countTurrets(class'da_turrets_AVeRTurret');
		//nCrush = playerPawn.countTurrets(class'da_turrets_CrushTurret');
		//nDfa = playerPawn.countTurrets(class'da_turrets_DFATurret');

		//c.DrawColor = c.MakeColor(255,255,255);
		c.Font = super.GetMyMediumFont(c);
		//c.DrawTextJustified("Ammo:"@ammoBoxes@"AVeR Turrets:"@aTurrets@"Crusher Turrets:"@cTurrets@"DFA Turrets:"@dTurrets, 1, 0, 100, c.ClipX, 120);

		boxY = y;
		for (i=0; i<4; i++)
		{
			switch (i)
			{
				case 0:
					bTexture = Texture'DA2GUI.Misc.sideviewAmmobox';
					amount = SGRI.buildCount[0];
					limit = SGRI.buildLimits[0];
				break;
				case 1:
					bTexture = Texture'DA2GUI.Misc.sideviewAver';
					amount = SGRI.buildCount[1];
					limit = SGRI.buildLimits[1];
				break;
				case 2:
					bTexture = Texture'DA2GUI.Misc.sideviewCrusher';
					amount = SGRI.buildCount[2];
					limit = SGRI.buildLimits[2];
				break;
				case 3:
					bTexture = Texture'DA2GUI.Misc.sideviewDFA';
					amount = SGRI.buildCount[3];
					limit = SGRI.buildLimits[3];
				break;
			}

			if (limit != 0)
			{
				c.SetPos(x, boxY);

				if (amount >= limit)
				{
					c.DrawColor = class'Canvas'.static.MakeColor(255, 0 ,0);
				}
				else 
				{
					c.DrawColor = class'Canvas'.static.MakeColor(255,255,255);
				}

				c.DrawTile(bTexture, width, height, 0, 0, 256, 256);
				if (amount < limit)
				{
					c.Font = super.GetMyMediumFont(c);
					c.DrawTextJustified(amount@"/"@limit, 1, x, boxY, x+width, boxY+height);
				}
				else
				{
					c.Font = super.GetMyTinyFont(c);
					c.DrawTextJustified("LIMIT", 1, x, boxY+(height/2)-20, x+width, boxY+(height/2));
					c.DrawTextJustified("REACHED", 1, x, boxY+(height/2), x+width, boxY+(height/2)+20);
				}

				boxY += height+10;
			}
		}

		//DrawBuildingLimitBox(c, x, boxY, Texture'DA2GUI.Misc.sideviewAmmobox', nAmmo, teamConfig.numAmmoboxes);
		//DrawBuildingLimitBox(c, c.ClipX*0.40, y, Texture'DA2GUI.Misc.sideviewAver', nAver, teamConfig.numAVeRs);
		//DrawBuildingLimitBox(c, c.ClipX*0.60, y, Texture'DA2GUI.Misc.sideviewCrusher', nCrush, teamConfig.numCrushers);
		//DrawBuildingLimitBox(c, c.ClipX*0.80, y, Texture'DA2GUI.Misc.sideviewDFA', nDfa, teamConfig.numDFAs);
	}
}

simulated function DrawTurretInfo(Canvas c, int x, int y, class<da_turrets_Turret> turret)
{
	
}

simulated function DrawBuildingLimitBox(Canvas c, int x, int y, Texture texture, int count, int limit)
{
	c.SetPos(x, y);

	if (count >= limit)
	{
		c.DrawColor = class'Canvas'.static.MakeColor(255, 0 ,0);
	}
	else 
	{
		c.DrawColor = class'Canvas'.static.MakeColor(255,255,255);
	}
	c.DrawTile(texture, 128, 128, 0, 0, 256, 256);
	c.DrawTextJustified(count@"/"@limit, 1, x, y, x+128, y+128);
}

*/



simulated function drawNameInfoBox(Canvas c) {
    local da_players_classPlayer dac;
    local vector X, Y, Z;
    local float ax, ay, xpos, ypos;
    local vector    ScreenPos, CamLoc;
    local rotator    CamRot;
    local Material TempMaterial;
    local float TempSize;
	local string RankNr;

if (PawnOwner != None)
{

   c.GetCameraLocation( CamLoc, CamRot);
   foreach VisibleCollidingActors(class'da_players_classPlayer', dac, 4000, PawnOwner.Location)

    if (dac != none && dac != PawnOwner  && IsTargetInFrontOfPlayer( c, dac, ScreenPos, CamLoc, CamRot )) {
        getAxes(playerOwner.getViewRotation(), X, Y, Z);

    ax = c.WorldToScreen(dac.location - dac.CollisionRadius * Y / 2).X;
    ay = c.worldToScreen(dac.location + dac.CollisionHeight * Z * 3).Y;
	

	C.FontScaleX = 0.65;
	C.FontScaleY = 0.65;

	c.Font = font'DA2FontsDialog.DIN8';

        c.setPos(ax, ay);
        drawBuddyInfoBox(c, dac);

	C.FontScaleX = 1.00;
	C.FontScaleY = 1.00;

	if (da_players_PRI(dac.PlayerReplicationInfo) != none)
	{
		//log("PlayerRank for Player" @daPRI.playerName@ "is" @daPRI.PlayerRank);

		if (da_players_PRI(dac.PlayerReplicationInfo).PlayerRank > 0)
		{
			Switch (da_players_PRI(dac.PlayerReplicationInfo).PlayerRank)
			{
				Case 9: RankNr = "3"; TempMaterial = Texture'DA2GUI.misc.Star'; Break;
				Case 8: RankNr = "2"; TempMaterial = Texture'DA2GUI.misc.Star'; Break;
				Case 7: RankNr = "1"; TempMaterial = Texture'DA2GUI.misc.Star'; Break;
				Case 6: RankNr = "3"; TempMaterial = Texture'DA2GUI.misc.Captain'; Break;
				Case 5: RankNr = "2"; TempMaterial = Texture'DA2GUI.misc.Captain'; Break;
				Case 4: RankNr = "1"; TempMaterial = Texture'DA2GUI.misc.Captain'; Break;
				Case 3: RankNr = "3"; TempMaterial = Texture'DA2GUI.misc.Private'; Break;
				Case 2: RankNr = "2"; TempMaterial = Texture'DA2GUI.misc.Private'; Break;
				Case 1: RankNr = "1"; TempMaterial = Texture'DA2GUI.misc.Private'; Break;
			}
	
			fillInInfoLocation(c, dac, xpos, ypos);

			c.setPos(xpos-20, ypos-96);
			C.SetDrawColor(255, 255, 255);
			TempSize = 36.f * 1.0;
			C.DrawTile(TempMaterial, TempSize, TempSize, 0, 0, TempMaterial.MaterialUSize(), TempMaterial.MaterialVSize());
			
			c.Font = font'DA2FontsDialog.DIN11';
			c.setPos(xpos+13, ypos-96);
			c.DrawText(RankNr);
		}
	}
     	}
} 
}

simulated function DrawSpectatingHud (Canvas C)
{
    local da_players_classPlayer dac;
    local vector X, Y, Z;
    local float ax, ay, xpos, ypos;
    local Material TempMaterial;
    local float TempSize;
	local string RankNr;

if (PawnOwner != None)
{
    dac = da_players_classPlayer(PawnOwner);

    getAxes(playerOwner.getViewRotation(), X, Y, Z);

    ax = c.WorldToScreen(dac.location - dac.CollisionRadius * Y / 2).X;
    ay = c.worldToScreen(dac.location + dac.CollisionHeight * Z * 3).Y;

	C.FontScaleX = 0.65;
	C.FontScaleY = 0.65;

	c.Font = font'DA2FontsDialog.DIN8';

    c.setPos(ax, ay);
    drawBuddyInfoBox(c, dac);

	C.FontScaleX = 1.00;
	C.FontScaleY = 1.00;

	if (da_players_PRI(dac.PlayerReplicationInfo) != none)
	{
		if (da_players_PRI(dac.PlayerReplicationInfo).PlayerRank > 0)
		{
			Switch (da_players_PRI(dac.PlayerReplicationInfo).PlayerRank)
			{
				Case 9: RankNr = "3"; TempMaterial = Texture'DA2GUI.misc.Star'; Break;
				Case 8: RankNr = "2"; TempMaterial = Texture'DA2GUI.misc.Star'; Break;
				Case 7: RankNr = "1"; TempMaterial = Texture'DA2GUI.misc.Star'; Break;
				Case 6: RankNr = "3"; TempMaterial = Texture'DA2GUI.misc.Captain'; Break;
				Case 5: RankNr = "2"; TempMaterial = Texture'DA2GUI.misc.Captain'; Break;
				Case 4: RankNr = "1"; TempMaterial = Texture'DA2GUI.misc.Captain'; Break;
				Case 3: RankNr = "3"; TempMaterial = Texture'DA2GUI.misc.Private'; Break;
				Case 2: RankNr = "2"; TempMaterial = Texture'DA2GUI.misc.Private'; Break;
				Case 1: RankNr = "1"; TempMaterial = Texture'DA2GUI.misc.Private'; Break;
			}
	
			fillInInfoLocation(c, dac, xpos, ypos);

			c.setPos(xpos-20, ypos-96);
			C.SetDrawColor(255, 255, 255);
			TempSize = 36.f * 1.0;
			C.DrawTile(TempMaterial, TempSize, TempSize, 0, 0, TempMaterial.MaterialUSize(), TempMaterial.MaterialVSize());
			
			c.Font = font'DA2FontsDialog.DIN11';
			c.setPos(xpos+13, ypos-96);
			c.DrawText(RankNr);
		}
	}
     	}
super.DrawSpectatingHud(c);
} 
	


function drawBuddyInfoBox(Canvas c, da_players_classPlayer dac) {
  local array<Color> colors;

    colors[0]=c.MakeColor(255, 255, 255);
    colors[1] = c.MakeColor(fclamp((100 - dac.health) / 33.0 * 255.0, 0, 255), 255 - fclamp((33 - dac.health) / 33.0 * 255.0, 0, 255), 0);
    colors[2]=c.MakeColor(128, 128, 128);

if (dac.health > 0)
  drawInfo(c, dac, colors, dac.getInfo(), 1.0);
}



function drawPlayerInfoBox(Canvas c, da_players_ClassPlayer p) {
}


simulated function DrawChampionHealthBar(Canvas c, float maxDistance)
{
	local KFMonster zombie;
	local float x, y, distance;
	local vector ScreenPos, CamLoc;
	local rotator CamRot;
	local float sizeMod;
	
	if (PawnOwner != none)
	{
		c.GetCameraLocation(CamLoc, CamRot);
		foreach VisibleCollidingActors(class'KFMonster', zombie, maxDistance, PawnOwner.Location)
		{
			if (IsTargetInFrontOfPlayer(c, zombie, ScreenPos, CamLoc, CamRot) && zombie.AmbientGlow == 255 && !zombie.Cloaked())
			{
				distance = VSize(PlayerOwner.Location - zombie.Location);
				fillInInfoLocation(c, zombie, x, y);

				sizeMod = (maxDistance - distance) / maxDistance;
				if (sizeMod < 0.25) sizeMod = 0.25;

				//Log("See KFMonster?!"@x@y);
				y = y-20*sizeMod;
				DrawHealthBar(c, zombie, x, y, 200*sizeMod, 15*sizeMod);
				
				if (sizeMod < 0.50)
					c.Font = super.GetMyTinyFont(c);
				else if (sizeMod < 0.75)
					c.Font = super.GetMySmallFont(c);
				else c.Font = super.GetMyMediumFont(c);

				c.DrawColor = class'Canvas'.static.MakeColor(255,255,255);
				c.DrawTextJustified("Champion", 1, x-50, y-30, x+50, y);
			}
		}
	}
}

simulated function DrawHealthBar(Canvas c, Pawn owner, float centerX, float centerY, int width, int height)
{
	local float healthPercentage, healthWidth;
	local int xPos, yPos, currentHealth, maxHealth;

	currentHealth = owner.Health;
	maxHealth = owner.HealthMax;

	if (currentHealth > 0)
	{
		if (currentHealth > maxHealth) currentHealth = maxHealth;

		healthPercentage = float(currentHealth) / float(maxHealth);
		xPos = centerX-float(width/2);
		yPos = centerY-float(height/2);

		healthWidth = width*healthPercentage;

		//c.DrawTileStretched(texture'DA2GUI.Button3', width+2, height+2);
		
		c.SetPos(xPos-1, yPos-1);
		c.DrawColor = class'Canvas'.static.MakeColor(60, 0, 0, 255);
		c.DrawTileStretched(texture'DA2GUI.Generic.whiteBox', width, height);

		c.SetPos(xPos, yPos);
		c.DrawColor = class'Canvas'.static.MakeColor(255, 255, 255);
		c.DrawTileStretched(texture'DA2GUI.Dialog.raised_blurry_red', healthWidth,height);
	}
}

simulated function DrawBossHealth(Canvas c, int currentHealth, int maxHealth)
{
	local float healthPercentage;
	local int xPos, width, bossHealthWidth, healthTextPos, healTimer;

	if (currentHealth > maxHealth)
		currentHealth = maxHealth;

	bossHealthWidth = c.ClipX*0.60;
	healthPercentage = float(currentHealth) / float(maxHealth);

	xPos = (c.ClipX-bossHealthWidth)/2;

	width = bossHealthWidth*healthPercentage;
	
	c.Font = super.GetMyTinyFont(c);

	if (bossPreviousHealth > 0 && bossPreviousHealth < currentHealth || Interval("BossHealthTimer", bossHealDisplayTime) > 0)
	{
		healTimer = Interval("BossHealthTimer");

		if (healTimer > 255)
		{
			c.DrawColor = class'Canvas'.static.MakeColor(50, 255, 50);
			c.Font = super.GetMyMediumFont(c);
		}
		else c.DrawColor = class'Canvas'.static.MakeColor(0, healTimer-100, 0);

		c.DrawTextJustified("BOSS HEALED", 1, xPos, bossHealthPositionY+20, xPos+bossHealthWidth, bossHealthPositionY+50);
	}
	else
	{
		//c.DrawColor = class'Canvas'.static.MakeColor(255, 255, 255);
		c.DrawColor = class'Canvas'.static.MakeColor(0, 0, 0);
	}
	bossPreviousHealth = currentHealth;

	c.SetPos(xPos-1, bossHealthPositionY-1);

	c.DrawTileStretched(texture'DA2GUI.Button3', bossHealthWidth+2, 22);
	c.SetPos(xPos, bossHealthPositionY);

	c.DrawColor = class'Canvas'.static.MakeColor(60, 0, 0, 255);
	c.DrawTileStretched(texture'DA2GUI.Generic.whiteBox', bossHealthWidth, 20);

	c.DrawColor = class'Canvas'.static.MakeColor(255, 255, 255);
	c.DrawTileStretched(texture'DA2GUI.Dialog.raised_blurry_red', width,20);

	c.Font = super.GetMyTinyFont(c);
	
	c.DrawTextJustified("BOSS", 0, xPos+10, bossHealthPositionY, bossHealthWidth-10, bossHealthPositionY+20);

	healthTextPos = xPos+width-10;
	if (width<100) healthTextPos = xPos+100;

	c.DrawTextJustified(currentHealth, 2, xPos, bossHealthPositionY, healthTextPos, bossHealthPositionY+20); // @int(float(currentHealth)/float(maxHealth)*100)$"%"
}

simulated function DrawDifficulty(Canvas c)
{
	local string gameDifficulty;
	local Color gameColor;
	switch (SurvivalGameReplicationInfo(PlayerOwner.GameReplicationInfo).difficulty)
	{
		case 0.0:
			gameDifficulty = "Girly Mode";
			gameColor = class'Canvas'.static.MakeColor(254, 93, 207);
			break;
		case 1.0:
			gameDifficulty = "Easy";
			gameColor = class'Canvas'.static.MakeColor(0, 255, 0);
			break;
		case 2.0:
			gameDifficulty = "Easy";
			gameColor = class'Canvas'.static.MakeColor(120, 255, 120);
			break;
		case 3.0:
		case 4.0:
			gameDifficulty = "Normal";
			gameColor = class'Canvas'.static.MakeColor(255, 255, 255);
			break;
		case 5.0:
		case 6.0:
			gameDifficulty = "Hard";
			gameColor = class'Canvas'.static.MakeColor(255, 160, 0);
			break;
		case 7.0:
			gameDifficulty = "SUICIDAL";
			gameColor = class'Canvas'.static.MakeColor(255, 0, 0);
			break;
		default:
			gameDifficulty = "Unknown :p";
			break;
	}
	c.DrawColor = gameColor;
	c.Font = super.GetMyTinyFont(c);
	c.DrawTextJustified("Difficulty:"@gameDifficulty@"("$int(SurvivalGameReplicationInfo(PlayerOwner.GameReplicationInfo).difficulty)$")", 0, 10, 50, 300, 70);
}

simulated function DrawWaveCount(Canvas c)
{
	if (SurvivalGameReplicationInfo(PlayerOwner.GameReplicationInfo).waveCount > 200)
	{
		c.DrawColor = class'Canvas'.static.MakeColor(255, 0, 0);
	}
	else if (SurvivalGameReplicationInfo(PlayerOwner.GameReplicationInfo).waveCount > 100)
	{
		c.DrawColor = class'Canvas'.static.MakeColor(255, 128, 0);
	}
	else if (SurvivalGameReplicationInfo(PlayerOwner.GameReplicationInfo).waveCount > 50)
	{
		c.DrawColor = class'Canvas'.static.MakeColor(255, 192, 128);
	}
	else if (SurvivalGameReplicationInfo(PlayerOwner.GameReplicationInfo).waveCount > 20)
	{
		c.DrawColor = class'Canvas'.static.MakeColor(255, 255, 255);
	}
	else 
	c.DrawColor = class'Canvas'.static.MakeColor(120, 255, 120);
	
	c.Font = super.GetMyTinyFont(c);
	c.DrawTextJustified("Wave:"@SurvivalGameReplicationInfo(PlayerOwner.GameReplicationInfo).waveCount, 0, 300, 50, 600, 70);
}

simulated function DrawZombieKillCounter(Canvas c)
{
	c.DrawTextJustified("Zombies Killed:"@SurvivalGameReplicationInfo(PlayerOwner.GameReplicationInfo).zombiesKilled, 0, 10, 0, c.ClipX, 50);
}

simulated function DrawZombieDensity(Canvas c)
{
	if (SGRI != none)
	{
		c.DrawTextJustified("VS", 1, c.ClipX/2-20, 0, c.ClipX/2+20, 50);

		c.Font = super.GetMyTinyFont(c);
		c.DrawTextJustified("Players", 2, c.ClipX/2-150, 6, c.ClipX/2-30, 23);

		c.Font = super.GetMyMediumFont(c);
		c.DrawTextJustified(SGRI.numPlayers, 2, c.ClipX/2-150, 22, c.ClipX/2-30, 50);

		c.Font = super.GetMyTinyFont(c);
		c.DrawTextJustified("Zombies", 0,  c.ClipX/2+30, 6, c.ClipX/2+150, 23);

		c.Font = super.GetMyMediumFont(c);
		c.DrawTextJustified(SGRI.zombieCount@"("$SGRI.infestationPercentage$"%)", 0, c.ClipX/2+30, 22, c.ClipX/2+200, 50);
		
		//c.DrawTextJustified("Players:"@SGRI.numPlayers@"VS Zombies:"@SGRI.zombieCount@"("$SurvivalGameReplicationInfo(PlayerOwner.GameReplicationInfo).infestationPercentage$"%)", 1, 0, 0, c.ClipX, 50);
	}
}

simulated function DrawLifeCounter(Canvas c)
{
	local string livesText;
	local Color textColor;
	local int livesLeft, flashTimer;

	if (SGRI != none)
	{
		if (SGRI.sharedLives)
		{
			livesLeft = SGRI.livesLeft;
			livesText = "Lives:"@livesLeft@"(Team)";
		}
		else
		{
			livesLeft = SPRI.Score/SGRI.deathPenalty;
			livesText = "Lives:"@livesLeft;
		}

		if (livesLeft > 3*SGRI.deathPenalty)
			textColor = class'Canvas'.static.MakeColor(0,255,0);
		else textColor = class'Canvas'.static.MakeColor(255,0,0);

		if (livesLeft != previousLifeCount || Interval("LifeFlash", lifeGainFlashTime) > 0)
		{
			flashTimer = Interval("LifeFlash",,10);
			//if (flashTimer <= 0) Interval("LifeFlash", true);

			if (textColor.R != 255)
			textColor.R = 255 - flashTimer;

			if (textColor.G != 255)
			textColor.G = 255 - flashTimer;

			textColor.B = 255 - flashTimer;
		}

		c.DrawColor = textColor;
		c.DrawTextJustified(livesText, 1, 100+c.ClipX/2, 0, c.ClipX, 50);

		previousLifeCount = livesLeft;
	}
}

simulated function drawGameTime(Canvas c) 
{
    local Color col;

    if(PlayerOwner.GameReplicationInfo.RemainingTime<=180) col=RedColor;
    else col=greycolor;
    
	c.Font = super.GetMyMediumFont(c);
	c.DrawColor = col;
    c.DrawTextJustified(""@FormatTime(PlayerOwner.GameReplicationInfo.RemainingTime), 2, c.ClipX-100, 0, c.ClipX-10, 50);
}

simulated function drawRadar(Canvas c) 
{
    local actor A;
    local pawn p;
    local float Dist, RadarRadius, Angle, offset, DotSize, rCenterX, rCenterY;
    local rotator Dir;
    local vector Start;
    local float fade;
    local texture tex;
    local bool dnd;

    if(PRI==none || PRI.Team == none)
       return;

    RadarRadius=50*resScaleX;

    if(PawnOwner==None) Start=PlayerOwner.Location;
    else Start=PawnOwner.Location;

    rCenterX = C.ClipX-55*resScaleX;
    rCenterY = radarRadius+5*resScaleX;

    C.Style = ERenderStyle.STY_Alpha;
    c.SetPos(rCenterX - radarRadius, (rCenterY - (radarRadius) + 55 ));
    c.DrawTile(Texture'DA2Hud.HUD.HUDIR5', radarRadius * 2, radarRadius * 2, 270, 0, 242, 242);

    ForEach DynamicActors(class'Actor', A)
    {
        //if(A == PawnOwner)
        //    A=mos.currentObjective;

        Dist=VSize(Start*vect(1,1,0)-A.Location*vect(1,1,0));
        dnd=false;

        if(dist<3000) 
        {
			fade=1-((level.timeseconds+(1-dist/4000.0))%1.0)*0.9;
			if(Dist>=2500) fade/=2.5;

			DotSize=C.ClipX*HUDScale/75;
			tex=texture'DA2Hud.SoftDot';
			c.DrawColor=C.MakeColor(0,0,0);

			P = Pawn(a);

			if( P != none && P.Health > 0)
			{
				if(da_turrets_turret(A) != none) {
					if(!da_turrets_turret(A).bBuilt)
						fade/=3;
					tex=texture'DA2Hud.SoftBox';
				}

				if (P.GetTeamNum() == PRI.Team.TeamIndex) // PlayerOwner.PlayerReplicationInfo.Team.TeamIndex
				{
					if(da_players_classplayer(p)!=none && da_players_classplayer(p).resolveClassInfo().auraHealPerSec>0 && p!=PlayerOwner.Pawn)
						tex=texture'DA2Hud.SoftDotM';
					C.DrawColor.G = 255.0*fade;
				}
				else
				{
					if(P.bIsCrouched) fade*=0.1;
					C.DrawColor.R = 255.0*fade;

					if (P.IsA('ZombieBoss'))
					{
						C.DrawColor.B = 255.0*fade;
						DotSize*=1.25;
					}
				}
			}
			//else if( A==mos.currentObjective && !da_objective_base(A).bDisabled) {
			//	DotSize*=1.5;
			//	tex=texture'DA2Hud.SoftBox';
			//	C.DrawColor.R=255.0*fade;
			//	C.DrawColor.G=222.0*fade;
			//}
			else {
				if(A != none && da_items_worldammobox(A)!=none) {
					if(!da_items_worldammobox(a).bBuilt)
						fade/=3;
					tex=texture'DA2Hud.SoftBox';
					DotSize*=0.9;
					C.DrawColor.R=100.0*fade;
					C.DrawColor.G=180.0*fade;
					C.DrawColor.B=130.0*fade;
				}
				else {
					dnd=true;
				}
			}

			if(!dnd) {
				Dist=fmin(2500,dist);
				Dir=rotator(A.Location-Start);
				Offset=dist/2500.0*radarRadius*0.80; //Buffer from edge of radar
				Angle=((Dir.Yaw-PlayerOwner.Rotation.Yaw)&65535)*6.2832/65536;

				C.Style = ERenderStyle.STY_Translucent;
				C.SetPos(rCenterX+offset*sin(Angle)-0.5*DotSize,
				(rCenterY-offset*cos(Angle)-0.5*DotSize + 55));
				C.DrawTile(tex,DotSize,DotSize,0,0,64,64);
			}
      }
  }
}

// Disable irrelevant HUD items.
simulated function drawObjectiveInfo(Canvas c);
simulated function drawItemInfoBox(Canvas c);

function initDynamicHudElements() 
{
    //mos = da_hud_MissionObjectives(playElements.addHudElement(class'da_hud_MissionObjectives'));
    playElements.addHudElement(class'da_hud_PlayerEffects');
    hudText = da_hud_HudText(combiElements.addHudElement(class'da_hud_HudText'));
}

defaultproperties
{
     bossHealthPositionY=70
     bossHealDisplayTime=355
     lifeGainFlashTime=200
     HealthIcon=(WidgetTexture=Texture'KillingFloorHUD.HUD.Hud_Medical_Cross',RenderStyle=STY_Alpha,TextureCoords=(X2=64,Y2=64),TextureScale=0.160000,PosX=0.021000,PosY=0.947000,ScaleMode=SM_Right,Scale=1.000000,Tints[0]=(B=255,G=255,R=255,A=255),Tints[1]=(B=255,G=255,R=255,A=255))
     HealthIconSize=12.000000
}
