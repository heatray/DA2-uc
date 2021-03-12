class da_WaitingMessage extends TimerMessage;

var name WarningMessage[2];
var localized string ObjectiveMessage;
var localized string MechanicSpawnMessage;
var localized string BuildMessage;
var localized string RepairMessage;
var localized string MedicSpawnMessage;
var localized string ShowObjectiveInfoMessage;
var localized string AttackerWinMessage;
var localized string DefenderWinMessage;
var localized string GunnerMessage;

static function string GetString(
	optional int Switch,
	optional PlayerReplicationInfo RelatedPRI_1,
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject
	)
{
	if ( Switch == 1 )
	{
		return default.ObjectiveMessage;
	}
	else if( Switch == 2 )
	{
		return default.MechanicSpawnMessage;
	}
	else if ( Switch == 3 )
	{
		return default.BuildMessage;
	}
	else if ( Switch == 4 )
	{
		return default.RepairMessage;
	}
	else if ( Switch == 5 )
	{
		return default.MedicSpawnMessage;
	}
	else if ( Switch == 6 )
	{
		return default.ShowObjectiveInfoMessage;
	}
	else if ( Switch == 7 )
	{
		return default.AttackerWinMessage;
	}
	else if ( Switch == 8 )
	{
		return default.DefenderWinMessage;
	}
	else if ( Switch == 9 )
	{
		return default.GunnerMessage;
	}

}

static function int GetFontSize(int Switch, PlayerReplicationInfo RelatedPRI1, PlayerReplicationInfo RelatedPRI2, PlayerReplicationInfo LocalPlayer)
{
	return 1;
}

static function GetPos(int Switch, out EDrawPivot OutDrawPivot, out EStackMode OutStackMode, out float OutPosX, out float OutPosY)
{
	OutDrawPivot = default.DrawPivot;
	OutStackMode = default.StackMode;
	OutPosX = default.PosX;

	switch( switch )
	{
		case 1:
			OutPosY = 0.60;
			break;
		case 3:
			OutPosY = 0.60;
			break;
		case 2:
		    OutPosY = 0.60;
		    break;
		case 4:
			OutPosY = 0.60;
			break;
		case 5:
			OutPosY = 0.60;
			break;
		case 6:
			OutPosY = 0.60;
			break;
		case 7:
			OutPosY = 0.40;
			break;
		case 8:
			OutPosY = 0.40;
			break;
		case 9:
			OutPosY = 0.60;
			break;
	}
}

static function float GetLifeTime(int Switch)
{
	switch( switch )
	{
		case 1:
			return 1;
		case 2:
		    return 5;
		case 3:
			return 0.01;
		case 4:
			return 0.01;
		case 5:
			return 5;
		case 6:
			return 5;
		case 7:
			return 8;
		case 8:
			return 8;
		case 9:
			return 0.01;
	}
}

static function ClientReceive(
	PlayerController P,
	optional int Switch,
	optional PlayerReplicationInfo RelatedPRI_1,
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject
	)
{
	super(CriticalEventPlus).ClientReceive(P, Switch, RelatedPRI_1, RelatedPRI_2, OptionalObject);

//	if ( Switch == 1 )
//	   	P.QueueAnnouncement(default.WarningMessage[Rand(2)], 1, AP_InstantOrQueueSwitch, 1);
}

static function RenderComplexMessage(
	Canvas Canvas,
	out float XL,
	out float YL,
	optional string MessageString,
	optional int Switch,
	optional PlayerReplicationInfo RelatedPRI_1,
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject
	)
{
	local int i;
	local float TempY;

	i = InStr(MessageString, "|");

	TempY = Canvas.CurY;

	//Canvas.FontScaleX = Canvas.ClipX / 1024.0;
	//Canvas.FontScaleY = Canvas.FontScaleX;
	
	Canvas.Font = class'da_players_hud'.static.GetMyMediumFont(Canvas);
	
	if ( i < 0 )
	{
		Canvas.TextSize(MessageString, XL, YL);
		Canvas.SetPos((Canvas.ClipX / 2.0) - (XL / 2.0), TempY);
		Canvas.DrawTextClipped(MessageString, false);
	}
	else
	{
		Canvas.TextSize(Left(MessageString, i), XL, YL);
		Canvas.SetPos((Canvas.ClipX / 2.0) - (XL / 2.0), TempY);
		Canvas.DrawTextClipped(Left(MessageString, i), false);

		Canvas.TextSize(Mid(MessageString, i + 1), XL, YL);
		Canvas.SetPos((Canvas.ClipX / 2.0) - (XL / 2.0), TempY + YL);
		Canvas.DrawTextClipped(Mid(MessageString, i + 1), false);
	}

	Canvas.FontScaleX = 1.0;
	Canvas.FontScaleY = 1.0;
}

defaultproperties
{
     WarningMessage(0)="HereTheyCome5"
     WarningMessage(1)="HereTheyCome2"
     ObjectiveMessage="Press '%Use%' to complete objective"
     MechanicSpawnMessage="Press '%showBuildMenu%' to place structures"
     BuildMessage="Look at structure and hold '%Button bBuild | startBuilding%' to build"
     RepairMessage="Look at structure and press '%Button bBuild | startBuilding%' to repair"
     MedicSpawnMessage="Stand near injured teammates to heal them"
     ShowObjectiveInfoMessage="Press '%showMissionObjectives%' for objective info"
     AttackerWinMessage="Attackers Won The Match!"
     DefenderWinMessage="Defenders Won The Match!"
     GunnerMessage="Press '%Use%' to operate this turret"
     bComplexString=True
     DrawColor=(G=0)
     FontSize=5
}
