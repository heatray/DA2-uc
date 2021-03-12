// ============================================================================
// Coded by: Leviathan
// A ricocheting, body piercing bulletproj with material-effects
// ============================================================================
class da_proj_bullet extends Projectile;


var sound HitMatSound[11];
var sound RicoSound;

var class<actor> HitMatFX[20];
var class<actor> ProjFX, ExpFX;

var actor FX, lastHit;

var float SpeedRand;
var class<DamageType> HeadshotDamType;


simulated function PostBeginPlay()
{
    Velocity=(Speed+(frand()-0.5)*SpeedRand)*Vector(Rotation);

    if (Level.NetMode!=NM_DedicatedServer)
    {
        FX=Spawn(ProjFX, self,, Location, Rotation);
        if(fx!=none) FX.SetBase(self);
    }

    super.PostBeginPlay();
}

simulated function ProcessTouch( actor Other, vector HitLocation )
{
    local vector hitnormal;

    hitnormal=Normal(HitLocation-Other.Location);

    if(Other!=Instigator && other!=lasthit)
	{
        lasthit=other;

        Damage=default.damage*(vsize(velocity)/speed);
        MomentumTransfer=default.MomentumTransfer*(vsize(velocity)/speed);

        //Piercing
        if(frand()/2+0.4<vsize(velocity/default.speed)) Velocity*=0.75;
        else destroy();

		// Dante: Please check for ROLE == ROLE_Authority before calling takedamag in a simulated function
		if (ROLE == ROLE_Authority) {
			if (Pawn(Other)!=none &&  Pawn(Other).IsHeadShot(HitLocation,velocity, 1.5) )
				Other.TakeDamage(Damage*2,Instigator,HitLocation,MomentumTransfer*Normal(Velocity),HeadShotDamType);
			else Other.TakeDamage(Damage,instigator,HitLocation,MomentumTransfer*Normal(Velocity),MyDamageType);
		}

        PlaySound(HitMatSound[6],SLOT_None,TransientSoundVolume*2,,TransientSoundRadius,0.9+frand()*0.2);
    }
}

simulated function HitWall( vector HitNormal, actor Wall )
{
    local vector HL,HN;
    local vector outvec;
    local float ricochet;
    local int matType;
    local material WallMat;

    outvec=Velocity-2.0*HitNormal*(Velocity dot HitNormal);
    outvec=normal(outvec);
    ricochet=((normal(velocity) dot outvec)+1)/2;

    if(vehicle(wall)!=none)
    {
        //Ricochet
        if(0.25+frand()*2<ricochet && vsize(velocity)/speed<default.speed*0.5)
        {
            Damage=default.damage*(vsize(velocity)/speed);
            wall.TakeDamage((Damage)*(1-ricochet),instigator,Location,MomentumTransfer*Normal(Velocity),MyDamageType);

            velocity=(0.8*ricochet)*(Velocity-2.0*HitNormal*(Velocity dot HitNormal));
            Velocity+=VRand()*rand(100);

            PlaySound(RicoSound,SLOT_None,TransientSoundVolume,,TransientSoundRadius,0.85+frand()*0.3);
        }
        else
        {
			if (ROLE == ROLE_Authority)
				wall.TakeDamage(Damage,instigator,Location,MomentumTransfer*Normal(Velocity),MyDamageType);
            Explode(Location, outvec);
        }

        PlaySound(HitMatSound[3],SLOT_None,TransientSoundVolume,,TransientSoundRadius,0.9+frand()*0.2);

        if ( EffectIsRelevant(Location,false) )
    	    Spawn(HitMatFX[3],,,Location+outvec*ExploWallOut,rotator(outvec));
    }
    else
    {
        if(wall.surfacetype!=0) matType=wall.surfacetype;
        else
        {
            Trace(hl,hn,location+vect(32,0,0)*vector(rotation),Location,false,,WallMat);
            if(WallMat!=None) matType=WallMat.SurfaceType;
        }

        //Ricochet
        if(0.3+frand()*3<ricochet && vsize(velocity)/speed<default.speed*0.5)
        {
            velocity=(0.8*ricochet)*(Velocity-2.0*HitNormal*(Velocity dot HitNormal));
            Velocity+=VRand()*rand(100);

            PlaySound(RicoSound,SLOT_None,TransientSoundVolume,,TransientSoundRadius,0.85+frand()*0.3);
        }
        else
        {
			if (ROLE == ROLE_Authority)
				wall.TakeDamage(Damage,instigator,Location,MomentumTransfer*Normal(Velocity),MyDamageType);
            Explode(Location, outvec);
        }

        PlaySound(HitMatSound[matType],SLOT_None,TransientSoundVolume,,TransientSoundRadius,0.9+frand()*0.2);

        if ( EffectIsRelevant(Location,false) )
    	    Spawn(HitMatFX[matType],,,Location+outvec*ExploWallOut,rotator(outvec));
    }
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
    if ( EffectIsRelevant(hitLocation,false) )
    {
    	Spawn(ExpFX,,,HitLocation + HitNormal*ExploWallOut,rotator(HitNormal));

        if ( (ExplosionDecal != None) && (Level.NetMode != NM_DedicatedServer) )
			Spawn(ExplosionDecal,self,,Location, rotator(-HitNormal));
    }
}

/*simulated function tick(float dt)
{
    setrotation(rotator(velocity));
}*/

simulated function Landed( vector HitNormal )
{
    HitWall( HitNormal, None );
}

simulated function Destroyed()
{
	Super.Destroyed();

    if( FX != none )
        fx.Destroy();
}

defaultproperties
{
     HitMatSound(0)=Sound'DA2_Various.HitSounds.bullethitdirt'
     HitMatSound(1)=Sound'DA2_Various.HitSounds.BulletHitStone'
     HitMatSound(2)=Sound'DA2_Various.HitSounds.BulletHitSand'
     HitMatSound(3)=Sound'DA2_Various.HitSounds.bullethitmetal'
     HitMatSound(4)=Sound'DA2_Various.HitSounds.bullethitwood'
     HitMatSound(5)=Sound'DA2_Various.HitSounds.bullethitdirt'
     HitMatSound(6)=Sound'DA2_Various.HitSounds.BulletHitFlesh'
     HitMatSound(7)=Sound'DA2_Various.HitSounds.BulletHitStone'
     HitMatSound(8)=Sound'DA2_Various.HitSounds.BulletHitSand'
     HitMatSound(9)=Sound'DA2_Various.HitSounds.bullethitdirt'
     HitMatSound(10)=Sound'DA2_Various.HitSounds.bullethitglass'
     RicoSound=Sound'DA2_Various.HitSounds.BulletRicochet'
     HitMatFX(0)=Class'DA2.da_effects_BulletHitRock'
     HitMatFX(1)=Class'DA2.da_effects_BulletHitRock'
     HitMatFX(2)=Class'DA2.da_effects_BulletHitDirt'
     HitMatFX(3)=Class'DA2.da_effects_BulletHitMetal'
     HitMatFX(4)=Class'DA2.da_effects_BulletHitWood'
     HitMatFX(5)=Class'DA2.da_effects_BulletHitDirt'
     HitMatFX(6)=Class'DA2.da_effects_BulletHitFlesh'
     HitMatFX(7)=Class'DA2.da_effects_BulletHitSnow'
     HitMatFX(8)=Class'DA2.da_effects_BulletHitSnow'
     HitMatFX(10)=Class'KFMod.GlassHitEmitter'
     HitMatFX(11)=Class'DA2.da_effects_BulletHitDirt'
     HitMatFX(12)=Class'DA2.da_effects_BulletHitRock'
     HitMatFX(13)=Class'DA2.da_effects_BulletHitWood'
     HitMatFX(14)=Class'DA2.da_effects_BulletHitDirt'
     HitMatFX(15)=Class'DA2.da_effects_BulletHitMetal'
     HitMatFX(16)=Class'DA2.da_effects_BulletHitWood'
     HitMatFX(17)=Class'DA2.da_effects_BulletHitDirt'
     HitMatFX(18)=Class'DA2.da_effects_BulletHitDirt'
     HitMatFX(19)=Class'DA2.da_effects_BulletHitDirt'
     ProjFX=Class'DA2.da_effects_Tracer'
     ExpFX=Class'DA2.da_effects_BulletHit'
     SpeedRand=500.000000
     Speed=8000.000000
     MaxSpeed=10000.000000
     Damage=25.000000
     MyDamageType=None
     ExplosionDecal=Class'ROEffects.BulletHoleDirt'
     ExploWallOut=2.000000
     DrawType=DT_None
     TransientSoundVolume=0.600000
     TransientSoundRadius=200.000000
}
