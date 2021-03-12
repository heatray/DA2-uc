// =============================================================================
//  DA2.da_players_ClassPlayer:
//  By: aBsOlUt, Dante
// SPECIAL THANKS TO: [FO]Squirrel - Frag Ops for Animation Blending and Idle
// =============================================================================
class da_players_ClassPlayer extends xPawn;

#EXEC OBJ LOAD FILE=DA2_PlayerModels.ukx
#EXEC OBJ LOAD FILE=DA2PlayerSkins.utx
#EXEC OBJ LOAD FILE=DA2_WeaponSounds.uax
#EXEC OBJ LOAD FILE=AMISounds.uax
#EXEC OBJ LOAD FILE=DA2Player.uax
#exec OBJ LOAD FILE=Inf_Player.uax

var sound BuildErrorSound[4];

var class<emitter> BloodClass[5];
var bool bPlayingAction, bAnimChanged;
var Sound SpawnSound;
var float armor;

var sound FootstepSounds[20]; // Indexed by ESurfaceTypes (sorry about the literal).

// Healing
var int healPlayer;
var float lastheal, lastHealAura;
var bool bPlayerIsHealing;

// Fire Related
var bool bAshen; // is our Zed crispy yet?
var class<Emitter> BurnEffect;  // The appearance of the flames we are attaching to our Zed.
var Emitter ItBUURRNNNS;
var int LastBurnDamage; // Record the last amount of Fire damage the pawn suffered.
var int BurnDown ; // Number of times our zombie must suffer Fire Damage.
var bool bBurnified;
var bool bBurnApplied;
var pawn LastDamagedBy,BurnInstigator;

// Stealth
var float curStealth;
// Currently not placed in inventory so players cannot access it while changing weapons
var Weapon mechTool;

var bool bDecapitated, bMaimed;
var InventoryAttachment BackpackAttachment;
var class<InventoryAttachment> BackpackClasses[6];

var Sound BreathingSound;

var bool EnableIncendiaryBullets;

replication {
    reliable if(Role == ROLE_Authority)
        bBurnified;
    reliable if (ROLE == ROLE_Authority && bNetOwner)
        bPlayerIsHealing, mechTool;
    reliable if (ROLE == ROLE_Authority && bNetInitial)
        curStealth;
  reliable if (ROLE < ROLE_Authority)
    build;
}

simulated function StartBurnFX()
{
  if( ItBUURRNNNS==None )
  {
    ItBUURRNNNS = Spawn(BurnEffect);
    ItBUURRNNNS.SetBase(Self);
    ItBUURRNNNS.Emitters[0].SkeletalMeshActor = self;
    ItBUURRNNNS.Emitters[0].UseSkeletalLocationAs = PTSU_SpawnOffset;
  }
  bBurnApplied = True;
}

simulated function StopBurnFX()
{
  RemoveFlamingEffects();
  if( ItBUURRNNNS!=None )
    ItBUURRNNNS.Kill();
  bBurnApplied = False;
}

function TakeFireDamage(int Damage, pawn BInstigator)
{
  if( Damage > 0 )
    {
        TakeDamage(Damage, BInstigator, Location, vect(0,0,0), class'DamTypeBurned');

      if (BurnDown > 0)
      {
        BurnDown --; // Decrement the number of FireDamage calls left before our Zombie is extinguished :)
      }
      if(BurnDown==0)
      {
            bBurnified = false;
      }
  }
  else
  {
        BurnDown = 0;
        bBurnified = false;
  }
}

simulated function RemoveFlamingEffects()
{
    local int i;

    if( Level.NetMode == NM_DedicatedServer )
        return;

    for( i=0; i<Attached.length; i++ )
    {
        if( Attached[i].IsA('xEmitter') && !Attached[i].IsA('BloodJet'))
        {
            xEmitter(Attached[i]).mRegen = false;
        }

         if( Attached[i].IsA('KFMonsterFlame'))
        {
          Attached[i].LifeSpan = 0.1;
        }
    }
}

static function StaticPrecache(LevelInfo L)
{
    L.AddPrecacheMaterial(Material'DA2PlayerSkins.Frontline_Body_grey_damage');
    L.AddPrecacheMaterial(Material'DA2PlayerSkins.Frontline_Head_grey_damage');
    L.AddPrecacheMaterial(Material'DA2PlayerSkins.Frontline_Body_damage');
    L.AddPrecacheMaterial(Material'DA2PlayerSkins.Frontline_Head_damage');
}

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(Material'DA2PlayerSkins.Frontline_Body_grey_damage');
    Level.AddPrecacheMaterial(Material'DA2PlayerSkins.Frontline_Head_grey_damage');
    Level.AddPrecacheMaterial(Material'DA2PlayerSkins.Frontline_Body_damage');
    Level.AddPrecacheMaterial(Material'DA2PlayerSkins.Frontline_Head_damage');

    Super.UpdatePrecacheMaterials();
}

simulated function PossessedBy(Controller C) {
    local int i;

    super.PossessedBy(C);

    if(da_players_playercontroller(c)!=none)
        i=da_players_playercontroller(c).pendingClass;
    else i=da_players_PRI(c.PlayerReplicationInfo).playerClass;

    if(i<6 && BackpackClasses[i]!=none)
        BackpackAttachment=Spawn(BackpackClasses[i]);
    if(BackpackAttachment!=none)
        AttachToBone(BackpackAttachment,'Spine2');
}

// Clean up weapon inventory before level change since certain weapons
// (sniper scopes with 3d scopes) won't get properly garbage collected
// otherwise. This lead to the webadmin and memory leak issues - Ramm
simulated function PreTravelCleanUp()
{
  local Inventory Inv;
  local da_weapons_Reloadable invWeapon;
  local int count;

  count=0;

  log(self$" PreTravelCleanUp()");

  // consider doing a check on count to make sure it doesn't get too high
  // and force Unreal to crash with a run away loop
  for ( Inv=Inventory; Inv!=None; Inv=Inv.Inventory )
  {
    invWeapon = da_weapons_Reloadable(Inv);
    if ( invWeapon != None )
    {
      invWeapon.PreTravelCleanUp();
    }

    count++;

    if( count > 500 )
      break;
  }
}

simulated function Destroyed()
{
    if(BackpackAttachment!=none)
        BackpackAttachment.Destroy();

	if ( ItBUURRNNNS != none )
	{
		ItBUURRNNNS.Emitters[0].SkeletalMeshActor = none;
		ItBUURRNNNS.Destroy();
	}

    super.Destroyed();
}

function botFixes() {
  jumpZ *= 1.35;
}

function int countAmmobox() {
  local da_items_WorldAmmoBox u;
  local int number;
  number = 0;
  foreach DynamicActors(class'da_items_WorldAmmoBox', u)
    if (!u.bStartBuilt && u.Team == playerReplicationInfo.team.teamIndex)
          number++;

  return number;
}

function int countStructures(class<Actor> bClass) {
  local Actor u;
  local int number;
  number = 0;
  foreach childactors(class'Actor', u)
    if (classIsChildOf(u.class, bClass))
      number++;
  return number;
}

function int countTurrets(class<da_turrets_Turret> bClass) {
  local da_turrets_Turret t;
  local int number;

  number = 0;
  foreach dynamicactors(class'da_turrets_turret', t) {
    if (t.mechOwner != none && classIsChildOf(t.class, bClass) && t.team == playerReplicationInfo.team.teamIndex)
      number++;
  }
  return number;
}

function ErrorMsg(int Reason) {
    if(da_players_playercontroller(controller)!=none)
        da_players_Playercontroller(controller).AMIAnnouncement(BuildErrorSound[Reason]);
}

function Actor placeStructure(class<Actor> bClass, optional float hackHeight, optional bool bTestBefore) {
  local vector loc;
  local Actor obj, test;
  local vector lHit, nHit;

  loc = location + vector(rotation) * (bClass.default.collisionRadius + collisionRadius) * 1.5;
  obj = trace(lHit, nHit, loc + vect(0, 0, -10000), loc, true);
    if (obj == none || !obj.bWorldGeometry || vsize(lHit - loc) > 300 || (nHit dot vect(0, 0, 1)) < 0.9) {
      ErrorMsg(1);
    return none;
  }

  foreach radiusActors(class'actor', test, 120) {
        if(da_buildable_Useable(test)!=none || da_turrets_Turret(test)!=none) {
            ErrorMsg(1);
            return none;
        }
    }

    lHit.Z += bClass.default.collisionHeight + hackHeight;
  if (bTestBefore)
    if (testBuildLocation(lHit, bClass.default.collisionRadius * 1.5, bClass.default.collisionHeight)) {
      obj = spawn(bClass, self,,lHit, rotation);
    }
  else obj = spawn(bClass, self,,lHit, rotation);

  return obj;
}

function bool testBuildLocation(vector loc, optional float radius, optional float height) {
  local Actor obj;
  local vector lHit, nHit, X, Y, Z;

  getAxes(rotation, X, Y, Z);

  obj = trace(lHit, nHit, loc + Y * radius - X * radius, location, true);
  if (obj != none && !obj.bWorldGeometry)
    return false;
  obj = trace(lHit, nHit, loc + Y * radius, location, true);
  if (obj != none && !obj.bWorldGeometry)
    return false;
  obj = trace(lHit, nHit, loc + Y * radius + X * radius, location, true);
  if (obj != none && !obj.bWorldGeometry)
    return false;
  return true;
}

function bool AllowAdditional(Class c) {
  local da_players_TeamConfig cfg;

  if (mechTool == none)  // Only mechs can build stuff
    return false;

    cfg = da_game_ReplicationInfo(level.GRI).teamConfig[PlayerReplicationInfo.team.teamindex];

  switch (c) {
    case class'da_items_WorldAmmoBox':
      return countStructures(class'da_items_WorldAmmoBox')<cfg.numAmmoboxes;
    case class'da_turrets_AVeRTurret':
      return countTurrets(class'da_turrets_AVeRTurret')<cfg.numAVeRs;
    case class'da_turrets_CrushTurret':
      return countTurrets(class'da_turrets_CrushTurret')<cfg.numCrushers;
    case class'da_turrets_DFATurret':
      return countTurrets(class'da_turrets_DFATurret')<cfg.numDFAs;
    default:
      return false;
  }
}

exec function Actor build(name structure) {
  local da_players_TeamConfig cfg;
  local Volume v;
  local da_turrets_Turret t;
  local da_items_WorldAmmobox ab;

  if (mechTool == none)  // Only mechs can build stuff
      return none;

  foreach touchingActors(class'Volume', v)
       if ( structure!='Ammobox' && da_ConstrainedVolume(v).bNoTurrets || structure=='Ammobox' && da_ConstrainedVolume(v).bNoAmmoboxes ) 
	   {
			ErrorMsg(3);
			return none;
       } 
	   
	   else if (LadderVolume(v) != none) 
	   {
       // TODO: Create a new sound since players can't build on ladders
			ErrorMsg(1);
			return none;
       }

    cfg = da_game_ReplicationInfo(level.GRI).teamConfig[PlayerReplicationInfo.team.teamindex];

    if (structure=='Ammobox' && countAmmobox() < cfg.numAmmoboxes) {
    ab = da_items_WorldAmmobox(placeStructure(class'da_items_WorldAmmoBox',0, true));
    ab.Team = playerReplicationInfo.team.teamIndex;
    return ab;
  }

  if (structure=='aver' && countTurrets(class'da_turrets_AVeRTurret') < cfg.numAVeRs) {
    t =  da_turrets_Turret(placeStructure(class'da_turrets_AVeRTurret', 90, true));
    t.setMechOwner(controller);
    return t;
    }
    if (structure=='crusher' && countTurrets(class'da_turrets_CrushTurret') < cfg.numCrushers) {
    t =  da_turrets_Turret(placeStructure(class'da_turrets_CrushTurret', 50, true));
    t.setMechOwner(controller);
    return t;
    }
    if (structure=='dfaturret' && countTurrets(class'da_turrets_DFATurret') < cfg.numDFAs) {
    t = da_turrets_Turret(placeStructure(class'da_turrets_DFATurret', 64, true));
    t.setMechOwner(controller);
    return t;
    }

    //warn(self@"Tried to build"@structure);
    ErrorMsg(2);
  return none;
}

simulated function array<string> getInfo() {
    local da_players_PRI daPRI;
    local array<string> info;
    local string classname;
    local float Amax, Avalue;

	if (da_players_PRI(PlayerReplicationInfo) != none && PlayerReplicationInfo != none)
	{
		daPRI = da_players_PRI(PlayerReplicationInfo);
	
		className = da_game_ReplicationInfo(level.GRI).teamConfig[PlayerReplicationInfo.team.teamindex].classSet.playerClasses[daPRI.playerClass].name;
	
		aValue = daPRI.weaponInfo.ammo;
		aMax = daPri.weaponInfo.maxAmmo;

		info[0] = daPRI.playerName@"["$className$"]";
		
		info[1] = "Health :"$string(health);
		
		info[2] = "Ammo :"$int(AValue)$"/"$int(AMax);

		return info;
	}
}


simulated function da_players_ClassInfo resolveClassInfo() {
    local da_players_PRI daPRI;
    daPRI = da_players_PRI(PlayerReplicationInfo);
    if (daPRI == none ||
        daPRI.playerClass < 0 ||
        daPRI.Team == none ||
        Level.GRI == none)
        return none;
    return da_game_ReplicationInfo(level.GRI).teamConfig[PlayerReplicationInfo.team.teamindex].classSet.playerClasses[daPRI.playerClass];
}

function Died(Controller Killer, class<DamageType> damageType, vector HitLocation) {
  if (Killer == Controller && defenceAlliance(level.game).suicidePenalty > 0.1) {
    da_players_PRI(playerReplicationInfo).suicidePenalty = defenceAlliance(level.game).suicidePenalty;
    if (killer.isa('playercontroller'))
      playerController(killer).receiveLocalizedMessage(class'da_SuicidePenaltyMessage');
  }

  da_players_PRI(PlayerReplicationInfo).setRespawnTime();
  super.died(killer, damageType, hitLocation);
}

// =====GORE EFFECTS=============================================================
simulated function PlayHit(float Damage, Pawn InstigatedBy, vector HitLocation, class<DamageType> damageType, vector Momentum, optional int HitIndex)
{
    local Vector HitNormal, HitRay;
    local Name HitBone;
    local float HitBoneDist;
    local PlayerController PC;
  local bool bShowEffects, bRecentHit;
  local int BloodType;

  bRecentHit = Level.TimeSeconds - LastPainTime < 0.4;
  super(pawn).PlayHit(Damage,InstigatedBy,HitLocation,DamageType,Momentum);
    if ( Damage <= 0 )
    return;

    PC = PlayerController(Controller);
  bShowEffects = ( (Level.NetMode != NM_Standalone) || (Level.TimeSeconds - LastRenderTime < 2.5)
          || ((InstigatedBy != None) && (PlayerController(InstigatedBy.Controller) != None))
          || (PC != None) );
  if ( !bShowEffects )
    return;

    HitRay = vect(0,0,0);
    if( InstigatedBy != None )
        HitRay = Normal(HitLocation-(InstigatedBy.Location+(vect(0,0,1)*InstigatedBy.EyeHeight)));

    if( DamageType.default.bLocationalHit )
        CalcHitLoc( HitLocation, HitRay, HitBone, HitBoneDist );
    else HitLocation = Location;

  if( InstigatedBy != none )
    HitNormal=Normal(InstigatedBy.Location-HitLocation);
  else HitNormal=Normal(HitLocation-Location);

  if(DamageType.Default.bCausesBlood) {
    //if(class'GameInfo'.static.NoBlood())
    //  BloodType=0;
    if(DamageType.Default.bBulletHit) {
            if(damage>40 || DamageType.Default.bAlwaysSevers)
                BloodType=3;
            else BloodType=2;
        }
        else BloodType=1;

    //Bloodhit
        hitHack(BloodClass[BloodType], HitLocation, Rotator(HitNormal));

        //Bloodloss
        if(frand()*50<damage) {
            if(hitbone!='')
                hitHack(BloodClass[4], HitLocation, Rotator(HitNormal), hitBone, self, true);
            else hitHack(BloodClass[4], HitLocation, Rotator(HitNormal), 'spine', self, true);
        }

        //Bloodsplat
        if(BloodType!=0 && (!bRecentHit || frand()*80<damage))
        hitHack(class'da_effects_BloodSplat', HitLocation, rotator(-HitNormal-vect(0,0,1)));

        //Gibs
        if(health<=0 && !DamageType.default.bNeverSevers && (frand()*120<damage || DamageType.default.bAlwaysSevers))
            if(DamageType.default.bSpecial)
                DismemberLimb('head', 'head', rotator(momentum));
            else if(hitbone=='' || (DamageType.default.bDetonatesGoop&&damage>40) || damage>100) {
                if(frand()<0.4) DismemberLimb('rshoulder', 'rshoulder', rotator(momentum));
                if(frand()<0.4) DismemberLimb('lshoulder', 'lshoulder', rotator(momentum));
                if(frand()<0.4) DismemberLimb('rthigh', 'rthigh', rotator(momentum));
                if(frand()<0.4) DismemberLimb('lthigh', 'lthigh', rotator(momentum));
                if(frand()<0.3) DismemberLimb('Head', 'Head', rotator(momentum));
                if(frand()<0.2) DismemberLimb('Spine', 'Spine', rotator(momentum));
            }
            else DismemberLimb(HitBone, HitBone, rotator(momentum));
    }

    if(bMaimed) {
        if(TeamSkin==0) {
            skins[0]=texture'DA2PlayerSkins.Frontline_Body_damage';
            skins[1]=texture'DA2PlayerSkins.Frontline_Head_damage';
        }
        else {
            skins[0]=texture'DA2PlayerSkins.Frontline_Body_grey_damage';
            skins[1]=texture'DA2PlayerSkins.Frontline_Head_grey_damage';
        }
    }

  //DoDamageFX( HitBone, Damage, DamageType, Rotator(HitNormal) );
  //if (DamageType.default.DamageOverlayMaterial != none && Damage > 0)
  //      SetOverlayMaterial( DamageType.default.DamageOverlayMaterial, DamageType.default.DamageOverlayTime, false );
}

function Actor hitHack(optional class<Actor> s, optional vector loc, optional rotator rot, optional name hideBone, optional xPawn bonePawn, optional bool bAttached) {
  local da_effects_HitHack h;
  h = spawn(class'da_effects_HitHack',,, loc, rot);
  h.bAttached = bAttached;
  h.hideBonePawn = bonePawn;
  h.hideBone = hideBone;
    h.hitClass = s;

  return h;
}

simulated function DismemberLimb( name StartBone, name Bone, rotator dir )
{
    //if( class'GameInfo'.static.UseLowGore() )
    //    return;

    //rotator(normal(getBoneCoords(Bone).origin-location))
    if(startbone==bone) {
        hithack(class'da_effects_gibstumpmedium',,,Bone, self, true);
    hithack(,,,Bone, self);
    }

    if(bone=='head') bDecapitated=true;

    if(bone=='pelvis') {
        hithack(class'da_effects_gibslarge',GetBoneCoords(Bone).origin, dir);
        DismemberLimb(Bone, 'spine', dir);
        DismemberLimb(Bone, 'rthigh', dir);
        DismemberLimb(Bone, 'lthigh', dir);
        bMaimed=true;
    }
    else if(bone=='spine') {
        hithack(class'da_effects_gibslarge',GetBoneCoords(Bone).origin, dir);
        DismemberLimb(Bone, 'rshoulder', dir);
        DismemberLimb(Bone, 'lshoulder', dir);
        DismemberLimb(Bone, 'head', dir);

        if(BackpackAttachment!=none)
            BackpackAttachment.Destroy();
    }
    else if(bone=='rshoulder') {
        hithack(class'da_effects_gibsmedium',GetBoneCoords(Bone).origin, dir);
        DismemberLimb(Bone, 'rfarm', dir);
        DismemberLimb(Bone, 'rhand', dir);
        bMaimed=true;
    }
    else if(bone=='lshoulder') {
        hithack(class'da_effects_gibsmedium',GetBoneCoords(Bone).origin, dir);
        DismemberLimb(Bone, 'lfarm', dir);
        DismemberLimb(Bone, 'lhand', dir);
        bMaimed=true;
    }
    else if(bone=='rthigh') {
        hithack(class'da_effects_gibsmedium',GetBoneCoords(Bone).origin, dir);
        DismemberLimb(Bone, 'rcalf', dir);
        DismemberLimb(Bone, 'rfoot', dir);
        bMaimed=true;
    }
    else if(bone=='lthigh') {
        hithack(class'da_effects_gibsmedium',GetBoneCoords(Bone).origin, dir);
        DismemberLimb(Bone, 'lcalf', dir);
        DismemberLimb(Bone, 'lfoot', dir);
        bMaimed=true;
    }
    else hithack(class'da_effects_gibsmedium', GetBoneCoords(Bone).origin, dir);
}

simulated function HideBone(name boneName)
{
  local int BoneScaleSlot;

    if( boneName == 'lthigh' )
    boneScaleSlot = 1;
  else if ( boneName == 'rthigh' )
    boneScaleSlot = 2;
  else if( boneName == 'rfarm' )
    boneScaleSlot = 3;
  else if ( boneName == 'lfarm' )
    boneScaleSlot = 4;
  else if ( boneName == 'head' )
    boneScaleSlot = 5;
  else if ( boneName == 'spine' )
    boneScaleSlot = 6;
  else boneScaleSlot=rand(100);

    SetBoneScale(BoneScaleSlot, 0.0, BoneName);
}

simulated function StartDeRes() {

 if( Level.NetMode == NM_DedicatedServer )
    return;

  AmbientGlow=0;
  MaxLights=5;

  if( Physics == PHYS_KarmaRagdoll )
  {
    // Remove flames
    RemoveFlamingEffects();
    // Turn off any overlays
    SetOverlayMaterial(None, 0.0f, true);
  }

    bDeRes = true;
  SetCollision(false, false, false);
}

State Dying
{
    simulated function TakeDamage( int Damage, Pawn InstigatedBy, Vector Hitlocation, Vector Momentum, class<DamageType> damageType, optional int HitIndex)
    {
        local vector dir;
      if(Physics!=PHYS_KarmaRagdoll || damage<=0)
       return;

      dir = normal(Location - HitLocation);
      dir *= RagShootStrength * vect(0, 0, -1);
      dir *= damage / 50;
      KAddImpulse(dir, HitLocation);

        PlayHit(Damage,InstigatedBy, hitLocation, damageType, Momentum);

        if((DamageType.Default.DamageOverlayMaterial != None) && (Level.DetailMode != DM_Low) && !Level.bDropDetail )
        SetOverlayMaterial(DamageType.Default.DamageOverlayMaterial, DamageType.default.DamageOverlayTime, true);
    }

    event KVelDropBelow();
}

// =====SOUNDS==================================================================
function PlayTakeHit(vector HitLocation, int Damage, class<DamageType> DamageType)
{
    PlayDirectionalHit(HitLocation);

    if(Level.TimeSeconds-LastPainSound<MinTimeBetweenPainSounds+frand()*0.3 )
        return;

    LastPainSound = Level.TimeSeconds;

    if(HeadVolume.bWaterVolume) {
        if( DamageType.IsA('Drowned') )
            PlaySound( GetSound(EST_Drown), SLOT_Pain,2*TransientSoundVolume );
        else
            PlaySound( GetSound(EST_HitUnderwater), SLOT_Pain,2*TransientSoundVolume );
        return;
    }

    if(damage>50 || health<20)
        PlaySound(sound'DA2Player.BigPain', SLOT_Pain,3.2*TransientSoundVolume,,150);
    else PlaySound(sound'DA2Player.Pain', SLOT_Pain,3*TransientSoundVolume,,150);

      if ( Health > 20 || Health <= 0)
  return;

        PlaySound(BreathingSound, SLOT_Talk, ((50-Health)/5)*TransientSoundVolume,,TransientSoundRadius,, false);

}

function PlayDyingSound()
{
  if(bSkeletized || bDecapitated)
    return;

    if(HeadVolume.bWaterVolume) {
        PlaySound(GetSound(EST_Drown), SLOT_Pain,3*TransientSoundVolume,true,200);
        return;
    }

    if(bMaimed && frand()<0.5)
        PlaySound(sound'DA2Player.BigDeath', SLOT_Pain,4.5*TransientSoundVolume, true,250);
  else PlaySound(sound'DA2Player.Death', SLOT_Pain,3.7*TransientSoundVolume, true,200);
}


function bool DoJump( bool bUpdating )
{
    if ( Super(unrealpawn).DoJump(bUpdating) )
    {
    if ( !bUpdating ) {
        PlaySound(sound'DA2Player.Jump.Jump', SLOT_Pain, 0.5,,100);
      PlaySound(sound'DA2_Various.GearRattling', SLOT_None, FootstepVolume*2.5,,100,0.9+frand()*0.2);
        }
        return true;
    }
    return false;
}

simulated function FootStepping(int Side)
{
  local int SurfaceNum, i;
  local actor A;
  local material FloorMat;
  local vector HL,HN,Start,End,HitLocation,HitNormal;
  local da_players_PRI daPRI;
  daPRI = da_players_PRI(PlayerReplicationInfo);

    SurfaceNum = 0;

    for ( i=0; i<Touching.Length; i++ )
	{
		if ( ((PhysicsVolume(Touching[i]) != None) && PhysicsVolume(Touching[i]).bWaterVolume)
		|| (FluidSurfaceInfo(Touching[i]) != None) )
		{
			//PlaySound(sound'Inf_Player.FootStepWaterDeep', SLOT_Interact, FootstepVolume * 2,, FootStepSoundRadius);
			
		if ( !Level.bDropDetail && (Level.DetailMode != DM_Low) && (Level.NetMode != NM_DedicatedServer)
			&& !Touching[i].TraceThisActor(HitLocation, HitNormal,Location - CollisionHeight*vect(0,0,1.1), Location) )
			Spawn(class'WaterRingEmitter',,,HitLocation,rot(16384,0,0));
		return;
		}
	}
		

  if ( bIsCrouched || bIsWalking )
    return;

  if ( (Base!=None) && (!Base.IsA('LevelInfo')) && (Base.SurfaceType!=0) )
  {
    SurfaceNum = Base.SurfaceType;
  }
  else
  {
    Start = Location - Vect(0,0,1)*CollisionHeight;
    End = Start - Vect(0,0,16);
    A = Trace(hl,hn,End,Start,false,,FloorMat);
    if (FloorMat !=None)
      SurfaceNum = FloorMat.SurfaceType;
  }
  PlaySound(FootstepSounds[SurfaceNum], SLOT_Interact, FootstepVolume,,200,0.9+frand()*0.2);
  PlaySound(sound'DA2_Various.GearRattling', SLOT_None, FootstepVolume*0.8,,100,0.9+frand()*0.2);
}

// =====ANIIMATIONS=============================================================
simulated function AssignInitialPose()
{
    TweenAnim(MovementAnims[0],0.0);
  AnimBlendParams(1, 1.0, 0.2, 0.2, 'Spine1');
    BoneRefresh();
}

simulated function SetWeaponAttachment(WeaponAttachment NewAtt) {
  super.setWeaponAttachment(newAtt);
    IdleWeaponAnim=da_weapons_weaponAttachment(WeaponAttachment).PlayerIdleAnim;
}

simulated function name GetAnimSeq()   //Get channel 1
{
  local name anim;
  local float frame, rate;

  GetAnimParams(1, anim, frame, rate);
  return anim;
}

simulated event SetAnimAction(name NewAction)
{
  local string cAnim;
    if (!bWaitForAnim)
    {
      AnimAction = NewAction;
        bPlayingAction = true;

        if ( ((Physics == PHYS_None)|| ((Level.Game != None) && Level.Game.IsInState('MatchOver')))
        && (DrivenVehicle == None) )
        {
            PlayAnim(AnimAction,,0.1);
      AnimBlendToAlpha(1,0.0,0.05);
        }
        else if ( (DrivenVehicle != None) || (Physics == PHYS_Falling) || ((Physics == PHYS_Walking) && (Velocity.Z != 0)) )
    {
      if ( CheckTauntValid(AnimAction) )
      {
        if (FireState == FS_None || FireState == FS_Ready)
        {
          AnimBlendParams(1, 1.0, 0.0, 0.2, FireRootBone);
          PlayAnim(NewAction,, 0.1, 1);
          FireState = FS_Ready;
        }
      }
      else if ( PlayAnim(AnimAction) )
      {
        if ( Physics != PHYS_None )
        {
          bWaitForAnim = false;
        }
      }

      else
        AnimAction = '';
    } else {
      cAnim = string(newAction);
      if (left(cAnim, 6) ~= "Reload" || left(cAnim, 5) ~= "Melee" || left(cAnim, 5) ~= "Throw") {
             AnimBlendParams(1, 1.0, 0.0, 0.2, FireRootBone);
             PlayAnim(AnimAction,, 0.0,1);
      }
    }

         bPlayingAction = false;
      }
}

simulated function PlayerFire(bool bLoopFire)
{
    local name FireAnim;
    local da_weapons_weaponAttachment dww;

    dww=da_weapons_weaponAttachment(WeaponAttachment);

    if (Physics == PHYS_Swimming || dww == none)
        return;

     FireAnim=dww.PlayerFireAnim;

     AnimBlendParams(1, 1.0, 0.0, 0.2, FireRootBone);

     if (bLoopFire)
     {
        LoopAnim(FireAnim,, 0.0, 1);
        FireState = FS_Looping;
     }
     else
     {
       PlayAnim(FireAnim,, 0.0,1);
       FireState = FS_PlayOnce;
     }

     IdleTime = Level.TimeSeconds;
}

simulated function PlayerReload()
{
local da_weapons_weaponAttachment dww;
local name ReloadAnim;

  dww=da_weapons_weaponAttachment(WeaponAttachment);
  if (dww == none)
    return;

  ReloadAnim=dww.PlayerReloadAnim;

  if (ReloadAnim != '')
    setAnimAction(reloadAnim);
}

simulated function PlayerMelee()
{
local da_weapons_weaponAttachment dww;
local name MeleeAnim;

  dww=da_weapons_weaponAttachment(WeaponAttachment);
  if (dww == none)
    return;
  MeleeAnim=dww.PlayerMeleeAnim;

  if (MeleeAnim != '')
    SetAnimAction(MeleeAnim);
//    if (Instigator != none && Instigator.Physics != PHYS_Falling)
//        Instigator.AddVelocity(vect(445,0,50) >> Instigator.Rotation);
}

simulated function PlayerThrowNade()
{
	if (da_weapons_Reloadable(weapon).isWeaponReady())
		SetAnimAction('Throw_Grenade');
}

simulated function Tick(float delta)
{
  local name CurAnimName;
    local da_players_ClassPlayer cp;
    local da_players_ClassInfo cinf;
    local controller c;
    local int i;
    local int stealthDegree;
	local da_players_PRI daPRI;
	local da_players_PlayerController pc;

    cinf = resolveClassInfo();
	
	if (da_players_PRI(PlayerReplicationInfo) != None)
	{
		daPRI = da_players_PRI(PlayerReplicationInfo);
		pc = da_players_PlayerController(daPRI.owner);    
	}	

  if (level.NetMode != NM_DEDICATEDSERVER)
  {
    if(bBurnified && !bBurnApplied && Health>0)
    {
      if ( !bGibbed )
      {
        StartBurnFX();
      }
    }
    else if(!bBurnified && bBurnApplied)
      StopBurnFX();

          else if(Health<=0){
      StopBurnFX();
      RemoveFlamingEffects();
      }
  }

    //LEVI - force walking while zooming
    if(PlayerController(Controller)!=none && !bIsWalking)
        bIsWalking=PlayerController(Controller).DesiredFOV!=PlayerController(Controller).DefaultFOV;

    if (cinf != none && cinf.bStealth) {
        stealthDegree = Min(200 * vsize(velocity) / GroundSpeed, 200) + 30;
        if (Health <= 0)
            stealthDegree = 0;
        curStealth += FClamp(stealthDegree - curStealth, -100, 75) * delta;
        Visibility = curStealth / 25;
        for (i = 0; i < Skins.length; i++) {
            if (skins[i].isa('FinalBlend') && FinalBlend(skins[i]).material.isa('OpacityModifier')) {
                ConstantColor(OpacityModifier(FinalBlend(skins[i]).material).Opacity).Color.a = curStealth;
            }
        }
    }

    if (ROLE == ROLE_Authority && cinf != none && cinf.auraHealPerSec > 0 && Level.TimeSeconds - lastHealAura >= 1) {
        lastHealAura = level.TimeSeconds;
        for(C=Level.ControllerList; C!=None; C=C.NextController) {
            if(c.pawn==none || da_players_ClassPlayer(c.pawn)==none || vsize(c.pawn.location-location)>cinf.auraHealRadius)
                continue;	
            cp=da_players_ClassPlayer(c.pawn);		
            if (cp.PlayerReplicationInfo != none && cp.PlayerReplicationInfo.Team != none &&
                cp.PlayerReplicationInfo.team.TeamIndex == PlayerReplicationInfo.Team.TeamIndex && cp.Health > 0) {
                cp.bPlayerIsHealing = true;
				
                if(cp!=self) {
                    cp.healPlayer = fmax(cp.healPlayer, cinf.auraHealPerSec);
                    playerreplicationinfo.Score+=fmin(cinf.auraHealPerSec, da_players_PRI(c.PlayerReplicationInfo).ChosenHealth-cp.health)/20;
					
					if ( da_players_PlayerController(cp.Controller) != none && cp.IsHumanControlled() && cp.Health < 100 )
					{
						da_players_PlayerController(cp.Controller).CheckForHint(18);
					}
					
					if ( pc != none && (cp.health < da_players_PRI(c.PlayerReplicationInfo).ChosenHealth))
					{ 
						pc.CheckForHint(19);
					}
					
					if(Owner != none && PlayerController(Owner) != None)
					{
						da_SteamStatsAndAchievements(pc.SteamStatsAndAchievements).AddScore(fmin(cinf.auraHealPerSec, da_players_PRI(c.PlayerReplicationInfo).ChosenHealth-cp.health)/20 , 2);
					
						if (( da_players_PRI(c.PlayerReplicationInfo).ChosenHealth-cp.health ) > 10 )
							da_players_PRI(PlayerController(Owner).PlayerReplicationInfo).MedicHealed += 10;
						else da_players_PRI(PlayerController(Owner).PlayerReplicationInfo).MedicHealed += (da_players_PRI(c.PlayerReplicationInfo).ChosenHealth-cp.health);
					
						//log("Medic Healed: "@da_players_PRI(PlayerController(Owner).PlayerReplicationInfo).MedicHealed);
					
						if (da_players_PRI(PlayerController(Owner).PlayerReplicationInfo).MedicHealed >= 500)
						da_SteamStatsAndAchievements(pc.SteamStatsAndAchievements).MedicHealing();
					}
                }
                else 
				{
					cp.healPlayer = fmax(cp.healPlayer, cinf.auraHealPerSec/5);
				}
            }
        }
    }

    if (ROLE == ROLE_Authority && bPlayerIsHealing && level.TimeSeconds - lastheal >= 1) {
        if (healPlayer == 0)
            bPlayerisHealing = false;
        else {
            lastheal = level.TimeSeconds;
            health = fmin(health + healPlayer, daPRI.ChosenHealth);
            healPlayer = 0;
        }
    }

  Super.Tick(delta);
  if (Health <= 0 || Physics == PHYS_KarmaRagdoll || bTearOff || !bPhysicsAnimUpdate)
    return;

  // ensure that the animations always play
  CurAnimName = GetAnimSeq();
  if (!bAnimChanged && !bPlayingAction && (CurAnimName == '' || CurAnimName == MovementAnims[0] || CurAnimName == MovementAnims[1] || CurAnimName == MovementAnims[2] || CurAnimName == MovementAnims[3]))
  {
    AnimBlendParams(1, 1.0, 0.0, 0.2, FireRootBone);
    LoopAnim(IdleWeaponAnim,, 0.0, 1);
  }
}

simulated function AnimEnd(int Channel)
{
  local bool bWasFiring;

  bAnimChanged = true;

  if (Channel == 1)
  {
    if (FireState == FS_Ready)
    {
      FireState = FS_None;
    }
    else if (FireState == FS_PlayOnce)
    {
      FireState = FS_Ready;
      IdleTime = Level.TimeSeconds;
      bWasFiring = true;
    }

    // smooth certain anims
    if (bPlayingAction || bWasFiring)
    {
      bPlayingAction = false;
      LoopAnim(IdleWeaponAnim,, 0.12, 1);
    }
    else
    {
      // experiment with the 0.9 and 0.2 settings.
      // 0.2 is how much to blend between the old upper
      // body anim and the new one.
      // 0.9 is how much to blend between the upper body
      // lower body.
      AnimBlendParams(1, 1.0, 0.0, 0.2, FireRootBone);
      LoopAnim(IdleWeaponAnim,, 0.0, 1);
      bPlayingAction = false;
    }
  }
  else if (bKeepTaunting && (Channel == 0))
    PlayVictoryAnimation();

  bAnimChanged = false;
}


//No Directional HIT Anims in DA2 Player Models
simulated function PlayDirectionalHit(Vector HitLoc);

//No Directional DEATH Anims in DA2 Player Models
simulated function PlayDirectionalDeath(Vector HitLoc);

//No victory animations for now.
function PlayVictoryAnimation();

//No weapon_switch for DA2 either.
function PlayWeaponSwitch(Weapon NewWeapon);
// ======ANIMATIONS END=========================================================


// ======ACTIONS START==========================================================
function PlayTeleportEffect( bool bOut, bool bSound)
{
         PlaySound(SpawnSound);
}

// DA players can't dodge :|
// =============================================================================
function bool Dodge(eDoubleClickDir DoubleClickMove) {
  return false;
}

function bool PerformDodge(eDoubleClickDir DoubleClickMove, vector Dir, vector Cross) {
    return false;
}

// DA players can't also double jump :\
// =============================================================================
function bool CanDoubleJump(){
  return false;
}
// ======ACTIONS END============================================================

function float GetExposureTo(vector TestLocation)
{
  local int i;
  local float PercentExposed;

  for(i=0; i<Hitpoints.Length; i++)
  {
    if( i == 0 )
    {
      if( FastTrace(GetBoneCoords(Hitpoints[i].PointBone).Origin,TestLocation))
      {
        PercentExposed += 0.4;
      }
    }
    else if ( i == 1)
    {
      if( FastTrace(GetBoneCoords(Hitpoints[i].PointBone).Origin,TestLocation))
      {
        PercentExposed += 0.3;
      }
    }
    else if ( i == 13)
    {
      if( FastTrace(GetBoneCoords(Hitpoints[i].PointBone).Origin,TestLocation))
      {
        PercentExposed += 0.15;
      }
    }
    else if ( i == 14)
    {
      if( FastTrace(GetBoneCoords(Hitpoints[i].PointBone).Origin,TestLocation))
      {
        PercentExposed += 0.15;
      }
    }
  }

  return PercentExposed;
}

//Hacked
function Sound GetSound(xPawnSoundGroup.ESoundType soundType)
{
    return none;
}

simulated exec function ROIronSights()
{
	if(Weapon != none)
	{
		Weapon.ROIronSights();
	}
}

//***************************************
// Vehicle driving
// StartDriving() and StopDriving() also called on client
// on transitions of bIsDriving setting

simulated event StartDriving(Vehicle V)
{
	DrivenVehicle = V;
	NetUpdateTime = Level.TimeSeconds - 1;
    AmbientSound = None;
    StopWeaponFiring();
	DeactivateSpawnProtection();

	// Move the driver into position, and attach to car.
	ShouldCrouch(false);
	bIgnoreForces = true;
	Velocity = vect(0,0,0);
	Acceleration = vect(0,0,0);
	bCanTeleport = false;

	if ( !V.bRemoteControlled || V.bHideRemoteDriver )
    {
		SetCollision( True, True, True);
		bCollideWorld = true;
		//V.AttachDriver( Self );
		if ( V.bDrawDriverinTP )
			CullDistance = 5000;
		else
		   	bHidden = true;
    }

	// set animation
	bPhysicsAnimUpdate = false;
	bWaitForAnim = false;
	if ( !V.bHideRemoteDriver && V.bDrawDriverinTP )
	{
		LoopAnim('Idle_Rest');
		SetAnimFrame(0.5);
		SmoothViewYaw = Rotation.Yaw;
		SetTwistLook(0,0);
	}
	else if ( !V.bRemoteControlled )
	{
		LoopAnim('Idle_Rest');
	}
}

defaultproperties
{
     BuildErrorSound(1)=Sound'AMISounds.Player.NotEnoughSpace'
     BuildErrorSound(2)=Sound'AMISounds.Player.BuildLimitReached'
     BuildErrorSound(3)=Sound'AMISounds.Player.TurretsDisallowed'
     bloodClass(1)=Class'DA2.da_effects_BloodPuff'
     bloodClass(2)=Class'DA2.da_effects_BloodSpray'
     bloodClass(3)=Class'DA2.da_effects_BloodJet'
     bloodClass(4)=Class'DA2.da_effects_BloodLoss'
     SpawnSound=Sound'DA2_WeaponSounds.Misc.Human_Spawn'
     FootstepSounds(0)=SoundGroup'Inf_Player.footsteps.FootstepDirt'
     FootstepSounds(1)=SoundGroup'Inf_Player.footsteps.FootstepGravel'
     FootstepSounds(2)=SoundGroup'Inf_Player.footsteps.FootstepDirt'
     FootstepSounds(3)=SoundGroup'Inf_Player.footsteps.FootstepMetal'
     FootstepSounds(4)=SoundGroup'Inf_Player.footsteps.FootstepWoodenfloor'
     FootstepSounds(5)=SoundGroup'Inf_Player.footsteps.FootstepGrass'
     FootstepSounds(6)=SoundGroup'Inf_Player.footsteps.FootstepDirt'
     FootstepSounds(7)=SoundGroup'Inf_Player.footsteps.FootstepSnowRough'
     FootstepSounds(8)=SoundGroup'Inf_Player.footsteps.FootstepSnowHard'
     FootstepSounds(9)=SoundGroup'Inf_Player.footsteps.FootstepWaterShallow'
     FootstepSounds(10)=SoundGroup'Inf_Player.footsteps.FootstepGravel'
     FootstepSounds(11)=SoundGroup'Inf_Player.footsteps.FootstepGravel'
     FootstepSounds(12)=SoundGroup'Inf_Player.footsteps.FootstepAsphalt'
     FootstepSounds(13)=SoundGroup'Inf_Player.footsteps.FootstepWoodenfloor'
     FootstepSounds(14)=SoundGroup'Inf_Player.footsteps.FootstepMud'
     FootstepSounds(15)=SoundGroup'Inf_Player.footsteps.FootstepMetal'
     FootstepSounds(16)=SoundGroup'Inf_Player.footsteps.FootstepAsphalt_P'
     FootstepSounds(17)=SoundGroup'Inf_Player.footsteps.FootstepDirt'
     FootstepSounds(18)=SoundGroup'Inf_Player.footsteps.FootstepDirt'
     FootstepSounds(19)=SoundGroup'Inf_Player.footsteps.FootstepDirt'
     BurnEffect=Class'KFMod.KFMonsterFlame'
     curStealth=255.000000
     BackpackClasses(1)=Class'DA2.da_players_MechBackpack'
     BackpackClasses(2)=Class'DA2.da_players_MedicBackpack'
     BreathingSound=Sound'KFPlayerSound.Malebreath'
     bCanDodgeDoubleJump=False
     Species=Class'ROEngine.ROSPECIES_Human'
     FootstepVolume=1.100000
     MinTimeBetweenPainSounds=0.300000
     FireRootBone="spine"
     DeResTime=0.000000
     RagdollLifeSpan=15.000000
     RagInvInertia=2.200000
     RagDeathVel=75.000000
     RagShootStrength=6000.000000
     RagSpinScale=4.500000
     RagDeathUpKick=100.000000
     RagImpactSounds(0)=SoundGroup'KF_PlayerGlobalSnd.Player_BodyImpact'
     bCanDoubleJump=False
     bCanWallDodge=False
     bCanPickupInventory=False
     bNoTeamBeacon=True
     bScriptPostRender=True
     GroundSpeed=275.000000
     WaterSpeed=180.000000
     AirSpeed=25.000000
     AccelRate=700.000000
     JumpZ=298.000000
     AirControl=0.000000
     ControllerClass=Class'DA2.da_AI_HumanBot'
     CrouchAnims(0)="CrouchedF"
     CrouchAnims(1)="CrouchedB"
     CrouchAnims(2)="CrouchedL"
     CrouchAnims(3)="CrouchedR"
     DodgeAnims(0)=
     DodgeAnims(1)=
     DodgeAnims(2)=
     DodgeAnims(3)=
     CrouchTurnRightAnim="Crouched_TurnR"
     CrouchTurnLeftAnim="Crouched_TurnL"
     IdleCrouchAnim="Idle_Crouched"
     IdleWeaponAnim="Idle_Rest"
     IdleChatAnim="Reload_Pistols"
     RootBone="Pelvis"
     HeadBone="Head1"
     SpineBone1="spine"
     SpineBone2="Spine1"
     CollisionHeight=43.000000
     Mass=500.000000
     Begin Object Class=KarmaParamsSkel Name=DAPawnKParams
         KConvulseSpacing=(Max=2.200000)
         KLinearDamping=0.150000
         KAngularDamping=0.050000
         KBuoyancy=1.000000
         KStartEnabled=True
         KVelDropBelowThreshold=50.000000
         bHighDetailOnly=False
         KFriction=0.600000
         KRestitution=0.300000
         KImpactThreshold=500.000000
     End Object
     KParams=KarmaParamsSkel'DA2.da_players_ClassPlayer.DAPawnKParams'

}
