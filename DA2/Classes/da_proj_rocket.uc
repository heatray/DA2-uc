class da_proj_rocket extends da_proj_projectile;


simulated function PostBeginPlay()
{
    super.PostBeginPlay();

    if ( Role == ROLE_Authority )
    {
        if (instigator!=none && Instigator.HeadVolume.bWaterVolume)
        {
            bHitWater = true;
            Velocity = 0.6*Velocity;
        }
    }

    Velocity = Speed*Vector(Rotation);
    Acceleration = Velocity+Vrand()*dispersion;

     SetTimer(1, true);
}

simulated function postNetBeginPlay() {
    super.postNetBeginPlay();
    if (instigator != none && instigator.weapon!=none && instigator.weapon.isa('da_weapons_MS25RocketLauncher') &&
        instigator.isLocallyControlled())
        da_weapons_MS25RocketLauncher(instigator.weapon).clientSetRocketView(self);
    PlaySound(sound'DA2_WeaponSounds.MS25_Launch',SLOT_Misc,1,false,300,0.95+frand()*0.1);
}

simulated function vector GetMatType()
{
    local vector HL,HN;
    local material WallMat;

    Trace(hl,hn,location+normal(velocity)*64,Location,false,,WallMat);

    if(WallMat!=None) matType=WallMat.SurfaceType;

    return hn;
}

function TakeDamage(int Damage, Pawn instigatedBy, Vector hitlocation, Vector momentum, class<DamageType> damageType, optional int HitIndex)
{
    if( damageType == class'SirenScreamDamage')
    {
        Disintegrate(HitLocation, vect(0,0,1));
    }

	if(damage>=armor && armor>0) destroy();
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
    GetMatType();

    if(mattype==3) PlaySound(HitMetalSound,SLOT_None,TransientSoundVolume,,TransientSoundRadius,0.9+frand()*0.2);
    else PlaySound(ExplosionSound,SLOT_Misc,TransientSoundVolume,,TransientSoundRadius,0.9+frand()*0.2);
    PlaySound(explosionSoundFar,SLOT_None,TransientSoundVolume/3,,TransientSoundRadius*15,0.9+frand()*0.2);

    if ( EffectIsRelevant(Location,false) )
    {
        Spawn(MaterialFX[matType],,, HitLocation, rotator(hitnormal));
        Spawn(ExplosionEmitter,,, HitLocation, rotator(hitnormal));
    Spawn(ExplosionDecal,self,,HitLocation, rotator(-HitNormal));
    }

    BlowUp(HitLocation);
}

function Timer()
{
  local Controller C;

    //DFA Turrets as long as they can shoot down enemy rockets
    for(C=Level.ControllerList; C!=None; C=C.NextController)
      if(da_turrets_TurretController(C)!=None && da_Turrets_DFATurret(C.Pawn)!=None && C.GetTeamNum()!=Team
          && !C.Pawn.IsFiring() && (C.focus==None || C.Pawn.Health<250) && C.Pawn.CanAttack(self) )
      {
        C.Focus = self;
        C.Target = self;
        if ( !C.IsInState('Engaged') );
            C.GotoState('Engaged');
        }
}

function Tick(float deltatime)
{
    Super.Tick(DeltaTime);
    SetRotation(rotator(velocity));
}

defaultproperties
{
     HitMetalSound=Sound'DA2_WeaponSounds.MS25_BlastArmor'
     ExplosionSound=Sound'DA2_WeaponSounds.MS25_Explosion'
     ExplosionSoundFar=Sound'DA2_WeaponSounds.MS25_ExplosionFar'
     Dispersion=10.000000
     Armor=5.000000
     BlastPenetration=0.600000
     ProjFX=Class'DA2.da_effects_RocketFX'
     ProjTrail=Class'DA2.da_effects_RocketTrail'
     Speed=700.000000
     MaxSpeed=3000.000000
     Damage=120.000000
     DamageRadius=400.000000
     MomentumTransfer=50000.000000
     MyDamageType=Class'DA2.da_damtypes_MS25RocketLauncher'
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'DA_WeaponPickupSM.shells.122mm_shell'
     bNetTemporary=False
     bUpdateSimulatedPosition=True
     LifeSpan=6.000000
     DrawScale=0.700000
     TransientSoundVolume=6.000000
     TransientSoundRadius=400.000000
     CollisionRadius=4.000000
     CollisionHeight=4.000000
     ForceType=FT_Constant
     ForceRadius=100.000000
     ForceScale=5.000000
}
