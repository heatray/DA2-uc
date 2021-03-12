//=============================================================================
// NOTE: This is just graphics, the actual weapon uses instant fire.
//=============================================================================
class da_effects_PulserProjectile extends Projectile;

#exec OBJ LOAD FILE=..\Sounds\ProjectileSounds.uax

var vector Dir;

simulated function ProcessTouch (Actor Other, Vector HitLocation)
{
	if ( (Other != instigator) && (!Other.IsA('Projectile') || Other.bProjTarget) )
	{
		if (ROLE == ROLE_Authority)
	    	Other.TakeDamage(Damage,Instigator,HitLocation,MomentumTransfer * Normal(Velocity),MyDamageType);
		Explode(HitLocation, vector(rotation)*-1 );
	}
}

function BlowUp(vector HitLocation)
{
	HurtRadius(Damage,DamageRadius, MyDamageType, MomentumTransfer, HitLocation );
	MakeNoise(1.0);
}


simulated function PostBeginPlay()
{
	Dir = vector(Rotation);
	Velocity = speed * Dir;
	Super.PostBeginPlay();
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
    Spawn(class'ROBulletHitMetalArmorEffect',,, HitLocation, rotator(HitNormal)); //Temp?
    PlaySound(Sound'ProjectileSounds.Bullets.Impact_Dirt');
	BlowUp(HitLocation);
	Destroy();
}

defaultproperties
{
     Speed=8000.000000
     MaxSpeed=8600.000000
     Damage=21.000000
     DamageRadius=22.000000
     MyDamageType=Class'DA2.DamTypeLinkPlasma'
     DrawType=DT_StaticMesh
     DrawScale3D=(X=2.000000,Y=1.400000,Z=1.350000)
     bCanBeDamaged=False
}
