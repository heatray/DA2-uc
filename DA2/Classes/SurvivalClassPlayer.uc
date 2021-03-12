class SurvivalClassPlayer extends da_players_ClassPlayer;
//This shit doesn't work
simulated function BeginState()
{
    Super.BeginState();

            skins[0]=texture'DA2PlayerSkins.Frontline_Body_damage';
            skins[1]=texture'DA2PlayerSkins.Frontline_Head_damage';  
}

defaultproperties
{
}
