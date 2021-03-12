class noturretsbuilt extends mutator config;

function prebeginplay()

{

local vehicle t;

foreach allactors(class'vehicle', t)

	{

	if(t!=none&&t.isa('da_turrets_Turret'))

		{

		da_turrets_Turret(t).bstartbuilt=false;

		}
	}
}

defaultproperties
{
     FriendlyName="Defence Alliance No Turrets Built"
     Description="Turrets that are usually built at the beginning of a game, will now be un-built"
}
