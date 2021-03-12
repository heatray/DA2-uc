class da_players_ClassSet extends Info placeable;

#exec TEXTURE IMPORT NAME=ClassSetIcon FILE=..\DA2\Textures\icon_classset.pcx GROUP=Icons

var(DA)	int	team;
var(DA) da_players_ClassInfo playerClasses[10];

function int GetDefaultNadeCount(int PClass)
{
 if(PClass >=0 && PClass <10)
     return playerClasses[PClass].grenadenumber;
 else
     return 0;
}

simulated function da_players_ClassInfo addClassInfo()
{
    local int i;

    for (i = 0; true; i++)
        if (playerClasses[i] == none)
        {
            playerClasses[i] = spawn(class'da_players_ClassInfo');
            return playerClasses[i];
        }
}

simulated function Destroyed()
{
    local int i;

    super.Destroyed();

	for (i = 0;i < ArrayCount(playerClasses); i++)
	{
        if (playerClasses[i] != none)
        {
            playerClasses[i].Destroy();
            playerClasses[i] = none;
        }
    }
}

defaultproperties
{
     Texture=Texture'DA2.Icons.ClassSetIcon'
}
