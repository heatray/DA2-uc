class da_proj_AVRocket extends da_proj_rocket;

var vector TargetLoc;
var bool hasTarget;

replication
{
    reliable if( bNetInitial && (Role==ROLE_Authority) )
        hasTarget, TargetLoc;
}


simulated function PostBeginPlay()
{
    super.PostBeginPlay();

    Velocity.z+=rand(20)+10;
    Settimer(0.15, true);
}

simulated function postNetBeginPlay() {
    super(da_proj_projectile).postNetBeginPlay();
}

simulated function Timer()
{
	local float seek, VelMag;
	local vector ForceDir;

    if(TargetLoc==vect(0,0,0) || Instigator != none && VSize(Location - targetLoc) > VSize(Instigator.location-targetloc) * 0.75)
        return;

    if(hasTarget) seek=0.3;
    else seek=0.1;

    ForceDir=Normal(TargetLoc-Location);
    if((ForceDir Dot normal(velocity))>0 ) {
	    VelMag = VSize(Velocity);
	    ForceDir = Normal(ForceDir * seek * VelMag + Velocity);
	    Velocity =  VelMag * ForceDir;
	    SetRotation(rotator(Velocity));
	}
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
    super(da_proj_projectile).Explode(hitlocation, hitnormal);
}

defaultproperties
{
     ExplosionEmitter=Class'DA2.da_effects_HEDPExplosion'
     MaterialFX(1)=Class'DA2.da_effects_CrushRock'
     MaterialFX(2)=Class'DA2.da_effects_CrushDirt'
     MaterialFX(3)=Class'DA2.da_effects_CrushMetal'
     MaterialFX(4)=Class'DA2.da_effects_CrushRock'
     MaterialFX(5)=Class'DA2.da_effects_CrushDirt'
     MaterialFX(7)=Class'DA2.da_effects_CrushSnow'
     MaterialFX(8)=Class'DA2.da_effects_CrushSnow'
     MaterialFX(10)=Class'DA2.da_effects_CrushDirt'
     HitMetalSound=Sound'DA2_Various.explosions.CrushHitMetal'
     ExplosionSound=None
     ExplosionSounds(0)=Sound'DA2_Various.explosions.CrushExp1'
     ExplosionSounds(1)=Sound'DA2_Various.explosions.CrushExp2'
     ExplosionSounds(2)=Sound'DA2_Various.explosions.CrushExp3'
     ExplosionSoundFar=Sound'DA2_Various.explosions.CrushExpFar'
     ExpSoundsNum=3
     Dispersion=40.000000
     ProjFX=Class'DA2.da_effects_AVRocketFX'
     ProjTrail=Class'DA2.da_effects_AVRocketTrail'
     Speed=900.000000
     MaxSpeed=3300.000000
     Damage=50.000000
     DamageRadius=175.000000
     MomentumTransfer=15000.000000
     MyDamageType=Class'DA2.da_damtypes_AVeRTurret'
     ExplosionDecal=Class'DA2.da_effects_CrusherDecal'
     DrawScale=1.000000
     DrawScale3D=(X=2.200000,Y=0.300000,Z=0.300000)
     PrePivot=(X=-10.000000)
     TransientSoundVolume=2.500000
     TransientSoundRadius=250.000000
     CollisionRadius=3.000000
     CollisionHeight=3.000000
     ForceRadius=80.000000
}
