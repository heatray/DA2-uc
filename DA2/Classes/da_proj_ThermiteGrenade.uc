//=============================================================================
// A special anti-infantry area-denial grenade.
// Coded by: Leviathan
//=============================================================================
class da_proj_ThermiteGrenade extends da_weapons_BasicGrenade;

var float ExplodeTime;

replication
{
    reliable if( bNetInitial && (Role==ROLE_Authority) )
        ExplodeTime;
}


simulated function vector GetMatType()
{
    local vector HL,HN;

    Trace(hl,hn,location-vect(0,0,16),Location,false);
    mattype=0;
    return HN;
}

simulated function HitWall( vector HitNormal, actor Wall )
{
    local Vector VNorm;

    if(explodetime!=0) return;

	if ( (Pawn(Wall) != None) || (GameObjective(Wall) != None) )
	{
		setRotation(rotator(hitNormal));
		destroy();
		return;
	}

    if((Level.NetMode != NM_DedicatedServer) && (Speed > 150) )
	    PlaySound(ImpactSound,SLOT_None,1,,100,0.9+frand()*0.2);

    // Reflect off Wall w/damping
    VNorm = (Velocity dot HitNormal) * HitNormal;
    Velocity = -VNorm * DampenFactor + (Velocity - VNorm) * DampenFactorParallel;

    RandSpin(200000);
    DesiredRotation.Roll = 0;
    RotationRate.Roll = 0;
    Speed = VSize(Velocity);

    if ( Speed < 20 )
    {
        Spawn(class'da2.da_effects_thgrenadefx', self,, Location, Rotation).setbase(self);
        PlaySound(sound'da2_weaponsounds.thermiteignite',SLOT_Misc,1.2,,100);

        bBounce=false;
		SetPhysics(PHYS_None);
		SetTimer(1.2, false);
    }
    else
    {
		bFixedRotationDir = false;
		bRotateToDesired = true;
		DesiredRotation.Pitch = 0;
		RotationRate.Pitch = 50000;
    }
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
    if(explodetime!=0) return;

    hitnormal=GetMatType();
    if(hitnormal==vect(0,0,0))
        hitnormal=vect(0,0,1);

    PlaySound(ExplosionSound,SLOT_Misc,TransientSoundVolume,,TransientSoundRadius,0.9+frand()*0.2);

    if ( EffectIsRelevant(Location,false) )
    {
        Spawn(MaterialFX[matType],,, HitLocation, rotator(hitnormal));
        Spawn(ExplosionEmitter,,, HitLocation, rotator(hitnormal));
		Spawn(ExplosionDecal,self,,HitLocation, rotator(-HitNormal));
    }

    bHidden=true;
    ExplodeTime=level.timeseconds;
    BlowUp(HitLocation);
    SetTimer(0.2, true);
}

simulated function Timer()
{
    local float tmp;

    if(ExplodeTime==0) {
        Explode(location, location);
        return;
    }

    tmp=1-(level.timeseconds-ExplodeTime)/5;
    if(tmp<=0) destroy();

    Damage=default.Damage*tmp;
    DamageRadius=default.damageradius*(0.5+tmp/2);

    BlowUp(Location);
}

simulated function BlowUp(vector HitLocation)
{
	SplashDamage(Damage, DamageRadius, MyDamageType, MomentumTransfer, HitLocation );
}

simulated function SplashDamage( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation )
{

	local actor Victims;
	local float damageScale, dist;
	local vector dir;

	if(bHurtEntry)
		return;

	bHurtEntry=true;
	foreach CollidingActors(class 'Actor', Victims, DamageRadius, HitLocation) {
		if((Victims!=self) && (Victims.Role==ROLE_Authority) && (!Victims.IsA('FluidSurfaceInfo'))) {
			dir=Victims.Location-HitLocation;
			dist=FMax(1,VSize(dir));
			dir=dir/dist;

            damageScale=1-FMax(0,(dist-Victims.CollisionRadius)/DamageRadius);

			if(!FastTrace(victims.Location,hitlocation)) {
                damagescale*=blastpenetration;
            }

            if(Pawn(Victims)!=none && da_players_playercontroller(Pawn(Victims).controller)!=none)
                da_players_playercontroller(pawn(victims).controller).dmgshake(momentum*damagescale/2500, dir);

            if(damageamount*damagescale>0)
            {
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
	bHurtEntry = false;
}

defaultproperties
{
     DampenFactor=0.150000
     DampenFactorParallel=0.250000
     BotFearClass=Class'DA2.da_triggers_BotFearFire'
     ExplosionEmitter=Class'DA2.da_effects_THGExplosion'
     ExplosionSound=Sound'DA2_WeaponSounds.explosions.ThermiteExplosion'
     ExplosionSoundFar=None
     Dispersion=10.000000
     Armor=0.000000
     BlastPenetration=0.750000
     Speed=750.000000
     Damage=35.000000
     DamageRadius=350.000000
     MomentumTransfer=500.000000
     MyDamageType=Class'DA2.da_damtypes_ThermiteGrenade'
     ExplosionDecal=None
     ExploWallOut=-2.000000
     LifeSpan=20.000000
     DrawScale=1.500000
     DrawScale3D=(Y=1.600000)
     Skins(0)=Texture'DA2Weapons.Skins.THGrenade'
     TransientSoundVolume=4.000000
     TransientSoundRadius=350.000000
}
