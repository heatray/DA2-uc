class da_effects_TriggeredFX extends Emitter;

var(Emitter) array<range> ParticleNum;
var(Emitter) float LightDuration;
var float LightEnd;

event Trigger( Actor Other, Pawn EventInstigator ) {
    local da_map_AmbFXManager afm;
    local rotator dir;
    local vector loc;
    local int i;

    bDynamicLight=true;
    LightEnd=level.timeseconds+LightDuration;

    afm=da_map_AmbFXManager(other);

    if(afm!=none) {
        loc.x+=MMRand(afm.FXArea.x);
        loc.y+=MMRand(afm.FXArea.y);
        loc.z+=MMRand(afm.FXArea.z);
        SetLocation(other.location+loc);

        dir.pitch+=(frand()-0.5)*afm.FXSpread;
        dir.yaw+=(frand()-0.5)*afm.FXSpread;
        SetRotation(other.Rotation+dir);
    }

    for(i=0; i<Emitters.Length; i++)
		if( Emitters[i]!=none)
            Emitters[i].SpawnParticle(MMRand(ParticleNum[i]));

    //super.Trigger(other, eventinstigator);
}

simulated function tick(float dt)
{
    LightBrightness=default.lightBrightness*(lightend-level.timeseconds)/lightduration;
    super.tick(dt);
}

function float MMRand(range In) {
    local float min;

    min=fmin(In.Min, In.Max);
    return frand()*(fmax(In.Min, In.Max)-min)+min;
}

simulated function Timer()
{
  bDynamicLight=false;
}

defaultproperties
{
     ParticleNum(0)=(Min=1.000000,Max=5.000000)
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UniformSize=True
         AutomaticInitialSpawning=False
         CoordinateSystem=PTCS_Relative
         MaxParticles=100
         UseRotationFrom=PTRS_Actor
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         StartSizeRange=(X=(Min=40.000000,Max=80.000000))
         Texture=None
         LifetimeRange=(Min=0.200000,Max=0.400000)
     End Object
     Emitters(0)=SpriteEmitter'DA2.da_effects_TriggeredFX.SpriteEmitter0'

     LightType=LT_Steady
     LightEffect=LE_NonIncidence
     LightHue=13
     LightSaturation=160
     LightBrightness=250.000000
     LightRadius=16.000000
}
