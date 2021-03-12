//=============================================================================
// A very big and powerful grenade. (Dicke fette bombe!)
// Coded by: Leviathan
//=============================================================================
class da_proj_PlasmaBomb extends da_weapons_BasicGrenade;

var bool disarmed;

replication
{
    reliable if (bNetDirty && Role == ROLE_Authority)
        disarmed;
}


simulated function PostBeginPlay()
{
    Super.PostBeginPlay();
    PlaySound(sound'DA2_Weaponsounds.PlasmaCharge',SLOT_Misc,1.75,false,180);
    //Ambientsound=sound'DA2_Weaponsounds.PlasmaCharge';
    Settimer(0.5, true);
}

simulated function vector GetMatType()
{
    local vector HL,HN;

    Trace(hl,hn,location-vect(0,0,16),Location,false);
    mattype=0;
    return HN;
}

function TakeDamage(int Damage, Pawn instigatedBy, Vector hitlocation, Vector momentum, class<DamageType> damageType, optional int HitIndex)
{
    if(instigator!=none && instigatedby!=instigator && instigatedby.GetTeamNum()==team)
        return;

    disarmed=true;
    Destroy();
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
    local float tmp;

    hitnormal=GetMatType();
    if(hitnormal==vect(0,0,0))
        hitnormal=vect(0,0,1);

    //if(!disarmed) {
        tmp=10-lifespan;
        tmp*=tmp;
        damage=tmp*10+200;
        DamageRadius=tmp*5+500;
        momentumtransfer=tmp*400+15000;

        PlaySound(ExplosionSound,SLOT_None,tmp*3+5,,TransientSoundRadius,0.95+frand()*0.1);
        PlaySound(explosionSoundFar,SLOT_None,(tmp*3+5)/4,,TransientSoundRadius*15,0.95+frand()*0.1);

        if ( EffectIsRelevant(Location,false) ) {
            Spawn(ExplosionEmitter,,, HitLocation, rotator(hitnormal));
		    Spawn(ExplosionDecal,self,,HitLocation, rotator(-HitNormal));
		    Spawn(class'da2.da_effects_plasmascorch',self,,HitLocation, rotator(-HitNormal));
        }

        BlowUp(HitLocation);
        return;
    //}


    /*PlaySound(sound'DA2_Weaponsounds.PlasmaDud',SLOT_Misc,TransientSoundVolume/2,,TransientSoundRadius/3,0.9+frand()*0.2);

    if ( EffectIsRelevant(Location,false) )
    {
        Spawn(class'da_effects_PlasmaDud',,, HitLocation, rotator(hitnormal));
		Spawn(class'shockaltdecal',self,,HitLocation, rotator(-HitNormal));
    }

    Damage=100;
    DamageRadius=300;
    MomentumTransfer=5000;
    BlowUp(HitLocation);*/
}

simulated function Timer()
{
    local controller c;

    for(C=Level.ControllerList; C!=None; C=C.NextController)
	    if(C.Pawn!=None && frand()<0.75 && C.GetTeamNum()!=Team
	        && !C.Pawn.IsFiring() && C.Pawn.CanAttack(self))
	    {
	        C.Focus = self;
            if(da_turrets_turretcontroller(c)!=none) {
		        C.Target = self;
	            if(!C.IsInState('Engaged'));
	                C.GotoState('Engaged');
		    }
            else c.FireWeaponAt(self);
	    }
}

simulated function BlowUp(vector HitLocation)
{
	SplashDamage(Damage, DamageRadius, MyDamageType, MomentumTransfer, HitLocation );
}

defaultproperties
{
     DampenFactor=0.150000
     DampenFactorParallel=0.250000
     BotFearClass=Class'DA2.da_triggers_BotFearFire'
     ExplosionEmitter=Class'DA2.da_effects_PlasmaExplosion'
     ExplosionSound=Sound'DA2_WeaponSounds.explosions.PlasmaExplode'
     ExplosionSoundFar=Sound'DA2_WeaponSounds.explosions.PlasmaExplodeFar'
     Dispersion=10.000000
     Armor=10.000000
     BlastPenetration=0.500000
     ProjFX=Class'DA2.da_effects_PlasmaBombFX'
     Speed=375.000000
     Damage=1200.000000
     DamageRadius=1000.000000
     MomentumTransfer=60000.000000
     MyDamageType=Class'DA2.da_damtypes_PlasmaBomb'
     ImpactSound=Sound'DA2_WeaponSounds.Misc.PlasmaBombPlant'
     ExplosionDecal=Class'DA2.da_effects_PlasmaDecal'
     StaticMesh=StaticMesh'DA2_StaticMeshes.Grenades.EMPGrenade'
     LifeSpan=10.000000
     DrawScale=2.850000
     DrawScale3D=(Y=0.800000)
     Skins(0)=Shader'DA2Weapons.Skins.PlasmaBomb'
     bFullVolume=True
     SoundVolume=255
     SoundRadius=96.000000
     TransientSoundVolume=25.000000
     TransientSoundRadius=750.000000
     CollisionRadius=2.000000
     CollisionHeight=2.000000
}
