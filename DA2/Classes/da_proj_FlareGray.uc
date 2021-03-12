// ============================================================================
// Coded by: Leviathan
// Flare - flies a high arc before exploding
// ============================================================================
class da_proj_FlareGray extends da_proj_projectile;

simulated function PostBeginPlay()
{
    Super.PostBeginPlay();

    Velocity = Speed*vect(0,0,1) + vect(1,1,0)*VRand()*Dispersion;
    SetRotation(rotator(velocity));
    Acceleration = Vrand()*(dispersion/4)-vect(0,0,1)*500;

    PlayOwnedSound(sound'DA2_Various.FlareLaunch',SLOT_None,1,,300,0.95+frand()*0.1,false);
}

function Tick(float deltatime)
{
    Super.Tick(DeltaTime);
    SetRotation(rotator(velocity));
}

defaultproperties
{
     ExplosionEmitter=Class'DA2.da_effects_FlareExpGray'
     MaterialFX(1)=None
     MaterialFX(2)=None
     MaterialFX(3)=None
     MaterialFX(4)=None
     MaterialFX(5)=None
     MaterialFX(7)=None
     MaterialFX(8)=None
     MaterialFX(10)=None
     ExplosionSound=Sound'DA2_Various.Flare.FlareExplo'
     ExplosionSoundFar=Sound'DA2_Various.Flare.FlareExploFar'
     Dispersion=200.000000
     ProjFX=Class'DA2.da_effects_FlareGray'
     ProjTrail=Class'DA2.da_effects_FlareTrailGray'
     Speed=1800.000000
     Damage=0.000000
     DamageRadius=0.000000
     MomentumTransfer=0.000000
     ExploWallOut=0.000000
     LifeSpan=5.000000
     TransientSoundVolume=3.000000
     TransientSoundRadius=500.000000
     bCollideActors=False
     bProjTarget=False
}
