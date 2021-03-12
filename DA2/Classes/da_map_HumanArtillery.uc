//-----------------------------------------------------------
//
//-----------------------------------------------------------
class da_map_HumanArtillery extends da_map_Artillery;

var() int artilleryShots;
var() int spread;

function spawnShot() {
    local rotator r;
    local int i;
    r.yaw *= 1 + (FRand() - 0.5) / 10;
    r.pitch *= 1 + (FRand() - 0.5) / 10;
    r.roll *= 1 + (FRand() - 0.5) / 10;
    for (i=0; i<artilleryShots; i++)
        spawn(projectileClass, self,, location + VRand() * spread , rotation);
}

defaultproperties
{
     artilleryShots=10
     Spread=300
     CollisionRadius=256.000000
     CollisionHeight=32.000000
}
