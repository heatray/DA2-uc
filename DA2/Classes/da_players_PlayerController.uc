// ============================================================================
//  DA2.da_players_PlayerController:
//  By: aBsOlUt, Dante
// ============================================================================
class da_players_PlayerController extends xPlayer;

#EXEC OBJ LOAD FILE=DA2_WeaponSounds.uax
#EXEC OBJ LOAD FILE=Weapons1st_tex.utx

var input byte bBuild;
var input byte bDeconstruct;
var bool bBuildUpdate;
var float AmmoDelayTime;

var int RecentHit;

//References
var da_game_ReplicationInfo DAGRI;
var da_players_PRI PRI;
var da_weapons_Grenades grenades;

//Player stuff
var float useRadius;
var float lastThrowFlare;

// Currently SELECTED class != current class
var int pendingClass;
var int pendingNade;
var bool incendiary;
var int ChosenHealth;
var float ReloadSpeed;
var int ChosenSpeed;
var int PlayerRank;

//Motion Blur: Extending ROPlayer will cause trouble so we will have to copy motion blur all over.
//Code belongs to perspective owners, DA2 members are not responsible for anything motion blur wise.
var		float		CurrentBlurAmount;				// how much we are blurred currently
var		float		CurrentFadeAmount;				// how much we are blurred currently
var		float		InitialBlurTime;  				// Saves the current blur time
var 	MotionBlur	ShellShockBlur;   				// The motion blur effect
var     config bool bUseBlurEffect;   				// Wether or not the blur effect should be used
var		byte		AltBlurLevel;
var()	byte		MaxAltBlurLevel;  				// The max amount we want to darken the screen for the alternative blur effect
var     bool        bDoFadeFromBlackEffect;

// For hint management
var     da_hud_HintManager  HintManager;
var     config  bool    	bShowHints;

var bool 	bRequestedSteamData;	// Used to track if we've requested Steam Stats and Achievements from Steam

// ============================================================================
replication {
	reliable if ( ROLE < ROLE_Authority )
		serverChooseClass, serverThrowFlare, startBuilding, startDeconstruct, serverUpdateBuilding, setPlayerRank, PlayerRank;
	reliable if (ROLE == ROLE_Authority)
		grenades, updateMission,AmmoDelayTime,Recenthit;
	unreliable if( Role==ROLE_Authority && !bDemoRecording )
        AMIAnnouncement, ClientDmgShake;
}
// ============================================================================

//-----------------------------------------------------------------------------
// Crouch - Toggles the bDuck flag - replaces UT2004 functionality
//-----------------------------------------------------------------------------

simulated function int GetRecentHit()
{
	return ServerRecentHit();
}
function int ServerRecentHit()
{
	return RecentHit;
}

simulated function float GetAmmoDelay()
{
	return ServerGetAmmoDelay();
}
function float ServerGetAmmoDelay()
{
	return AmmoDelayTime;
}
simulated function SetRecentHit(int RH)
{
	SSetRecentHit(Rh);
}
function SSetRecentHit(int RH)
{
	RecentHit = RH;
}
exec function ToggleDuck()
{
	if( Pawn != none && Pawn.CanCrouchTransition())
	{
		if( bDuck == 0 )
		{
			bDuck = 1;
		}
		else
		{
			bDuck = 0;
		}
	}
}

exec function Crouch()
{
	if( Pawn != none && Pawn.CanCrouchTransition())
	{
		bDuck = 1;
	}
}

exec function UnCrouch()
{
	if( Pawn != none && Pawn.CanCrouchTransition())
	{
		bDuck = 0;
	}
}

function AdjustView(float DeltaTime )
{
	local da_weapons_Rifle rifle;
	FOVAngle = DesiredFOV;



	// adjust FOV for weapon zooming
	if ( bZooming ) {
		rifle = da_weapons_Rifle(pawn.weapon);
		DesiredZoomLevel = FClamp(DesiredZoomLevel,rifle.minZoom, rifle.maxZoom);
		DesiredFOV = FClamp(90.0 - (DesiredZoomLevel * 88.0), 1, 170);
	}
}

function PlayWinMessage(bool bWinner)
{
    super.PlayWinMessage(bWinner);
    //myHUD.bshowScoreboard = true;
}

// Overriden to support resetting motion blur before switching maps and cleaning
// up weapons that aren't properly garbage collected under normal circumstances
event PreClientTravel()
{
	super.PreClientTravel();

	if( Level.NetMode != NM_DedicatedServer )
	{
		ResetBlur();

        log(self$" PreClientTravel()");

		if( Pawn != none)
		{
             if ( da_players_ClassPlayer(Pawn) != none )
			{
				da_players_ClassPlayer(Pawn).PreTravelCleanUp();
			}
		}
	}
}

// Overidden to support resetting shake and blur values when you posses the pawn
function AcknowledgePossession(Pawn P)
{
	if( P != none )
	{
		StopViewShaking();
		if( Level.NetMode != NM_DedicatedServer )
		{
			ResetBlur();
		}
	}

	if ( Viewport(Player) != None )
	{
		AcknowledgedPawn = P;
		if ( P != None )
			P.SetBaseEyeHeight();
		ServerAcknowledgePossession(P, Handedness, bAutoTaunt);
	}
}

auto state PlayerWaiting
{
    simulated function Timer()
    {
	SteamStatsAndAchievements = Spawn(SteamStatsAndAchievementsClass, self); //What!?

        if ( (PlayerReplicationInfo != none && PlayerReplicationInfo.bReadyToPlay) )
        {
            SetTimer(0, false);
        }
        else if ( !bRequestedSteamData && SteamStatsAndAchievements == none )
    	{
			if ( Level.NetMode == NM_Standalone )
			{
				SteamStatsAndAchievements = Spawn(SteamStatsAndAchievementsClass, self);
				if ( SteamStatsAndAchievements == none || !SteamStatsAndAchievements.Initialize(self) )
				{
					SteamStatsAndAchievements.Destroy();
					SteamStatsAndAchievements = none;
					bRequestedSteamData = true;
				}
			}
			else
			{
				bRequestedSteamData = true;
			}
    	}
        else if ( SteamStatsAndAchievements != none && !SteamStatsAndAchievements.bInitialized )
    	{
    		if ( !bRequestedSteamData )
    		{
				SteamStatsAndAchievements.GetStatsAndAchievements();
				bRequestedSteamData = true;
		}


        }
    }
   
    simulated function BeginState()
    {
		if( Level.NetMode != NM_DedicatedServer )
		{
			ResetBlur();
		}
		
		// Spawn hint manager (if needed)
	    UpdateHintManagement(bShowHints);    

		super.BeginState();

        bRequestedSteamData = false;

        if (Level.NetMode != NM_DedicatedServer)
        {
			SetTimer(0.1, true);
            Timer();
        }
    }
}

event PlayerTick( float DeltaTime )
{
	super.playerTick(deltaTime);

	if (bBuild != 0 || bDeconstruct != 0)
		bBuildUpdate = true;
	else if (bBuildUpdate) {
		bBuildUpdate = false;
		serverUpdateBuilding(bBuild, bDeconstruct);
	}
}

simulated function postBeginPlay() {
	super.postBeginPlay();
	
	// Spawn hint manager (if needed)
	UpdateHintManagement(bShowHints);
}


function serverUpdateBuilding(byte newBuild, byte newDeconstruct) {
	bBuild = newBuild;
	bDeconstruct = newDeconstruct;
}

simulated function AMIAnnouncement(sound aSound)
{

	if ( (Level.TimeSeconds - LastPlaySound) < 2.0 )
		return;

    LastPlaySound = Level.TimeSeconds;

    if ( ViewTarget != None )
		ViewTarget.PlaySound(aSound,SLOT_Interface,10,true,,,false);
}

function rotator adjustGrenadeAiming(projectile g) {
    return GetViewRotation();
}

exec function NextWeapon() {
	if (bZooming)
    {
        if (DesiredZoomLevel == da_weapons_Rifle(pawn.Weapon).minZoom)
	       return;

        playSound(sound'DA2_WeaponSounds.Scope_ZoomChange',SLOT_Interact, 1.5);
    	DesiredZoomLevel -= da_weapons_Rifle(pawn.weapon).zoomStep;
	}
	else if (da_weapons_Reloadable(Pawn.weapon).isWeaponReady())
		super.nextWeapon();
}

exec function PrevWeapon() {
	if (bZooming)
	{
	    if (DesiredZoomLevel == da_weapons_Rifle(pawn.Weapon).maxZoom)
	       return;
        playSound(sound'DA2_WeaponSounds.Scope_ZoomChange',SLOT_Interact, 2.5);
    	DesiredZoomLevel += da_weapons_Rifle(pawn.weapon).zoomStep;
	}
	else if (da_weapons_Reloadable(Pawn.weapon).isWeaponReady())
		super.prevWeapon();
}



// OH btw, with adding the method here you prevented bots to use it.
// But I doubt anyone will write code for bots for this anyways.
exec function throwFlare()
{
     if (PRI != none && !PRI.bIsSpectator)
          serverThrowFlare();
}

function serverThrowFlare()
{
	if (PRI == none || PRI.bIsSpectator)
		return;
    playerThrowFlare();
}

simulated function playerThrowFlare()
{
    local Projectile fx;
    local da_players_ClassPlayer cp;
    cp = da_players_ClassPlayer(pawn);

    if (cp == none)    //aBsOlUt
       return;

    if (level.timeseconds - lastThrowFlare < 3)
		return;
	lastThrowFlare = level.timeSeconds;

	if (playerreplicationinfo.team.teamIndex == 0)
		fx = Spawn(class'da_proj_FlareGreen', self,,Pawn.Location);
	else
		fx = Spawn(class'da_proj_FlareGray', self,,Pawn.Location);
}

function SetPawnClass(string inClass, string inCharacter)
{
   PawnClass= class'DA2.da_players_HumanPlayer';
}

function ToggleZoom() {
	if (bZooming)
		endZoom();
	else {
		bZooming = true;
       	desiredZoomLevel = da_weapons_rifle(pawn.weapon).minZoom;
	}
}

function Restart() {
    DAGRI=da_game_ReplicationInfo(GameReplicationInfo);
    PRI=da_players_PRI(PlayerReplicationInfo);
	
	if (PRI != none) 
	{
    PRI.playerClass = pendingClass;
	PRI.selectedNade = pendingNade;
	PRI.enableIncendiary = incendiary;
	PRI.ReloadSpeed = ReloadSpeed;
	SendRanktoServer();
	PRI.PlayerRank = PlayerRank;
	log("function Restart for "@PRI.PlayerName);
	}

  if ( PRI.playerClass < 0 ) { //Check for class
        pawn.LinkMesh(none);
		GotoState('ChoosingClass');
		ClientGotoState('ChoosingClass','');
	} else
		//ClientCloseMenu(true, true);
        super.Restart();

    grenades = da_weapons_Grenades(pawn.FindInventoryType(class'da_weapons_Grenades'));

}

function ClientRestart(Pawn NewPawn) 
{
    DAGRI=da_game_ReplicationInfo(GameReplicationInfo);
    PRI=da_players_PRI( PlayerReplicationInfo );
    if (PRI != none) 
	{
        PRI.playerClass = pendingClass;
		PRI.selectedNade = pendingNade;
		PRI.enableIncendiary = incendiary;
		PRI.ReloadSpeed = ReloadSpeed;
		PRI.PlayerRank = da_SteamStatsAndAchievements(SteamStatsAndAchievements).GetPlayerRank();
		log("function ClientRestart");
		
	log("PlayerRank in PlayerController:"@PlayerRank);
	
	log("PlayerRank in da_SteamStatsAndAchievements:"@da_SteamStatsAndAchievements(SteamStatsAndAchievements).GetPlayerRank());

	log("PlayerRank in PRI:"@PRI.playerRank); 
	
	log("Playerclass in ClientRestart"@PRI.playerClass);
	
		Switch (PRI.playerClass)
		{
			case 0:
			AMIAnnouncement(Sound'AMISounds.player.ClassInfantry');
			break;
			
			case 1:
			AMIAnnouncement(Sound'AMISounds.player.ClassEngineer');
			break;
			
			case 2:
			AMIAnnouncement(Sound'AMISounds.player.ClassMedic');
			break;
			
			case 3:
			AMIAnnouncement(Sound'AMISounds.player.ClassMachineGunner');
			break;
			
			case 4:
			AMIAnnouncement(Sound'AMISounds.player.ClassSniper');
			break;
			
			case 5:
			AMIAnnouncement(Sound'AMISounds.player.ClassAntiArmour');
			break;
			
			case 6:
			AMIAnnouncement(Sound'AMISounds.player.ClassEngineer');
			break;
		}
	}
	super.clientRestart(newPawn);
	
    da_players_Hud(self.myHUD).bShowedSpawnHints = false;
}

simulated function ShowSpawnHint()
{
	local array<int> AvailableHints;
	local Inventory Inv;
	local bool bHasGrenades;
	
	//Add the default hints for all classes
	AvailableHints.Insert(0,3);
	AvailableHints[0] = 12;
	AvailableHints[1] = 13;
	AvailableHints[2] = 14;
	
	for ( Inv = Pawn.Inventory; Inv != None; Inv = Inv.Inventory )
	{
		if ( Inv.IsA('da_weapons_Grenades') )
		{
			bHasGrenades = true;
		}
	}
	
	// Iron sights hint
	if ( da_weapons_Rifle(Pawn.weapon).bHasIronsight )
	{
		AvailableHints.Insert(0, 1);
		AvailableHints[0] = 11;
	}
	
	// Grenades hint
	if ( bHasGrenades )
	{
		AvailableHints.Insert(0, 1);
		AvailableHints[0] = 10;	
	}
	
	// Melee Hint
	if ( da_weapons_BasicGun(Pawn.weapon) != none )
	{
		AvailableHints.Insert(0, 1);
		AvailableHints[0] = 15;	
	}
	
	if ( Rand(3) > 2 )
	{	
		CheckForHint(AvailableHints[Rand(AvailableHints.Length)]);
	}
	
	// screen Messages
	if ( da_players_ClassPlayer(Pawn) != none && da_players_ClassPlayer(Pawn).resolveClassInfo().bCanBuild && !da_players_ClassPlayer(Pawn).resolveClassInfo().bCanOnlyRepair )
	{
		ReceiveLocalizedMessage(class'da2.da_WaitingMessage', 2);
	}
	else if ( da_players_ClassPlayer(Pawn) != none && da_players_ClassPlayer(Pawn).resolveClassInfo().auraHealPerSec > 0 )
	{
		ReceiveLocalizedMessage(class'da2.da_WaitingMessage', 5);	
	}
	
}

//Registers a new MUB
simulated function updateMission(da_objective_base objective) {
         da_players_Hud(self.myHUD).registerUpdate(objective);
}

function ServerChangeTeam( int N )
{
	local TeamInfo OldTeam;
	OldTeam = PlayerReplicationInfo.Team;
	if ( Level.Game.ChangeTeam(self, N, true) ) {
		if ( Level.Game.bTeamGame && (PlayerReplicationInfo.Team != OldTeam) )
            pendingClass = -1;
            da_players_PRI( PlayerReplicationInfo ).playerClass = -1;
			if ( Pawn != None)
                Pawn.Died( None, class'DamageType', Pawn.Location );
      }
}

// ============================================================================
exec function SendRanktoServer()
{
	local int Rank;
	
	if ( da_SteamStatsAndAchievements(SteamStatsAndAchievements).GetPlayerRank() != 0 )
		Rank = da_SteamStatsAndAchievements(SteamStatsAndAchievements).GetPlayerRank();
	
	log("calling setPlayerRank(), received rank"@Rank@"from achievements");
	
	setPlayerRank(Rank);
}

// ============================================================================
function setPlayerRank(int Rank)
{
	log("received request, sending rank"@Rank@" to server for player "@da_Players_PRI(PlayerReplicationInfo).PlayerName);
	if ( Rank != 0 )
	{
		PlayerRank = Rank;
		PRI.PlayerRank = PlayerRank;
		
		log("setplayerrank, rank written in PRI: "@PRI.PlayerRank);
	}
}


// ============================================================================
exec function chooseClass( int num, int nade, float extrahealth, float speed, float reload, bool inc)
{
	if (PRI == none)
		PRI = da_players_PRI(PlayerReplicationInfo);
	
    serverChooseClass(num,nade,extrahealth,reload,inc);
	pendingClass = num;
	pendingNade = nade;
	Incendiary = inc;
	ChosenHealth = extrahealth;
	ReloadSpeed = reload;
}

exec function startBuilding() {
    local da_players_ClassPlayer cp;
    cp = da_players_ClassPlayer(pawn);
    if (cp == none || !cp.resolveClassInfo().bCanBuild)
        return;
	bBuild = 1;
	bDeconstruct = 0;
    ClientSetWeapon(class'da_weapons_MechTool');
}

exec function startDeconstruct() {
    local da_players_ClassPlayer cp;
    cp = da_players_ClassPlayer(pawn);
    if (cp == none || !cp.resolveClassInfo().bCanBuild)
        return;
	bDeconstruct = 1;
	bBuild = 0;
    ClientSetWeapon(class'da_weapons_MechTool');
}

exec function showMissionObjectives() {
    da_players_Hud(myHUD).showObjectives();
	ServerShowPathToBase(1);
}

exec function throwNade() {
    if (grenades != none && da_weapons_Reloadable(Pawn.weapon).isWeaponReady())
    {
        if (grenades.grenadeAmount > 0 && bZooming)
           endZoom();

        grenades.throwGrenade();
    }
}

exec function ChangeTeam( int N )
{
	ServerChangeTeam(N);
}

exec function BasePath(byte num)
{
	if (PlayerReplicationInfo.Team == None )
		return;
	ServerShowPathToBase(num);
}

function ServerShowPathToBase(int TeamNum)
{
	if ( (Level.NetMode != NM_Standalone) && (Level.TimeSeconds - LastWhispTime < 0.5) )
		return;
	LastWhispTime = Level.TimeSeconds;

	DefenceAlliance(Level.Game).ShowPathTo(Self, TeamNum);
}

exec function classSpecial() {
	if (da_players_ClassPlayer(pawn).MechTool != none)
		showBuildMenu();
}

function serverChooseClass(int num, int nade, float extrahealth, float reload, bool inc) {
    if (DefenceAlliance(level.game).canChooseClass(self, num, nade, extrahealth, reload, inc)) {
    	pendingClass = num;
		pendingNade = nade;
		incendiary = inc;
		ChosenHealth = extrahealth;
		ReloadSpeed = reload;
        //PRI.setRespawnTime();
    } else {
		GotoState('ChoosingClass');
		ClientGotoState('ChoosingClass','');
    }
}

exec function showBuildMenu() {


	if (da_players_ClassPlayer(Pawn).MechTool != none && !da_players_ClassPlayer(Pawn).resolveClassInfo().bCanOnlyRepair)
		clientOpenMenu("DA2.da_GUI_MechChooseStructure");
}

// ============================================================================
exec function ShowCCMenu()
{
		ClientOpenMenu("DA2.da_GUI_chooseClass");
}

// ============================================================================
function ServerUse() {
	local da_buildable_Useable item;

	if (pawn != none) {

		// NOTE: This might be redundant since the superclass also calls usedBy, but it does so
		// only for touched actors.
		foreach Pawn.VisibleCollidingActors(class'da_buildable_Useable',item,useRadius)
			if(item != none)
			{
				item.UsedBy(pawn);
				Ammodelaytime = level.timeseconds;
			}
	}

	super.ServerUse();
}

function PlayStartupMessage(byte StartupStage); //1.1 aBs

// ============================================================================
state ChoosingClass extends PlayerWaiting
{
	function serverChooseClass( int num, int nade, float extrahealth, float reload, bool inc)
	{
		if ( Pawn != None ) {

			Pawn.destroy();
			Pawn = None;
		}
		global.serverChooseClass( num , nade, extrahealth, reload, inc);
		//global.setPlayerRank(rank);
		loadPlayers();
		ServerRestartPlayer();
		SendRanktoServer();
	}

	exec function Fire(optional float F) {
	    ShowCCMenu();
	}
   
	function PawnDied(Pawn P);
	function ProcessMove(float DeltaTime, vector NewAccel, eDoubleClickDir DoubleClickMove, rotator DeltaRot);

	function BeginState()
	{
		super.BeginState();

            ShowCCMenu(); //Let him choose class

		if ( Pawn != None ) {
			Pawn.bhidden= true;
			Pawn.setCollision( false, false, false );
		}
	}
}

state Dead
{
	function BeginState()
	{
			local Actor A;

		EndZoom();
		CameraDist = Default.CameraDist;
		FOVAngle = DesiredFOV;
		Pawn = None;
        Enemy = None;
        bBehindView = true;
        bFrozen = true;
		bJumpStatus = false;
        bPressedJump = false;
        bBlockCloseCamera = true;
		bValidBehindCamera = false;
		bFreeCamera = False;
		if ( Viewport(Player) != None )
			ForEach DynamicActors(class'Actor',A)
				A.NotifyLocalPlayerDead(self);
        FindGoodView();
        SetTimer(1.0, false);
		StopForceFeedback();
		ClientPlayForceFeedback("Damage");  // jdf
		CleanOutSavedMoves();
		
		ClientOpenMenu("DA2.da_GUI_chooseClass");
	
 		//pendingClass = -1;	
        da_players_PRI( PlayerReplicationInfo ).playerClass = -1;
    }
Begin:
}

//LEVI - improved, directional DamageShake
function DmgShake(int amount, vector dir) {
    if(pawn!=none && ASTurret(pawn)==none)
        ClientDmgShake(amount, normal(normal(dir)>>rotator(normal(vector(GetViewRotation())))));
}

private function ClientDmgShake(int amount, vector dir) {
    local rotator rot, dev;

    amount=clamp(amount*(frand()/5+0.9),0,200);
    rot=GetViewRotation();
    dev=rotator(dir);

    ShakeView( amount*dir,
               (amount*20)*vect(1,1,1),
               0.3+amount/10,
               1.5*amount*dir,
               (amount*15)*vect(1,1,1),
               0.3+amount/10);

    if(rot.pitch>0 && rot.pitch<16380)
        rot.pitch=fmin(16380,rot.pitch+dev.pitch*amount/500);
    else if(rot.pitch>49160 && rot.pitch<65536)
        rot.pitch=fmax(49160,rot.pitch+dev.pitch*amount/500);
    rot.yaw+=dev.yaw*amount/500;

    SetRotation(rot);
}

function NotifyTakeHit(pawn InstigatedBy, vector HitLocation, int Damage, class<DamageType> damageType, vector Momentum)
{
    Super.NotifyTakeHit(InstigatedBy,HitLocation,Damage,DamageType,Momentum);
    DmgShake(Damage/1.5+vsize(momentum)/100, momentum);
}

// Overriden to implement blur that works online - Ramm
function NewClientPlayTakeHit(vector AttackLoc, vector HitLoc, byte Damage, class<DamageType> damageType)
{
    local float blurscale;

	super.NewClientPlayTakeHit(AttackLoc, HitLoc, Damage, damageType);

	if( Damage < 1 )
	{
		return;
	}

    if( Damage > Pawn.default.Health )
    {
    	blurscale = 1.0;
    }
    else
    {
    	blurscale = float(Damage)/ float(Pawn.default.Health);
    }

    AddBlur(FMin(1.0,blurscale), FMin(0.25,blurscale));
}

//Bloom for DA2 - Copied from ROPlayer.uc, belongs to RO
exec function Bloom()
{
	local bool bBloom;

	bBloom = bool(ConsoleCommand("get ini:Engine.Engine.ViewportManager Bloom"));

    if( bBloom )
    {
    	PostFX_SetActive(0, false);
    	ConsoleCommand("set ini:Engine.Engine.ViewportManager Bloom"@False);
    }
    else
    {
    	PostFX_SetActive(0, true);
    	ConsoleCommand("set ini:Engine.Engine.ViewportManager Bloom"@True);
    }
}

simulated function postfxon(int i)
{
   	if( PostFX_IsReady() )
		PostFX_SetActive(i, true);
}

simulated function postfxoff(int i)
{
	if( PostFX_IsReady() )
		PostFX_SetActive(i, false);
}

simulated function postfxblur(float f)//0... 1
{
   	if( PostFX_IsReady() )
		PostFX_SetParameter(1, 0, f);
}

simulated function postfxbw(float f, optional bool bDoNotTurnOffFadeFromBlackEffect)	//0... 1
{
	if( !PostFX_IsReady() )
		return;

    if (!bDoNotTurnOffFadeFromBlackEffect)
        bDoFadeFromBlackEffect = false;

	PostFX_SetParameter(2, 0, f);
}

exec function postfxbloom(float f)	//0... 1 (default 0.7f)
{
	if( Level.NetMode != NM_Standalone )
		return;

	PostFX_SetParameter(0, 0, f);
}

exec function postfxbloomgamma(float f)	//0... 1 (default 1.0f)
{
	if( Level.NetMode != NM_Standalone )
		return;

	PostFX_SetParameter(0, 1, f);
}

exec function postfxbloom_bpcontrast(float f)	//0.0f ... 4.0f (default 3.0f)
{
	if( Level.NetMode != NM_Standalone )
		return;

	PostFX_SetParameter(0, 2, f);
}

exec function postfxbloom_blurmult(float f)	//1.0f ... 2.0f (Default 1.5f)
{
	if( Level.NetMode != NM_Standalone )
		return;

	PostFX_SetParameter(0, 3, f);
}

// use alternate blur effect if the main one is not enabled
simulated event RenderOverlays( Canvas Canvas )
{
	if((!bUseBlurEffect || !PostFX_IsReady()) && BlurTime > 0)
 	{
		Canvas.DrawColor.A = Min(MaxAltBlurLevel,AltBlurLevel) * (BlurTime/InitialBlurTime);
    	Canvas.Style = ERenderStyle.STY_Alpha;

    	Canvas.SetPos(0,0);
    	Canvas.DrawTile( texture'Engine.BlackTexture', Canvas.SizeX, Canvas.SizeY, 0.0, 0.0, texture'Weapons1st_tex.zoomblur10'.USize, texture'Weapons1st_tex.zoomblur10'.VSize );
 	}
}

//MOTION BLUR
// Update the blur amount for this player
simulated function UpdateBlurEffect(float DeltaTime)
{
	if( BlurTime > 0 )
	{
		 BlurTime -= DeltaTime;

		 if( bUseBlurEffect )
		 {
			 if( InitialBlurTime > 0 )
			 {
			 	CurrentBlurAmount = BlurTime/InitialBlurTime;
			 }
			 else
			 {
			 	CurrentBlurAmount = 0;
			 }
			postfxblur(CurrentBlurAmount);
		 }
	}

	if( ColorFadeTime > 0 )
	{
		 ColorFadeTime -= DeltaTime * 2;

		 if( bUseBlurEffect )
		 {
			 if( InitialBlurTime > 0 )
			 {
			 	CurrentFadeAmount = ColorFadeTime/InitialBlurTime;
			 }
			 else
			 {
			 	CurrentFadeAmount = 0;
			 }

			postfxbw(CurrentFadeAmount);
		 }
	}

	if( ColorFadeTime <= 0 )
	{
        CurrentFadeAmount = 0;
		postfxbw(CurrentFadeAmount);

		postfxoff(2);
	}

	if( BlurTime <= 0 )
	{
		BlurTime=0;
		AltBlurLevel = 0;

        CurrentBlurAmount = 0;
 		postfxblur(CurrentBlurAmount);

		postfxoff(1);
	}
}

exec function testBlur(float blurTime, float blurScale)
{
     addBlur(blurTime, blurScale);
}

simulated function AddBlur(float NewBlurTime, float NewBlurScale)
{

	if( Level.Netmode == NM_DedicatedServer )
	{
		return;
	}

	if( bUseBlurEffect )
	{
		if( CurrentBlurAmount < NewBlurScale)
		{
			CurrentBlurAmount = NewBlurScale/2;
			CurrentFadeAmount = NewBlurScale/4;
		}

		postfxblur(CurrentBlurAmount);
		postfxon(1);

		// Don't do the black and white effect if the detail settings are low
		if ( !Level.bDropDetail && (Level.DetailMode != DM_Low) )
		{
			postfxbw(CurrentFadeAmount);
			postfxon(2);
		}
	}

	if( (MaxAltBlurLevel * NewBlurScale) > AltBlurLevel )
    	AltBlurLevel = MaxAltBlurLevel * NewBlurScale;

    if( NewBlurTime > BlurTime )
    {
	    BlurTime = NewBlurTime;
	    ColorFadeTime = NewBlurTime/4;
	    InitialBlurTime = NewBlurTime;
    }
}

simulated function ResetBlur()
{
	BlurTime = 0.0;
	ColorFadeTime = 0.0;

    CurrentFadeAmount = 0;
	AltBlurLevel = 0;
    CurrentBlurAmount = 0;

	if( PostFX_IsReady() )
	{
		postfxbw(CurrentFadeAmount);
		postfxoff(2);
		postfxblur(CurrentBlurAmount);
		postfxoff(1);
	}
}

// Give the player a quick blur effect
simulated function PlayerWhizzed(float DistSquared)
{
	local float Intensity;

	Intensity = 1.0 - ((FMin(DistSquared,22500))/22500);  // 22500 = (150*150) = Radius of bullet whiz cylinder squared
	AddBlur(0.10, Intensity/4);
}

// Hint management functions
simulated function NotifyHintRenderingDone()
{
    if ( HintManager != none )
    {
        HintManager.NotifyHintRenderingDone();
    }
}

simulated function UpdateHintManagement(bool bUseHints)
{
    if ( Level.GetLocalPlayerController() == self )
    {
        if ( bUseHints && HintManager == none )
        {
            HintManager = spawn(class'da_hud_HintManager', self);

            if ( HintManager == none )
            {
                warn("Unable to spawn hint manager");
            }
        }
        else if ( !bUseHints && HintManager != none )
        {
            HintManager.Destroy();
            HintManager = none;
        }

        if ( !bUseHints )
        {
            if ( da_players_Hud(myHUD) != none )
            {
                da_players_Hud(myHUD).bDrawHint = false;
            }
        }
    }
}

simulated function CheckForHint(int hintType)
{
    
	//log("In CheckForHint()");
	if ( HintManager != none )
    {
		//log("HintManager != none");
		HintManager.CheckForHint(hintType);
    }
}

// The player wants to switch to weapon group number F.
exec function SwitchWeapon(byte F)
{
	if ( Pawn != None && da_weapons_Reloadable(Pawn.weapon).isWeaponReady())
		Pawn.SwitchWeapon(F);
}

// ============================================================================

defaultproperties
{
     UseRadius=600.000000
     pendingClass=-1
     bUseBlurEffect=True
     MaxAltBlurLevel=100
     bShowHints=True
     CheatClass=Class'DA2.da_CheatManager'
     SteamStatsAndAchievementsClass=Class'DA2.da_SteamStatsAndAchievements'
     FovAngle=100.000000
     bAdrenalineEnabled=False
     PlayerReplicationInfoClass=Class'DA2.da_players_PRI'
     PawnClass=Class'DA2.da_players_HumanPlayer'
}
