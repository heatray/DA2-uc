class da_proj_AmmoboxGrenade extends da_proj_Projectile;


var() float DampenFactor, DampenFactorParallel;


simulated function Destroyed()
{
    super.Destroyed();
}

simulated function PostBeginPlay()
{
    Super.PostBeginPlay();

    if(Role==ROLE_Authority) {
        RandSpin(25000);
        Velocity=Speed*Vector(Rotation)+VRand()*Dispersion;
        SetRotation(rotator(velocity));
    }
	LifeSpan = frand() + 0.2;
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

    // Reflect off Wall w/damping
    VNorm = (Velocity dot HitNormal) * HitNormal;
    Velocity = -VNorm * DampenFactor + (Velocity - VNorm) * DampenFactorParallel;

    RandSpin(100000);
    DesiredRotation.Roll = 0;
    RotationRate.Roll = 0;
    Speed = VSize(Velocity);

    if ( Speed < 20 )
    {
        bBounce = False;
        PrePivot.Z = -1;
		SetPhysics(PHYS_None);
		DesiredRotation = Rotation;
		DesiredRotation.Roll = 0;
		DesiredRotation.Pitch = 0;
		SetRotation(DesiredRotation);
    }
    else
    {
        if ( (Level.NetMode != NM_DedicatedServer) && (Speed > 250) )
		    PlaySound(ImpactSound,SLOT_Misc,0.8,,150,0.9+frand()*0.2);
		else
		{
			bFixedRotationDir = false;
			bRotateToDesired = true;
			DesiredRotation.Pitch = 0;
			RotationRate.Pitch = 50000;
		}
    }
}

defaultproperties
{
     DampenFactor=0.150000
     DampenFactorParallel=0.250000
     ExplosionSounds(0)=Sound'DA2_WeaponSounds.explosions.Grenade_Explosion1'
     ExplosionSounds(1)=Sound'DA2_WeaponSounds.explosions.Grenade_Explosion2'
     ExplosionSounds(2)=Sound'DA2_WeaponSounds.explosions.Grenade_Explosion3'
     ExplosionSounds(3)=Sound'DA2_WeaponSounds.explosions.Grenade_Explosion4'
     ExpSoundsNum=4
     Dispersion=800.000000
     Armor=100.000000
     Speed=400.000000
     MaxSpeed=1000.000000
     Damage=150.000000
     DamageRadius=400.000000
     MomentumTransfer=50000.000000
     MyDamageType=Class'DA2.da_damtypes_AmmoExp'
     ImpactSound=SoundGroup'Inf_Weapons_Foley.Grenade.grenadeland'
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'DA2_StaticMeshes.Grenades.FragGrenade'
     Physics=PHYS_Falling
     DrawScale=2.000000
     AmbientGlow=80
     FluidSurfaceShootStrengthMod=2.500000
     TransientSoundVolume=3.500000
     TransientSoundRadius=500.000000
     bBounce=True
     bFixedRotationDir=True
     DesiredRotation=(Pitch=12000,Yaw=5666,Roll=2334)
}
