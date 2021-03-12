//-----------------------------------------------------------
//
//-----------------------------------------------------------
class da_HudElementList extends Actor;

var array<da_HudElement> list;
var da_players_Hud hud;
var bool bgamePlayHud;
var bool bSpectatorHud;
var bool bShowWhenDead;

function init(da_players_Hud h) {
    hud = h;
}

final function da_HudElement addHudElement(class<da_HudElement> hudElementClass) {
    local da_HudElement element;
    element = spawn(hudElementClass, owner);
    if (element != none) {
        element.init(self, hud);
        list[list.length] = element;
    } else
        warn("Couldn't create an instance of"@hudElementClass);
    return element;
}

function bool isActive() {
    return (bSpectatorHud && hud.PlayerOwner.IsSpectating() ||
        (hud.pawnOwner != none && hud.pawnOwner.health > 0 || bShowWhenDead) && bgamePlayHud && !hud.PlayerOwner.IsSpectating());
}

function postRender(Canvas c) {
    local int i;
    if (!isActive())
        return;
    for (i = 0; i < list.length; i++)
        list[i].postRender(c);
}

function updateHudData() {
    local int i;
    if (!isActive())
        return;
    for (i = 0; i < list.length; i++)
        list[i].updateHudData();
}

defaultproperties
{
     bHidden=True
     RemoteRole=ROLE_None
}
