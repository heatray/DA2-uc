class da_effects_HitHack extends Actor;

var vector hitLoc;
var rotator hitRot;
var Class<Actor> hitClass;
var name hideBone;
var xPawn hideBonePawn;
var bool bAttached;

replication {
    reliable if (ROLE == ROLE_Authority)
        hitClass, hideBone, hideBonePawn, bAttached;
}


simulated function tick(float deltaTime) {
    local actor a;

	if (hitClass != none)
	    a=spawn(hitClass,,, location, rotation);
	if (hideBonePawn != none) {
	    if (a!=none && bAttached)
	        hideBonePawn.AttachToBone(a, hideBone);
		else hideBonePawn.hideBone(hideBone);
	}
    disable('tick');
}

defaultproperties
{
     DrawType=DT_Mesh
     RemoteRole=ROLE_SimulatedProxy
     LifeSpan=0.200000
}
