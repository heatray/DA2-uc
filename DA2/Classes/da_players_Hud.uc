// D:\mods\UT2004Script3339\XInterface\Classes\HudBase.uc
//-----------------------------------------------------------
// TODO: This class really needs to be cleaned up
//-----------------------------------------------------------
class da_players_Hud extends HudBase;

#EXEC OBJ LOAD FILE=../DA2/Textures/DA2HUD.utx

var DigitSet DigitsBig, DigitsMedium, DigitsSmall;

var float lastDraw;
var SpriteWidget radar, times;
var SpriteWidget crossHair, recoilIndicator, ami;
var int RecentHit;

var array<GameObjective>   Objectives;

var NumericWidget AmmoCount;
var NumericWidget AmmoLeft, grenades;
var NumericWidget health;

// var texture hudElements;
var da_game_ReplicationInfo GRI;
var da_players_PRI  PRI;
var float ammoLeftFlashing;
var float scoreFade, currentScore, scoreDiff;

/* Even original epic hud is pretty much overloaded so I'm going
 * to improve it, although this might slow down hud rendering */
var bool bHudElementInit;
var array<da_HudElementList> hudLists;
var da_HudElementList playElements;
var da_HudElementList spectatorElements;
var da_HudElementList combiElements;
var da_hud_MissionObjectives mos;
var da_hud_HudText hudText;

var color ShadowColor, NavyColor, CrimsonColor, GreyColor;
var string StartupMsg[5], NotReadyMsg;

var int ammoboxes, avers, crushers, dfas;

var     float                   DamageHUDTimer; //DrawDangerIndicator
var     class<DamageType>       HUDHitDamage;
var     bool                    DamageIsUber;
var     float                   DamageStartTime;
var     float                   VomitHudTimer;


// Voice meter
var     TexRotator              NeedleRotator; 			// The texture for the VU Meter needle
var     texture                 VoiceMeterBackground;   // Background texture for the voice meter
var()   float                   VoiceMeterX;    		// Voice meter X position
var()   float                   VoiceMeterY;    		// Voice meter Y position
var()   float                   VoiceMeterSize;         // Size of the voice meter icon
var     bool                    bUsingVOIP; // Player is using VOIP

struct TextWidget
{
	// Font must be set before calling DrawTextWidgetClipped()
	// String must left blank in default properties (for localization)
	var localized string text;
	var ERenderStyle RenderStyle;
	var EDrawPivot DrawPivot;
	var float PosX, PosY;
	var float WrapWidth, WrapHeight;
	var int OffsetX, OffsetY;
	var bool bDrawShadow;
	var color Tints[2];
};

// for drawing widgets on specific areas of the hud
struct AbsoluteCoordsInfo
{
	var float PosX, PosY;
	var float width, height;
};

struct RelativeCoordsInfo
{
	var float X, Y;   // 0-1 values
	var float XL, YL; // 0-1 values
};

// for hints
var						bool				bDrawHint;
var         			bool                bFirstHintRender; 		// Used to only calculate hint sizing constants once
var(da_players_Hud)  	float               HintFadeTime; 			// How long it takes to fade in/out
var         			float               HintRemainingTime;
var(da_players_Hud)  	float               HintLifetime;
var(da_players_Hud)  	float               HintDesiredAspectRatio; // Aspect ratio used to wrap hint data
var         			string              HintTitle, HintText; 	// This is localized in KFHintManager
var         			array<string>       HintWrappedText;
var(da_players_Hud)  	SpriteWidget        HintBackground;
var(da_players_Hud)  	TextWidget          HintTitleWidget;
var(da_players_Hud)  	TextWidget          HintTextWidget;
var(da_players_Hud)  	RelativeCoordsInfo  HintCoords; 			// default properties of this are used when rendering, XL and YL are used to pivot around the X and Y pos
var						bool				bIsSecondDowntime;
var						float				Hint_45_Time;
var						bool				bHint_45_TimeSet;
var						bool				bShowedSpawnHints;

var		float					hudLastRenderTime;

simulated event PostBeginPlay() {
    local GameObjective go;
    super.postBeginPlay();

    HudScale=1;
    
   	Hint_45_Time = 9999999;

    foreach allactors(class'GameObjective', go)
        Objectives[Objectives.length] = go;
}

simulated function LinkActors() {
    super.linkActors();
    if (playerOwner != none && !bHudElementInit) {
        initHudElementLists();
        initDynamicHudElements();
        bHudElementInit = true;

    }
}

function da_HudElementList registerList(optional class<da_HudElementList> listClass) {
    local da_HudElementList list;
    if (listClass == none)
        listClass = class'da_HudElementList';
    list = spawn(listClass, owner);
    if (list != none) {
        list.init(self);
        hudLists[hudLists.length] = list;
    } else
        log("Couldn't create instance of"$listClass);
    return list;
}

function initHudElementLists() {
    playElements = registerList();
    playElements.bgamePlayHud = true;
    spectatorElements = registerList();
    spectatorElements.bSpectatorHud = false;
    combiElements = registerList();
    combiElements.bgamePlayHud = true;
    combiElements.bSpectatorHud = false;
}

function initDynamicHudElements() {
    mos = da_hud_MissionObjectives(playElements.addHudElement(class'da_hud_MissionObjectives'));
    playElements.addHudElement(class'da_hud_PlayerEffects');
    hudText = da_hud_HudText(combiElements.addHudElement(class'da_hud_HudText'));
}


//PASSES////////////////////////////////////////////////////////////////////////
simulated function DrawHudPassA (Canvas C)
{
	if(playerOwner.IsDead() || PRI.bIsSpectator)
    return;

 	DisplayLocalMessages(C);
    C.Reset();
    C.Style = ERenderStyle.STY_Alpha;
    drawCrossHair(c);
    drawAMI(c);
    drawScoreChange(c);
    drawAmmo(C);
    checkDrawInfoBox(c);
    checkDrawHealthInfo(c);
    drawGameTime(c);
    drawObjectiveInfo(c);
    drawHealth(c);
	DrawDamageIndicators(c);
	drawHudRank(c, c.clipx*0.004, c.clipy*0.73, 90, 90);
	drawAmmoBoxInfo(c);
	drawItemInfoBox(c);
	drawTurretRepairInfo(c);
   	
	if ( Level.TimeSeconds - LastVoiceGainTime < 0.333 )
	{
		if ( !bUsingVOIP && PlayerOwner != None && PlayerOwner.ActiveRoom != None &&
			 PlayerOwner.ActiveRoom.GetTitle() == "Team" )
		{
			bUsingVOIP = true;
			PlayerOwner.NotifySpeakingInTeamChannel();
		}

		//DisplayVoiceGain(C);
	}
	else
	{
		bUsingVOIP = false;
	}

	if( Level.TimeSeconds - LastVoiceGainTime < 0.333 )
		DisplayVoiceGain(C);

    lastDraw=level.timeseconds;
}

//-----------------------------------------------------------------------------
// DisplayVoiceGain - Draw the voice meter and needle
//-----------------------------------------------------------------------------
function DisplayVoiceGain(Canvas C)
{
	local float VoiceGain;
	local float PosY, PosX, XL, YL;
	local string ActiveName;
	local float IconSize, scale, YOffset;
	local color SavedColor;

	scale = C.SizeY / 1200.0 * HudScale;

	SavedColor = C.DrawColor;
	C.DrawColor = WhiteColor;
	C.Style = ERenderStyle.STY_Alpha;

	VoiceGain = (1 - 3 * Min( Level.TimeSeconds - LastVoiceGainTime, 0.3333 )) * LastVoiceGain;

	YOffset = 12 * scale;
	IconSize = VoiceMeterSize * Scale;

	PosY = VoiceMeterY * C.ClipY - IconSize - YOffset;
	PosX = VoiceMeterX * C.ClipX;
	C.SetPos( PosX, PosY );

	C.DrawTile( VoiceMeterBackground, IconSize, IconSize, 0, 0, VoiceMeterBackground.USize, VoiceMeterBackground.VSize );

	NeedleRotator.Rotation.Yaw = -1 * ((20000 * VoiceGain) + 55000);

	C.SetPos( PosX, PosY );
	C.DrawTileScaled(NeedleRotator, scale * VoiceMeterSize / 128.0, scale * VoiceMeterSize / 128.0);

	// Display name of currently active channel
	if ( PlayerOwner != None && PlayerOwner.ActiveRoom != None )
		ActiveName = PlayerOwner.ActiveRoom.GetTitle();

	// Remove for release
	if(ActiveName == "")
		ActiveName = "No Channel Selected!";

	if ( ActiveName != "" )
	{
	    C.SetPos(0, 0);
		ActiveName = "(" @ ActiveName @ ")";
		C.Font = GetFontSizeIndex(C,-2);
		C.StrLen(ActiveName,XL,YL);

		if ( XL > 0.125 * C.ClipY )
		{
			C.Font = GetFontSizeIndex(C,-4);
			C.StrLen(ActiveName,XL,YL);
		}

		C.SetPos( PosX + ((IconSize/2) - (XL/2)), PosY - YL);
		C.DrawColor = C.MakeColor(160,160,160);
		if ( PlayerOwner != None && PlayerOwner.PlayerReplicationInfo != None )
		{
			if ( PlayerOwner.PlayerReplicationInfo.Team != None )
			{
				if ( PlayerOwner.PlayerReplicationInfo.Team.TeamIndex == 0 )
					C.DrawColor = RedColor;
				else
					C.DrawColor = TurqColor;
			}
		}

		C.DrawText( ActiveName );
	}

	C.DrawColor = SavedColor;
}

simulated function drawHudPassd(Canvas C) {
    if(playerOwner.IsDead() || PRI.bIsSpectator)
    return;

    super.DrawHudPassD(c);
    drawRadar(c);
    
	if ( !bShowedSpawnHints )
	{
		da_players_PlayerController(PlayerOwner).ShowSpawnHint();
		bShowedSpawnHints = true;
	}
}

simulated function drawHealth(Canvas c) {
    DrawNumericWidget(c, health, digitsBig);
}

simulated function DrawSpectatingHud (Canvas C)
{
    local byte s;
    local string msg;
	local int i, PlayerCount;
	local int CountDown;

    C.reset();

   	DisplayLocalMessages(C);

  	C.Font = GetMyMediumFont(C);
	//c.font = Font(DynamicLoadObject("DA2FontsDialog.DIN13", class'Font'));

	// Draw hints
	if ( bDrawHint )
	{
		DrawHint(C);
	}
	
	if(playerOwner.IsDead() && da_players_PlayerController(PlayerOwner).pendingClass>-1)
    {
		CountDown = (PRI.nextRespawnTime - da_game_ReplicationInfo(PlayerOwner.GameReplicationInfo).timeSeconds());
		
		
        if(CountDown > 0)
		{
			drawShadowedText(c, c.SizeX / 2.0, 350 * resScaleY, whitecolor, "Entering battlefield..."@max(CountDown, 0), true);
			
			//if (CountDown == 6)
			//DA_players_playercontroller(playerowner).AMIAnnouncement(Sound'AMISounds.player.PrepareForInsertion');
		}
		else 
		{ 
			drawShadowedText(c, c.SizeX / 2.0, 350 * resScaleY, whitecolor, "Click to enter the battlefield", true); 
			
			if (CountDown == 0) 
			DA_players_playercontroller(playerowner).AMIAnnouncement(Sound'AMISounds.player.Deploying');
		}
    }
    else
    {
        if( Role == ROLE_Authority )
        {
            if(level.game!=none)
                s=deathmatch(level.game).startupstage;

            if(s<5 && PlayerOwner.PlayerReplicationInfo!=none)
            {
                if(s==1 && !PlayerOwner.PlayerReplicationInfo.bReadyToPlay);// msg=NotReadyMsg;
                else msg=StartupMsg[s];
                drawShadowedText(c, c.SizeX*0.5, 350*resScaleY, whitecolor, msg, true);
            }
        }
        else
        {
            if(PlayerOwner.PlayerReplicationInfo!=none)
            {
                if(!PlayerOwner.PlayerReplicationInfo.bReadyToPlay)
                {
                    msg=NotReadyMsg;
                }
                else
                {
            		if (GRI == None)
            			msg = StartupMsg[0];
            		for (i = 0; i < GRI.PRIArray.Length; i++)
            		{
            			if ( GRI.PRIArray[i] != None && !GRI.PRIArray[i].bOnlySpectator
            			     && (!GRI.PRIArray[i].bIsSpectator || GRI.PRIArray[i].bWaitingPlayer) )
            				PlayerCount++;
            		}
            		if (GRI.MinNetPlayers - PlayerCount > 0)
            		{
            			msg=StartupMsg[0]@"("$(GRI.MinNetPlayers - PlayerCount)$")";
            		}
            		else
            		{
                        msg="Starting...";
            		}
                }
                drawShadowedText(c, c.SizeX*0.5, 350*resScaleY, whitecolor, msg, true);
            }
        }
        super.DrawSpectatingHud(c);
    }
}

simulated function UpdateHud() {
    local float max, value;
    local da_weapons_ammo daAmmo;
    local int i;

    GRI = da_game_ReplicationInfo(PlayerOwner.GameReplicationInfo);
    PRI = da_players_PRI(PlayerOwner.PlayerReplicationInfo);

    if (GRI != none && PRI != none)
        for (i = 0; i < hudLists.Length; i++)
            hudLists[i].updateHudData();

    // The lazy mans way ^^
    AmmoLeft.Tints[0] = default.AmmoLeft.Tints[0];
    AmmoLeft.Tints[1] = default.AmmoLeft.Tints[1];

    if (PawnOwner != none && PawnOwner.Weapon != none) {
        if (da_players_PlayerController(PlayerOwner).grenades != none)
            grenades.value = da_players_PlayerController(PlayerOwner).grenades.grenadeAmount;
        PawnOwner.Weapon.getAmmoCount(max, value);
        AmmoCount.Value = value;

        if (da_weapons_Reloadable(pawnowner.Weapon) != none) {
            daAmmo = da_weapons_Reloadable(pawnOwner.Weapon).getAmmoObject(0);
            if (daAmmo != none) {
                ammoLeft.Value = daAmmo.ammoLeft;
                if (daAmmo.ammoLeft < daAmmo.default.ammoLeft / 4.0) {
                    if (ammoLeftFlashing - level.timeSeconds > default.ammoLeftFlashing / 2.0) {
                        AmmoLeft.Tints[0] = class'Canvas'.static.makeColor(255, 0, 0);
                        AmmoLeft.Tints[1] = class'Canvas'.static.makeColor(255, 0, 0);
                    } else {
                        if (ammoLeftFlashing < level.TimeSeconds)
                            ammoLeftFlashing = level.TimeSeconds + default.ammoLeftFlashing;
                        AmmoLeft.Tints[0] = default.AmmoLeft.Tints[0];
                        AmmoLeft.Tints[1] = default.AmmoLeft.Tints[1];
                    }
                } else {
                    AmmoLeft.Tints[0] = default.AmmoLeft.Tints[0];
                    AmmoLeft.Tints[1] = default.AmmoLeft.Tints[1];
                }
            }
        } else
            ammoLeft.Value = 0;
  }
    health.value = PawnOwner.Health * 100 / pawnOwner.default.health;
  //sort();

  super.updateHud();
}

simulated event PostRender( canvas canvas ) {
    local int i;
//    local float scale;

    super.postRender(canvas);
    if (GRI == none || PRI == none)
        return;
    for (i = 0; i < hudLists.length; i++)
        hudLists[i].postRender(canvas);
        
    if ( bDrawHint && !bHideHud )
	{
	    DrawHint(Canvas);
	}
	
	hudLastRenderTime = Level.TimeSeconds;

// Add turret counter in HUD for mechanics

	if (da_players_ClassPlayer(PlayerOwner.Pawn) != none && PRI.playerClass == 1)
	{
		DrawBuildingLimits(canvas, da_players_ClassPlayer(PlayerOwner.Pawn), canvas.ClipX-90, canvas.ClipY*0.45, 80, 80);
	}

// This will draw danger corners when health is below 20

//	if (PawnOwner != none && (PawnOwner.Health > 20 || PawnOwner.Health <= 0))
//		return;

//	Canvas.Style = ERenderStyle.STY_Alpha;
//	Canvas.SetPos(0,0);
//	Canvas.SetDrawColor(127,127,127);
//	Canvas.DrawTile( shader'DA2HUD.NearDeathShader', Canvas.SizeX, Canvas.SizeY, 0, 0, 1024, 1024 );

}

simulated function registerUpdate(da_objective_base obj) 
{
	PlayerOwner.ReceiveLocalizedMessage(class'da2.da_WaitingMessage', 6);	

	mos.updateObjective(obj);
}

function showObjectives() {
    mos.showObjectives();
}

simulated function drawAMI(Canvas c) {
    DrawSpriteWidget(c, ami);
}


//ELEMENTS//////////////////////////////////////////////////////////////////////
simulated function DrawCrosshair(Canvas c) {
    local da_weapons_BasicGun w;
    local float recoil, size, dtime;

    dtime=level.timeseconds-lastdraw;

  if ( PawnOwner.bSpecialCrosshair )
  {
    PawnOwner.SpecialDrawCrosshair( C );
    return;
  }
  if (!bCrosshairShow)
    return;

    w = da_weapons_BasicGun(PawnOwner.Weapon);

    if(w!=none) {
        recoil=w.UpdateRecoil()/20;
        recoilIndicator.textureScale=0.05+Recoil;

        recoilIndicator.Tints[0].A=fclamp(320*(0.4-recoil),0,255);
        recoilIndicator.Tints[1].A=fclamp(320*(0.4-recoil),0,255);

        recoilIndicator.posx=0.5-recoil*0.7;
        recoilIndicator.WidgetTexture=Texture'DA2Crosshairs.Weapon.recoilLeft';
        DrawSpriteWidget(c, recoilIndicator);

        recoilIndicator.posx=0.5+recoil*0.7;
        recoilIndicator.WidgetTexture=Texture'DA2Crosshairs.Weapon.recoilRight';
        DrawSpriteWidget(c, recoilIndicator);

        if(w.drawCrosshair() && w.DACrosshair!=none)
        {
         crossHair.textureScale = 0.5;
           crossHair.WidgetTexture = w.DACrosshair;
           DrawSpriteWidget(c, crossHair);
        }
    }
	Recenthit = DA_players_playercontroller(playerowner).getrecenthit();

    if(RecentHit>0) {
        recenthit=min(recenthit,255);
        size=36*HudScale;
        C.Style = ERenderStyle.STY_Translucent;
        C.DrawColor=C.MakeColor(RecentHit,RecentHit/8,RecentHit/8);
        C.SetPos((C.ClipX-size)/2, (C.ClipY-size)/2);
        C.DrawTile(texture'DA2Hud.SoftDot',size,size,0,0,64,64);
        RecentHit-=RecentHit*6.0*dtime;
        RecentHit-=60*dtime;
	DA_players_playercontroller(playerowner).SetRecenthit(RecentHit);
    }
}

simulated function drawRadar(Canvas c) {
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
    c.SetPos(rCenterX - radarRadius, rCenterY - radarRadius);
    c.DrawTile(Texture'DA2Hud.HUD.HUDIR5', radarRadius * 2, radarRadius * 2, 270, 0, 242, 242);

    ForEach DynamicActors(class'Actor', A)
    {

        if(A == PawnOwner)
            A=mos.currentObjective;

        Dist=VSize(Start*vect(1,1,0)-A.Location*vect(1,1,0));
        dnd=false;

        if(dist<3000) {

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

            if (P.GetTeamNum() == PRI.Team.TeamIndex)
            {
                if(da_players_classplayer(p)!=none && da_players_classplayer(p).resolveClassInfo().auraHealPerSec>0)
                    tex=texture'DA2Hud.SoftDotM';
                C.DrawColor.G = 255.0*fade;
            }
            else
            {
                if(P.bIsCrouched) fade*=0.1;
                   C.DrawColor.R = 255.0*fade;
            }
        }
        else if( A==mos.currentObjective && !da_objective_base(A).bDisabled) {
            DotSize*=1.5;
            tex=texture'DA2Hud.SoftBox';
            C.DrawColor.R=255.0*fade;
            C.DrawColor.G=222.0*fade;
        }
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
            rCenterY-offset*cos(Angle)-0.5*DotSize);
            C.DrawTile(tex,DotSize,DotSize,0,0,64,64);
        }
      }
  }
}



simulated function drawObjectiveInfo(Canvas c) {
     local da_objective_base obj;
     local string output;
     local vector start;

     if (PRI.team == none)
        return;

     obj=mos.currentObjective;
     start=PawnOwner.Location+PawnOwner.BaseEyeHeight*vect(0,0,1);

     if (obj == none)
       return;

     //draw hovering info-text
     if(obj!=none &&
        normal(obj.Location-Start) dot vector(playerowner.GetViewRotation())>0.9 &&
        fasttrace(obj.location,start)) 
            drawObjectiveInfoBox(c, obj);
            
     if(obj.DefenderTeamIndex==PRI.team.teamIndex) {
        if(da_objective_usable(obj)!=none)
            output="Defend";
        else if(da_objective_touchable(obj)!=none)
            output="Hold";
        else if(da_objective_destroyable(obj)!=none)
            output="Protect ("$da_objective_destroyable(obj).Health$")";
        else output="Defend";
     }
     else {
        if(da_objective_usable(obj)!=none)
            output="Secure";
        else if(da_objective_touchable(obj)!=none)
            output="Advance";
        else if(da_objective_destroyable(obj)!=none)
            output="Destroy ("$da_objective_destroyable(obj).Health$")";
        else output="Attack";
     }

  // Objective text below the objetive arrow, on top of screen
  //c.font = Font(DynamicLoadObject("DA2FontsDialog.DIN10", class'Font'));
  C.Font = GetMyMediumFont(C);
  drawShadowedText(c, c.SizeX*0.5, c.SizeY*0.12, NavyColor, output, true);
}

function drawPlayerInfoBox(Canvas c, da_players_ClassPlayer p) {
    local float Amax, Avalue;
    local array<Color> colors;
    local array<string> strings;
    local int index;
    local da_players_ClassInfo ClassInfo;
    local da_players_PRI oPRI;
    local string className;

 If (PawnOwner != None)
{
        if (PRI.playerClass < 0)
	return;
            ClassInfo = GRI.teamConfig[PRI.Team.TeamIndex].classSet.playerClasses[PRI.playerClass];
        oPRI = da_players_PRI(p.PlayerReplicationInfo);

        //Get classname if the player has chosen one
        if (oPRI.playerClass >= 0) {
            className = GRI.teamConfig[oPRI.Team.TeamIndex].classSet.playerClasses[oPRI.playerClass].name;
        }

        if (p.Weapon != none)
             p.Weapon.GetammoCount(Amax, Avalue);

        //Allow all classes to see name and profession of other players of the
        //same team
        if (ClassInfo != none && p.PlayerReplicationInfo.Team.TeamIndex == PRI.Team.TeamIndex)
        {
            colors[index] = c.MakeColor(0, 255, 0);
            strings[index++] = oPRI.playerName@"["$className$"]";

           if (ClassInfo.auraHealPerSec > 0)
           {
             colors[index] = c.MakeColor(fclamp((100 - p.health) / 33.0 * 255.0, 0, 255), 255 - fclamp((33 - p.health) / 33.0 * 255.0, 0, 255), 0);
             strings[index++] = "Health :"$string(p.health);
           }

           //Allow mechanics to see ammo of that ally
           if (pawnowner.FindInventoryType(class'da_weapons_MechTool') != none) {
             aValue = oPRI.weaponInfo.ammo;
             aMax = oPri.weaponInfo.maxAmmo;
//             c.setDrawColor(255,215,56);
             colors[index] = c.MakeColor(0,255,0);
             strings[index++] = "Ammo :"$int(AValue)$"/"$int(AMax);
           }

        }
        else
        {
            colors[index] = c.MakeColor(255,0,0);
            strings[index++] = oPRI.playerName;
        }
        drawInfo(c, p, colors, strings);
}}

//Allow medics to see health of all allies
simulated function drawHealthInfo(Canvas c, da_players_ClassPlayer p) {
    local array<Color> colors;
    local array<string> strings;
    local int index;
//    local da_players_ClassInfo Classinfo;

	if (p == none || p.PlayerReplicationInfo == none || PRI == none || p.PlayerReplicationInfo.Team.TeamIndex != PRI.Team.TeamIndex || p.health <= 0)
	{
	    return;
	}
	
	colors[index] = c.MakeColor(fclamp((100 - p.health) / 33.0 * 255.0, 0, 255), 255 - fclamp((33 - p.health) / 33.0 * 255.0, 0, 255), 0);
	strings[index++] = "Health :"$string(p.health);

    drawInfo(c, p, colors, strings);

}

function DisplayMessages(Canvas C)
{
    local int i, j, XPos, YPos,MessageCount;
    local float XL, YL;


    for( i = 0; i < ConsoleMessageCount; i++ )
    {
        if ( TextMessages[i].Text == "" )
            break;
        else if( TextMessages[i].MessageLife < Level.TimeSeconds )
        {
            TextMessages[i].Text = "";

            if( i < ConsoleMessageCount - 1 )
            {
                for( j=i; j<ConsoleMessageCount-1; j++ )
                    TextMessages[j] = TextMessages[j+1];
            }
            TextMessages[j].Text = "";
            break;
        }
        else
      MessageCount++;
    }

    XPos = (ConsoleMessagePosX * HudCanvasScale * C.SizeX) + (((1.0 - HudCanvasScale) / 2.0) * C.SizeX);
    YPos = (ConsoleMessagePosY * HudCanvasScale * C.SizeY) + (((1.0 - HudCanvasScale) / 2.0) * C.SizeY);

    C.Reset();
    C.Font = GetMySmallFont(C);
//	C.Font = Font(DynamicLoadObject("DA2FontsDialog.DIN10", class'Font'));
	C.Style = ERenderStyle.STY_Alpha;
    C.DrawColor = ConsoleColor;
    C.TextSize ("A", XL, YL);

    YPos -= YL * MessageCount+1; // DP_LowerLeft
    YPos -= YL; // Room for typing prompt

    for( i=0; i<MessageCount; i++ )
    {
        if ( TextMessages[i].Text == "" )
            break;

        C.StrLen( TextMessages[i].Text, XL, YL );
        C.SetPos( XPos, YPos );
        C.DrawColor = TextMessages[i].TextColor;
        C.DrawText( TextMessages[i].Text, false );
        YPos += YL;
    }
}
simulated function drawScoreChange(Canvas c) {

   local float Fade, posX, posY;
   local string output;
   local color col;

   if (PRI == none || PRI.bIsSpectator)
      return;

  if(scoreFade>Level.TimeSeconds)
    {
		C.Font = GetMyMediumFont(C);      
	  //c.font = Font(DynamicLoadObject("DA2FontsDialog.DIN13", class'Font'));
        Fade = (scoreFade-Level.TimeSeconds)/2;


        if(scoreDiff>0) {
            col=WhiteColor;
            output="(+"$scoreDiff$")";
        }
        else {
            col=RedColor;
            output="("$scoreDiff$")";
        }

        if(Fade<=1) col.A=255*Fade;
        else col.A=255;

        posX=c.SizeX*0.5;
        posY=c.SizeY*0.75;

        DrawShadowedText(c, posX, posY, col, output, true);
    }

    if(currentScore!=PRI.Score && scoreFade<Level.TimeSeconds) {
        scoreFade = Level.TimeSeconds+2;
        scoreDiff = PRI.score - currentScore;
        currentScore = PRI.Score;
    }
}

simulated function drawGameTime(Canvas c) {

    local color col;

    if(PlayerOwner.GameReplicationInfo.RemainingTime<=180) col=RedColor;
    else col=greycolor;
    
	//c.font = Font(DynamicLoadObject("DA2FontsDialog.DIN13", class'Font'));
	C.Font = GetMyMediumFont(C);   
    DrawShadowedText(c, c.SizeX*0.02, c.SizeY*0.03, col, "Time Remaining:"@FormatTime(PlayerOwner.GameReplicationInfo.RemainingTime));
}

simulated function drawBuildStatus(Canvas c) {
    local da_players_teamconfig conf;
    local array<Color> colors;
    local array<string> strings;

    if(PRI.playerClass!=1)
      return;

    conf=GRI.teamConfig[PRI.Team.TeamIndex];

	colors[0]=greyColor;
	strings[0]="Ammobox:"@conf.numAmmoboxes;
	colors[1]=greyColor;
	strings[1]="AVeR:"@conf.numAVeRs;
	colors[2]=greyColor;
	strings[2]="Crusher:"@conf.numCrushers;
	colors[3]=greyColor;
	strings[3]="DFA:"@conf.numDFAs;

    //c.font = Font(DynamicLoadObject("DA2FontsDialog.DIN10", class'Font'));
    C.Font = GetMySmallFont(C);   
    DrawGenericInfo(c, c.SizeX*0.02, c.SizeY*0.06, colors, strings, true);
}

simulated function drawProfession(Canvas c) {
  // Class
    // DrawSpriteWidget(c, prof[Clamp(PRI.playerClass, 0, 6)]);
    local array<string> classes;

  //c.font = Font(DynamicLoadObject("DA2FontsDialog.DIN13", class'Font'));
  C.Font = GetMyMediumFont(C);  
  c.Style = ERenderStyle.STY_Alpha;
  c.SetDrawColor(255,255,255);

  // Hard-coded class names
  classes[0] = "RIFLEMAN";
  classes[1] = "MECHANIC";
  classes[2] = "MEDIC";
  classes[3] = "GUNNER";
  classes[4] = "SNIPER";
  classes[5] = "ROCKETEER";
  classes[6] = "ENGINEER";

  if (PRI.playerClass >= 0 && PRI.playerClass < classes.length)
    drawText(c, c.SizeX*0.01, c.SizeY*0.01, classes[PRI.playerClass]);
}

simulated function drawAmmo(Canvas c) {
    DrawNumericWidget(c, ammoCount, digitsBig);
    if (ammoLeft.value >= 0)
        DrawNumericWidget(c, ammoLeft, digitsBig);
    DrawNumericWidget(c, grenades, digitsBig);
    DrawSpriteWidget(c, times);
}

//MINOR ELEMENTS/FUNCTIONS///////////////////////////////////////////////////////////////
//Written by Zeh borrowed by new HUD that did not make it
simulated function String FormatTime( int Seconds ) {
  local int Minutes, Hours;
  local String Time;

  if( Seconds > 3600 ) {
    Hours = Seconds / 3600;
    Seconds -= Hours * 3600;

    Time = Hours$":";
  }
  Minutes = Seconds / 60;
  Seconds -= Minutes * 60;

  if( Minutes >= 10 )
    Time = Time $ Minutes $ ":";
  else
    Time = Time $ "0" $ Minutes $ ":";

  if( Seconds >= 10 )
    Time = Time $ Seconds;
  else
    Time = Time $ "0" $ Seconds;

  return Time;
}

simulated function DrawTypingPrompt (Canvas C, String Text, optional int Pos) {
  local float XPos, YPos;
  local float XL, YL;

  //c.font = Font(DynamicLoadObject("DA2FontsDialog.DIN10", class'Font'));
  C.Font = GetMySmallFont(C);  
  C.Style = ERenderStyle.STY_Alpha;
  C.DrawColor = ConsoleColor;

  C.TextSize ("A", XL, YL);

  XPos = (ConsoleMessagePosX * HudCanvasScale * C.SizeX) + (((1.0 - HudCanvasScale) * 0.5) * C.SizeX);
  YPos = (ConsoleMessagePosY * HudCanvasScale * C.SizeY) + (((1.0 - HudCanvasScale) * 0.5) * C.SizeY) - YL;

  C.SetPos (XPos, YPos);
  //C.DrawTextClipped ("(>"@Left(Text, Pos)$"_"$Right(Text, Len(Text) - Pos), false);
  C.DrawTextClipped("(>"@Left(Text, Pos)$chr(4)$Eval(Pos < Len(Text), Mid(Text, Pos), "_"), true);
}

simulated function checkDrawInfoBox(Canvas c) {
    local Actor a;
    local vector hitL, hitNorm, traceStart;

 If (PawnOwner != None)
{
  traceStart = PawnOwner.Location + PawnOwner.BaseEyeHeight * vect(0,0,1) + PawnOwner.CollisionRadius * vector(playerOwner.getViewRotation());
  a = trace(hitL, hitNorm, traceStart + vector(playerOwner.getViewRotation()) * 2500, traceStart, true);
  if (pawn(a) != none && pawn(a).playerReplicationInfo != none && !a.IsA('Vehicle'))
       drawPlayerInfoBox(c, da_players_ClassPlayer(a));

  else if (da_buildable_Useable(a) != none)
  {
     drawBuildableInfoBox(c, da_buildable_Useable(a));
	 
	if ( PawnOwner.FindInventoryType(class'da_weapons_MechTool') != none && VSizeSquared(a.Location - PawnOwner.Location) < 200000 )
	{	   
			DrawMechStructureHints(da_buildable_Useable(a));
	}
	 
  } 
  else if (da_turrets_Turret(a) != none)
  {
    drawTurretInfoBox(c, da_turrets_Turret(a));

   	if ( PawnOwner.FindInventoryType(class'da_weapons_MechTool') != none && VSizeSquared(a.Location - PawnOwner.Location) < 200000 )
	{	   
			DrawMechHints(da_turrets_Turret(a));
	}
	else if ( PRI.playerClass == 3 && VSizeSquared(a.Location - PawnOwner.Location) < 200000 )
	{	   
			DrawGunnerHints(da_turrets_Turret(a));
	}
  }	
}
}

simulated function checkDrawHealthInfo(Canvas C) {
  local da_players_classPlayer dac;
        local float  iconScale;
     local vector    ScreenPos, CamLoc;
  local rotator    CamRot;

    if(PRI.playerClass != 2)
  return;

    iconScale = 0.75;
    c.GetCameraLocation( CamLoc, CamRot);
  foreach VisibleCollidingActors(class'da_players_classPlayer', dac, 4000, PawnOwner.Location,false)
  {
    if (dac != none && dac != pawnOwner && IsTargetInFrontOfPlayer( c, dac, ScreenPos, CamLoc, CamRot )) {
      drawHealthInfo(c, dac);
    }
  }
}

//Similar to players with minor changes, draws ammoboxes, objectives and turrets
simulated function drawItemInfoBox(Canvas c) {
    local GameObjective O;
    local vector X, Y, Z;
    local float ax, ay, bx, by, xpos, ypos;
    local vector    ScreenPos, CamLoc;
    local rotator    CamRot;
	local Material TempMaterial;
    local float TempSize;
	local string    DistanceText;

	O=mos.currentObjective;

    c.GetCameraLocation( CamLoc, CamRot);

     if (O != none && IsTargetInFrontOfPlayer( c, O, ScreenPos, CamLoc, CamRot )) {
           getAxes(playerOwner.getViewRotation(), X, Y, Z);

          ax = c.WorldToScreen(O.location - O.CollisionRadius * Y / 2).X;
          bx = c.WorldToScreen(O.location + O.CollisionRadius * Y / 2).X;
          ay = c.worldToScreen(O.location + O.CollisionHeight * Z * 3).Y;
          by = c.worldToScreen(O.location - O.CollisionHeight * Z * 3).Y;
		  
		  	c.setPos(ax, ay);
			
			TempMaterial = Texture'DA2Objectives.Arrow';
			
			fillInInfoLocation(c, O, xpos, ypos);

			c.setPos(xpos-24, ypos-118);
			C.SetDrawColor(255, 255, 255);
			TempSize = 5.f * 8;
			C.DrawTile(TempMaterial, TempSize*4, TempSize, 0, 0, TempMaterial.MaterialUSize(), TempMaterial.MaterialVSize());
			
			DistanceText = ""@int(VSize(O.Location - PawnOwner.Location) / 50) $"m";
			
			c.Font = font'DA2FontsDialog.DIN13';
			c.setPos(xpos-14, ypos-136);
			c.DrawText(DistanceText);
     }
}

//This function was borrowed by HUD_Assault
//Epic wrote it.
static function bool IsTargetInFrontOfPlayer( Canvas C, Actor Target, out Vector ScreenPos,
                       Vector CamLoc, Rotator CamRot )
{
  if ( (Target.Location - CamLoc) dot vector(CamRot) < 0)
    return false;

  ScreenPos = C.WorldToScreen( Target.Location );
  if ( ScreenPos.X <= 0 || ScreenPos.X >= C.ClipX ) return false;
  if ( ScreenPos.Y <= 0 || ScreenPos.Y >= C.ClipY ) return false;

  return true;
}

simulated function DrawBox(canvas canvas, float width, float height)
{
  local float X, Y;
  X = canvas.CurX;
  Y = canvas.CurY;
  canvas.DrawRect(Texture'engine.WhiteSquareTexture', 1, height);
  canvas.DrawRect(Texture'engine.WhiteSquareTexture', width, 1);
  canvas.SetPos(X + width, Y);
  canvas.DrawRect(Texture'engine.WhiteSquareTexture', 1, height);
  canvas.SetPos(X, Y + height);
  canvas.DrawRect(Texture'engine.WhiteSquareTexture', width + 1, 1);
  canvas.SetPos(X, Y);
}

simulated function float getWidth(Canvas c, string txt) {
  local float w, h;
  c.textSize(txt, w, h);
  return w;
}

simulated function float getHeight(Canvas c, string txt) {
  local float w, h;
  c.textSize(txt, w, h);
  return h;
}

simulated function drawTextRightJustified(Canvas c, float x, float y, string txt) {
    c.setPos(x - getWidth(c, txt), y);
  c.drawTextClipped(txt);
}

simulated function drawText(Canvas c, float x, float y, string txt, optional bool bCenter) {
  if (bCenter)
    c.setPos(x - getWidth(c, txt) / 2.0, y);
  else
    c.setPos(x, y);
  c.drawText(txt);
}

function fillInInfoLocation(Canvas c, Actor a, out float _x, out float _y, optional float hackFactor) {
    local vector X, Y, Z;
  getAxes(playerOwner.getViewRotation(), X, Y, Z);

  if (hackFactor < 0.00001)
    hackFactor = 1.0;

    _x = c.WorldToScreen(a.location).X;
    _y = c.WorldToScreen(a.Location + a.CollisionHeight * vect(0, 0, 1.2) * hackFactor).Y;
}

function drawGenericInfo(Canvas c, float x, float y, array<Color> lineColors, array<string> lineTexts, optional bool bShadowed, optional bool bCentered) {
    local int i;
    for (i = lineTexts.length - 1; i >= 0; i--) {
        if (lineColors.length > i)
            c.drawColor = lineColors[i];
        y -= getHeight(c, lineTexts[i]);

        if(bShadowed) drawShadowedText(c, x, y, lineColors[i], lineTexts[i], bCentered);
        else drawText(c, x, y, lineTexts[i], bCentered);
    }
}

function drawShadowedText(Canvas c, float x, float y, color textcolor, string output, optional bool bCentered) {
    c.DrawColor=ShadowColor;
    c.DrawColor.A=textcolor.A*0.75;
    drawText(c, x+1, y+1, output, bCentered);
    c.DrawColor=textcolor;
    drawText(c, x, y, output, bCentered);
}

function drawInfo(Canvas c, Actor a, array<Color> lineColors, array<string> lineTexts, optional float hackFactor) {
  local float x, y;

  fillInInfoLocation(c, a, x, y, hackFactor);

  // Overlay description (when aiming at a player, at a turret, at an ammobox)
  //c.font = Font(DynamicLoadObject("DA2FontsDialog.DIN10", class'Font'));
  C.Font = GetMySmallFont(C); 
//  c.font = class'HudBase'.static.loadFontStatic(7);
  drawGenericInfo(c, x, y, lineColors, lineTexts, true, true);
}

simulated function drawAmmoBoxInfo(Canvas c) {
    local da_items_worldAmmoBox obj;
    local float xpos, ypos;
    local vector    ScreenPos, CamLoc;
    local rotator    CamRot;
	local da_weapons_BasicGun w;
	local Material TempMaterial;
    local float TempSize;
	local string    DistanceText,Pos,Vec;

	w = da_weapons_BasicGun(PawnOwner.Weapon);
	

	If (PawnOwner != none && w != none && w.hasLowAmmo())
	{
	   c.GetCameraLocation( CamLoc, CamRot);
	   foreach CollidingActors(class'da_items_worldAmmoBox', obj, 2800, PawnOwner.Location)
	   {
		 if (obj != none && obj.isBuilt() && IsTargetInFrontOfPlayer( c, obj, ScreenPos, CamLoc, CamRot )) 
			{	
			TempMaterial = TexOscillator'DA2HUD.HUD.ammo_osc';
			
			fillInInfoLocation(c, obj, xpos, ypos);

			c.setPos(xpos-24, ypos-118);
			C.SetDrawColor(255, 255, 255);
			TempSize = 10.f * 5;
			C.DrawTile(TempMaterial, TempSize, TempSize, 0, 0, TempMaterial.MaterialUSize(), TempMaterial.MaterialVSize());
			
			DistanceText = ""@int(VSize(obj.Location - PawnOwner.Location) / 50) $"m";
			
			c.Font = font'DA2FontsDialog.DIN8';
			c.setPos(xpos-12, ypos-125);
			c.DrawText(DistanceText);
	
			}
		else if (obj != none && obj.isBuilt() && ((obj.Location - CamLoc) dot vector(CamRot) > 0))
			{
				ScreenPos = C.WorldToScreen( obj.Location ); 
				
				if (ScreenPos.Y >= 0 && ScreenPos.Y <= C.ClipY)
				{
					fillInInfoLocation(c, obj, xpos, ypos);
					
					if (ypos >= C.ClipY*0.85)
						ypos = C.ClipY*0.85;
						
					else if (ypos <= C.ClipY*0.4)
						ypos = C.ClipY*0.4;
					
					if (ScreenPos.X <= 0) {
						xpos = C.ClipX*0.02;
						TempMaterial = TexOscillator'DA2HUD.HUD.ammo_osc_left'; 
						}
						
					else if (ScreenPos.X >= C.ClipX) {
						xpos = C.ClipX*0.96;
						TempMaterial = TexOscillator'DA2HUD.HUD.ammo_osc_right';
						}
					
					else TempMaterial = TexOscillator'DA2HUD.HUD.ammo_osc_tp';
			
					c.setPos(xpos,ypos-118);
					
					C.SetDrawColor(255, 255, 255);
					TempSize = 10.f * 5;
					C.DrawTile(TempMaterial, TempSize, TempSize, 0, 0, TempMaterial.MaterialUSize(), TempMaterial.MaterialVSize());
					
					DistanceText = ""@int(VSize(obj.Location - PawnOwner.Location) / 50) $"m";
					
					c.Font = font'DA2FontsDialog.DIN8';
					c.setPos(xpos+12, ypos-125);
					c.DrawText(DistanceText);
				}
			}
		}
	}
}

simulated function drawTurretRepairInfo(Canvas c) {
    local da_turrets_Turret obj;
    local float xpos, ypos;
    local vector    ScreenPos, CamLoc;
    local rotator    CamRot;
	local Material TempMaterial;
    local float TempSize;
	local string    DistanceText;
	
	if (da_players_PRI(PlayerOwner.PlayerReplicationInfo) != none)
	{
	PRI = da_players_PRI(PlayerOwner.PlayerReplicationInfo);

	if (PawnOwner != none && PRI != none && (PRI.PlayerClass == 1 || PRI.PlayerClass == 6))
	{
	   c.GetCameraLocation( CamLoc, CamRot);
	   foreach CollidingActors(class'da_turrets_Turret', obj, 2800, PawnOwner.Location)
	   {
		 if (obj != none && obj.isBuilt() && obj.Team == PRI.team.TeamIndex &&
		 IsTargetInFrontOfPlayer( c, obj, ScreenPos, CamLoc, CamRot ) && Obj.Health < Obj.default.health/3) 
		 {
			TempMaterial = TexOscillator'DA2HUD.HUD.repair_osc';
			
			fillInInfoLocation(c, obj, xpos, ypos);

			c.setPos(xpos-24, ypos-68);
			C.SetDrawColor(255, 255, 255);
			TempSize = 10.f * 5;
			C.DrawTile(TempMaterial, TempSize, TempSize, 0, 0, TempMaterial.MaterialUSize(), TempMaterial.MaterialVSize());
			
			DistanceText = ""@int(VSize(obj.Location - PawnOwner.Location) / 50) $"m";
			
			c.Font = font'DA2FontsDialog.DIN8';
			c.setPos(xpos-12, ypos-75);
			c.DrawText(DistanceText);
		 }
		}
	}
	}
}


function drawBuildableInfoBox(Canvas c, da_buildable_Useable obj) {
    local array<Color> colors;

  colors[0]=c.MakeColor(255,255,255);
  colors[1]=c.MakeColor(255,255,255);
  colors[2]=c.MakeColor(255,255,255);

  // Ammobox only, apparently

    //if (pawnowner.FindInventoryType(class'da_weapons_MechTool') != none)
	drawInfo(c, obj, colors, obj.getInfoForMech());
}

function drawTurretInfoBox(Canvas c, da_turrets_Turret obj) {
  local array<Color> colors;
	
  if (obj.team != PRI.team.teamIndex || PRI == none)
    return;

  // Turret.. duh

  colors[0]=c.MakeColor(255,255,255);
  colors[1]=c.MakeColor(255,255,255);
  colors[2]=c.MakeColor(255,255,255);

  drawInfo(c, obj, colors, obj.getInfoForMech(), 0.4);
}

function drawObjectiveInfoBox(Canvas c, da_objective_base obj) {
  local array<Color> colors;
   
    colors[0]=c.MakeColor(255, 200, 0);
    colors[1]=c.MakeColor(255, 200, 0);

  drawInfo(c, obj, colors, obj.getInfo(), 1.0);
}

//simulated function DisplayLocalMessages(Canvas C) {
//}

simulated function LocalizedMessage( class<LocalMessage> Message, optional int Switch, optional PlayerReplicationInfo RelatedPRI_1, optional PlayerReplicationInfo RelatedPRI_2, optional Object OptionalObject, optional String CriticalString) {

    if ( class<xDeathMessage>(message) != none && hudText != none)
    {
        hudText.addKillMessage(message, switch, RelatedPRI_1, RelatedPRI_2, OptionalObject, CriticalString);
    }
    else
	{ 
		super.LocalizedMessage(message, switch, RelatedPRI_1, RelatedPRI_2, OptionalObject, CriticalString);
	}
}

function Font GetMySmallFont(Canvas C)
{
	if ( C.ClipY < 601)
	{
		return Font(DynamicLoadObject("DA2FontsDialog.DIN10", class'Font'));
	}
	
	if ( C.ClipY < 801)
	{
		return Font(DynamicLoadObject("DA2FontsDialog.DIN13", class'Font'));
	}
	
	if ( C.ClipY < 1025)
	{
		return Font(DynamicLoadObject("DA2FontsDialog.DIN16", class'Font'));
	}
	
	return Font(DynamicLoadObject("DA2FontsDialog.DIN18", class'Font'));
}

static function Font GetMyMediumFont(Canvas C)
{
	if ( C.ClipY < 601)
	{
		return Font(DynamicLoadObject("DA2FontsDialog.DIN13", class'Font'));
	}
	
	if ( C.ClipY < 801)
	{
		return Font(DynamicLoadObject("DA2FontsDialog.DIN16", class'Font'));
	}
	
	if ( C.ClipY < 1025)
	{
		return Font(DynamicLoadObject("DA2FontsDialog.DIN18", class'Font'));
	}
	
	return Font(DynamicLoadObject("DA2FontsDialog.DIN20", class'Font'));
}

function Font GetMyTinyFont(Canvas C)
{
	if ( C.ClipY < 601)
	{
		return Font(DynamicLoadObject("DA2FontsDialog.DIN10", class'Font'));
	}
	
	if ( C.ClipY < 801)
	{
		return Font(DynamicLoadObject("DA2FontsDialog.DIN11", class'Font'));
	}
	
	if ( C.ClipY < 1025)
	{
		return Font(DynamicLoadObject("DA2FontsDialog.DIN13", class'Font'));
	}
	
	return Font(DynamicLoadObject("DA2FontsDialog.DIN16", class'Font'));
}

function Font GetMyLargeFont(Canvas C)
{
	if ( C.ClipY < 601)
	{
		return Font(DynamicLoadObject("DA2FontsDialog.DIN20", class'Font'));
	}
	
	if ( C.ClipY < 801)
	{
		return Font(DynamicLoadObject("DA2FontsDialog.DIN22", class'Font'));
	}
	
	if ( C.ClipY < 1025)
	{
		return Font(DynamicLoadObject("DA2FontsDialog.DIN25", class'Font'));
	}
	
	return Font(DynamicLoadObject("DA2FontsDialog.DIN25", class'Font'));
}

simulated function ShowHint(string title, string text)
{
	bFirstHintRender = true;
	HintWrappedText.Length = 0;
	HintRemainingTime = HintLifetime + HintFadeTime * 2;
	HintTitle = title;

	// Parse keybinds
	if (PlayerOwner != none)
		HintText = class'DefenceAlliance'.static.ParseLoadingHintNoColor(text, PlayerOwner);
	else
		HintText = text;
	bDrawHint = true;
}

// This function draws a hint on the hud. The hint to be drawn
// is set by calling ShowHint().
function DrawHint(Canvas Canvas)
{
	local float alpha; // 0 - 1
	local float XL, YL;
	local AbsoluteCoordsInfo coords;
	local color DrawColor;
	local float backgroundOffset;
	local int i;

	// Calculate wrapping width & draw coords if needed
	if ( bFirstHintRender )
	{
		CalculateHintWrappingData(Canvas);
		bFirstHintRender = false;
	}

	// Calculate alpha value
	if ( HintRemainingTime > HintLifetime + HintFadeTime ) // Fade in
	{
		alpha = 1 - (HintRemainingTime - HintLifetime - HintFadeTime) / HintFadeTime;
	}
	else if ( HintRemainingTime < HintFadeTime ) // Fade out
	{
		alpha = HintRemainingTime / HintFadeTime;
	}
	else
	{
		alpha = 1.0;
	}

	// Decrement remaining time if needed
	if ( PlayerOwner.Player != none && GUIController(PlayerOwner.Player.GUIController) != none &&
		 GUIController(PlayerOwner.Player.GUIController).ActivePage != none ) 
	{
		// don't decrement if menu is open
	}
	else
	{
		HintRemainingTime -= Level.TimeSeconds - hudLastRenderTime;
	}

	// Calculate rendering color
	DrawColor = HintBackground.Tints[TeamIndex];
	DrawColor.A = float(DrawColor.A) * alpha;

	// Don't draw if alpha is 0 (0 == 255 for some reason)
	if ( DrawColor.A != 0 )
	{
		// Set proper rendering style
		Canvas.Style = ERenderStyle.STY_Alpha;

		// Calculate background offset in relation to text
		backgroundOffset = HintBackground.PosY * Canvas.ClipY;

		// Calculate absolute drawing coordinates (mostly for text widget)
		coords.PosX = HintCoords.X * Canvas.ClipX;
		coords.PosY = HintCoords.Y * Canvas.ClipY;
		coords.width = HintCoords.XL * Canvas.ClipX;
		coords.height = HintCoords.YL * Canvas.ClipY;

		// Draw the background
		Canvas.DrawColor = DrawColor;
		Canvas.SetPos(coords.PosX - backgroundOffset * 2, coords.PosY - backgroundOffset);
		Canvas.DrawTileScaled(HintBackground.WidgetTexture, (coords.width + backgroundOffset * 4) / HintBackground.WidgetTexture.MaterialUSize(), (coords.height + backgroundOffset * 2)  / HintBackground.WidgetTexture.MaterialVSize());
		//Canvas.kf_DrawTileScaled(HintBackground.WidgetTexture, coords.width + backgroundOffset, coords.height + backgroundOffset);kf_kf_kf_
		
		// Draw title
		Canvas.Font = GetMySmallFont(Canvas);
		HintTitleWidget.text = HintTitle;
		HintTitleWidget.Tints[TeamIndex].A = float(default.HintTitleWidget.Tints[TeamIndex].A) * alpha;
		DrawTextWidgetClipped(Canvas, HintTitleWidget, coords, XL, YL);

		// Draw each line individually
		HintTextWidget.OffsetY = YL * 1.5;
		Canvas.Font = GetMySmallFont(Canvas);
		HintTextWidget.Tints[TeamIndex].A = float(default.HintTextWidget.Tints[TeamIndex].A) * alpha;
		YL = 0;
		
		for ( i = 0; i < HintWrappedText.Length; i++ )
		{
			HintTextWidget.text = HintWrappedText[i];
			
			if ( HintWrappedText[i] != "" )
			{
				DrawTextWidgetClipped(Canvas, HintTextWidget, coords, XL, YL);
			}
			else
			{
				YL /= 2;
			}
			
			HintTextWidget.OffsetY += YL;
		}
	}

	// Stop rendering hint if needed (and notify hint manager)
	if ( HintRemainingTime <= 0 )
	{
		bDrawHint = false;
		
		if ( da_players_PlayerController(PlayerOwner) != none )
		{
			da_players_PlayerController(PlayerOwner).NotifyHintRenderingDone();
		}
	}
}

// This function is used to calculate how the hint data should
// be wrapped.
function CalculateHintWrappingData(Canvas Canvas)
{
	local float XL, YL, XL2, YL2;
	local float minWidth, wrapWidth, totalYL;
	local int i, count;

	// First calculate minimum message width (e.g. the width of the
	// title string)
	Canvas.Font = GetMyMediumFont(Canvas);
	Canvas.SetPos(0, 0);
	Canvas.TextSize(HintTitle, minWidth, totalYL);
	
	if ( minWidth < 10.0 )
	{
		minWidth = 20.0;
	}
	
	totalYL += totalYL / 2;

	// Calculate max width of text string (or perhaps we should just use full screen width?)
	Canvas.Font = GetMyMediumFont(Canvas);
	Canvas.TextSize(HintText, XL, YL);

	// Starting with full string width, progressively reduce width until the ratio of the height
	// to the width is smaller than HintDesiredAspectRatio
	wrapWidth = XL;
	
	for ( count = 0; count < 25; count++ ) // max 25 iterations
	{
		// Wrap text
		HintWrappedText.Length = 0;
		Canvas.WrapStringToArray(HintText, HintWrappedText, wrapWidth, "|");

		// Calculate current width & height
		XL = 0; YL = 0;
		XL2 = 0; YL2 = 0;
		
		for ( i = 0; i < HintWrappedText.Length; i++ )
		{
			if ( HintWrappedText[i] != "" )
			{
				Canvas.TextSize(HintWrappedText[i], XL, YL);
			}
			else
			{
				YL /= 2;
			}
			
			if ( XL > XL2 )
			{
				XL2 = XL;
			}
			
			YL2 += YL;
		}

		// Check if current width is too small
		if ( XL2 < minWidth )
		{
			wrapWidth = minWidth;
			break;
		}

		// Calculate ratio
		if ( YL2 < 1 )
		{
			YL = 1;
		}
		else
		{
			YL = XL2 / YL2;
		}

		// Check if we should accept this wrap width
		if ( YL < HintDesiredAspectRatio )
		{
			wrapWidth = XL2;
			break;
		}

		// Else, reduce currentWidth and try again.
		wrapWidth *= 0.80;
	}

	// Wrap text to array
	HintWrappedText.Length = 0;
	Canvas.SetPos(0, 0);
	Canvas.WrapStringToArray(HintText, HintWrappedText, wrapWidth, "|");

	// Calculate total width and height
	wrapWidth = minWidth;
	XL = 0; YL = 0;
	
	for ( i = 0; i < HintWrappedText.Length; i++ )
	{
		Canvas.SetPos(0, 0);
		
		if ( HintWrappedText[i] != "" )
		{
			Canvas.TextSize(HintWrappedText[i], XL, YL);
		}
		else
		{
			YL /= 2;
		}
		
		if ( XL > wrapWidth )
		{
			wrapWidth = XL;
		}
		
		totalYL += YL;
	}

	// for safety
	if ( wrapWidth < 10 )
	{
		wrapWidth = 10;
	}
	
	if ( totalYL < 10 )
	{
		totalYL = 10;
	}

	// Calculate target relative coordinates
	HintCoords.XL = wrapWidth / Canvas.ClipX;
	HintCoords.YL = totalYL / Canvas.ClipY;
	HintCoords.X = default.HintCoords.X + HintCoords.XL * default.HintCoords.XL;
	HintCoords.Y = default.HintCoords.Y + HintCoords.YL * default.HintCoords.YL;
}

function DrawTextWidgetClipped(Canvas C, TextWidget widget, AbsoluteCoordsInfo coords, optional out float XL, optional out float YL, optional out float YL_oneline, optional bool bNoRender)
{
	local float ScreenX, ScreenY, ScreenXL, ScreenYL;
	local float oldClipX, oldClipY, oldOrgX, oldOrgY, myXL, myYL;

	// Calculate where we want to write
	ScreenX = coords.width * widget.PosX;
	ScreenY = coords.height * widget.PosY;

	// Save old canvas settings
	oldClipX = C.ClipX; oldClipY = C.ClipY;
	oldOrgX = C.OrgX; oldOrgY = C.OrgY;

	// Check if we should wrap
	if (widget.WrapWidth ~= 0)
	{
		// Calculate text size
		C.Font = GetMySmallFont(C);
		C.TextSize(widget.text, ScreenXL, ScreenYL);
		YL_oneline = ScreenYL;
		XL = ScreenXL; YL = ScreenYL;
	}
	else
	{
		// Calculate text size
		ScreenXL = coords.width * widget.WrapWidth;
		C.ClipX = ScreenXL;
		C.TextSize(widget.text, myXL, YL_oneline); // only used to fill YL_oneline variable
		C.StrLen(widget.text, myXL, myYL);
		XL = myXL; YL = myYL;
		ScreenYL = myYL;
	}

	// Calculate offsets
	ScreenX += widget.OffsetX + coords.PosX;
	ScreenY += widget.OffsetY + coords.PosY;

	CalcPivotCoords(widget.DrawPivot, ScreenX, ScreenY, ScreenXL, ScreenYL);

	// Draw the text
	C.DrawColor = widget.Tints[TeamIndex];
	C.Style = widget.RenderStyle;
	C.SetOrigin(ScreenX + C.OrgX, ScreenY + C.OrgY);
	C.SetClip(ScreenXL, ScreenYL);
	C.SetPos(0,0);

	if (widget.bDrawShadow && !bNoRender)
	{
		C.DrawColor.R = 0;
		C.DrawColor.G = 0;
		C.DrawColor.B = 0;
		C.SetOrigin(C.OrgX + 1, C.OrgY + 1);
		C.SetPos(0,0);
		C.DrawText(widget.text);
		C.SetOrigin(C.OrgX - 1, C.OrgY - 1);
		C.SetPos(0,0);
		C.DrawColor = widget.Tints[TeamIndex];
	}

	if (!bNoRender)
	C.DrawText(widget.text);

	// Restore old canvas settings
	C.SetOrigin(oldOrgX, oldOrgY);
	C.SetClip(oldClipX, oldClipY);
}

function CalcPivotCoords(EDrawPivot DrawPivot, out float ScreenX, out float ScreenY, float ScreenXL, float ScreenYL)
{
	switch (DrawPivot)
	{
		case DP_UpperLeft:
			break;

		case DP_UpperMiddle:
			ScreenX -= ScreenXL * 0.5;
			break;

		case DP_UpperRight:
			ScreenX -= ScreenXL;
			break;

		case DP_MiddleRight:
			ScreenX -= ScreenXL;
			ScreenY -= ScreenYL * 0.5;
			break;

		case DP_LowerRight:
			ScreenX -= ScreenXL;
			ScreenY -= ScreenYL;
			break;

		case DP_LowerMiddle:
			ScreenX -= ScreenXL * 0.5;
			ScreenY -= ScreenYL;
			break;

		case DP_LowerLeft:
			ScreenY -= ScreenYL;
			break;

		case DP_MiddleLeft:
			ScreenY -= ScreenYL * 0.5;
			break;

		case DP_MiddleMiddle:
			ScreenX -= ScreenXL * 0.5;
			ScreenY -= ScreenYL * 0.5;
			break;

		default:
			break;
	}
}

simulated function LayoutMessage( out HudLocalizedMessage Message, Canvas C )
{
	Message.StringMessage = class'DefenceAlliance'.static.ParseLoadingHintNoColor(Message.StringMessage, PlayerOwner);

	if ( Message.Switch < 7 )
	{
		Message.StringFont = GetMyMediumFont(C);
	}
	else
	{
		Message.StringFont = GetMyLargeFont(C);
	}

	Message.DrawColor = GreyColor;

	Message.Message.static.GetPos( Message.Switch, Message.DrawPivot, Message.StackMode, Message.PosX, Message.PosY );
	C.Font = Message.StringFont;
	C.TextSize( Message.StringMessage, Message.DX, Message.DY );
}

function DrawMechHints(da_turrets_Turret MyTurret)
{
		if ( MyTurret.team != PRI.team.teamIndex )
		{
			return;
		}
		
		if ( MyTurret.buildCount < 100 && !MyTurret.bBuilt )
		{
			PlayerOwner.ReceiveLocalizedMessage(class'da2.da_WaitingMessage', 3);					
		}
		else if ( MyTurret.Health < MyTurret.default.Health )
		{
			PlayerOwner.ReceiveLocalizedMessage(class'da2.da_WaitingMessage', 4);	
		}
}

function DrawGunnerHints(da_turrets_Turret MyTurret)
{
		if ( MyTurret.team != PRI.team.teamIndex )
		{
			return;
		}
		
		if ( MyTurret.bBuilt )
		{
			PlayerOwner.ReceiveLocalizedMessage(class'da2.da_WaitingMessage', 9);					
		}

}

function DrawMechStructureHints(da_buildable_Useable MyStructure)
{
		if ( !MyStructure.bBuilt )
		{
			PlayerOwner.ReceiveLocalizedMessage(class'da2.da_WaitingMessage', 3);					
		}
		else if ( MyStructure.Health < MyStructure.default.Health )
		{
			PlayerOwner.ReceiveLocalizedMessage(class'da2.da_WaitingMessage', 4);	
		}
}

simulated function DrawBuildingLimits(Canvas canvas, da_players_ClassPlayer playerPawn, int x, int y, int height, int width)
{

	local int i, boxY, amount, limit;
	local Texture bTexture;
	if (playerPawn != none)
	{
		canvas.Font = GetMyMediumFont(Canvas);
		boxY = y;

		if (PRI.Team.TeamIndex == 0) {

		for (i=0; i<4; i++)
		{
			switch (i)
			{
				case 0:
					bTexture = Texture'DA2GUI.Misc.sideviewAmmobox';
					amount = GRI.buildCount_def[0];
					limit = GRI.buildLimits_def[0];
				break;
				case 1:
					bTexture = Texture'DA2GUI.Misc.sideviewAver';
					amount = GRI.buildCount_def[1];
					limit = GRI.buildLimits_def[1];
				break;
				case 2:
					bTexture = Texture'DA2GUI.Misc.sideviewCrusher';
					amount = GRI.buildCount_def[2];
					limit = GRI.buildLimits_def[2];
				break;
				case 3:
					bTexture = Texture'DA2GUI.Misc.sideviewDFA';
					amount = GRI.buildCount_def[3];
					limit = GRI.buildLimits_def[3];
				break;
			}

			if (limit != 0)
			{
				canvas.SetPos(x, boxY);

				if (amount >= limit)
				{
					canvas.DrawColor = class'Canvas'.static.MakeColor(255, 0 ,0);
				}
				else 
				{
					canvas.DrawColor = class'Canvas'.static.MakeColor(255,255,255);
				}

				canvas.DrawTile(bTexture, width, height, 0, 0, 256, 256);
				if (amount < limit)
				{
					canvas.Font = GetMyMediumFont(Canvas);
					canvas.DrawTextJustified(amount@"/"@limit, 1, x, boxY, x+width, boxY+height);
				}
				else
				{
					canvas.Font = GetMyTinyFont(canvas);
					canvas.DrawTextJustified("LIMIT", 1, x, boxY+(height/2)-20, x+width, boxY+(height/2));
					canvas.DrawTextJustified("REACHED", 1, x, boxY+(height/2), x+width, boxY+(height/2)+20);
				}

				boxY += height+10;
			}
		}}

		else 
		{

		for (i=0; i<4; i++)
		{
			switch (i)
			{
				case 0:
					bTexture = Texture'DA2GUI.Misc.sideviewAmmobox';
					amount = GRI.buildCount_att[0];
					limit = GRI.buildLimits_att[0];
				break;
				case 1:
					bTexture = Texture'DA2GUI.Misc.sideviewAver';
					amount = GRI.buildCount_att[1];
					limit = GRI.buildLimits_att[1];
				break;
				case 2:
					bTexture = Texture'DA2GUI.Misc.sideviewCrusher';
					amount = GRI.buildCount_att[2];
					limit = GRI.buildLimits_att[2];
				break;
				case 3:
					bTexture = Texture'DA2GUI.Misc.sideviewDFA';
					amount = GRI.buildCount_att[3];
					limit = GRI.buildLimits_att[3];
				break;
			}

			if (limit != 0)
			{
				canvas.SetPos(x, boxY);

				if (amount >= limit)
				{
					canvas.DrawColor = class'Canvas'.static.MakeColor(255, 0 ,0);
				}
				else 
				{
					canvas.DrawColor = class'Canvas'.static.MakeColor(255,255,255);
				}

				canvas.DrawTile(bTexture, width, height, 0, 0, 256, 256);
				if (amount < limit)
				{
					canvas.Font = GetMyMediumFont(canvas);
					canvas.DrawTextJustified(amount@"/"@limit, 1, x, boxY, x+width, boxY+height);
				}
				else
				{
					canvas.Font = GetMyTinyFont(canvas);
					canvas.DrawTextJustified("LIMIT", 1, x, boxY+(height/2)-20, x+width, boxY+(height/2));
					canvas.DrawTextJustified("REACHED", 1, x, boxY+(height/2), x+width, boxY+(height/2)+20);
				}

				boxY += height+10;
			}
		}} 
	}
}

simulated function DrawTurretInfo(Canvas canvas, int x, int y, class<da_turrets_Turret> turret)
{
	
}

simulated function DrawBuildingLimitBox(Canvas canvas, int x, int y, Texture texture, int count, int limit)
{
	canvas.SetPos(x, y);

	if (count >= limit)
	{
		canvas.DrawColor = class'Canvas'.static.MakeColor(255, 0 ,0);
	}
	else 
	{
		canvas.DrawColor = class'Canvas'.static.MakeColor(255,255,255);
	}
	canvas.DrawTile(texture, 128, 128, 0, 0, 256, 256);
	canvas.DrawTextJustified(count@"/"@limit, 1, x, y, x+128, y+128);
}

simulated function drawHudRank(Canvas c, int x, int y, int height, int width)
{
local Material TMaterial;
local string RankNr;

PRI = da_players_PRI(PlayerOwner.PlayerReplicationInfo);

	if (PRI != none && PRI.PlayerRank > 0)
	{
		c.SetPos(x, y);
		C.SetDrawColor(255, 255, 255);
	
			Switch (PRI.PlayerRank)
			{
				Case 9: RankNr = "3"; TMaterial = Texture'DA2GUI.misc.Star'; Break;
				Case 8: RankNr = "2"; TMaterial = Texture'DA2GUI.misc.Star'; Break;
				Case 7: RankNr = "1"; TMaterial = Texture'DA2GUI.misc.Star'; Break;
				Case 6: RankNr = "3"; TMaterial = Texture'DA2GUI.misc.Captain'; Break;
				Case 5: RankNr = "2"; TMaterial = Texture'DA2GUI.misc.Captain'; Break;
				Case 4: RankNr = "1"; TMaterial = Texture'DA2GUI.misc.Captain'; Break;
				Case 3: RankNr = "3"; TMaterial = Texture'DA2GUI.misc.Private'; Break;
				Case 2: RankNr = "2"; TMaterial = Texture'DA2GUI.misc.Private'; Break;
				Case 1: RankNr = "1"; TMaterial = Texture'DA2GUI.misc.Private'; Break;
			}
	
		c.DrawTile(TMaterial, width, height, 0, 0, 256, 256);
		
		c.Font = font'DA2FontsDialog.DIN20';
		c.setPos(x+74, y);
		c.DrawText(RankNr);
	
	}
}

//Copied from HUDKillingFloor
simulated function DrawDamageIndicators(Canvas C)
{
	local class<DamTypeZombieAttack> ZHUDDam;
	local float DltA;

	// let's mod this to account for other types of damage effects.
	// - ALEX
	if ( DamageHUDTimer>Level.TimeSeconds )
	{
		C.SetPos(0, 0);
		DltA = DamageHUDTimer - Level.TimeSeconds;
		C.SetDrawColor(255, 255, 255, clamp((DltA / DamageStartTime * 200.f), 0, 200));

		ZHUDDam = class<DamTypeZombieAttack>(HUDHitDamage);

		if ( ZHUDDam == none )
		{
			C.DrawTile( FinalBlend'KillingfloorHUD.GoreSplashFB', C.SizeX, C.SizeY, 0.0, 0.0, 512, 512);
		}
		else
		{
			if ( DamageIsUber )
			{
				C.DrawTile( ZHUDDam.default.HUDUberDamageTex, C.SizeX, C.SizeY, 0.0, 0.0, ZHUDDam.default.HUDUberDamageTex.MaterialUSize(), ZHUDDam.default.HUDUberDamageTex.MaterialVSize());
			}
			else
			{
				C.DrawTile( ZHUDDam.default.HUDDamageTex, C.SizeX, C.SizeY, 0.0, 0.0, ZHUDDam.default.HUDDamageTex.MaterialUSize(), ZHUDDam.default.HUDDamageTex.MaterialVSize());
			}
		}
	}
}

simulated function DisplayHit(vector HitDir, int Damage, class<DamageType> damageType)
{
	// What type of damage are we sustaining?
	HUDHitDamage = damageType;

	if( DamageTime[0] > 0 )
	{
		DamageIsUber = true;
	}
	else
	{
		DamageIsUber = false;
	}

	if( class<DamTypeZombieAttack>(HUDHitDamage) != none )
	{
		DamageStartTime = class<DamTypeZombieAttack>(HUDHitDamage).default.HUDTime;
		if ( HUDHitDamage==Class'DamTypeVomit' )
		{
			VomitHudTimer = Level.TimeSeconds + 0.8;
		}
	}
	else
	{
		DamageStartTime = Clamp(float(Damage) / 5.f, 0.2, 1.5);
	}

	DamageHUDTimer = Level.TimeSeconds + DamageStartTime;
}
//End Copy


//MISC//////////////////////////////////////////////////////////////////////////

defaultproperties
{
     DigitsBig=(DigitTexture=Texture'DA2HUD.HUD.HUDIR5',TextureCoords[0]=(X1=1,Y1=161,X2=13,Y2=180),TextureCoords[1]=(X1=14,Y1=161,X2=24,Y2=180),TextureCoords[2]=(X1=26,Y1=161,X2=38,Y2=180),TextureCoords[3]=(X1=38,Y1=161,X2=50,Y2=180),TextureCoords[4]=(X1=50,Y1=161,X2=63,Y2=180),TextureCoords[5]=(X1=63,Y1=161,X2=75,Y2=180),TextureCoords[6]=(X1=75,Y1=161,X2=87,Y2=180),TextureCoords[7]=(X1=87,Y1=161,X2=99,Y2=180),TextureCoords[8]=(X1=100,Y1=161,X2=112,Y2=180),TextureCoords[9]=(X1=112,Y1=161,X2=124,Y2=180))
     Crosshair=(WidgetTexture=Texture'DA2Crosshairs.Weapon.assaultcross',RenderStyle=STY_Alpha,TextureCoords=(X2=32,Y2=32),TextureScale=0.750000,DrawPivot=DP_MiddleMiddle,PosX=0.500000,PosY=0.500000,Scale=0.750000,Tints[0]=(B=255,G=255,R=255,A=255),Tints[1]=(B=255,G=255,R=255,A=255))
     RecoilIndicator=(WidgetTexture=Texture'DA2Crosshairs.Weapon.RecoilLeft',RenderStyle=STY_Alpha,TextureCoords=(X2=64,Y2=64),TextureScale=0.500000,DrawPivot=DP_MiddleMiddle,PosX=0.500000,PosY=0.500000,Scale=0.500000,Tints[0]=(B=255,G=255,R=255,A=255),Tints[1]=(B=255,G=255,R=255,A=255))
     ami=(WidgetTexture=Texture'DA2HUD.HUD.HUDIR5',RenderStyle=STY_Alpha,TextureCoords=(Y1=270,X2=152,Y2=512),TextureScale=0.500000,PosY=0.750000,Scale=1.000000,Tints[0]=(B=255,G=255,R=255,A=255),Tints[1]=(B=255,G=255,R=255,A=255))
     AmmoCount=(RenderStyle=STY_Alpha,TextureScale=0.500000,DrawPivot=DP_UpperRight,PosX=0.030000,PosY=0.895000,Tints[0]=(B=255,G=255,R=255,A=255),Tints[1]=(B=255,G=255,R=255,A=255))
     ammoLeft=(RenderStyle=STY_Alpha,TextureScale=0.500000,DrawPivot=DP_UpperRight,PosX=0.067500,PosY=0.895000,Tints[0]=(B=255,G=255,R=255,A=255),Tints[1]=(B=255,G=255,R=255,A=255))
     Grenades=(RenderStyle=STY_Alpha,TextureScale=0.500000,PosX=0.010000,PosY=0.832500,Tints[0]=(B=255,G=255,R=255,A=255),Tints[1]=(B=255,G=255,R=255,A=255))
     Health=(RenderStyle=STY_Alpha,TextureScale=0.500000,PosX=0.010000,PosY=0.955000,Tints[0]=(B=255,G=255,R=255,A=255),Tints[1]=(B=255,G=255,R=255,A=255))
     ammoLeftFlashing=1.400000
     ShadowColor=(A=255)
     NavyColor=(B=160,G=110,R=10,A=255)
     CrimsonColor=(R=200,A=255)
     GreyColor=(B=200,G=200,R=200,A=255)
     StartupMsg(0)="Waiting for more players."
     StartupMsg(1)="Waiting for other players to be ready."
     StartupMsg(2)="Starting... 3"
     StartupMsg(3)="Starting... 2"
     StartupMsg(4)="Starting... 1"
     NotReadyMsg="Click when ready!"
     NeedleRotator=TexRotator'InterfaceArt_tex.HUD.Needle_rot'
     VoiceMeterBackground=Texture'InterfaceArt_tex.HUD.VUMeter'
     VoiceMeterX=0.640000
     VoiceMeterY=1.000000
     VoiceMeterSize=85.000000
     HintFadeTime=0.500000
     HintLifetime=8.000000
     HintDesiredAspectRatio=100.000000
     HintBackground=(WidgetTexture=Texture'DA2GUI.Dialog.Display98',RenderStyle=STY_Alpha,DrawPivot=DP_MiddleMiddle,PosY=0.005000,ScaleMode=SM_Left,Scale=1.000000,Tints[0]=(B=255,G=255,R=255,A=192),Tints[1]=(B=255,G=255,R=255,A=192))
     HintTitleWidget=(RenderStyle=STY_Alpha,WrapWidth=100.000000,WrapHeight=1.000000,bDrawShadow=True,Tints[0]=(B=255,G=255,R=255,A=255),Tints[1]=(B=255,G=255,R=255,A=255))
     HintTextWidget=(RenderStyle=STY_Alpha,WrapWidth=100.000000,WrapHeight=1.000000,Tints[0]=(B=255,G=255,R=255,A=255),Tints[1]=(B=255,G=255,R=255,A=255))
     HintCoords=(X=0.980000,Y=0.500000,XL=-1.000000)
     InstructionFontName="DA2FontsDialog.DIN12"
     bHideWeaponName=True
     LevelActionFontName="DA2FontsDialog.DIN14"
     ProgressFontName="DA2FontsDialog.DIN18"
     ConsoleFontSize=6
     ConsoleMessagePosX=0.140000
     ConsoleMessagePosY=0.875000
}
