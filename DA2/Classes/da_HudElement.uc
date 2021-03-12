//-----------------------------------------------------------
//
//-----------------------------------------------------------
class da_HudElement extends Actor;

var da_players_Hud hud;
var da_HudElementList myList;
var PlayerController playerOwner;

function init(da_HudElementList list, da_players_Hud h) {
    hud = h;
    myList = list;
    playerOwner = hud.playerOwner;
}

function da_players_PRI PRI()
{
    if( hud != none )
    {
        return hud.PRI;
    }

    return none;
}

function da_players_ClassPlayer pawnOwner() {
    return da_players_ClassPlayer(hud.PawnOwner);
}

function postRender(Canvas c);
function updateHudData();

defaultproperties
{
     bHidden=True
     RemoteRole=ROLE_None
}
