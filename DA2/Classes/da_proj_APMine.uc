//=============================================================================
// A anti-personnel, sticky mine.
// Coded by: Leviathan
//=============================================================================
class da_proj_APMine extends da_weapons_BasicGrenade;

var bool activated, triggered, launched;

replication
{
    reliable if (bNetDirty && Role == ROLE_Authority)
        triggered, launched, activated;
}


simulated function PostBeginPlay()
{
    RandSpin(20000);

    super.PostBeginPlay();

    if(BotFear!=none)
        BotFear.TeamNum=team;
}

simulated function HitWall( vector HitNormal, actor Wall )
{
    if(Physics==PHYS_None) return;

	SetPhysics(PHYS_None);
	SetRotation(rotator(hitnormal));
	SetLocation(location-vector(rotation));
	SetCollisionSize(4, 2);
	DesiredRotation = Rotation;
	DesiredRotation.Roll = 0;
	DesiredRotation.Pitch = 0;
	SetTimer(0.8,false);

	FX=Spawn(class'da2.da_effects_minefx', self);
    if(FX!=none) FX.SetBase(self);

    if ( (Level.NetMode != NM_DedicatedServer) && (Speed > 250) )
	    PlaySound(ImpactSound,SLOT_Misc,1,,100,0.975+frand()*0.05);
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
    if(launched) setlocation(location+vector(rotation)*50);

    hitnormal=GetMatType();
    if(hitnormal==vect(0,0,0))
        hitnormal=vect(0,0,1);

    PlaySound(ExplosionSound,SLOT_Misc,TransientSoundVolume,,TransientSoundRadius);

    if ( EffectIsRelevant(Location,false) )
    {
        Spawn(MaterialFX[matType],,, Location, rotator(hitnormal));
        Spawn(ExplosionEmitter,,, Location, rotator(hitnormal));
		Spawn(ExplosionDecal,self,,Location, rotator(-HitNormal));
    }

    BlowUp(Location);
}

simulated function Timer()
{
    local pawn victim;
    local controller c;

    if(triggered) {
        Destroy();
        return;
    }

    if(!activated) {
        activated=true;
        SetTimer(0.4,true);
    }

    for(C=Level.ControllerList; C!=None; C=C.NextController) {
        if(c.pawn==none || unrealpawn(c.pawn)==none || vsize((Location+vector(rotation)*60)-c.Pawn.Location)>100)
            continue;
        victim=unrealpawn(c.pawn);
        if(victim.health>0 && victim.PlayerReplicationInfo!=none && victim.PlayerReplicationInfo.team.teamindex!=team || victim.isa('monster')) {
            triggered=true;
            bHidden=true;
            launched=true;
            if(FX!=none) fx.Destroy();
            Spawn(class'DA2.da_effects_minelaunch',self,,Location);
            PlaySound(Sound'DA2_WeaponSounds.MineLaunch',SLOT_Misc,1.6,,100);
            SetTimer(0.4,false);
            return;
        }
    }
}

function TakeDamage(int Damage, Pawn instigatedBy, Vector hitlocation, Vector momentum, class<DamageType> damageType, optional int HitIndex)
{
    if(damagetype==mydamagetype) damage/=5;

    if(!triggered && damage>=armor && armor>0) {
      //SetTimer(0.1+frand()*0.15, false);
      lifespan=0.1+frand()*0.15;
      Triggered=true;
      bProjTarget=false;
      Destroy();
    }
}

defaultproperties
{
     BotFearClass=Class'DA2.da_triggers_BotFearMine'
     ExplosionEmitter=Class'DA2.da_effects_MineExplosion'
     ExplosionSound=Sound'DA2_WeaponSounds.explosions.MineExplode'
     ExplosionSoundFar=Sound'DA2_WeaponSounds.explosions.MineExplodeFar'
     Dispersion=200.000000
     Armor=15.000000
     BlastPenetration=0.250000
     Speed=400.000000
     MaxSpeed=800.000000
     Damage=200.000000
     DamageRadius=600.000000
     MomentumTransfer=80000.000000
     MyDamageType=Class'DA2.da_damtypes_APMine'
     ImpactSound=Sound'DA2_WeaponSounds.Misc.MineActivate'
     StaticMesh=StaticMesh'DA2_StaticMeshes.Grenades.APMine'
     bNetTemporary=False
     LifeSpan=240.000000
     DrawScale=1.500000
     AmbientGlow=32
     TransientSoundVolume=5.500000
}
