// ============================================================================
// DA2.da_items_worldAmmoBox: The world ammobox will refill your current weapon
// ammo as well as grenades. Mappers place this anywhere on the map and set the,
// delay time to avoid spam. Default is 3.5 seconds of delay after a use.
// Coded by: aBsOlUt
// ============================================================================
class da_items_WorldAmmoBox extends da_buildable_Useable;

#exec obj load file=Textures\DA2DefenseStructures.utx

//Avoid spam.
var() float delayTime; //The amount of time the ammobox needs to be ready
var() int explosionDamage;
var() float explosionRadius;
var() float explosionMomentum;
var		bool bReadyToUse;
var() byte Team;

replication {
	reliable if (ROLE == ROLE_Authority)
		bReadyToUse;
}

simulated function array<string> getInfoForMech() {
	local array<string> msg;
	msg = super.getInfoForMech();
	if (isBuilt())
	{
	   if (bReadyToUse)
        	msg[msg.length] = "Ready";
	   else
		    msg[msg.length] = "Recharging";
    }
	return msg;
}

simulated function buildingStarted() {
   skins[0]=Shader'DA2DefenseStructures.items.ammoBoxSkin';
   super.buildingStarted();
}

simulated function buildingEnded() {
    super.buildingEnded();
    skins.length = 0;
}

function UsedBy(Pawn user)
{
  local da_players_PRI DAPRI;
  local da_game_ReplicationInfo DAGRI;
  local Controller C;
  local int i;

  if( !canUse(user.controller) || IsInState('sleepTime') )
      return;

     C=User.Controller;
//   log("============Controller is"@C);
     DAPRI=da_players_PRI(User.PlayerReplicationInfo);
     DAGRI=da_game_ReplicationInfo(Level.Game.GameReplicationInfo);

       if ( da_AI_HumanBot(C) != None && C.Pawn != None)
       {
         da_AI_HumanBot(C).grenades.grenadeAmount = DAGRI.TeamConfig[ DAPRI.Team.TeamIndex].classSet.playerClasses[DAPRI.playerClass].grenadenumber;
         refillAmmo(da_weapons_reloadable(User.Weapon));
       }

       if ( da_Players_PlayerController(C) != None)
       {
         da_Players_PlayerController(C).grenades.grenadeAmount = DAGRI.TeamConfig[ DAPRI.Team.TeamIndex].classSet.playerClasses[DAPRI.playerClass].grenadenumber;
         refillAmmo(da_weapons_reloadable(User.Weapon));
         gotoState('sleepTime');

	for ( i=0; DAGRI.TeamConfig[ DAPRI.Team.TeamIndex ].classSet.playerClasses[ DAPRI.playerClass ].Weapons[i] != none; i++ )
	{
	refillAmmo(da_weapons_reloadable(user.findInventoryType(DAGRI.TeamConfig[ DAPRI.Team.TeamIndex ].classSet.playerClasses[ DAPRI.playerClass ].Weapons[i].Weapon )));
	}

	 da_SteamStatsAndAchievements(da_Players_PlayerController(C).SteamStatsAndAchievements).AddAmmoboxUse();
       }

	DefenceAlliance(Level.Game).ResetPlasmaKills(); //Resets PlasmaKill counter when ammobox is used

     //Play the useSound
     if (useSound != none)
          PlaySound(useSound,,2.5*TransientSoundVolume);

}

simulated function refillAmmo(da_weapons_Reloadable dw)
{
    if (dw.getAmmoObject(0) != none)
        dw.getAmmoObject(0).giveFullAmmo();
    if (dw.getAmmoObject(1) != none)
        dw.getAmmoObject(1).giveFullAmmo();
}

simulated function bool isEnemy(Controller c) {
    return c.GetTeamNum() != 0;
}

state sleepTime
{
begin:
  bReadyToUse = false;
  sleep(delayTime);
  bReadyToUse = true;
  gotoState('');
}

function explode(vector hitLocation, vector momentum) {
    local int i, r;
    local rotator rot;

	rot.pitch=16384;

    Spawn(class'da2.da_effects_ammoexplosion', Self,, HitLocation, rot).remoteRole = ROLE_SimulatedProxy;
    PlaySound(sound'DA2_Various.AmmoExplosion',SLOT_None,18,,800,0.9+frand()*0.2);
    PlaySound(sound'DA2_Various.TurretExpFar',SLOT_None,6,,4000,0.9+frand()*0.2);

    if (explosionDamage > 0)
       hurtRadius(explosionDamage, explosionRadius, class'da2.da_damtypes_ammoexp', explosionMomentum, hitLocation);

    r=rand(4)+4;

    for(i=0;i<r;i++)
        spawn(class'da_proj_ammoboxgrenade',,,location,rot);

    destroy();
}

defaultproperties
{
     DelayTime=6.500000
     ExplosionDamage=50
     ExplosionRadius=800.000000
     ExplosionMomentum=80000.000000
     bReadyToUse=True
     Team=255
     maxUseDistance=100.000000
     ItemName="Ammobox"
     UseSound=Sound'DA2_WeaponSounds.Human_WeaponChange'
     Health=200
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'DA2_StaticMeshes.Misc.worldAmmoBox'
     DrawScale=0.700000
     Skins(0)=Shader'DA2DefenseStructures.items.ammoBoxSkin'
     bCollideActors=True
     bCollideWorld=True
     bBlockActors=True
     bBlockPlayers=True
     bProjTarget=True
}
