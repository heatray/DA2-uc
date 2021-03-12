class da_CheatManager extends CheatManager;

var	localized string	CheatsNotEnabled;
var	localized string	EnablingCheatsKillsPerks;
var	localized string	CheatsEnabled;

/** check if cheats are enabled, if not playing a SP game always return true */
function bool areCheatsEnabled()
{
	if ( class'ROEngine.ROLevelInfo'.static.RODebugMode() )
	{
		return true;
	}

	if ( Level.NetMode != NM_Standalone )
	{
		return true;
	}

	if ( !bCheatsEnabled )
	{
		ClientMessage(CheatsNotEnabled$": EnableCheats");
		ClientMessage(EnablingCheatsKillsPerks);
		return false;
	}

	return true;
}

exec function EnableCheats()
{
	if ( Level.NetMode == NM_Standalone )
	{
		if ( Level.GetLocalPlayerController().SteamStatsAndAchievements != none )
		{
			Level.GetLocalPlayerController().SteamStatsAndAchievements.bUsedCheats = true;
		}

		bCheatsEnabled = true;
		ClientMessage(CheatsEnabled);
	}
}

defaultproperties
{
     CheatsNotEnabled="Cheats are NOT enabled, to enable cheats type"
     EnablingCheatsKillsPerks="Enabling cheats prevents you from obtaining Achievements"
     CheatsEnabled="Cheats enabled, you are no longer able to obtain Achievements until the map changes"
}
