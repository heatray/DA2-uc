//-----------------------------------------------------------
// AmbFXManager
// Spawns FX and SFX at random places and time and can trigger
// other stuff. Chained with other AmbFXManagers this can be
// used to create a complex ambience for maps.
// coded by: Leviathan
//-----------------------------------------------------------
class da_map_AmbFXManager extends Triggers;

var(AmbFXManager) int FXSpread;
var(AmbFXManager) rangevector FXArea;
var(AmbFXManager) bool AreaRelativeToDir;
var(AmbFXManager) range Delay, Loops;
var(AmbFXManager) array<Class<Actor> > FXClass;
var(AmbFXManager) array<sound> SFX;
var(AmbFXManager) range SFXVolume, SFXRadius, SFXPitch;
var(AmbFXManager) bool Active;

var int loopsRemain;

function BeginPlay() {
    if(active)
        StartTimer();
}

function StartTimer()
{
    loopsRemain=MMrand(loops);
    SetTimer(MMRand(delay)+0.0001,false);
}

event Timer() {
    local actor fx;
    local vector start;
    local rotator dir;

    if(!active) return;

    start.x+=MMRand(FXArea.x);
    start.y+=MMRand(FXArea.y);
    start.z+=MMRand(FXArea.z);
    if(arearelativetodir)
        start=start>>rotation;

    dir.pitch+=(frand()-0.5)*FXSpread;
    dir.yaw+=(frand()-0.5)*FXSpread;

    if(fxclass.length>0) fx=spawn(FXClass[rand(fxclass.length)],,,location+start,rotation+dir);

    if(sfx.length>0) {
        if(fx!=none)
            fx.PlayOwnedSound(SFX[rand(sfx.length)],SLOT_None, MMRand(SFXVolume),,MMrand(SFXRadius), MMRand(SFXPitch));
        else
            PlaySound(SFX[rand(sfx.length)],SLOT_None, MMRand(SFXVolume),,MMrand(SFXRadius), MMRand(SFXPitch));
    }

    TriggerEvent( Event, Self, None);

    loopsRemain--;
    if(loopsRemain==0)
        active=false;
    else SetTimer(MMRand(delay)+0.0001,false);
}

event Trigger( Actor Other, Pawn EventInstigator ) {
    if(loops.min==0 && loops.Max==0)
        Active=!active;
    else Active=true;
    StartTimer();

    super.Trigger(other, eventinstigator);
}

event UnTrigger( Actor Other, Pawn EventInstigator ) {
    Active=false;
    SetTimer(0,false);
    super.Trigger(other, eventinstigator);
}

function float MMRand(range In) {
    local float min;

    min=fmin(In.Min, In.Max);
    return frand()*(fmax(In.Min, In.Max)-min)+min;
}

function Reset() {
	Active=default.active;
}

defaultproperties
{
     AreaRelativeToDir=True
     Delay=(Min=5.000000,Max=10.000000)
     Loops=(Min=1.000000,Max=1.000000)
     SFXVolume=(Min=0.900000,Max=1.100000)
     SFXRadius=(Min=300.000000,Max=500.000000)
     SFXPitch=(Min=0.900000,Max=1.100000)
     Active=True
     Rotation=(Pitch=16384)
     Texture=Texture'DA2Textures.editing.Planetbomb'
     bDirectional=True
}
