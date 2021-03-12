// ============================================================================
// Coded by: Leviathan
// Generic Projectile with some more features
// ============================================================================
class da_proj_Projectile extends Projectile;

var() class<Emitter> ExplosionEmitter, MaterialFX[20];
var() sound HitMetalSound, ExplosionSound, ExplosionSounds[5], ExplosionSoundFar;
var() int ExpSoundsNum;
var() float Dispersion, Armor, BlastPenetration;
var() class<actor> ProjFX, ProjTrail;
var   bool    bDisintegrated; // This nade has been disintegrated by a siren scream.
var() sound   DisintegrateSound;// The sound of this projectile disintegrating
var int MatType;
var actor FX, Trail;
var bool bHitWater;
var byte Team;

replication
{
    reliable if(bNetInitial && Role==ROLE_Authority)
        team;
}


simulated function PostNetReceive()
{
	if( bHidden && !bDisintegrated )
	{
		Disintegrate(Location, vect(0,0,1));
	}
}


simulated function PostBeginPlay()
{
    if ( Role == ROLE_Authority )
    {
        Velocity = Speed*Vector(Rotation) + VRand()*Dispersion;
        SetRotation(rotator(velocity));

        if(instigator!=none && Instigator.HeadVolume.bWaterVolume)
        {
            bHitWater = true;
            Velocity = 0.6*Velocity;
        }
    }

    if (Level.NetMode!=NM_DedicatedServer)
    {
        FX=Spawn(ProjFX, self,, Location, Rotation);
        if(FX!=none) FX.SetBase(self);
        Trail=Spawn(ProjTrail, self,, Location, Rotation);
        if(Trail!=none) Trail.SetBase(self);
    }

    super.PostBeginPlay();

    if(Instigator!=None)
		Team=Instigator.GetTeamNum();
}



function ProcessTouch( actor Other, vector HitLocation )
{
    local vector hitnormal;

    hitnormal=Normal(HitLocation-Other.Location);

    if(Other!=Instigator)
	{
        if(pawn(other)!=none && vehicle(other)==none) mattype=6;
        else mattype=3;

        if(damageradius==0) Other.TakeDamage(Damage,instigator,HitLocation,MomentumTransfer*Normal(Velocity),MyDamageType);
		else {
			setRotation(rotator(-velocity));
			destroy();
		}
    }
}

simulated function HitWall( vector HitNormal, actor Wall )
{
    wall.TakeDamage(Damage,instigator,Location,MomentumTransfer*Normal(Velocity),MyDamageType);
    if(vehicle(wall)!=none) mattype=3;

	setRotation(rotator(hitNormal));
	destroy();
}

simulated function vector GetMatType()
{
    local vector HL,HN;
    local material WallMat;

    if(vsize(velocity)<50) Trace(hl,hn,location-vect(0,0,16),Location,false,,WallMat);
    else Trace(hl,hn,location+Normal(velocity)*32,Location,false,,WallMat);

    if(WallMat!=None)
    {
        matType=WallMat.SurfaceType;
        if(mattype==0) mattype=1;
    }
    return HN;
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
    hitnormal=GetMatType();
    if(hitnormal==vect(0,0,0))
        hitnormal=vect(0,0,1);

    if(mattype==3 && HitMetalSound!=none) PlaySound(HitMetalSound,SLOT_None,TransientSoundVolume,,TransientSoundRadius,0.9+frand()*0.2);
    else if(explosionSound!=none) PlaySound(ExplosionSound,SLOT_None,TransientSoundVolume,,TransientSoundRadius,0.9+frand()*0.2);
    else PlaySound(ExplosionSounds[rand(expSoundsNum)],SLOT_None,TransientSoundVolume,,TransientSoundRadius,0.9+frand()*0.2);
    if(ExplosionSoundFar!=none) PlaySound(explosionSoundFar,SLOT_None,TransientSoundVolume/3,,TransientSoundRadius*15,0.9+frand()*0.2);

    if ( EffectIsRelevant(Location,false) )
    {
        Spawn(MaterialFX[matType],,, HitLocation, rotator(hitnormal));
        Spawn(ExplosionEmitter,,, HitLocation, rotator(hitnormal));
		Spawn(ExplosionDecal,self,,HitLocation, rotator(-HitNormal));
    }

    BlowUp(HitLocation);
}

simulated function BlowUp(vector HitLocation)
{
	if(damageradius>0) SplashDamage(Damage, DamageRadius, MyDamageType, MomentumTransfer, HitLocation );
	if ( Role == ROLE_Authority )
		MakeNoise(1.0);
}

simulated function SplashDamage( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation )
{
	local actor Victims;
	local float damageScale, momentumscale, dist;
	local vector dir;
	local PlayerController PC;

	if(bHurtEntry)
		return;

	//viewshake and blur that will actually work in multiplayer ;) - Ramm
	if (Level.NetMode != NM_DedicatedServer)
	{
		PC = Level.GetLocalPlayerController();
		if (PC != None && PC.ViewTarget != None)
		{
			if( PC.Pawn != none && da_players_playercontroller(PC) != none )
			{

				dir=PC.Pawn.Location-HitLocation;
				dist=FMax(1,VSize(dir));
				dir=dir/dist;

	            momentumScale=(1-FMax(0,(dist-PC.Pawn.CollisionRadius)/(DamageRadius*4)))*100;
	            momentumScale=(momentumScale*momentumScale)/10000;

				if (Dist < DamageRadius * 1.0 )
				{
		                da_players_playercontroller(PC).dmgshake(momentum*momentumscale/2500, dir);
		                addblur(PC.Pawn, fmin(15, 0.1+momentum*momentumscale/20000), fmin(1, momentum*momentumscale/15000));

				}
			}
		}
	}

	bHurtEntry=true;
	foreach CollidingActors(class 'Actor', Victims, DamageRadius*4, HitLocation) {
		if((Victims!=self) && (Victims.Role==ROLE_Authority) && (!Victims.IsA('FluidSurfaceInfo'))) {
			dir=Victims.Location-HitLocation;
			dist=FMax(1,VSize(dir));
			dir=dir/dist;

			if(dist<damageradius) {
                damageScale=(1-FMax(0,(dist-Victims.CollisionRadius)/DamageRadius))*100;
                damagescale=(damagescale*damagescale)/10000;
			}
			else damagescale=0;

            momentumScale=(1-FMax(0,(dist-Victims.CollisionRadius)/(DamageRadius*4)))*100;
            momentumScale=(momentumScale*momentumScale)/10000;

			if(!FastTrace(victims.Location,hitlocation)) {
                momentumScale*=blastpenetration;
                damagescale*=blastpenetration;
            }

            if ( Instigator == None || Instigator.Controller == None )
			Victims.SetDelayedDamageInstigatorController(InstigatorController);

            if(damageamount*damagescale>0)
            {
                if ( Instigator == None || Instigator.Controller == None )
                    Victims.SetDelayedDamageInstigatorController( InstigatorController );
			    if ( Victims == LastTouched )
				    LastTouched = None;

                Victims.TakeDamage
			    (
			        DamageAmount*damagescale,
			        Instigator,
			        Victims.Location-0.5*(Victims.CollisionHeight+Victims.CollisionRadius)*dir,
			        damagescale*Momentum*dir,
			        DamageType
                );

			    if (Instigator != None && Vehicle(Victims) != None && Vehicle(Victims).Health > 0)
			        Vehicle(Victims).DriverRadiusDamage(DamageAmount, DamageRadius, Instigator.Controller, DamageType, Momentum, HitLocation);
            }
        }
	}
	if ( (LastTouched != None) && (LastTouched != self) && (LastTouched.Role == ROLE_Authority) && !LastTouched.IsA('FluidSurfaceInfo') )
	{
		Victims = LastTouched;
		LastTouched = None;
		dir = Victims.Location - HitLocation;
		dist = FMax(1,VSize(dir));
		dir = dir/dist;
		damageScale = FMax(Victims.CollisionRadius/(Victims.CollisionRadius + Victims.CollisionHeight),1 - FMax(0,(dist - Victims.CollisionRadius)/DamageRadius));
		if ( Instigator == None || Instigator.Controller == None )
			Victims.SetDelayedDamageInstigatorController(InstigatorController);
		Victims.TakeDamage
		(
			damageScale * DamageAmount,
			Instigator,
			Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dir,
			(damageScale * Momentum * dir),
			DamageType
		);
		if (Vehicle(Victims) != None && Vehicle(Victims).Health > 0)
			Vehicle(Victims).DriverRadiusDamage(DamageAmount, DamageRadius, InstigatorController, DamageType, Momentum, HitLocation);
	}
	bHurtEntry = false;
}

simulated function AddBlur(pawn p, float time, float amount)
{
	local da_players_PlayerController PC;

    pc=da_players_playercontroller(p.controller);

    if(Level.NetMode==NM_DedicatedServer || pc==none || amount<0.05 || pc!=Level.GetLocalPlayerController())
        return;

    pc.AddBlur(time, amount);
}

function TakeDamage(int Damage, Pawn instigatedBy, Vector hitlocation, Vector momentum, class<DamageType> damageType, optional int HitIndex)
{
	if(damage>=armor && armor>0) destroy();
}

simulated function Landed( vector HitNormal )
{
    HitWall( HitNormal, none );
}

simulated function Destroyed()
{
	explode(location, vector(rotation));

    if(FX!=none) fx.Destroy();
    if(emitter(trail)!=none) emitter(trail).Kill();

	Super.Destroyed();
}

// Make the projectile distintegrate, instead of explode
simulated function Disintegrate(vector HitLocation, vector HitNormal)
{
	bDisintegrated = true;
	bHidden = true;

	if( Role == ROLE_Authority )
	{
	   SetTimer(0.1, false);
	   NetUpdateTime = Level.TimeSeconds - 1;
	}

	PlaySound(DisintegrateSound,,2.0);

	if ( EffectIsRelevant(Location,false) )
	{
		Spawn(Class'KFMod.SirenNadeDeflect',,, HitLocation, rotator(vect(0,0,1)));
	}
	
	destroy();
}

defaultproperties
{
     ExplosionEmitter=Class'DA2.da_effects_HGExplosion'
     MaterialFX(1)=Class'DA2.da_effects_BlastRock'
     MaterialFX(2)=Class'DA2.da_effects_BlastDirt'
     MaterialFX(3)=Class'DA2.da_effects_BlastMetal'
     MaterialFX(4)=Class'DA2.da_effects_BlastDirt'
     MaterialFX(5)=Class'DA2.da_effects_BlastDirt'
     MaterialFX(7)=Class'DA2.da_effects_BlastSnow'
     MaterialFX(8)=Class'DA2.da_effects_BlastSnow'
     MaterialFX(10)=Class'DA2.da_effects_BlastDirt'
     MaterialFX(11)=Class'DA2.da_effects_BlastRock'
     MaterialFX(12)=Class'DA2.da_effects_BlastRock'
     MaterialFX(13)=Class'DA2.da_effects_BlastDirt'
     MaterialFX(14)=Class'DA2.da_effects_BlastDirt'
     MaterialFX(15)=Class'DA2.da_effects_BlastMetal'
     MaterialFX(16)=Class'DA2.da_effects_BlastDirt'
     MaterialFX(17)=Class'DA2.da_effects_BlastDirt'
     MaterialFX(18)=Class'DA2.da_effects_BlastDirt'
     MaterialFX(19)=Class'DA2.da_effects_BlastDirt'
     ExplosionSoundFar=Sound'DA2_WeaponSounds.explosions.Grenade_ExplosionFar'
     Dispersion=500.000000
     BlastPenetration=0.300000
     DisintegrateSound=Sound'Inf_Weapons.panzerfaust60.faust_explode_distant02'
     Team=255
     Speed=5000.000000
     MaxSpeed=10000.000000
     Damage=25.000000
     MomentumTransfer=10000.000000
     MyDamageType=None
     ExplosionDecal=Class'DA2.da_effects_NadeDecal'
     ExploWallOut=2.000000
     DrawType=DT_None
     TransientSoundVolume=0.600000
     TransientSoundRadius=200.000000
     bProjTarget=True
}
