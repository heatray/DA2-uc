//-----------------------------------------------------------
//
//-----------------------------------------------------------
class da_proj_HumanArtilleryProjectile extends Projectile;

#EXEC OBJ LOAD FILE=DA2_WeaponSounds.uax

var Emitter ProjectileEffect;

replication
{
	// Things the server should send to the client.
	reliable if( Role == ROLE_Authority )
           doEffects;
}

simulated function beginPlay() {
    super.BeginPlay();

    velocity = Speed * vector(rotation);
    ProjectileEffect = spawn(class'da_effects_HumanArtillery',self);

}

simulated function Landed(vector hitNormal) {
    Explode(HitNormal, HitNormal);

}

simulated function HitWall (vector HitNormal, actor Wall)
{
    Landed(HitNormal);
}

simulated function ProcessTouch(Actor Other, Vector HitLocation) {

    Explode(HitLocation,Normal(HitLocation-Other.Location));
}

simulated function BlowUp(vector HitLocation)
{
	HurtRadius(Damage,DamageRadius, MyDamageType, MomentumTransfer, HitLocation );
	if ( Role == ROLE_Authority )
		MakeNoise(1.0);
}

function Explode(vector HitLocation, vector HitNormal)
{
   	HurtRadius(Damage,DamageRadius, MyDamageType, MomentumTransfer, Location);
   	if ( FRand() < 0.5)
   	{
        PlaySound(sound'DA2_WeaponSounds.MS25_Explosion',,2.5*TransientSoundVolume);
    }
    else
    {
        //PlaySound (Sound'Inf_Weapons.F1.f1_explode01',,3*TransientSoundVolume);
    }

 if ( Role == ROLE_Authority )
        MakeNoise(1.0);

	destroy();
}

function doEffects(vector HitLoc, vector momentum)
{
     spawn(class'da_effects_ExplosionA',self);

}

defaultproperties
{
     Speed=2200.000000
     Damage=29.000000
     DamageRadius=1100.000000
     MomentumTransfer=28000.000000
     MyDamageType=Class'DA2.da_other_ArtilleryDamageType'
     DrawType=DT_None
     bNetTemporary=False
     bCanBeDamaged=False
     CollisionRadius=35.000000
     CollisionHeight=35.000000
}
