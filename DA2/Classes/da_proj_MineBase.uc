//-----------------------------------------------------------
//
//-----------------------------------------------------------
class da_proj_MineBase extends Projectile abstract;

var float   realRadius, realHeight; // Used after Mine is attached to a wall
var AvoidMarker FearMe;
var Sound   readySound;

simulated function Destroyed() {
    if (FearMe != None)
        FearMe.Destroyed();
    super.Destroyed();
}


simulated function ProcessTouch(Actor Other, Vector HitLocation)
{
  Explode(HitLocation,Normal(HitLocation-Other.Location));
}

auto state setup {

    simulated function Landed(Vector HitNormal) {
        log("Mine ---> auto state Setup BeginPlay");
        setPhysics(PHYS_None);
        bCollideWorld = false;
        setCollisionSize(realRadius, realHeight);
        FearMe = spawn(class'AvoidMarker');
    }

   	function endState()
	{
	    gotoState('activate');
    }
}

state activate {
    simulated function beginPlay() {
        log("Mine ---> state ACTIVE BeginPlay");
        activated();    // default behaviour: no startuptime needed
    }

    simulated final function activated() {
    log("Mine ---> going to STATE READY BeginPlay");
        gotoState('ready');
    }
}

state ready {
    simulated function beginPlay() {
    log("Mine --->  state READY BeginPlay");
        playSound(readySound);
    }

    simulated function ProcessTouch(Actor Other, Vector HitLocation)
    {
	  // if ( Other != Instigator )
	       log("Mine ---> TOUCHED BY"@Other);
	       	Explode(HitLocation,Normal(HitLocation-Other.Location));
    }

    simulated function HitWall (vector HitNormal, actor Wall)
    {
	   if ( Role == ROLE_Authority )
    	{
			// Why only for movers ?
	   	   if ( Mover(Wall) != None && ROLE == ROLE_Authority)
	       		Wall.TakeDamage( Damage, instigator, Location, MomentumTransfer * Normal(Velocity), MyDamageType);

		  MakeNoise(1.0);
	   }
	   Explode(Location + ExploWallOut * HitNormal, HitNormal);
	   if ( (ExplosionDecal != None) && (Level.NetMode != NM_DedicatedServer) )
		  Spawn(ExplosionDecal,self,,Location, rotator(-HitNormal));
    }
}

function BlowUp(vector HitLocation)
{

	HurtRadius(Damage,DamageRadius, MyDamageType, MomentumTransfer, HitLocation );
	MakeNoise(1.0);
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
	if ( Level.NetMode != NM_DedicatedServer )
		Spawn(class'ROEffects.ROVehicleDestroyedEmitter', Self,, HitLocation, Rotation);

    BlowUp(HitLocation);
	Destroy();
}

defaultproperties
{
     realRadius=85.000000
     RealHeight=85.000000
     Physics=PHYS_Falling
     LifeSpan=0.000000
     CollisionRadius=10.000000
     CollisionHeight=10.000000
}
