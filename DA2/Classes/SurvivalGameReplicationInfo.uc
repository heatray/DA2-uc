class SurvivalGameReplicationInfo extends da_game_ReplicationInfo;

var int zombieCount, zombiesKilled, livesLeft, deathPenalty, bossHealth, bossMaxHealth, numPlayers, waveCount;
var float infestationPercentage, difficulty, eventTime;
var bool sharedLives, bossAlive;
var string eventMessage;
var Color eventColor;
//var int buildCount[4];
//var int buildLimits[4];

replication {
    reliable if (ROLE == ROLE_AUTHORITY)
        zombieCount, zombiesKilled, livesLeft, infestationPercentage, sharedLives, bossAlive, numPlayers,
        deathPenalty, difficulty, bossHealth, bossMaxHealth, eventMessage, eventColor, eventTime, waveCount; 
}

defaultproperties
{
}
