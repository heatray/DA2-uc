class SurvivalPlayerReplicationInfo extends da_players_PRI;
var float eventTime;
var string eventMessage;
var Color eventColor;
var int totalDamageDone;
var int DamageDone;

replication
{
	reliable if ( ROLE == ROLE_Authority)
		eventTime, eventMessage, eventColor, totalDamageDone;	
}

simulated function AddEventMessage(string message, Color msgColor, float displayTime)
{
	eventTime = displayTime+Level.TimeSeconds;
	eventMessage = message;
	eventColor = msgColor;
}

defaultproperties
{
}
