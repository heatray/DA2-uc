//-----------------------------------------------------------
//
//-----------------------------------------------------------
class da_map_Artillery extends Actor placeable;

var(Artillery) float initialDelay;
var(Artillery) Range waitDuration;
var(Artillery) bool bTriggered;
var class<Projectile> projectileClass;

function beginPlay() {
    if (!bTriggered)
        setTimer(initialDelay, false);
}

function Trigger(Actor Other, Pawn EventInstigator) {
    if (bTriggered)
        setTimer(initialDelay, false);
}

function UnTrigger(Actor Other, Pawn EventInstigator) {
    if (bTriggered)
        setTimer(0.0, false);
}

function timer() {
    spawnShot();
    setTimer(waitDuration.Min + (waitDuration.Max - waitDuration.Min) * frand(), false);
}

function spawnShot() {
    local rotator r;
    r.yaw *= 1 + (FRand() - 0.5) / 10;
    r.pitch *= 1 + (FRand() - 0.5) / 10;
    r.roll *= 1 + (FRand() - 0.5) / 10;

    spawn(projectileClass, self,, location, rotation);
}

defaultproperties
{
     ProjectileClass=Class'DA2.da_proj_HumanArtilleryProjectile'
     bHidden=True
     Texture=Texture'DA2Textures.editing.Artillery'
     bDirectional=True
}
