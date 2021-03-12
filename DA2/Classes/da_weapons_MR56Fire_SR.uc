class da_weapons_MR56Fire_SR extends da_weapons_GunFire;

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
		DamageMin=8;
        DamageMax=12; }
	else {
		DamageType=Class'DA2.da_damtypes_MR56Rifle';
		DamageMin=12;
        DamageMax=18; }
	
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

defaultproperties
{
     MuzEmitterClass=Class'DA2.da_effects_MR56Muzzle1st'
     FireSoundFar=Sound'DA2_WeaponSounds.Gunshots.MR-56_FireFar'
     FireSoundRand=0.050000
     Momentum=8500.000000
     bWaitForRelease=False
     TransientSoundVolume=2.250000
     TransientSoundRadius=250.000000
     FireAnim="Fire_Loop"
     FireLoopAnim="Fire_Loop"
     FireEndAnim="Fire_End"
     FireSound=Sound'DA2_WeaponSounds.Gunshots.MR-56_Fire'
     FireRate=0.096000
     AmmoClass=Class'DA2.da_weapons_MR56Ammo'
     ShakeRotMag=(X=25.000000,Y=25.000000,Z=200.000000)
     ShakeRotRate=(X=7500.000000,Y=7500.000000,Z=7500.000000)
     ShakeRotTime=0.650000
     ShakeOffsetMag=(X=-4.000000,Y=4.000000,Z=4.000000)
     ShakeOffsetRate=(X=1000.000000,Y=1000.000000)
     ShakeOffsetTime=2.150000
     aimerror=30.000000
     Spread=0.025000
}
