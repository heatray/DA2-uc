class da_SteamStatsAndAchievements extends SteamStatsAndAchievementsBase;

//=============================================================================
// Stats
//=============================================================================
const DASTAT_HuskKills						= 0;
const DASTAT_ZedKills						= 1;
const DASTAT_SniperKills					= 2;
const DASTAT_RocketKills					= 3;
const DASTAT_GrenadeKills					= 4;
const DASTAT_AmmoboxUses					= 5;
const DASTAT_MeleeKills						= 6;
const DASTAT_Score							= 7;
const DASTAT_RifScore						= 8;
const DASTAT_RifKills						= 9;
const DASTAT_MechScore						= 10;
const DASTAT_MechKills						= 11;
const DASTAT_MedScore						= 12;
const DASTAT_MedKills						= 13;
const DASTAT_MGScore						= 14;
const DASTAT_MGKills						= 15;
const DASTAT_SnipScore						= 16;
const DASTAT_SnipKills						= 17;
const DASTAT_RockScore						= 18;
const DASTAT_RockKills						= 19;
const DASTAT_EngScore						= 20;
const DASTAT_EngKills						= 21;
const DASTAT_A9								= 22;
const DASTAT_APMine							= 23;
const DASTAT_AVeR							= 24;
const DASTAT_Crusher						= 25;
const DASTAT_DFA							= 26;
const DASTAT_EMP							= 27;
const DASTAT_GK2							= 28;
const DASTAT_HandGrenade					= 29;
const DASTAT_LK2							= 30;
const DASTAT_Melee							= 31;
const DASTAT_MR40							= 32;
const DASTAT_MR56							= 33;
const DASTAT_MS25							= 34;
const DASTAT_NuclearGrenade					= 35;
const DASTAT_P280							= 36;
const DASTAT_Plasma							= 37;
const DASTAT_Sniper							= 38;
const DASTAT_SniperHeadshot					= 39;
const DASTAT_Thermite						= 40;
const DASTAT_XD40							= 41;


// Misc Stats


var	const SteamStatInt		HuskKillsStat;
var	int						SavedHuskKillsStat;

var	const SteamStatInt		ZedKillsStat;
var	int						SavedZedKillsStat;

var	const SteamStatInt		SniperKillsStat;
var	int						SavedSniperKillsStat;

var	const SteamStatInt		RocketKillsStat;
var	int						SavedRocketKillsStat;

var	const SteamStatInt		GrenadeKillsStat;
var	int						SavedGrenadeKillsStat;

var	const SteamStatInt		AmmoboxStat;
var	int						SavedAmmoboxStat;

var	const SteamStatInt		MeleeKillsStat;
var	int						SavedMeleeKillsStat;

var	const SteamStatInt		ScoreStat;
var	int						SavedScoreStat;

var	const SteamStatInt		RifScoreStat;
var	int						SavedRifScoreStat;

var	const SteamStatInt		RifKillsStat;
var	int						SavedRifKillsStat;

var	const SteamStatInt		MechScoreStat;
var	int						SavedMechScoreStat;

var	const SteamStatInt		MechKillsStat;
var	int						SavedMechKillsStat;

var	const SteamStatInt		MedScoreStat;
var	int						SavedMedScoreStat;

var	const SteamStatInt		MedKillsStat;
var	int						SavedMedKillsStat;

var	const SteamStatInt		MGScoreStat;
var	int						SavedMGScoreStat;

var	const SteamStatInt		MGKillsStat;
var	int						SavedMGKillsStat;

var	const SteamStatInt		SnipScoreStat;
var	int						SavedSnipScoreStat;

var	const SteamStatInt		SnipKillsStat;
var	int						SavedSnipKillsStat;

var	const SteamStatInt		RockScoreStat;
var	int						SavedRockScoreStat;

var	const SteamStatInt		RockKillsStat;
var	int						SavedRockKillsStat;

var	const SteamStatInt		EngScoreStat;
var	int						SavedEngScoreStat;

var	const SteamStatInt		EngKillsStat;
var	int						SavedEngKillsStat;
//======================================================
var	const SteamStatInt		A9Stat;
var	int						SavedA9Stat;

var	const SteamStatInt		APMineStat;
var	int						SavedAPMineStat;

var	const SteamStatInt		AVeRStat;
var	int						SavedAVeRStat;

var	const SteamStatInt		CrusherStat;
var	int						SavedCrusherStat;

var	const SteamStatInt		DFAStat;
var	int						SavedDFAStat;

var	const SteamStatInt		EMPStat;
var	int						SavedEMPStat;

var	const SteamStatInt		GK2Stat;
var	int						SavedGK2Stat;

var	const SteamStatInt		HandGrenadeStat;
var	int						SavedHandGrenadeStat;

var	const SteamStatInt		LK2Stat;
var	int						SavedLK2Stat;

var	const SteamStatInt		MeleeStat;
var	int						SavedMeleeStat;

var	const SteamStatInt		MR40Stat;
var	int						SavedMR40Stat;

var	const SteamStatInt		MR56Stat;
var	int						SavedMR56Stat;

var	const SteamStatInt		MS25Stat;
var	int						SavedMS25Stat;

var	const SteamStatInt		NuclearGrenadeStat;
var	int						SavedNuclearGrenadeStat;

var	const SteamStatInt		P280Stat;
var	int						SavedP280Stat;

var	const SteamStatInt		PlasmaStat;
var	int						SavedPlasmaStat;

var	const SteamStatInt		SniperStat;
var	int						SavedSniperStat;

var	const SteamStatInt		SniperHeadshotStat;
var	int						SavedSniperHeadshotStat;

var	const SteamStatInt		ThermiteStat;
var	int						SavedThermiteStat;

var	const SteamStatInt		XD40Stat;
var	int						SavedXD40Stat;

//=============================================================================
// Achievements
//=============================================================================
const DAACHIEVEMENT_Obliterate15ZedsWithPlasmabomb		= 0;
const DAACHIEVEMENT_Incendiary					= 1;
const DAACHIEVEMENT_KillXEnemies				= 2;
const DAACHIEVEMENT_KillXEnemies2				= 3;
const DAACHIEVEMENT_KillXEnemies3				= 4;
const DAACHIEVEMENT_Sniper1					= 5;
const DAACHIEVEMENT_Sniper2					= 6;
const DAACHIEVEMENT_Rocket					= 7;
const DAACHIEVEMENT_Grenade					= 8;
const DAACHIEVEMENT_Ammobox					= 9;
const DAACHIEVEMENT_PatriarchKilled				= 10;
const DAACHIEVEMENT_SurvivedSuicidal			= 11;
const DAACHIEVEMENT_DamageDone10000			= 12;
const DAACHIEVEMENT_DamageDone40000				= 13;
const DAACHIEVEMENT_CrawlerChampionKilled		= 14;
const DAACHIEVEMENT_ClotChampionKilled			= 15;
const DAACHIEVEMENT_GorefastChampionKilled		= 16;
const DAACHIEVEMENT_StalkerChampionKilled		= 17;
const DAACHIEVEMENT_SirenChampionKilled			= 18;
const DAACHIEVEMENT_BloatChampionKilled			= 19;
const DAACHIEVEMENT_HuskChampionKilled			= 20;
const DAACHIEVEMENT_ScrakeChampionKilled		= 21;
const DAACHIEVEMENT_FleshpoundChampionKilled	= 22;
const DAACHIEVEMENT_DestroyTurret				= 23;
const DAACHIEVEMENT_MedicHealing				= 24;
const DAACHIEVEMENT_StunTurret					= 25;
const DAACHIEVEMENT_TurretsBuild				= 26;
const DAACHIEVEMENT_GotObjective				= 27;
const DAACHIEVEMENT_MeleeKills					= 28;
const DAACHIEVEMENT_FPMelee						= 29;


// Achievement Status
var bool Obliterate15ZedsWithPlasmabombCompleted;
var bool IncendiaryCompleted;
var bool KillXEnemiesCompleted;
var bool KillXEnemies2Completed;
var bool KillXEnemies3Completed;
var bool Sniper1Completed;
var bool Sniper2Completed;
var bool RocketCompleted;
var bool GrenadeCompleted;
var bool AmmoboxCompleted;
var bool PatriarchKilledCompleted;
var bool SurvivedSuicidalCompleted;
var bool DamageDone10000Completed;
var bool DamageDone40000Completed;
var bool CrawlerChampionKilledCompleted;
var bool ClotChampionKilledCompleted;
var bool GorefastChampionKilledCompleted;
var bool StalkerChampionKilledCompleted;
var bool SirenChampionKilledCompleted;
var bool BloatChampionKilledCompleted;
var bool HuskChampionKilledCompleted;
var bool ScrakeChampionKilledCompleted;
var bool FleshpoundChampionKilledCompleted;
var bool DestroyTurretCompleted;
var bool MedicHealingCompleted;
var bool StunTurretCompleted;
var bool TurretsBuildCompleted;
var bool GotObjectiveCompleted;
var bool MeleeKillsCompleted;
var bool FPMeleeCompleted;

var int TotalCompleted;
var float ScoreCount;

replication
{
	reliable if ( bFlushStatsToClient && Role == ROLE_Authority )

		HuskKillsStat, ZedKillsStat, SniperKillsStat, RocketKillsStat,
		GrenadeKillsStat, AmmoboxStat, MeleeKillsStat, ScoreStat, RifScoreStat,
		RifKillsStat, MechScoreStat, MechKillsStat, MedScoreStat, MedKillsStat,
		MGScoreStat, MGKillsStat, SnipScoreStat, SnipKillsStat, RockScoreStat, 
		RockKillsStat, EngScoreStat, EngKillsStat, A9Stat, APMineStat, AVeRStat,
		CrusherStat, DFAStat, EMPStat, GK2Stat, HandGrenadeStat, LK2Stat, MeleeStat,
		MR40Stat, MR56Stat, MS25Stat, NuclearGrenadeStat, P280Stat, PlasmaStat,
		SniperStat, SniperHeadShotStat, ThermiteStat, XD40Stat;
}



// Used to only send the Stats/Achievements that have changed to Steam
simulated event PostNetReceive()
{
	local bool bFlushStatsToDatabase;

	if ( bDebugStats )
		log("STEAMSTATS: PostNetReceive called");


	if ( HuskKillsStat.Value != SavedHuskKillsStat )
	{
		FlushStatToSteamInt(HuskKillsStat, SteamNameStat[DASTAT_HuskKills]);

		SavedHuskKillsStat = HuskKillsStat.Value;
		bFlushStatsToDatabase = true;
	}

	if ( ZedKillsStat.Value != SavedZedKillsStat )
	{
		FlushStatToSteamInt(ZedKillsStat, SteamNameStat[DASTAT_ZedKills]);

		SavedZedKillsStat = ZedKillsStat.Value;
		bFlushStatsToDatabase = true;
	}

	if ( SniperKillsStat.Value != SavedSniperKillsStat )
	{
		FlushStatToSteamInt(SniperKillsStat, SteamNameStat[DASTAT_SniperKills]);

		SavedSniperKillsStat = SniperKillsStat.Value;
		bFlushStatsToDatabase = true;
	}

	if ( RocketKillsStat.Value != SavedRocketKillsStat )
	{
		FlushStatToSteamInt(RocketKillsStat, SteamNameStat[DASTAT_RocketKills]);

		SavedRocketKillsStat = RocketKillsStat.Value;
		bFlushStatsToDatabase = true;
	}

	if ( GrenadeKillsStat.Value != SavedGrenadeKillsStat )
	{
		FlushStatToSteamInt(GrenadeKillsStat, SteamNameStat[DASTAT_GrenadeKills]);

		SavedGrenadeKillsStat = GrenadeKillsStat.Value;
		bFlushStatsToDatabase = true;
	}

	if ( AmmoboxStat.Value != SavedAmmoboxStat )
	{
		FlushStatToSteamInt(AmmoboxStat, SteamNameStat[DASTAT_AmmoboxUses]);

		SavedAmmoboxStat = AmmoboxStat.Value;
		bFlushStatsToDatabase = true;
	}

	if ( MeleeKillsStat.Value != SavedMeleeKillsStat )
	{
		FlushStatToSteamInt(MeleeKillsStat, SteamNameStat[DASTAT_MeleeKills]);

		SavedMeleeKillsStat = MeleeKillsStat.Value;
		bFlushStatsToDatabase = true;
	}
	
	if ( ScoreStat.Value != SavedScoreStat )
	{
		FlushStatToSteamInt(ScoreStat, SteamNameStat[DASTAT_Score]);

		SavedScoreStat = ScoreStat.Value;
		bFlushStatsToDatabase = true;
	}
	
	if ( RifScoreStat.Value != SavedRifScoreStat )
	{
		FlushStatToSteamInt(RifScoreStat, SteamNameStat[DASTAT_RifScore]);

		SavedRifScoreStat = RifScoreStat.Value;
		bFlushStatsToDatabase = true;
	}
	
	if ( RifKillsStat.Value != SavedRifKillsStat )
	{
		FlushStatToSteamInt(RifKillsStat, SteamNameStat[DASTAT_RifKills]);

		SavedRifKillsStat = RifKillsStat.Value;
		bFlushStatsToDatabase = true;
	}
	
	if ( MechScoreStat.Value != SavedMechScoreStat )
	{
		FlushStatToSteamInt(MechScoreStat, SteamNameStat[DASTAT_MechScore]);

		SavedMechScoreStat = MechScoreStat.Value;
		bFlushStatsToDatabase = true;
	}
	
	if ( MechKillsStat.Value != SavedMechKillsStat )
	{
		FlushStatToSteamInt(MechKillsStat, SteamNameStat[DASTAT_MechKills]);

		SavedMechKillsStat = MechKillsStat.Value;
		bFlushStatsToDatabase = true;
	}
	
	if ( MedScoreStat.Value != SavedMedScoreStat )
	{
		FlushStatToSteamInt(MedScoreStat, SteamNameStat[DASTAT_MedScore]);

		SavedMedScoreStat = MedScoreStat.Value;
		bFlushStatsToDatabase = true;
	}
	
	if ( MedKillsStat.Value != SavedMedKillsStat )
	{
		FlushStatToSteamInt(MedKillsStat, SteamNameStat[DASTAT_MedKills]);

		SavedMedKillsStat = MedKillsStat.Value;
		bFlushStatsToDatabase = true;
	}
	
	if ( MGScoreStat.Value != SavedMGScoreStat )
	{
		FlushStatToSteamInt(MGScoreStat, SteamNameStat[DASTAT_MGScore]);

		SavedMGScoreStat = MGScoreStat.Value;
		bFlushStatsToDatabase = true;
	}
	
	if ( MGKillsStat.Value != SavedMGKillsStat )
	{
		FlushStatToSteamInt(MGKillsStat, SteamNameStat[DASTAT_MGKills]);

		SavedMGKillsStat = MGKillsStat.Value;
		bFlushStatsToDatabase = true;
	}
	
	if ( SnipScoreStat.Value != SavedSnipScoreStat )
	{
		FlushStatToSteamInt(SnipScoreStat, SteamNameStat[DASTAT_SnipScore]);

		SavedSnipScoreStat = SnipScoreStat.Value;
		bFlushStatsToDatabase = true;
	}
	
	if ( SnipKillsStat.Value != SavedSnipKillsStat )
	{
		FlushStatToSteamInt(SnipKillsStat, SteamNameStat[DASTAT_SnipKills]);

		SavedSnipKillsStat = SnipKillsStat.Value;
		bFlushStatsToDatabase = true;
	}
	
	if ( RockScoreStat.Value != SavedRockScoreStat )
	{
		FlushStatToSteamInt(RockScoreStat, SteamNameStat[DASTAT_RockScore]);

		SavedRockScoreStat = RockScoreStat.Value;
		bFlushStatsToDatabase = true;
	}
	
	if ( RockKillsStat.Value != SavedRockKillsStat )
	{
		FlushStatToSteamInt(RockKillsStat, SteamNameStat[DASTAT_RockKills]);

		SavedRockKillsStat = RockKillsStat.Value;
		bFlushStatsToDatabase = true;
	}
	
	if ( EngScoreStat.Value != SavedEngScoreStat )
	{
		FlushStatToSteamInt(EngScoreStat, SteamNameStat[DASTAT_EngScore]);

		SavedEngScoreStat = EngScoreStat.Value;
		bFlushStatsToDatabase = true;
	}
	
	if ( EngKillsStat.Value != SavedEngKillsStat )
	{
		FlushStatToSteamInt(EngKillsStat, SteamNameStat[DASTAT_EngKills]);

		SavedEngKillsStat = EngKillsStat.Value;
		bFlushStatsToDatabase = true;
	}
////=======================================
	if ( A9Stat.Value != SavedA9Stat )
	{
		FlushStatToSteamInt(A9Stat, SteamNameStat[DASTAT_A9]);

		SavedA9Stat = A9Stat.Value;
		bFlushStatsToDatabase = true;
	}
	
	if ( APMineStat.Value != SavedAPMineStat )
	{
		FlushStatToSteamInt(APMineStat, SteamNameStat[DASTAT_APMine]);

		SavedAPMineStat = APMineStat.Value;
		bFlushStatsToDatabase = true;
	}
	
	if ( AVeRStat.Value != SavedAVeRStat )
	{
		FlushStatToSteamInt(AVeRStat, SteamNameStat[DASTAT_AVeR]);

		SavedAVeRStat = AVeRStat.Value;
		bFlushStatsToDatabase = true;
	}
	
	if ( CrusherStat.Value != SavedCrusherStat )
	{
		FlushStatToSteamInt(CrusherStat, SteamNameStat[DASTAT_Crusher]);

		SavedCrusherStat = CrusherStat.Value;
		bFlushStatsToDatabase = true;
	}
	
	if ( DFAStat.Value != SavedDFAStat )
	{
		FlushStatToSteamInt(DFAStat, SteamNameStat[DASTAT_DFA]);

		SavedDFAStat = DFAStat.Value;
		bFlushStatsToDatabase = true;
	}
	
	if ( EMPStat.Value != SavedEMPStat )
	{
		FlushStatToSteamInt(EMPStat, SteamNameStat[DASTAT_EMP]);

		SavedEMPStat = EMPStat.Value;
		bFlushStatsToDatabase = true;
	}
	
	if ( GK2Stat.Value != SavedGK2Stat )
	{
		FlushStatToSteamInt(GK2Stat, SteamNameStat[DASTAT_GK2]);

		SavedGK2Stat = GK2Stat.Value;
		bFlushStatsToDatabase = true;
	}
	
	if ( HandGrenadeStat.Value != SavedHandGrenadeStat )
	{
		FlushStatToSteamInt(HandGrenadeStat, SteamNameStat[DASTAT_HandGrenade]);

		SavedHandGrenadeStat = HandGrenadeStat.Value;
		bFlushStatsToDatabase = true;
	}
	
	if ( LK2Stat.Value != SavedLK2Stat )
	{
		FlushStatToSteamInt(LK2Stat, SteamNameStat[DASTAT_LK2]);

		SavedLK2Stat = LK2Stat.Value;
		bFlushStatsToDatabase = true;
	}
	
	if ( MeleeStat.Value != SavedMeleeStat )
	{
		FlushStatToSteamInt(MeleeStat, SteamNameStat[DASTAT_Melee]);

		SavedMeleeStat = MeleeStat.Value;
		bFlushStatsToDatabase = true;
	}
	
	if ( MR40Stat.Value != SavedMR40Stat )
	{
		FlushStatToSteamInt(MR40Stat, SteamNameStat[DASTAT_MR40]);

		SavedMR40Stat = MR40Stat.Value;
		bFlushStatsToDatabase = true;
	}
	
	if ( MR56Stat.Value != SavedMR56Stat )
	{
		FlushStatToSteamInt(MR56Stat, SteamNameStat[DASTAT_MR56]);

		SavedMR56Stat = MR56Stat.Value;
		bFlushStatsToDatabase = true;
	}
	
	if ( MS25Stat.Value != SavedMS25Stat )
	{
		FlushStatToSteamInt(MS25Stat, SteamNameStat[DASTAT_MS25]);

		SavedMS25Stat = MS25Stat.Value;
		bFlushStatsToDatabase = true;
	}
	
	if ( NuclearGrenadeStat.Value != SavedNuclearGrenadeStat )
	{
		FlushStatToSteamInt(NuclearGrenadeStat, SteamNameStat[DASTAT_NuclearGrenade]);

		SavedNuclearGrenadeStat = NuclearGrenadeStat.Value;
		bFlushStatsToDatabase = true;
	}
	
	if ( P280Stat.Value != SavedP280Stat )
	{
		FlushStatToSteamInt(P280Stat, SteamNameStat[DASTAT_P280]);

		SavedP280Stat = P280Stat.Value;
		bFlushStatsToDatabase = true;
	}
	
	if ( PlasmaStat.Value != SavedPlasmaStat )
	{
		FlushStatToSteamInt(PlasmaStat, SteamNameStat[DASTAT_Plasma]);

		SavedPlasmaStat = PlasmaStat.Value;
		bFlushStatsToDatabase = true;
	}
	
	if ( SniperStat.Value != SavedSniperStat )
	{
		FlushStatToSteamInt(SniperStat, SteamNameStat[DASTAT_Sniper]);

		SavedSniperStat = SniperStat.Value;
		bFlushStatsToDatabase = true;
	}
	
	if ( SniperHeadshotStat.Value != SavedSniperHeadshotStat )
	{
		FlushStatToSteamInt(SniperHeadshotStat, SteamNameStat[DASTAT_SniperHeadshot]);

		SavedSniperHeadshotStat = SniperHeadshotStat.Value;
		bFlushStatsToDatabase = true;
	}
	
	if ( ThermiteStat.Value != SavedThermiteStat )
	{
		FlushStatToSteamInt(ThermiteStat, SteamNameStat[DASTAT_Thermite]);

		SavedThermiteStat = ThermiteStat.Value;
		bFlushStatsToDatabase = true;
	}
	
	if ( XD40Stat.Value != SavedXD40Stat )
	{
		FlushStatToSteamInt(XD40Stat, SteamNameStat[DASTAT_XD40]);

		SavedXD40Stat = XD40Stat.Value;
		bFlushStatsToDatabase = true;
	}

	if ( bFlushStatsToDatabase )
	{
		FlushStatsToSteamDatabase();
	}
}

// Event Callback for each GetStatsAndAchievements call
// NETWORK: Client only
simulated event OnStatsAndAchievementsReady()
{
PCOwner = da_players_PlayerController(Owner);

	GetStatInt(HuskKillsStat, SteamNameStat[DASTAT_HuskKills]);
	SavedHuskKillsStat = HuskKillsStat.Value;
	PCOwner.ServerInitializeSteamStatInt(DASTAT_HuskKills, HuskKillsStat.Value);

	GetStatInt(ZedKillsStat, SteamNameStat[DASTAT_ZedKills]);
	SavedZedKillsStat = ZedKillsStat.Value;
	PCOwner.ServerInitializeSteamStatInt(DASTAT_ZedKills, ZedKillsStat.Value);

	GetStatInt(SniperKillsStat, SteamNameStat[DASTAT_SniperKills]);
	SavedSniperKillsStat = SniperKillsStat.Value;
	PCOwner.ServerInitializeSteamStatInt(DASTAT_SniperKills, SniperKillsStat.Value);

	GetStatInt(RocketKillsStat, SteamNameStat[DASTAT_RocketKills]);
	SavedRocketKillsStat = RocketKillsStat.Value;
	PCOwner.ServerInitializeSteamStatInt(DASTAT_RocketKills, RocketKillsStat.Value);

	GetStatInt(GrenadeKillsStat, SteamNameStat[DASTAT_GrenadeKills]);
	SavedGrenadeKillsStat = GrenadeKillsStat.Value;
	PCOwner.ServerInitializeSteamStatInt(DASTAT_GrenadeKills, GrenadeKillsStat.Value);

	GetStatInt(AmmoboxStat, SteamNameStat[DASTAT_AmmoboxUses]);
	SavedAmmoboxStat = AmmoboxStat.Value;
	PCOwner.ServerInitializeSteamStatInt(DASTAT_AmmoboxUses, AmmoboxStat.Value);
	
	GetStatInt(MeleeKillsStat, SteamNameStat[DASTAT_MeleeKills]);
	SavedMeleeKillsStat = MeleeKillsStat.Value;
	PCOwner.ServerInitializeSteamStatInt(DASTAT_MeleeKills, MeleeKillsStat.Value);
	
	GetStatInt(ScoreStat, SteamNameStat[DASTAT_Score]);
	SavedScoreStat = ScoreStat.Value;
	PCOwner.ServerInitializeSteamStatInt(DASTAT_Score, ScoreStat.Value);
	
	GetStatInt(RifScoreStat, SteamNameStat[DASTAT_RifScore]);
	SavedRifScoreStat = RifScoreStat.Value;
	PCOwner.ServerInitializeSteamStatInt(DASTAT_RifScore, RifScoreStat.Value);
	
	GetStatInt(RifKillsStat, SteamNameStat[DASTAT_RifKills]);
	SavedRifKillsStat = RifKillsStat.Value;
	PCOwner.ServerInitializeSteamStatInt(DASTAT_RifKills, RifKillsStat.Value);
	
	GetStatInt(MechScoreStat, SteamNameStat[DASTAT_MechScore]);
	SavedMechScoreStat = MechScoreStat.Value;
	PCOwner.ServerInitializeSteamStatInt(DASTAT_MechScore, MechScoreStat.Value);
	
	GetStatInt(MechKillsStat, SteamNameStat[DASTAT_MechKills]);
	SavedMechKillsStat = MechKillsStat.Value;
	PCOwner.ServerInitializeSteamStatInt(DASTAT_MechKills, MechKillsStat.Value);
	
	GetStatInt(MedScoreStat, SteamNameStat[DASTAT_MedScore]);
	SavedMedScoreStat = MedScoreStat.Value;
	PCOwner.ServerInitializeSteamStatInt(DASTAT_MedScore, MedScoreStat.Value);
	
	GetStatInt(MedKillsStat, SteamNameStat[DASTAT_MedKills]);
	SavedMedKillsStat = MedKillsStat.Value;
	PCOwner.ServerInitializeSteamStatInt(DASTAT_MedKills, MedKillsStat.Value);
	
	GetStatInt(MGScoreStat, SteamNameStat[DASTAT_MGScore]);
	SavedMGScoreStat = MGScoreStat.Value;
	PCOwner.ServerInitializeSteamStatInt(DASTAT_MGScore, MGScoreStat.Value);
	
	GetStatInt(MGKillsStat, SteamNameStat[DASTAT_MGKills]);
	SavedMGKillsStat = MGKillsStat.Value;
	PCOwner.ServerInitializeSteamStatInt(DASTAT_MGKills, MGKillsStat.Value);
	
	GetStatInt(SnipScoreStat, SteamNameStat[DASTAT_SnipScore]);
	SavedSnipScoreStat = SnipScoreStat.Value;
	PCOwner.ServerInitializeSteamStatInt(DASTAT_SnipScore, SnipScoreStat.Value);
	
	GetStatInt(SnipKillsStat, SteamNameStat[DASTAT_SnipKills]);
	SavedSnipKillsStat = SnipKillsStat.Value;
	PCOwner.ServerInitializeSteamStatInt(DASTAT_SnipKills, SnipKillsStat.Value);

	GetStatInt(RockScoreStat, SteamNameStat[DASTAT_RockScore]);
	SavedRockScoreStat = RockScoreStat.Value;
	PCOwner.ServerInitializeSteamStatInt(DASTAT_RockScore, RockScoreStat.Value);
	
	GetStatInt(RockKillsStat, SteamNameStat[DASTAT_RockKills]);
	SavedRockKillsStat = RockKillsStat.Value;
	PCOwner.ServerInitializeSteamStatInt(DASTAT_RockKills, RockKillsStat.Value);
	
	GetStatInt(EngScoreStat, SteamNameStat[DASTAT_EngScore]);
	SavedEngScoreStat = EngScoreStat.Value;
	PCOwner.ServerInitializeSteamStatInt(DASTAT_EngScore, EngScoreStat.Value);
	
	GetStatInt(EngKillsStat, SteamNameStat[DASTAT_EngKills]);
	SavedEngKillsStat = EngKillsStat.Value;
	PCOwner.ServerInitializeSteamStatInt(DASTAT_EngKills, EngKillsStat.Value);
	////===================
	GetStatInt(A9Stat, SteamNameStat[DASTAT_A9]);
	SavedA9Stat = A9Stat.Value;
	PCOwner.ServerInitializeSteamStatInt(DASTAT_A9, A9Stat.Value);
	
	GetStatInt(APMineStat, SteamNameStat[DASTAT_APMine]);
	SavedAPMineStat = APMineStat.Value;
	PCOwner.ServerInitializeSteamStatInt(DASTAT_APMine, APMineStat.Value);
	
	GetStatInt(AVeRStat, SteamNameStat[DASTAT_AVeR]);
	SavedAVeRStat = AVeRStat.Value;
	PCOwner.ServerInitializeSteamStatInt(DASTAT_AVeR, AVeRStat.Value);
	
	GetStatInt(CrusherStat, SteamNameStat[DASTAT_Crusher]);
	SavedCrusherStat = CrusherStat.Value;
	PCOwner.ServerInitializeSteamStatInt(DASTAT_Crusher, CrusherStat.Value);
	
	GetStatInt(DFAStat, SteamNameStat[DASTAT_DFA]);
	SavedDFAStat = DFAStat.Value;
	PCOwner.ServerInitializeSteamStatInt(DASTAT_DFA, DFAStat.Value);
	
	GetStatInt(EMPStat, SteamNameStat[DASTAT_EMP]);
	SavedEMPStat = EMPStat.Value;
	PCOwner.ServerInitializeSteamStatInt(DASTAT_EMP, EMPStat.Value);
	
	GetStatInt(GK2Stat, SteamNameStat[DASTAT_GK2]);
	SavedGK2Stat = GK2Stat.Value;
	PCOwner.ServerInitializeSteamStatInt(DASTAT_GK2, GK2Stat.Value);
	
	GetStatInt(HandGrenadeStat, SteamNameStat[DASTAT_HandGrenade]);
	SavedHandGrenadeStat = HandGrenadeStat.Value;
	PCOwner.ServerInitializeSteamStatInt(DASTAT_HandGrenade, HandGrenadeStat.Value);
	
	GetStatInt(LK2Stat, SteamNameStat[DASTAT_LK2]);
	SavedLK2Stat = LK2Stat.Value;
	PCOwner.ServerInitializeSteamStatInt(DASTAT_LK2, LK2Stat.Value);
	
	GetStatInt(MeleeStat, SteamNameStat[DASTAT_Melee]);
	SavedMeleeStat = MeleeStat.Value;
	PCOwner.ServerInitializeSteamStatInt(DASTAT_Melee, MeleeStat.Value);
	
	GetStatInt(MR40Stat, SteamNameStat[DASTAT_MR40]);
	SavedMR40Stat = MR40Stat.Value;
	PCOwner.ServerInitializeSteamStatInt(DASTAT_MR40, MR40Stat.Value);
	
	GetStatInt(MR56Stat, SteamNameStat[DASTAT_MR56]);
	SavedMR56Stat = MR56Stat.Value;
	PCOwner.ServerInitializeSteamStatInt(DASTAT_MR56, MR56Stat.Value);
	
	GetStatInt(MS25Stat, SteamNameStat[DASTAT_MS25]);
	SavedMS25Stat = MS25Stat.Value;
	PCOwner.ServerInitializeSteamStatInt(DASTAT_MS25, MS25Stat.Value);
	
	GetStatInt(NuclearGrenadeStat, SteamNameStat[DASTAT_NuclearGrenade]);
	SavedNuclearGrenadeStat = NuclearGrenadeStat.Value;
	PCOwner.ServerInitializeSteamStatInt(DASTAT_NuclearGrenade, NuclearGrenadeStat.Value);
	
	GetStatInt(P280Stat, SteamNameStat[DASTAT_P280]);
	SavedP280Stat = P280Stat.Value;
	PCOwner.ServerInitializeSteamStatInt(DASTAT_P280, P280Stat.Value);
	
	GetStatInt(PlasmaStat, SteamNameStat[DASTAT_Plasma]);
	SavedPlasmaStat = PlasmaStat.Value;
	PCOwner.ServerInitializeSteamStatInt(DASTAT_Plasma, PlasmaStat.Value);
	
	GetStatInt(SniperStat, SteamNameStat[DASTAT_Sniper]);
	SavedSniperStat = SniperStat.Value;
	PCOwner.ServerInitializeSteamStatInt(DASTAT_Sniper, SniperStat.Value);
	
	GetStatInt(SniperHeadShotStat, SteamNameStat[DASTAT_SniperHeadShot]);
	SavedSniperHeadshotStat = SniperHeadshotStat.Value;
	PCOwner.ServerInitializeSteamStatInt(DASTAT_SniperHeadShot, SniperHeadShotStat.Value);
	
	GetStatInt(ThermiteStat, SteamNameStat[DASTAT_Thermite]);
	SavedThermiteStat = ThermiteStat.Value;
	PCOwner.ServerInitializeSteamStatInt(DASTAT_Thermite, ThermiteStat.Value);
	
	GetStatInt(XD40Stat, SteamNameStat[DASTAT_XD40]);
	SavedXD40Stat = XD40Stat.Value;
	PCOwner.ServerInitializeSteamStatInt(DASTAT_XD40, XD40Stat.Value);
	
	Obliterate15ZedsWithPlasmabombCompleted = GetAchievementCompleted(SteamNameAchievement[DAACHIEVEMENT_Obliterate15ZedsWithPlasmabomb]);
	IncendiaryCompleted = GetAchievementCompleted(SteamNameAchievement[DAACHIEVEMENT_Incendiary]);
	KillXEnemiesCompleted = GetAchievementCompleted(SteamNameAchievement[DAACHIEVEMENT_KillXEnemies]);
	KillXEnemies2Completed = GetAchievementCompleted(SteamNameAchievement[DAACHIEVEMENT_KillXEnemies2]);
	KillXEnemies3Completed = GetAchievementCompleted(SteamNameAchievement[DAACHIEVEMENT_KillXEnemies3]);
	Sniper1Completed = GetAchievementCompleted(SteamNameAchievement[DAACHIEVEMENT_Sniper1]);
	Sniper2Completed = GetAchievementCompleted(SteamNameAchievement[DAACHIEVEMENT_Sniper2]);
	RocketCompleted = GetAchievementCompleted(SteamNameAchievement[DAACHIEVEMENT_Rocket]);
	GrenadeCompleted = GetAchievementCompleted(SteamNameAchievement[DAACHIEVEMENT_Grenade]);
	AmmoboxCompleted = GetAchievementCompleted(SteamNameAchievement[DAACHIEVEMENT_Ammobox]);
	MeleeKillsCompleted = GetAchievementCompleted(SteamNameAchievement[DAACHIEVEMENT_MeleeKills]);
	PatriarchKilledCompleted = GetAchievementCompleted(SteamNameAchievement[DAACHIEVEMENT_PatriarchKilled]);
	SurvivedSuicidalCompleted = GetAchievementCompleted(SteamNameAchievement[DAACHIEVEMENT_SurvivedSuicidal]);
	DamageDone10000Completed = GetAchievementCompleted(SteamNameAchievement[DAACHIEVEMENT_DamageDone10000]);
	DamageDone40000Completed = GetAchievementCompleted(SteamNameAchievement[DAACHIEVEMENT_DamageDone40000]);
	CrawlerChampionKilledCompleted = GetAchievementCompleted(SteamNameAchievement[DAACHIEVEMENT_CrawlerChampionKilled]);
	ClotChampionKilledCompleted = GetAchievementCompleted(SteamNameAchievement[DAACHIEVEMENT_ClotChampionKilled]);
	GorefastChampionKilledCompleted = GetAchievementCompleted(SteamNameAchievement[DAACHIEVEMENT_GorefastChampionKilled]);
	StalkerChampionKilledCompleted = GetAchievementCompleted(SteamNameAchievement[DAACHIEVEMENT_StalkerChampionKilled]);
	SirenChampionKilledCompleted = GetAchievementCompleted(SteamNameAchievement[DAACHIEVEMENT_SirenChampionKilled]);
	BloatChampionKilledCompleted = GetAchievementCompleted(SteamNameAchievement[DAACHIEVEMENT_BloatChampionKilled]);
	HuskChampionKilledCompleted = GetAchievementCompleted(SteamNameAchievement[DAACHIEVEMENT_HuskChampionKilled]);
	ScrakeChampionKilledCompleted = GetAchievementCompleted(SteamNameAchievement[DAACHIEVEMENT_ScrakeChampionKilled]);
	FleshpoundChampionKilledCompleted = GetAchievementCompleted(SteamNameAchievement[DAACHIEVEMENT_FleshpoundChampionKilled]);
	DestroyTurretCompleted = GetAchievementCompleted(SteamNameAchievement[DAACHIEVEMENT_DestroyTurret]);
	MedicHealingCompleted = GetAchievementCompleted(SteamNameAchievement[DAACHIEVEMENT_MedicHealing]);
	StunTurretCompleted = GetAchievementCompleted(SteamNameAchievement[DAACHIEVEMENT_StunTurret]);
	TurretsBuildCompleted = GetAchievementCompleted(SteamNameAchievement[DAACHIEVEMENT_TurretsBuild]);
	GotObjectiveCompleted = GetAchievementCompleted(SteamNameAchievement[DAACHIEVEMENT_GotObjective]);
	FPMeleeCompleted = GetAchievementCompleted(SteamNameAchievement[DAACHIEVEMENT_FPMelee]);

	super.OnStatsAndAchievementsReady();
}

// Called on Server to initialize Stats from Client replication, because Servers can't access Steam Stats directly
function InitializeSteamStatInt(int Index, int Value)
{
PCOwner = da_players_PlayerController(Owner);

	if ( bDebugStats )
		log("STEAMSTATS: InitializeSteamStatInt called - Index="$Index @ "Value="$Value @ "Player="$PCOwner.PlayerReplicationInfo.PlayerName);

	switch ( Index )
	{
		case DASTAT_HuskKills:
			InitStatInt(HuskKillsStat, Value);
			break;

		case DASTAT_ZedKills:
			InitStatInt(ZedKillsStat, Value);
			break;

		case DASTAT_SniperKills:
			InitStatInt(SniperKillsStat, Value);
			break;

		case DASTAT_RocketKills:
			InitStatInt(RocketKillsStat, Value);
			break;

		case DASTAT_GrenadeKills:
			InitStatInt(GrenadeKillsStat, Value);
			break;

		case DASTAT_AmmoboxUses:
			InitStatInt(AmmoboxStat, Value);
			break;
			
		case DASTAT_MeleeKills:
			InitStatInt(MeleeKillsStat, Value);
			break;
			
		case DASTAT_Score:
			InitStatInt(ScoreStat, Value);
			break;
			
		case DASTAT_RifScore:
			InitStatInt(RifScoreStat, Value);
			break;
			
		case DASTAT_RifKills:
			InitStatInt(RifKillsStat, Value);
			break;
			
		case DASTAT_MechScore:
			InitStatInt(MechScoreStat, Value);
			break;
			
		case DASTAT_MechKills:
			InitStatInt(MechKillsStat, Value);
			break;
			
		case DASTAT_MedScore:
			InitStatInt(MedScoreStat, Value);
			break;
			
		case DASTAT_MedKills:
			InitStatInt(MedKillsStat, Value);
			break;
			
		case DASTAT_MGScore:
			InitStatInt(MGScoreStat, Value);
			break;
			
		case DASTAT_MGKills:
			InitStatInt(MGKillsStat, Value);
			break;
			
		case DASTAT_SnipScore:
			InitStatInt(SnipScoreStat, Value);
			break;
			
		case DASTAT_SnipKills:
			InitStatInt(SnipKillsStat, Value);
			break;
			
		case DASTAT_RockScore:
			InitStatInt(RockScoreStat, Value);
			break;
			
		case DASTAT_RockKills:
			InitStatInt(RockKillsStat, Value);
			break;
			
		case DASTAT_EngScore:
			InitStatInt(EngScoreStat, Value);
			break;
			
		case DASTAT_EngKills:
			InitStatInt(EngKillsStat, Value);
			break;
			//============
		case DASTAT_A9:
			InitStatInt(A9Stat, Value);
			break;
			
		case DASTAT_APMine:
			InitStatInt(APMineStat, Value);
			break;
			
		case DASTAT_AVeR:
			InitStatInt(AVeRStat, Value);
			break;
			
		case DASTAT_Crusher:
			InitStatInt(CrusherStat, Value);
			break;
			
		case DASTAT_DFA:
			InitStatInt(DFAStat, Value);
			break;
			
		case DASTAT_EMP:
			InitStatInt(EMPStat, Value);
			break;
			
		case DASTAT_GK2:
			InitStatInt(GK2Stat, Value);
			break;
			
		case DASTAT_HandGrenade:
			InitStatInt(HandGrenadeStat, Value);
			break;
			
		case DASTAT_LK2:
			InitStatInt(LK2Stat, Value);
			break;
			
		case DASTAT_Melee:
			InitStatInt(MeleeStat, Value);
			break;
			
		case DASTAT_MR40:
			InitStatInt(MR40Stat, Value);
			break;
			
		case DASTAT_MR56:
			InitStatInt(MR56Stat, Value);
			break;
			
		case DASTAT_MS25:
			InitStatInt(MS25Stat, Value);
			break;
			
		case DASTAT_NuclearGrenade:
			InitStatInt(NuclearGrenadeStat, Value);
			break;
			
		case DASTAT_P280:
			InitStatInt(P280Stat, Value);
			break;
			
		case DASTAT_Plasma:
			InitStatInt(PlasmaStat, Value);
			break;
			
		case DASTAT_Sniper:
			InitStatInt(SniperStat, Value);
			break;
			
		case DASTAT_SniperHeadshot:
			InitStatInt(SniperHeadshotStat, Value);
			break;
			
		case DASTAT_Thermite:
			InitStatInt(ThermiteStat, Value);
			break;
			
		case DASTAT_XD40:
			InitStatInt(XD40Stat, Value);
			break;
	}
}


/*
// Sets the specified Steam Achievement as completed; also, flushes all Stats and Achievements to the client
function SetSteamAchievementCompleted(int Index)
{
	if ( bDebugStats )
		log("STEAMSTATS: SetSteamAchievementCompleted called - Name="$Achievements[Index].SteamName @ "Player="$PCOwner.PlayerReplicationInfo.PlayerName);

	FlushStatsToClient();
	SetLocalAchievementCompleted(Index);
	SetAchievementCompleted(Achievements[Index].SteamName);
}
*/


// Called from multiple locations on Client and Server to set Achievement booleans for later use
simulated event SetLocalAchievementCompleted(int Index)
{

	switch ( Index )
	{
		case DAACHIEVEMENT_Obliterate15ZedsWithPlasmabomb:
			Obliterate15ZedsWithPlasmabombCompleted = true;
			break;
		case DAACHIEVEMENT_Incendiary:
			IncendiaryCompleted = true;
			break;
		case DAACHIEVEMENT_KillXEnemies:
			KillXEnemiesCompleted = true;
			break;
		case DAACHIEVEMENT_KillXEnemies2:
			KillXEnemies2Completed = true;
			break;
		case DAACHIEVEMENT_KillXEnemies3:
			KillXEnemies3Completed = true;
			break;
		case DAACHIEVEMENT_Sniper1:
			Sniper1Completed = true;
			break;
		case DAACHIEVEMENT_Sniper2:
			Sniper2Completed = true;
			break;
		case DAACHIEVEMENT_Rocket:
			RocketCompleted = true;
			break;
		case DAACHIEVEMENT_Grenade:
			GrenadeCompleted = true;
			break;
		case DAACHIEVEMENT_Ammobox:
			AmmoboxCompleted = true;
			break;
		case DAACHIEVEMENT_MeleeKills:
			MeleeKillsCompleted = true;
			break;
		case DAACHIEVEMENT_PatriarchKilled:
			PatriarchKilledCompleted = true;
			break;
		case DAACHIEVEMENT_SurvivedSuicidal:
			SurvivedSuicidalCompleted = true;
			break;
		case DAACHIEVEMENT_DamageDone10000:
			DamageDone10000Completed = true;
			break;
		case DAACHIEVEMENT_DamageDone40000:
			DamageDone40000Completed = true;
			break;
		case DAACHIEVEMENT_CrawlerChampionKilled:
			CrawlerChampionKilledCompleted = true;
			break;
		case DAACHIEVEMENT_ClotChampionKilled:
			ClotChampionKilledCompleted = true;
			break;
		case DAACHIEVEMENT_GorefastChampionKilled:
			GorefastChampionKilledCompleted = true;
			break;
		case DAACHIEVEMENT_StalkerChampionKilled:
			StalkerChampionKilledCompleted = true;
			break;
		case DAACHIEVEMENT_SirenChampionKilled:
			SirenChampionKilledCompleted = true;
			break;
		case DAACHIEVEMENT_BloatChampionKilled:
			BloatChampionKilledCompleted = true;
			break;
		case DAACHIEVEMENT_HuskChampionKilled:
			HuskChampionKilledCompleted = true;
			break;
		case DAACHIEVEMENT_ScrakeChampionKilled:
			ScrakeChampionKilledCompleted = true;
			break;
		case DAACHIEVEMENT_FleshpoundChampionKilled:
			FleshpoundChampionKilledCompleted = true;
			break;
		case DAACHIEVEMENT_DestroyTurret:
			DestroyTurretCompleted = true;
			break;
		case DAACHIEVEMENT_MedicHealing:
			MedicHealingCompleted = true;
			break;
		case DAACHIEVEMENT_StunTurret:
			StunTurretCompleted = true;
			break;
		case DAACHIEVEMENT_TurretsBuild:
			TurretsBuildCompleted = true;
			break;
		case DAACHIEVEMENT_GotObjective:
			GotObjectiveCompleted = true;
			break;
		case DAACHIEVEMENT_FPMelee:
			FPMeleeCompleted = true;
			break;
	}
}


// Called when the owner of this Stats Actor dies(used to reset "in one life" stats)
//function PlayerDied()
//{
//PCOwner = da_players_PlayerController(Owner);
//	if ( bDebugStats )
//		log("STEAMSTATS: PlayerDied resetting 'in one life' Stats - Player="$PCOwner.PlayerReplicationInfo.PlayerName);
//}

function FPMelee()
{
	if ( bDebugStats )
	log("STEAMSTATS: Completed Flashpound Melee");
	
	if ( !FPMeleeCompleted)
	{
		SetSteamAchievementCompleted(DAACHIEVEMENT_FPMelee);
	}
}

function GotObjective()
{
	if ( bDebugStats )
	log("STEAMSTATS: Completed Objective");
	
	if ( !GotObjectiveCompleted)
	{
		SetSteamAchievementCompleted(DAACHIEVEMENT_GotObjective);
	}
}

function DestroyTurret()
{
	if ( bDebugStats )
	log("STEAMSTATS: Completed Destroy Turret");
	
	if ( !DestroyTurretCompleted)
	{
		SetSteamAchievementCompleted(DAACHIEVEMENT_DestroyTurret);
	}
}

function TurretsBuild()
{
	if ( bDebugStats )
	log("STEAMSTATS: Completed Turrets Build");
	
	if ( !TurretsBuildCompleted)
	{
		SetSteamAchievementCompleted(DAACHIEVEMENT_TurretsBuild);
	}
}

function StunTurret()
{
	if ( bDebugStats )
	log("STEAMSTATS: Completed Stun Turret");
	
	if ( !StunTurretCompleted)
	{
		SetSteamAchievementCompleted(DAACHIEVEMENT_StunTurret);
	}
}

function MedicHealing()
{
	if ( bDebugStats )
	log("STEAMSTATS: Completed Medic Healing");
	
	if ( !MedicHealingCompleted)
	{
		SetSteamAchievementCompleted(DAACHIEVEMENT_MedicHealing);
	}
}

function Killed15ZedsWithPlasmabomb()
{
	if ( bDebugStats )
	log("STEAMSTATS: Completed 15 Kills with PlasmaBomb");
	
	if ( !Obliterate15ZedsWithPlasmabombCompleted)
	{
		SetSteamAchievementCompleted(DAACHIEVEMENT_Obliterate15ZedsWithPlasmabomb);
	}
}

function PatriarchKilled()
{
	if ( bDebugStats )
	log("STEAMSTATS: Completed Patriarch Killed");
	
	if ( !PatriarchKilledCompleted)
	{
		SetSteamAchievementCompleted(DAACHIEVEMENT_PatriarchKilled);
	}
}

function CrawlerChampionKilled()
{
	if ( bDebugStats )
	log("STEAMSTATS: Completed Crawler Champion");
	
	if ( !CrawlerChampionKilledCompleted)
	{
		SetSteamAchievementCompleted(DAACHIEVEMENT_CrawlerChampionKilled);
	}
}

function ClotChampionKilled()
{
	if ( bDebugStats )
	log("STEAMSTATS: Completed Clot Champion");
	
	if ( !ClotChampionKilledCompleted)
	{
		SetSteamAchievementCompleted(DAACHIEVEMENT_ClotChampionKilled);
	}
}

function GorefastChampionKilled()
{
	if ( bDebugStats )
	log("STEAMSTATS: Completed Gorefast Champion");
	
	if ( !GorefastChampionKilledCompleted)
	{
		SetSteamAchievementCompleted(DAACHIEVEMENT_GorefastChampionKilled);
	}
}

function StalkerChampionKilled()
{
	if ( bDebugStats )
	log("STEAMSTATS: Completed Stalker Champion");
	
	if ( !StalkerChampionKilledCompleted)
	{
		SetSteamAchievementCompleted(DAACHIEVEMENT_StalkerChampionKilled);
	}
}

function SirenChampionKilled()
{
	if ( bDebugStats )
	log("STEAMSTATS: Completed Siren Champion");
	
	if ( !SirenChampionKilledCompleted)
	{
		SetSteamAchievementCompleted(DAACHIEVEMENT_SirenChampionKilled);
	}
}

function BloatChampionKilled()
{
	if ( bDebugStats )
	log("STEAMSTATS: Completed Bloat Champion");
	
	if ( !BloatChampionKilledCompleted)
	{
		SetSteamAchievementCompleted(DAACHIEVEMENT_BloatChampionKilled);
	}
}

function HuskChampionKilled()
{
	if ( bDebugStats )
	log("STEAMSTATS: Completed Husk Champion");
	
	if ( !HuskChampionKilledCompleted)
	{
		SetSteamAchievementCompleted(DAACHIEVEMENT_HuskChampionKilled);
	}
}

function ScrakeChampionKilled()
{
	if ( bDebugStats )
	log("STEAMSTATS: Completed Scrake Champion");
	
	if ( !ScrakeChampionKilledCompleted)
	{
		SetSteamAchievementCompleted(DAACHIEVEMENT_ScrakeChampionKilled);
	}
}

function FleshpoundChampionKilled()
{
	if ( bDebugStats )
	log("STEAMSTATS: Completed Fleshpound Champion");
	
	if ( !FleshpoundChampionKilledCompleted)
	{
		SetSteamAchievementCompleted(DAACHIEVEMENT_FleshpoundChampionKilled);
	}
}

function SurvivedSuicidal()
{
	if ( bDebugStats )
	log("STEAMSTATS: Completed Surviving suicidal difficulty");
	
	if ( !SurvivedSuicidalCompleted)
	{
		SetSteamAchievementCompleted(DAACHIEVEMENT_SurvivedSuicidal);
	}
}

function DamageDone10000()
{
	if ( bDebugStats )
	log("STEAMSTATS: Completed 10000 damage done");
	
	if ( !DamageDone10000Completed)
	{
		SetSteamAchievementCompleted(DAACHIEVEMENT_DamageDone10000);
	}
}

function DamageDone40000()
{
	if ( bDebugStats )
	log("STEAMSTATS: Completed 40000 damage inflicted");
	
	if ( !DamageDone40000Completed)
	{
		SetSteamAchievementCompleted(DAACHIEVEMENT_DamageDone40000);
	}
}

function AddHuskKill()
{
	SetStatInt(HuskKillsStat, HuskKillsStat.Value + 1);

	if ( bDebugStats )
	log("STEAMSTATS: Adding Husk Kill - NewKills="$HuskKillsStat.Value);

	if ( !IncendiaryCompleted && HuskKillsStat.Value >= 200)
	{
		SetSteamAchievementCompleted(DAACHIEVEMENT_Incendiary);
	}
}

function AddSniperKill()
{
	SetStatInt(SniperKillsStat, SniperKillsStat.Value + 1);

	if ( bDebugStats )
	log("STEAMSTATS: Adding Sniper Kill - NewKills="$SniperKillsStat.Value);

	if ( !Sniper1Completed && SniperKillsStat.Value >= 500)
	{
		SetSteamAchievementCompleted(DAACHIEVEMENT_Sniper1);
	}

	if ( !Sniper2Completed && SniperKillsStat.Value >= 2000)
	{
		SetSteamAchievementCompleted(DAACHIEVEMENT_Sniper2);
	}
}

function AddRocketKill()
{
	SetStatInt(RocketKillsStat, RocketKillsStat.Value + 1);

	if ( bDebugStats )
	log("STEAMSTATS: Adding Rocket Kill - NewKills="$GrenadeKillsStat.Value);

	if ( !RocketCompleted && RocketKillsStat.Value >= 2000)
	{
		SetSteamAchievementCompleted(DAACHIEVEMENT_Rocket);
	}
}

function AddGrenadeKill()
{
	SetStatInt(GrenadeKillsStat, GrenadeKillsStat.Value + 1);

	if ( bDebugStats )
	log("STEAMSTATS: Adding Grenade Kill - NewKills="$GrenadeKillsStat.Value);

	if ( !GrenadeCompleted && GrenadeKillsStat.Value >= 1000)
	{
		SetSteamAchievementCompleted(DAACHIEVEMENT_Grenade);
	}
}

function AddAmmoboxUse()
{
	SetStatInt(AmmoboxStat, AmmoboxStat.Value + 1);

	if ( bDebugStats )
	log("STEAMSTATS: Adding Ammobox use - NewKills="$AmmoboxStat.Value);

	if ( !AmmoboxCompleted && AmmoboxStat.Value >= 100)
	{
		SetSteamAchievementCompleted(DAACHIEVEMENT_Grenade);
	}
}

function AddMeleeKill()
{
	SetStatInt(MeleeKillsStat, MeleeKillsStat.Value + 1);

	if ( bDebugStats )
	log("STEAMSTATS: Adding Melee Kill - NewKills="$MeleeKillsStat.Value);

	if ( !MeleeKillsCompleted && MeleeKillsStat.Value >= 50)
	{
		SetSteamAchievementCompleted(DAACHIEVEMENT_MeleeKills);
	}
}

function AddZedKill(class<DamageType> damageType, int PlayerClass)
{
PCOwner = da_players_PlayerController(Owner);
	SetStatInt(ZedKillsStat, ZedKillsStat.Value + 1);
	
	switch (damagetype)
	{
		case class'da_damtypes_A9SMG':
		SetStatInt(A9Stat, A9Stat.Value + 1);
		break;
		
		case class'da_damtypes_APMine':
		SetStatInt(APMineStat, APMineStat.Value + 1);
		break;
		
		case class'da_damtypes_AVeRTurret':
		SetStatInt(AVeRStat, AVeRStat.Value + 1);
		break;
		
		case class'da_damtypes_CrusherTurret':
		SetStatInt(CrusherStat, CrusherStat.Value + 1);
		break;
		
		case class'da_damtypes_DFATurret':
		SetStatInt(DFAStat, DFAStat.Value + 1);
		break;
		
		case class'da_damtypes_EMPGrenade':
		SetStatInt(EMPStat, EMPStat.Value + 1);
		break;
		
		case class'da_damtypes_GK2Shotgun':
		SetStatInt(GK2Stat, GK2Stat.Value + 1);
		break;
		
		case class'da_damtypes_HandGrenade':
		SetStatInt(HandGrenadeStat, HandGrenadeStat.Value + 1);
		break;
		
		case class'da_damtypes_LK2Shotgun':
		SetStatInt(LK2Stat, LK2Stat.Value + 1);
		break;
		
		case class'da_damtypes_Melee':
		SetStatInt(MeleeStat, MeleeStat.Value + 1);
		break;
		
		case class'da_damtypes_MR40Heavy':
		SetStatInt(MR40Stat, MR40Stat.Value + 1);
		break;
		
		case class'da_damtypes_MR56Rifle':
		SetStatInt(MR56Stat, MR56Stat.Value + 1);
		break;
		
		case class'da_damtypes_MS25RocketLauncher':
		SetStatInt(MS25Stat, MS25Stat.Value + 1);
		break;
		
		case class'da_damtypes_NuclearGrenade':
		SetStatInt(NuclearGrenadeStat, NuclearGrenadeStat.Value + 1);
		break;
		
		case class'da_damtypes_p280Pistol':
		SetStatInt(P280Stat, P280Stat.Value + 1);
		break;
		
		case class'da_damtypes_PlasmaBomb':
		SetStatInt(PlasmaStat, PlasmaStat.Value + 1);
		break;
		
		case class'da_damtypes_Sniper':
		SetStatInt(SniperStat, SniperStat.Value + 1);
		break;
		
		case class'da_damtypes_SniperHeadshot':
		SetStatInt(SniperHeadshotStat, SniperheadshotStat.Value + 1);
		break;
		
		case class'da_damtypes_ThermiteGrenade':
		SetStatInt(ThermiteStat, ThermiteStat.Value + 1);
		break;
		
		case class'da_damtypes_XD40Pistol':
		SetStatInt(XD40Stat, XD40Stat.Value + 1);
		break;
	}
	
	switch (playerClass)
	{
		case 0:
		SetStatInt(RifKillsStat, RifKillsStat.Value + 1);
		break;
		
		case 1:
		SetStatInt(MechKillsStat, MechKillsStat.Value + 1);
		break;
		
		case 2:
		SetStatInt(MedKillsStat, MedKillsStat.Value + 1);
		break;
		
		case 3:
		SetStatInt(MGKillsStat, MGKillsStat.Value + 1);
		break;
		
		case 4:
		SetStatInt(SnipKillsStat, SnipKillsStat.Value + 1);
		break;
		
		case 5:
		SetStatInt(RockKillsStat, RockKillsStat.Value + 1);
		break;
		
		case 6:
		SetStatInt(EngKillsStat, EngKillsStat.Value + 1);
		break;
	}

	if ( bDebugStats )
	log("STEAMSTATS: Adding Kill - NewKills="$ZedKillsStat.Value @ "Player="$PCOwner.PlayerReplicationInfo.PlayerName);
}

function AddScore(float Score, int PlayerClass)
{
ScoreCount += Score;

	If (ScoreCount >= 1)
	{
		PCOwner = da_players_PlayerController(Owner);

		SetStatInt(ScoreStat, ScoreStat.Value + 1);
		
		if ( !KillXEnemiesCompleted && ScoreStat.Value >= 12000 )
		{
			SetSteamAchievementCompleted(DAACHIEVEMENT_KillXEnemies);
		}

		if ( !KillXEnemies2Completed && ScoreStat.Value >= 48000 )
		{
			SetSteamAchievementCompleted(DAACHIEVEMENT_KillXEnemies2);
		}

		if ( !KillXEnemies3Completed && ScoreStat.Value >= 144000 )
		{
			SetSteamAchievementCompleted(DAACHIEVEMENT_KillXEnemies3);
		}
		
		switch (playerClass)
		{
			case 0:
			SetStatInt(RifScoreStat, RifScoreStat.Value + 1);
			if ( bDebugStats ) log("STEAMSTATS: Adding Riflemen Score - New Total Score="$RifScoreStat.Value @ "For Class="$PlayerClass);
			break;
			
			case 1:
			SetStatInt(MechScoreStat, MechScoreStat.Value + 1);
			if ( bDebugStats ) log("STEAMSTATS: Adding Mechanic Score - New Total Score="$MechScoreStat.Value @ "For Class="$PlayerClass);
			break;
			
			case 2:
			SetStatInt(MedScoreStat, MedScoreStat.Value + 1);
			if ( bDebugStats ) log("STEAMSTATS: Adding Medic Score - New Total Score="$MedScoreStat.Value @ "For Class="$PlayerClass);
			break;
			
			case 3:
			SetStatInt(MGScoreStat, MGScoreStat.Value + 1);
			if ( bDebugStats ) log("STEAMSTATS: Adding MG Score - New Total Score="$MGScoreStat.Value @ "For Class="$PlayerClass);
			break;
			
			case 4:
			SetStatInt(SnipScoreStat, SnipScoreStat.Value + 1);
			if ( bDebugStats ) log("STEAMSTATS: Adding Sniper Score - New Total Score="$SnipScoreStat.Value @ "For Class="$PlayerClass);
			break;
			
			case 5:
			SetStatInt(RockScoreStat, RockScoreStat.Value + 1);
			if ( bDebugStats ) log("STEAMSTATS: Adding Rocketeer Score - New Total Score="$RockScoreStat.Value @ "For Class="$PlayerClass);
			break;
			
			case 6:
			SetStatInt(EngScoreStat, EngScoreStat.Value + 1);
			if ( bDebugStats ) log("STEAMSTATS: Adding Engineer Score - New Total Score="$EngScoreStat.Value @ "For Class="$PlayerClass);
			break;
		}
		
		if ( bDebugStats ) 
			log("STEAMSTATS: Adding Score - New Total Score="$ScoreStat.Value @ "Player="$PCOwner.PlayerReplicationInfo.PlayerName);
			
	ScoreCount -= 1;
	}
}

Simulated function int GetPlayerRank()
{
local int rank;

	if (ScoreStat.Value >= 240000 )
		rank = 9;
	else if (ScoreStat.Value >= 180000 )
		rank = 8;
	else if (ScoreStat.Value >= 120000 )
		rank = 7; //Commander 1
	else if (ScoreStat.Value >= 96000 )
		rank = 6;
	else if (ScoreStat.Value >= 72000 )
		rank = 5;
	else if (ScoreStat.Value >= 48000 )
		rank = 4; //Captain 1
	else if (ScoreStat.Value >= 36000 )
		rank = 3;
	else if (ScoreStat.Value >= 24000 )
		rank = 2;
	else if (ScoreStat.Value >= 12000 )
		rank = 1; //Private 1
	else
		rank = 0;
return rank;
}

defaultproperties
{
     SteamNameStat(0)="HuskKills"
     SteamNameStat(1)="ZedKills"
     SteamNameStat(2)="SniperKills"
     SteamNameStat(3)="RocketKills"
     SteamNameStat(4)="GrenadeKills"
     SteamNameStat(5)="AmmoboxUses"
     SteamNameStat(6)="MeleeKills"
     SteamNameStat(7)="TotalScore"
     SteamNameStat(8)="RiflemanScore"
     SteamNameStat(9)="RiflemanKills"
     SteamNameStat(10)="MechanicScore"
     SteamNameStat(11)="MechanicKills"
     SteamNameStat(12)="MedicScore"
     SteamNameStat(13)="MedicKills"
     SteamNameStat(14)="MachineGunnerScore"
     SteamNameStat(15)="MachineGunnerKills"
     SteamNameStat(16)="SniperScore"
     SteamNameStat(17)="SnipKills"
     SteamNameStat(18)="RocketeerScore"
     SteamNameStat(19)="RocketeerKills"
     SteamNameStat(20)="EngineerScore"
     SteamNameStat(21)="EngineerKills"
     SteamNameStat(22)="A9SMGKills"
     SteamNameStat(23)="APMineKills"
     SteamNameStat(24)="AVeRKills"
     SteamNameStat(25)="CrusherKills"
     SteamNameStat(26)="DFAKills"
     SteamNameStat(27)="EMPKills"
     SteamNameStat(28)="GK2Kills"
     SteamNameStat(29)="HandGrenadeKills"
     SteamNameStat(30)="LK2Kills"
     SteamNameStat(31)="MeleeWeaponKills"
     SteamNameStat(32)="MR40Kills"
     SteamNameStat(33)="MR56Kills"
     SteamNameStat(34)="MS25Kills"
     SteamNameStat(35)="NuclearGrenadeKills"
     SteamNameStat(36)="P280Kills"
     SteamNameStat(37)="PlasmaKills"
     SteamNameStat(38)="SniperGunKills"
     SteamNameStat(39)="SniperHeadshotKills"
     SteamNameStat(40)="ThermiteKills"
     SteamNameStat(41)="XD40Kills"
     SteamNameAchievement(0)="Obliterate15ZedsWithPlasmabomb"
     SteamNameAchievement(1)="IncendiaryBullets"
     SteamNameAchievement(2)="AdvancedGunnerRank"
     SteamNameAchievement(3)="AlliangeCaptainRank"
     SteamNameAchievement(4)="SupremeCommanderRank"
     SteamNameAchievement(5)="Sniper1Upgrade"
     SteamNameAchievement(6)="Sniper2Upgrade"
     SteamNameAchievement(7)="NuclearRockets"
     SteamNameAchievement(8)="NuclearGrenades"
     SteamNameAchievement(9)="AmmoUpdate"
     SteamNameAchievement(10)="PatriarchKilled"
     SteamNameAchievement(11)="SurvivedSuicidal"
     SteamNameAchievement(12)="10000DamageInflicted"
     SteamNameAchievement(13)="40000DamageInflicted"
     SteamNameAchievement(14)="CrawlerChampionKilled"
     SteamNameAchievement(15)="ClotChampionKilled"
     SteamNameAchievement(16)="GorefastChampionKilled"
     SteamNameAchievement(17)="StalkerChampionKilled"
     SteamNameAchievement(18)="SirenChampionKilled"
     SteamNameAchievement(19)="BloatChampionKilled"
     SteamNameAchievement(20)="HuskChampionKilled"
     SteamNameAchievement(21)="ScrakeChampionKilled"
     SteamNameAchievement(22)="FleshpoundChampionKilled"
     SteamNameAchievement(23)="DestroyTurret"
     SteamNameAchievement(24)="MedicHealing"
     SteamNameAchievement(25)="StunTurret"
     SteamNameAchievement(26)="TurretsBuild"
     SteamNameAchievement(27)="GotObjective"
     SteamNameAchievement(28)="MeleeKills50"
     SteamNameAchievement(29)="MeleedFleshpound"
}
