//=============================================================================
// Coded by Dante
// Improved by Leviathan
// The DA Grenade.
// Characteristics: Not a lot of bounce, fast versatile and can cause a lot of
// damage.
//=============================================================================
class da_weapons_BasicGrenade extends da_proj_Projectile;

#EXEC OBJ LOAD FILE=DA2_StaticMeshes.usx
#EXEC OBJ LOAD FILE=DA2_WeaponSounds.uax
#EXEC OBJ LOAD FILE=DA2_Various.uax

var() float DampenFactor, DampenFactorParallel;
var AvoidMarker botFear;
var class<AvoidMarker> BotFearClass;

simulated function PostBeginPlay()
{
    Super.PostBeginPlay();

    if(Role==ROLE_Authority && botfearclass!=none) {
        RandSpin(25000);
		BotFear=Spawn(botfearclass);
		BotFear.SetBase(self);
		BotFear.lifespan=lifespan;
	}
}

simulated function ProcessTouch( actor Other, vector HitLocation )
{
	local vector HitNormal, VNorm;

    VNorm = (Velocity dot HitNormal) * HitNormal;
    Velocity = -VNorm * 0.5;

    return;
}

simulated function HitWall( vector HitNormal, actor Wall )
{
    local Vector VNorm;

	if ( (Pawn(Wall) != None) || (GameObjective(Wall) != None) )
	{
		setRotation(rotator(hitNormal));
		destroy();
		return;
	}

    if(Level.NetMode!=NM_DedicatedServer && Speed>150)
	    PlaySound(ImpactSound,SLOT_None,0.9,,80,0.9+frand()*0.2);

    // Reflect off Wall w/damping
    VNorm = (Velocity dot HitNormal) * HitNormal;
    Velocity = -VNorm * DampenFactor + (Velocity - VNorm) * DampenFactorParallel;

    RandSpin(200000);
    DesiredRotation.Roll = 0;
    RotationRate.Roll = 0;
    Speed = VSize(Velocity);

    if(Speed < 20)
    {
        bBounce = False;
        SetPhysics(PHYS_None);
		DesiredRotation = Rotation;
		DesiredRotation.Roll = 0;
		DesiredRotation.Pitch = 0;
		SetRotation(DesiredRotation);
    }
    else
    {
		bFixedRotationDir = false;
		bRotateToDesired = true;
		DesiredRotation.Pitch = 0;
		RotationRate.Pitch = 50000;
    }
}

function TakeDamage(int Damage, Pawn instigatedBy, Vector hitlocation, Vector momentum, class<DamageType> damageType, optional int HitIndex)
{
    if( damageType == class'SirenScreamDamage')
    {
        Disintegrate(HitLocation, vect(0,0,1));
    }

	if(damage>=armor && armor>0) {
      SetTimer(0.1+frand()*0.1, false);
      bProjTarget=false;
    }
}

function Timer()
{
    Destroy();
}

simulated function Destroyed()
{
    if(BotFear!=none) BotFear.Destroy();

	Super.Destroyed();
}

defaultproperties
{
     DampenFactor=0.200000
     DampenFactorParallel=0.400000
     BotFearClass=Class'DA2.da_triggers_BotFearSpot'
     ExplosionSounds(0)=Sound'DA2_WeaponSounds.explosions.Grenade_Explosion1'
     ExplosionSounds(1)=Sound'DA2_WeaponSounds.explosions.Grenade_Explosion2'
     ExplosionSounds(2)=Sound'DA2_WeaponSounds.explosions.Grenade_Explosion3'
     ExplosionSounds(3)=Sound'DA2_WeaponSounds.explosions.Grenade_Explosion4'
     ExpSoundsNum=4
     Dispersion=300.000000
     Armor=20.000000
     Speed=1000.000000
     MaxSpeed=1000.000000
     Damage=300.000000
     DamageRadius=300.000000
     MomentumTransfer=100000.000000
     MyDamageType=Class'DA2.da_damtypes_HandGrenade'
     ImpactSound=Sound'DA2_WeaponSounds.Misc.GrenadeBounce'
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'DA2_StaticMeshes.Grenades.FragGrenade'
     Physics=PHYS_Falling
     LifeSpan=2.500000
     DrawScale=2.000000
     AmbientGlow=16
     bUnlit=False
     FluidSurfaceShootStrengthMod=2.500000
     TransientSoundVolume=5.000000
     TransientSoundRadius=600.000000
     CollisionRadius=1.000000
     CollisionHeight=1.000000
     bBounce=True
     bFixedRotationDir=True
     DesiredRotation=(Pitch=12000,Yaw=5666,Roll=2334)
     bNetInitial=True
}
