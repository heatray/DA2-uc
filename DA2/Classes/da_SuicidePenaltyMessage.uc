class da_SuicidePenaltyMessage extends LocalMessage;

var(Messages) localized string penaltyMessage;

static function string GetString(
    optional int Switch,
    optional PlayerReplicationInfo RelatedPRI_1, 
    optional PlayerReplicationInfo RelatedPRI_2,
    optional Object OptionalObject 
    )
{
    return Default.penaltyMessage;
}

defaultproperties
{
     penaltyMessage="Penalty for suiciding"
     bIsUnique=True
     bFadeMessage=True
     DrawColor=(B=0,G=0)
     StackMode=SM_Down
     PosY=0.100000
}
