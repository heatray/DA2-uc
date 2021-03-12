//-----------------------------------------------------------
// Generic turret class for DA2.
//-----------------------------------------------------------
class da_turrets_Turret extends ASTurret;

#EXEC OBJ LOAD FILE=../DA2/Animations/DA2_Stationary.ukx
#EXEC OBJ LOAD FILE=../DA2/Textures/DA2Weapons.utx

var() Range rotYawConstraint;
var() string descriptiveName;

var()   bool    bStartBuilt;
var     float   buildTime;      // Total time required to build this
var     float   currentBuild;   // Current build progress time
var     bool    bBuilt, bBuilding, bRepairing, bDeconstructing;
var		bool	receivedBuilt;
var		class<Emitter>		BuildFX;
var		class<Emitter>		RepairFX;
var		Controller mechOwner;
var 	int 	buildCount, repairCount;

var float Score;
var class<emitter> DamageFXClass;
var emitter DamageFX;

var sound DeploySound, StartupSound, ShutdownSound, StunnedSound;
var sound ExplosionSounds[3], ExplosionSoundFar;
var material CrosshairTex;
var float lastWarningTime;
var	float warningDelay;

var float IdleDestroyTime;
var float MaxIdleTime;

var float StunTime;

replication {
    reliable if (ROLE == ROLE_Authority)
        currentBuild, bBuilt, bStartBuilt,
		bBuilding, bRepairing, bDeconstructing;
	reliable if( bNetDirty && Role==ROLE_Authority )
        StunTime;
}


//SETUP+INITIALIZATION----------------------------------------------------------
simulated function postBeginPlay() {
	if (ROLE == ROLE_Authority)
		class'da_map_BuildBeacon'.static.createBeaconFor(self);

	if(bStartBuilt)
	    MaxIdleTime=0;
    else IdleDestroyTime=level.timeseconds+MaxIdleTime;

	setTimer(0.1, true);
	super.postBeginPlay();
}

simulated event PostNetBeginPlay() {
	super.postNetBeginPlay();
	if (bStartBuilt) {
		currentBuild = buildTime;
		buildingEnded();
		gotoState('');
		return;
	}
	buildingStarted();
}

simulated function postNetReceive() {
    if (isBuilt() && !receivedBuilt) {
		buildingEnded();
		receivedBuilt = true;
   } else if (!isBuilt())
        updateBuildProgress();
		super.postNetReceive();
}

function setMechOwner(Controller p) {
 mechOwner = p;
 setTeamNum(mechOwner.playerReplicationInfo.team.teamIndex);
     if (!isBuilt())
         buildingStarted();
}

/*function AddDefaultInventory()
{
	if (weapon == none)
   		GiveWeapon( DefaultWeaponClassName );
    if ( Controller != None )
        Controller.ClientSwitchToBestWeapon();
}*/

//BUILDING+REPAIRING+DECONSTRUCTING---------------------------------------------
simulated function build(float amount, playerreplicationinfo PRI);

simulated function bool isBuilt() {
    return bBuilt || bStartBuilt;
}

simulated function buildingStarted() {
	if(PlayerController(controller)!=none)
        KDriverLeave(true);
    if(da_turrets_TurretController(controller)!=none && ROLE==ROLE_Authority)
        controller.destroy();

    bNonHumanControl = true;
	bAutoTurret = false;

    AmbientSound=None;
    if(currentBuild>0)
        PlaySound(ShutdownSound,SLOT_None,2,,200);
    else PlaySound(DeploySound,SLOT_None,2,,200);

	setSkins();

	applyShaderChanges(self);
	applyShaderChanges(turretBase);
	applyShaderChanges(turretSwivel);
}

auto state Building {
    simulated event endState() {
        bBuilt = true;
        if (bStartBuilt)
			bStartBuilt = false;
        buildingEnded();
    }

	simulated function timer() {
		global.timer();
		if (isBuilt())
			gotoState('');
	}

    // One can only continue to build if it's not damaged
    simulated function build(float amount, playerreplicationinfo PRI) {
        if (health < default.health)
            return;

        if(PRI!=none && PRI.Owner != none && da_players_PlayerController(PRI.owner) != none) 
		{
            PRI.Score+=(fmin(amount, buildtime-currentbuild)/buildtime)*score/2;
			
			da_SteamStatsAndAchievements(da_players_PlayerController(PRI.owner).SteamStatsAndAchievements).AddScore(((fmin(amount, buildtime-currentbuild)/buildtime)*score/2) , 1);
			
			da_players_PRI(PRI).TurretsBuild += ((buildtime-currentbuild)/buildtime);
			
			if ( da_players_PRI(PRI).TurretsBuild >= 3)
			da_SteamStatsAndAchievements(da_players_PlayerController(PRI.owner).SteamStatsAndAchievements).TurretsBuild();
		}

        currentBuild = FMin(currentBuild + amount, buildTime);
        bBuilding = true;
		bDeconstructing = false;
		buildCount = 0;
        if (currentBuild >= buildTime && ROLE == ROLE_Authority)
            gotoState('');
    }

	simulated function deconstruct(float amount) {
		if (Controller != none && isHumanControlled())
			return;
		currentBuild = FMax(currentBuild - amount, 0);
		bBuilt = false;
		bBuilding = true;
		bDeconstructing = true;
		buildCount = 0;

		if(damagefx!=none)
		    damagefx.Kill();

        if (ROLE == ROLE_Authority && isDeconstructed())
            destroy();
	}

	simulated function StunTurret(float Amount);
}

simulated function updateBuildProgress() {
	local vector loc;
	local rotator rot;

	IdleDestroyTime=level.timeseconds+MaxIdleTime;

	if (frand() < 0.3) {
		randomPlace(loc, rot);
		spawn(BuildFX,,,loc, rot);
	}
	if (frand() < 0.2)
		playWorkSound();

	updateShader(self, currentBuild * 200 / buildTime + 20);
	updateShader(turretBase, currentBuild * 200 / buildTime + 20);
	updateShader(turretSwivel, currentBuild * 200 / buildTime + 20);
}

simulated function buildingEnded() {
	local Controller newController;

	bNonHumanControl = default.bNonHumanControl;
	bAutoTurret = default.bAutoTurret;

    AmbientSound=default.AmbientSound;
    if(currentBuild>0)
        PlaySound(StartupSound,SLOT_None,2,,200);

	if ( Role == Role_Authority )
    {
        if ( bAutoTurret && (Controller == None) && (AutoTurretControllerClass != None) )
        {
            NewController = spawn(AutoTurretControllerClass);
            if ( NewController != None )
                NewController.Possess(self);
        }
        if ( !bAutoTurret && !bNonHumanControl && IndependentVehicle() )
            Level.Game.RegisterVehicle(self);
    }

	setSkins();
}

simulated function repair(int amount, playerreplicationinfo PRI) {
	if (health < default.health) {
	    if(PRI!=none)
            PRI.Score+=(fmin(amount, default.health-health)/default.health)*score/2;

		health = min(health + amount, default.health);
		bRepairing = true;
	}
}

simulated function updateRepairProgress() {
	local vector loc;
	local rotator rot;

	IdleDestroyTime=level.timeseconds+MaxIdleTime;

	if (frand() < 0.4) {
		randomPlace(loc, rot);
		spawn(repairFX,,,loc, rot);
	}
	if (frand() < 0.2)
		playWorkSound();
}

simulated function deconstruct(float amount) {
	if (Controller != none && isHumanControlled())
		return ;
	currentBuild = FMax(currentBuild - amount, 0);
	bBuilt = false;
	bBuilding = true;
	bDeconstructing = true;
	if (ROLE == ROLE_Authority && isDeconstructed()) {
		class'da_map_BuildBeacon'.static.decreaseRatingAt(self);
		destroy();
	}
}

simulated function playWorkSound() {
	if (frand() < 0.333)
		playSound(sound'DA2_Various.Bzzzt1', SLOT_Interact, 1);
	else if (frand() < 0.5)
		playSound(sound'DA2_Various.Bzzzt2', SLOT_Interact, 1);
	else
		playSound(sound'DA2_Various.Bzzzt3', SLOT_Interact, 1);
}

simulated function timer() {
    local Controller C;

    if((controller!=none && playercontroller(controller)!=none) ||
      (weapon!=none && weapon.IsFiring()))
        IdleDestroyTime=level.timeseconds+MaxIdleTime;
	else if(MaxIdleTime>0 && level.TimeSeconds>IdleDestroyTime)
	    Died(none, none, Location);

    if (bDeconstructing && !isInState('Building')) {
		buildingStarted();
		gotoState('Building');
	}

	if (bBuilding) {
		buildCount = min(buildCount + 1, 100);
		if (buildCount > 10 && ROLE == ROLE_Authority) {
			bBuilding = false;
			bDeconstructing = false;
			buildCount = 0;
		} else
			updateBuildProgress();
	} else
		buildCount = 0;
	if (bRepairing) {
		repairCount = min(repairCount + 1, 100);
		if (repairCount > 10 && ROLE == ROLE_Authority) {
			bRepairing = false;
			repairCount = 0;
		} else
			updateRepairProgress();
	} else
		repairCount = 0;

    //Execute enemy Turret AI to shoot at me if they can
	if(frand()<0.5)
        for (C = Level.ControllerList; C != None; C = C.NextController)
            if(da_turrets_TurretController(C)!=None && da_Turrets_AVeRTurret(C.Pawn)!=None
                && C.GetTeamNum()!=Team && !C.Pawn.IsFiring() && C.Pawn.CanAttack(self)) {
			        C.Focus = self;
			        C.Target = self;
			        if ( !C.IsInState('Engaged')) ;
     			        C.GotoState('Engaged');
        }

	super.timer();
}


//DEATH+DAMAGE------------------------------------------------------------------
function TakeDamage( int Damage, Pawn instigatedBy, Vector hitlocation, Vector momentum, class<DamageType> damageType, optional int HitIndex) {
    local playerreplicationinfo PRI;
    local float tmp;

    if(damage<=0 || (da_turrets_TurretController(controller)!=none && instigatedby==self))
        return;

    tmp=health;

    if(damagefx==none && bBuilt)
    {
        damagefx=spawn(damagefxclass, self);
        damagefx.setbase(self);
        damagefx.remoteRole = ROLE_SimulatedProxy;
    }

    if (damageType == class'da_damtypes_EMPGrenade')
       StunTurret(damage/17); //Max damage per EMP-Nade is 200 ~= 13 seconds (13)

    if(health-damage<=0) instigator=instigatedby;

	super.takeDamage(damage, instigatedBy, hitlocation, momentum, damageType);

    if(health<default.Health*0.2 && health>0 && (level.timeSeconds-lastWarningTime)>warningDelay) {
		lastWarningTime = level.TimeSeconds;
		playDamageWarning();
	}

	if(instigatedBy==none || Level.NetMode==NM_Client)
		return;

	PRI=instigatedby.PlayerReplicationInfo;
    if(PRI!=none && PRI.Team != none) {
        if(PRI.Team.TeamIndex!=team)
		{
            PRI.Score+=Score*(tmp-fmax(0,health))/default.health;
			
			if (damageType == class'da_damtypes_EMPGrenade' && da_players_PlayerController(PRI.owner) != none)
				da_SteamStatsAndAchievements(da_players_PlayerController(PRI.owner).SteamStatsAndAchievements).StunTurret();
		}
        else PRI.Score-=Score*(tmp-fmax(0,health))/default.health;
    }
}

simulated function StunTurret(float Amount)
{
     if(amount<1)
         return;

     StunTime=fmax(level.timeseconds+3, StunTime)+Amount;

     if(!isInState('Stunned'))
        gotoState('Stunned');
}

state Stunned {
    ignores ClientKDriverEnter;

    simulated function repair(int amount, playerreplicationinfo PRI);
    simulated function deconstruct(float amount);
    simulated function build(float amount, playerreplicationinfo PRI);
    function playDamageWarning();

    function BeginState() {
        if(PlayerController(controller)!=none)
            KDriverLeave(true);
        if(da_turrets_TurretController(controller)!=none && ROLE==ROLE_Authority)
            controller.destroy();

        bNonHumanControl=true;
	    bAutoTurret=false;

        PlaySound(ShutdownSound,SLOT_None,2,,200);
		AmbientSound=StunnedSound;
    }

    simulated function timer() {
        if(level.TimeSeconds>StunTime)
            gotoState('');
    }

    function endState() {
        AmbientSound=default.AmbientSound;
        BuildingEnded();
    }
}

function playDamageWarning()
{
    PlaySound(sound'DA2_Various.TurretAlarm',SLOT_None,6,,400);
}

simulated function Explode( vector HitLocation, vector HitNormal )
{
	local rotator rot;

	rot.pitch=16384;

    if ( Level.NetMode != NM_DedicatedServer )
		/*ExplosionEffect = */Spawn(class'da2.da_effects_turretexplosion', Self,, HitLocation, rot);

        PlaySound(ExplosionSounds[rand(3)],SLOT_None,15,,800,0.9+frand()*0.2);
        PlaySound(ExplosionSoundFar,SLOT_None,5,,4000,0.9+frand()*0.2);

        Team=255;   //omfg hack for FF - aBs

		if (ROLE == ROLE_Authority && isBuilt()) {
			HurtRadius(500, 700, class'da_damtypes_TurretExp', 25000, HitLocation);
		}

    if ( TurretBase != None )
		TurretBase.Destroy();

	if ( TurretSwivel != None )
		TurretSwivel.Destroy();
}

simulated function Destroyed()
{
    if(damagefx!=none) damagefx.Kill();
	Super.Destroyed();
}


//CONTROL-----------------------------------------------------------------------
function Vehicle FindEntryVehicle(Pawn P)
{
    if ( AIController(P.Controller) != None )
        return self;
    if (VSize(P.Location - Location) < EntryRadius)
        return self;
    return None;
}

function bool TryToDrive(Pawn P) {
	local da_players_ClassPlayer dap;
	dap = da_players_ClassPlayer(P);
	if (dap.resolveClassInfo() != none &&
		dap.resolveClassInfo().bCanUseTurrets) {
			return super.TryToDrive(P);
	}
	return false;
}

/*function PossessedBy(Controller C)
{
    super(Vehicle).PossessedBy( C );

    NetUpdateTime = Level.TimeSeconds - 1;
    bStasis = false;
    C.Pawn  = Self;
    AddDefaultInventory();
    if ( Weapon != None )
    {
        Weapon.NetUpdateTime = Level.TimeSeconds - 1;
        Weapon.Instigator = Self;
        PendingWeapon = None;
        Weapon.BringUp();
    }
}*/

/*simulated function ClientKDriverEnter( PlayerController PC )
{
    //Disallow operating a stunned turret
	if (isInState('Stunned'))
	   return;

	super.ClientKDriverEnter( PC );
}*/


//INFOS-------------------------------------------------------------------------
//simulated function DrawEnemyName( Canvas C, HUDCDeathMatch H );

simulated function float getHealthPercentage() {
	return float(health) / default.health;
}

simulated function float getCompletedPercentage() {
    return currentBuild / buildTime;
}

simulated function bool isDeconstructed() {
	return !bBuilt && currentBuild < 0.0001;
}

simulated function array<string> getInfoForMech() {
    local array<string> info;

    info[0]=descriptiveName;
    info[1]="Health:"@health$"/"$default.health;
    if (!isBuilt())
        info[2]="Build Progress:"@int(currentBuild*100.0/buildTime)$"%";
    //class'da_Utilities'.static.format(currentBuild* 100.0 / buildTime, 2)

    return info;
}


//TEXTURES+RENDERING------------------------------------------------------------
simulated function bool DrawCrosshair( Canvas C, out vector ScreenPos )
{
	local vector	HitLocation;
	local float		RatioX, RatioY;
	local float		tileX, tileY;
	local float		SizeX, SizeY, Scale;

	HitLocation = GetCrosshairWorldLocation();
	ScreenPos = C.WorldToScreen( HitLocation );

	SizeX = CrosshairTex.MaterialUSize();
	SizeY = CrosshairTex.MaterialVSize();

	RatioX = C.SizeX / 640.0;
	RatioY = C.SizeY / 480.0;

	tileX = CrosshairScale * SizeX * RatioX;
	tileY = CrosshairScale * SizeY * RatioX;

	// Clip Crosshair position
	ClipScreenCoords( C, ScreenPos.X, ScreenPos.Y, TileX*0.5, TileY*0.5 );

	C.Style = ERenderStyle.STY_Alpha;
	C.DrawColor = class'Canvas'.static.MakeColor(255, 255, 255, 255);
	C.SetPos(ScreenPos.X - tileX*0.5, ScreenPos.Y - tileY*0.5);
	C.DrawTile( CrosshairTex, tileX, tileY, 0.0, 0.0, SizeX, SizeY);

    if(PlayerController(Controller)==none || PlayerController(Controller).bBehindView)
        return true;

    C.SetPos(0,0);
    C.SetDrawColor(255,244,0);
    C.DrawTile( finalblend'DA2Weapons.ZoomFuzz', C.SizeX, C.SizeY, 0, 0, 256, 256 );

    C.SetDrawColor(0,0,0);
    Scale=C.ClipX/1024;

    // Draw the 4 corners
    // Need to replace this with a non UT texture - Ramm
/*	C.SetPos(0,0);
	C.DrawTile(texture'NewSniperRifle.COGAssaultZoomedCrosshair',160*Scale,160*Scale, 0, 274, 159, -158);
	C.SetPos(C.ClipX-160*Scale,0);
	C.DrawTile(texture'NewSniperRifle.COGAssaultZoomedCrosshair',160*Scale,160*Scale, 159,274, -159, -158);
	C.SetPos(0,C.ClipY-160*Scale);
	C.DrawTile(texture'NewSniperRifle.COGAssaultZoomedCrosshair',160*Scale,160*Scale, 0,116, 159, 158);
	C.SetPos(C.ClipX-160*Scale,C.ClipY-160*Scale);
	C.DrawTile(texture'NewSniperRifle.COGAssaultZoomedCrosshair',160*Scale,160*Scale, 159, 116, -159, 158);

	// Draw the Horz Borders
	C.SetPos(160*Scale,0);
	C.DrawTile(texture'NewSniperRifle.COGAssaultZoomedCrosshair', C.ClipX-320*Scale, 160*Scale, 284, 512, 32, -160);
	C.SetPos(160*Scale,C.ClipY-160*Scale);
	C.DrawTile(texture'NewSniperRifle.COGAssaultZoomedCrosshair', C.ClipX-320*Scale, 160*Scale, 284, 352, 32, 160);

	// Draw the Vert Borders
	C.SetPos(0,160*Scale);
	C.DrawTile(texture'NewSniperRifle.COGAssaultZoomedCrosshair', 160*Scale, C.ClipY-320*Scale, 0,308, 160,32);
    C.SetPos(C.ClipX-160*Scale,160*Scale);
	C.DrawTile(texture'NewSniperRifle.COGAssaultZoomedCrosshair', 160*Scale, C.ClipY-320*Scale, 160,308, -160,32);
		 */
	return true;
}

/* Clip Screen Coordinates to fit Canvas visible area */
simulated function ClipScreenCoords( Canvas C, out float X, out float Y, optional float XL, optional float YL )
{
	if ( X < XL ) X = XL;
	if ( Y < YL ) Y = YL;
	if ( X > C.ClipX - XL ) X = C.ClipX - XL;
	if ( Y > C.ClipY - YL ) Y = C.ClipY - YL;
}

simulated function bool WeaponHitsCrosshairsHL()
{
	return false;
}

simulated function updateShader(Actor a, float color) {
	local Material m;
	local int i;

	if (a == none)
		return;

	for (i = 0; i < a.skins.length; i++) {
		m = a.skins[i];
		if (m.isa('FinalBlend') && FinalBlend(m).material.isa('OpacityModifier'))
			ConstantColor(OpacityModifier(FinalBlend(m).material).opacity).color.a = currentBuild * 200 / buildTime + 20;
	}
}

simulated function applyShaderChanges(Actor a) {
	local int i;
    local OpacityModifier mod;
	local FinalBlend fb;

	if (a == none)
		return;

    for (i = 0; i < a.skins.length; i++)
        if (a.skins[i].isa('Shader')) {
			fb = new class'FinalBlend';
			fb.zWrite = true;
			fb.FrameBufferBlending=FB_AlphaBlend;
            mod = new class'OpacityModifier';
            mod.material = a.skins[i];
            mod.opacity = new class'ConstantColor';
			fb.material = mod;
            ConstantColor(mod.opacity).color.a = currentBuild * 200 / buildTime + 20;
            a.skins[i] = fb;
        }
}

simulated function setSkin(Actor a, Material m) {
	if (a == none)
		return;

	a.skins[0] = m;
}
simulated function Material getSkinFor(Actor a) {
	return a.default.skins[0];
}

simulated function setSkins() {
	setSkin(self, getSkinFor(self));
	setSkin(turretBase, getSkinFor(turretBase));
	setSkin(turretSwivel, getSkinFor(turretSwivel));
}


//MISCELLANEOUS-----------------------------------------------------------------
simulated function randomPlace(out vector loc, out rotator rot) {
	local float low, high;
	low = location.z - collisionHeight;
	if (turretBase != none)
		low = min(low, turretBase.location.z - turretBase.collisionHeight);
	if (turretSwivel != none)
		low = min(low, turretSwivel.location.z - turretSwivel.collisionHeight);
	high = location.z + collisionHeight;
	if (turretBase != none)
		high = max(low, turretBase.location.z + turretBase.collisionHeight);
	if (turretSwivel != none)
	high = max(low, turretSwivel.location.z + turretSwivel.collisionHeight);
	loc = location + (collisionradius*0.6) * vrand() * vect(1, 1, 0);
	loc.z = (high - low) * frand() + low;

	rot = rotator(loc - turretswivel.location);
}

simulated function UpdateRocketAcceleration(float DeltaTime, float YawChange, float PitchChange) {
    local float newYawAccel;
    local float yaw;
    local Range yc;

    if ( PlayerController(Controller) != None && PlayerController(Controller).bFreeCamera ) {
        super.UpdateRocketAcceleration(deltaTime, yawChange, pitchChange);
        return;
    }

    if (deltaTime > 0.3)
        deltaTime  = 0.3;

    yaw = Rotation.yaw & 65535;
    newYawAccel = RotationInertia*YawAccel + DeltaTime*RotationSpeed*YawChange;
    yaw += newYawAccel;

    yc.min = (OriginalRotation.yaw + rotYawConstraint.min) & 65535;
    yc.max = (OriginalRotation.yaw + rotYawConstraint.max) & 65535;

    if (abs(yc.Max - yc.min) > 0.001) {
        if (yc.Min < yc.Max &&
            (yaw < yc.Min || yaw > yc.Max) ||
            yc.Min > yc.Max &&
            (yaw >= yc.Min && yaw <= yc.Max)) {
            // Calculate new yawChange
            yawAccel = 0;
            if (abs(yaw - yc.min ) <
                abs(yaw - yc.max ))
                yawChange = yc.Min - yaw;
            else
                yawChange = yc.Max - yaw;

            yawChange /= deltaTime * rotationSpeed;
        }
    }
    super.UpdateRocketAcceleration(deltaTime, yawChange, pitchChange);
}

defaultproperties
{
     rotYawConstraint=(Min=49151.000000,Max=16384.000000)
     descriptiveName="DA Turret"
     buildTime=5.000000
     BuildFX=Class'DA2.da_effects_BuildSparks'
     RepairFX=Class'DA2.da_effects_RepairSparks'
     Score=10.000000
     DamageFXClass=Class'DA2.da_effects_TurretDamage'
     DeploySound=Sound'DA2_Various.Misc.TurretDeploy'
     StartUpSound=Sound'DA2_Various.Misc.TurretStartup'
     ShutDownSound=Sound'DA2_Various.Misc.TurretShutdown'
     StunnedSound=Sound'DA2_Various.Misc.TurretStunnedAmb'
     ExplosionSounds(0)=Sound'DA2_Various.explosions.TurretExp1'
     ExplosionSounds(1)=Sound'DA2_Various.explosions.TurretExp2'
     ExplosionSounds(2)=Sound'DA2_Various.explosions.TurretExp3'
     ExplosionSoundFar=Sound'DA2_Various.explosions.TurretExpFar'
     WarningDelay=3.000000
     MaxIdleTime=180.000000
     RotPitchConstraint=(Min=10000.000000,Max=4000.000000)
     bZooming=True
     CrosshairScale=0.400000
     bDrawDriverInTP=True
     bDrawMeshInFP=True
     Team=0
     AutoTurretControllerClass=Class'DA2.da_turrets_TurretController'
     ExitPositions(0)=(X=-100.000000,Z=-50.000000)
     ExitPositions(1)=(Y=100.000000,Z=-50.000000)
     ExitPositions(2)=(Y=-100.000000,Z=-50.000000)
     ExitPositions(3)=(X=100.000000,Z=-50.000000)
     EntryPosition=(Z=-50.000000)
     EntryRadius=160.000000
     DriverDamageMult=0.300000
     Health=100
     AmbientSound=Sound'DA2_Various.Misc.TurretAmb'
     SoundVolume=150
     SoundRadius=100.000000
     bNetNotify=True
}
