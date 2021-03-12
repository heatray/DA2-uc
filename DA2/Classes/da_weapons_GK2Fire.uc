class da_weapons_GK2Fire extends ProjectileFire;//da_weapons_GunFire;//BaseProjectileFire;

var()           class<Emitter>  ShellEjectClass;            // class of the shell eject emitter
var()           Emitter         ShellEjectEmitter;          // The shell eject emitter
var()           name            ShellEjectBoneName;         // name of the shell eject bone

/*
function DoTrace(Vector Start, Rotator Dir)
{
    local Vector X, End, HitLocation, HitNormal;
    local Actor Other;
    local pawn headshotpawn;
    local int Damage;
    local material surface;

	MaxRange();
    X = Vector(Dir);
    End = Start + TraceRange * X;

	if (da_players_PRI(Instigator.PlayerReplicationInfo).enableIncendiary) {
		DamageType=Class'KFmod.DamTypeFlamethrower';
		DamageMin=12;
        DamageMax=15; }
	else {
		DamageType=Class'DA2.da_damtypes_GK2Shotgun';
		DamageMin=19;
        DamageMax=23; }
	
    Other = Weapon.Trace(HitLocation, HitNormal, End, Start, true,, surface);

    if ( Other != None && Other != Instigator )
    {
        Damage = DamageMin;
		if ( (DamageMin != DamageMax) && (FRand() > 0.5) )
			Damage += Rand(1 + DamageMax - DamageMin);
        Damage = Damage * DamageAtten;

		WeaponAttachment(Weapon.ThirdPersonActor).UpdateHit(Other, HitLocation, HitNormal);

        if(damagetypeheadshot!=none)
        {
            if (Vehicle(Other) != None)
                HeadShotPawn = Vehicle(Other).CheckForHeadShot(HitLocation, X, 2.0);

            if (HeadShotPawn!=None)
                HeadShotPawn.TakeDamage(Damage * HeadShotDamageMult, Instigator, HitLocation, Momentum*X, DamageTypeHeadShot);
            else if ( (Pawn(Other) != None) && Pawn(Other).IsHeadShot(HitLocation, X, HeadshotChance))
                Other.TakeDamage(Damage * HeadShotDamageMult, Instigator, HitLocation, Momentum*X, DamageTypeHeadShot);
            else Other.TakeDamage(Damage, Instigator, HitLocation, Momentum*X, DamageType);
        }
        else Other.TakeDamage(Damage, Instigator, HitLocation, Momentum*X, DamageType);

        SpawnHitEffects(other, surface, hitlocation, rotator(hitnormal));
    }
    else
    {
        HitLocation = End;
        HitNormal = Vect(0,0,0);
	    WeaponAttachment(Weapon.ThirdPersonActor).UpdateHit(Other,HitLocation,HitNormal);
    }
}

*/
simulated function InitEffects()
{
    super.InitEffects();

    // don't even spawn on server
    if ( (Level.NetMode == NM_DedicatedServer) || (AIController(Instigator.Controller) != None) )
		return;
    if ( (ShellEjectClass != None) && ((ShellEjectEmitter == None) || ShellEjectEmitter.bDeleteMe) )
    {
        ShellEjectEmitter = Weapon.Spawn(ShellEjectClass);
        Weapon.AttachToBone(ShellEjectEmitter, ShellEjectBoneName);
    }
}

function DrawMuzzleFlash(Canvas Canvas)
{
    super.DrawMuzzleFlash(Canvas);
    // Draw shell ejects
    if (ShellEjectEmitter != None )
    {
        Canvas.DrawActor( ShellEjectEmitter, false, false, Weapon.DisplayFOV );
    }
}

function FlashMuzzleFlash()
{
    super.FlashMuzzleFlash();

    if (ShellEjectEmitter != None)
    {
        ShellEjectEmitter.Trigger(Weapon, Instigator);
    }
}

simulated function DestroyEffects()
{
    super.DestroyEffects();

    if (ShellEjectEmitter != None)
        ShellEjectEmitter.Destroy();
}

defaultproperties
{
     ShellEjectClass=Class'ROEffects.KFShellEjectShotty'
     ShellEjectBoneName="Shell_Ejector"
     ProjPerFire=10
     ProjSpawnOffset=(X=25.000000,Y=5.000000,Z=-6.000000)
     bWaitForRelease=True
     TransientSoundVolume=4.200000
     FireSound=Sound'DA2_WeaponSounds.Gunshots.GK2_Fire'
     FireRate=0.965000
     AmmoClass=Class'DA2.da_weapons_GK2Ammo'
     AmmoPerFire=1
     ShakeRotMag=(X=50.000000,Y=50.000000,Z=400.000000)
     ShakeRotRate=(X=12500.000000,Y=12500.000000,Z=12500.000000)
     ShakeRotTime=5.000000
     ShakeOffsetMag=(X=-8.000000,Y=2.000000,Z=10.000000)
     ShakeOffsetRate=(X=1000.000000,Y=1000.000000,Z=1000.000000)
     ShakeOffsetTime=3.000000
     ProjectileClass=Class'DA2.da_proj_Shotgun'
     BotRefireRate=1.500000
     FlashEmitterClass=Class'ROEffects.MuzzleFlash1stKar'
     aimerror=1.000000
     Spread=1100.000000
     SpreadStyle=SS_Random
}
