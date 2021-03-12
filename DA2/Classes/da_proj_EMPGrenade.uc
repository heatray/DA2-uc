//=============================================================================
// A special anti-turret grenade.
// Coded by: Leviathan
//=============================================================================
class da_proj_EMPGrenade extends da_weapons_BasicGrenade;


simulated function PostBeginPlay()
{
    Super.PostBeginPlay();
    PlaySound(sound'DA2_Weaponsounds.EMPCharge',SLOT_Misc,1,false,100);
}

simulated function vector GetMatType()
{
    local vector HL,HN;

    Trace(hl,hn,location-vect(0,0,16),Location,false);
    mattype=0;
    return HN;
}

function TakeDamage(int dmg, Pawn instigatedBy, Vector hitlocation, Vector momentum, class<DamageType> damageType, optional int HitIndex)
{
	if(dmg>=armor && armor>0) {
      SetTimer(0.1+frand()*0.1, false);
      armor=0;
    }

    //multiple EMP-Nades can accumulate a stronger pulse
    if(damagetype==mydamagetype) {
      damage+=dmg/2;
      damageradius+=dmg;
    }
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
    hitnormal=GetMatType();
    if(hitnormal==vect(0,0,0))
        hitnormal=vect(0,0,1);

    PlaySound(ExplosionSound,SLOT_Misc,TransientSoundVolume+damage/75,,TransientSoundRadius,(0.9+frand()*0.2)/(0.75+damage/200));

    if ( EffectIsRelevant(Location,false) )
    {
        Spawn(MaterialFX[matType],,, HitLocation, rotator(hitnormal));
        Spawn(ExplosionEmitter,,, HitLocation, rotator(hitnormal));
		Spawn(ExplosionDecal,self,,HitLocation, rotator(-HitNormal));
    }

    BlowUp(HitLocation);
}

simulated function SplashDamage( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation )
{
	local KFMonster Victims;
	
	super.SplashDamage(DamageAmount, DamageRadius, DamageType, Momentum, Hitlocation);
	
	foreach CollidingActors(class 'KFMonster', Victims, DamageRadius*2, HitLocation) 
	{
		if( (Victims!=self) && (Victims.Role==ROLE_Authority) && (!Victims.IsA('FluidSurfaceInfo')) )
		{
			Victims.bStunImmune=False;
			Victims.FlipOver();
			Victims.bStunned=True;
			Victims.SetTimer(10.0,false);
		}
	}
}

simulated function ProcessTouch( actor Other, vector HitLocation )
{
	if(unrealpawn(other)==none) {
	    SetPhysics(PHYS_Trailer);
	    SetBase(other);
	}

    return;
}

defaultproperties
{
     DampenFactor=0.150000
     DampenFactorParallel=0.250000
     BotFearClass=None
     ExplosionEmitter=Class'DA2.da_effects_EMPGExplosion'
     ExplosionSound=Sound'DA2_WeaponSounds.explosions.EMPExplosion'
     ExplosionSoundFar=None
     Dispersion=200.000000
     Armor=10.000000
     BlastPenetration=0.750000
     ProjFX=Class'DA2.da_effects_EMPGrenadeFX'
     Speed=900.000000
     Damage=50.000000
     DamageRadius=450.000000
     MomentumTransfer=5000.000000
     MyDamageType=Class'DA2.da_damtypes_EMPGrenade'
     ExplosionDecal=None
     StaticMesh=StaticMesh'DA2_StaticMeshes.Grenades.EMPGrenade'
     LifeSpan=3.000000
     DrawScale=1.900000
     TransientSoundVolume=3.300000
     TransientSoundRadius=350.000000
}
