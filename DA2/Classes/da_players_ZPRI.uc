//=============================================================================
// da_players_ZPRI.
//=============================================================================
class da_players_ZPRI extends da_players_PRI
	placeable;


var int zLeft;
var kfrules g;

replication
{
	// Things the server should send to the client.
	reliable if ( bNetDirty && (Role == Role_Authority) )
		zLeft;
	reliable if ( (Role == Role_Authority) )
		g;

}

function postbeginplay()
{
    local kfrules a;

    super.postbeginplay();

    foreach allactors(class'kfrules', a)
    if(a!=none)
    g=a;
}

function timer()
{
    local actor a;
    local Controller C;

    if( G != none )
    {
        zleft = class'mutkf'.default.killsforpat - G.mdead;
    }

	UpdatePlayerLocation();
	SetTimer(1.5 + FRand(), true);
	if( FRand() < 0.65 )
		return;

	if( !bBot )
	{
	    C = Controller(Owner);
		if ( C != none && !bReceivedPing )
			Ping = Min(int(0.25 * float(C.ConsoleCommand("GETPING"))),255);
	}
}

defaultproperties
{
}
