//=============================================================================
// Sniper Bullet
//=============================================================================
class da_proj_Sniper extends da_proj_bullet;

var     float       DamageAtten;
var()   int         MaxPenetrations; // Yeah, Hardy har har. It refers in fact to the number of times the bolt can pass through someone and keep going.
var()   float       PenDamageReduction; // how much damage does it lose with each person it passes through?
var()   float       HeadShotDamageMult;
var() class<actor> ProjFX, ProjTrail;
var actor FX, Trail;
var bool bHitWater;
var byte Team;

simulated event PreBeginPlay()
{
    Super.PreBeginPlay();

    if( Pawn(Owner) != None )
        Instigator = Pawn( Owner );
		
		if ( Instigator.PlayerReplicationInfo != none )
		{
			if (da_players_PRI(Instigator.PlayerReplicationInfo).enableIncendiary) 
			{
				MyDamageType=Class'KFmod.DamTypeFlamethrower';
				//DamageTypeHeadShot=Class'KFmod.DamTypeFlamethrower';
				Damage=275; 
			}
			else 
			{
				MyDamageType=Class'DA2.da_damtypes_Sniper';
				//DamageTypeHeadShot=Class'DA2.da_damtypes_SniperHeadshot';
				Damage=400;
			}
		}
}


simulated function PostNetBeginPlay()
{
	local PlayerController PC;

	Super.PostNetBeginPlay();

	if ( Level.NetMode == NM_DedicatedServer )
		return;

	PC = Level.GetLocalPlayerController();
	if ( (Instigator != None) && (PC == Instigator.Controller) )
		return;
	if ( Level.bDropDetail || (Level.DetailMode == DM_Low) )
	{
		bDynamicLight = false;
		LightType = LT_None;
	}
	else if ( (PC == None) || (PC.ViewTarget == None) || (VSize(PC.ViewTarget.Location - Location) > 3000) )
	{
		bDynamicLight = false;
		LightType = LT_None;
	}
}

simulated function PostBeginPlay()
{
    if ( Role == ROLE_Authority )
    {
        Velocity = Speed*Vector(Rotation);
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

simulated singular function HitWall(vector HitNormal, actor Wall)
{
local vector HL,HN;
local vector outvec;
local int matType;
local material WallMat;

    outvec=Velocity-2.0*HitNormal*(Velocity dot HitNormal);
    outvec=normal(outvec);

    if(wall.surfacetype!=0) matType=wall.surfacetype;
        else
        {
            Trace(hl,hn,location+vect(32,0,0)*vector(rotation),Location,false,,WallMat);
            if(WallMat!=None) matType=WallMat.SurfaceType;
        }

    if ( Role == ROLE_Authority )
	{
		if ( !Wall.bStatic && !Wall.bWorldGeometry )
		{
			if ( Instigator == None || Instigator.Controller == None )
				Wall.SetDelayedDamageInstigatorController( InstigatorController );
			Wall.TakeDamage( Damage, instigator, Location, MomentumTransfer * Normal(Velocity), MyDamageType);
			if (DamageRadius > 0 && Vehicle(Wall) != None && Vehicle(Wall).Health > 0)
				Vehicle(Wall).DriverRadiusDamage(Damage, DamageRadius, InstigatorController, MyDamageType, MomentumTransfer, Location);
			HurtWall = Wall;
		}
		MakeNoise(1.0);
	}
	Explode(Location + ExploWallOut * HitNormal, HitNormal);

    if ( EffectIsRelevant(Location,false) )
    	    Spawn(HitMatFX[matType],,,Location+outvec*ExploWallOut,rotator(outvec));

	HurtWall = None;

    Destroy();
}

simulated function ProcessTouch (Actor Other, vector HitLocation)
{
    local vector X;
	local Vector TempHitLocation, HitNormal;
	local array<int>	HitPoints;
    local KFPawn HitPawn;
	local vector outvec;

	if ( Other == none || Other == Instigator || Other.Base == Instigator || !Other.bBlockHitPointTraces  )
		return;

    X = Vector(Rotation);

 	if( ROBulletWhipAttachment(Other) != none )
	{
        if(!Other.Base.bDeleteMe)
        {
	        Other = Instigator.HitPointTrace(TempHitLocation, HitNormal, HitLocation + (200 * X), HitPoints, HitLocation,, 1);

			if( Other == none || HitPoints.Length == 0 )
				return;

			HitPawn = KFPawn(Other);

            if (Role == ROLE_Authority)
            {
    	    	if ( HitPawn != none )
    	    	{
     				// Hit detection debugging
    				/*log("Bullet hit "$HitPawn.PlayerReplicationInfo.PlayerName);
    				HitPawn.HitStart = HitLocation;
    				HitPawn.HitEnd = HitLocation + (65535 * X);*/

                    if( !HitPawn.bDeleteMe )
                    	HitPawn.ProcessLocationalDamage(Damage, Instigator, TempHitLocation, MomentumTransfer * Normal(Velocity), MyDamageType,HitPoints);


                    // Hit detection debugging
    				//if( Level.NetMode == NM_Standalone)
    				//	HitPawn.DrawBoneLocation();
    	    	}
    		}
		}
	}
    else
    {
        if (Pawn(Other) != none && Pawn(Other).IsHeadShot(HitLocation, X, 1.0))
        {
            Pawn(Other).TakeDamage(Damage * HeadShotDamageMult, Instigator, HitLocation, MomentumTransfer * Normal(Velocity), MyDamageType);
        }
        else
        {
            Other.TakeDamage(Damage, Instigator, HitLocation, MomentumTransfer * Normal(Velocity), MyDamageType);
        }
    }
	
	if ( EffectIsRelevant(Location,false) && !Other.IsA('da_turrets_Turret'))
			Spawn(Class'DA2.da_effects_BulletHitFlesh',,,Location+outvec*ExploWallOut,rotator(outvec));
	else if ( EffectIsRelevant(Location,false) && Other.IsA('da_turrets_Turret'))
			Spawn(Class'DA2.da_effects_BulletHitMetal',,,Location+outvec*ExploWallOut,rotator(outvec));

   	PenDamageReduction = default.PenDamageReduction;

   	Damage *= PenDamageReduction; // Keep going, but lose effectiveness each time.

    // if we've struck through more than the max number of foes, destroy.
    if ( Damage / default.Damage <= PenDamageReduction / MaxPenetrations )
    {
        Destroy();
    }

    speed = VSize(Velocity);

    if( Speed < (default.Speed * 0.25) )
    {
        Destroy();
    }
}

simulated function Destroyed()
{
    if(FX!=none) fx.Destroy();
    if(emitter(trail)!=none) emitter(trail).Kill();

	Super.Destroyed();
}

defaultproperties
{
     DamageAtten=5.000000
     MaxPenetrations=20
     PenDamageReduction=0.200000
     HeadShotDamageMult=4.000000
     ProjTrail=Class'DA2.da_effects_SniperTrailNew'
     Speed=12000.000000
     MaxSpeed=12000.000000
     bSwitchToZeroCollision=True
     Damage=400.000000
     DamageRadius=0.000000
     MomentumTransfer=150000.000000
     MyDamageType=Class'DA2.da_damtypes_Sniper'
     ExplosionDecal=Class'DA2.da_effects_LongBulletHole'
     DrawType=DT_StaticMesh
     LifeSpan=15.000000
     Style=STY_Alpha
}
