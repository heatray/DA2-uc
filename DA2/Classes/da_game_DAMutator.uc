class da_game_DAMutator extends DMMutator
    HideDropDown
    CacheExempt;

function bool CheckReplacement(Actor Other, out byte bSuperRelevant)
{
    if (Controller(Other) != None && MessagingSpectator(Other) == None)
    {
        Controller(Other).bAdrenalineEnabled = false;
        Controller(Other).PlayerReplicationInfoClass = class'da_players_PRI';
    }
    else if (Other.IsA('Pickup'))
        return false;

    return true;
}

defaultproperties
{
}
