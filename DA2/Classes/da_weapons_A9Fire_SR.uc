class da_weapons_A9Fire_SR extends da_weapons_GunFire;

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
		DamageMax=12; }
	else {
		DamageType=Class'DA2.da_damtypes_A9SMG';
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
     MuzEmitterClass=Class'DA2.da_effects_XD40Muzzle1st'
     FireSoundFar=Sound'DA2_WeaponSounds.Gunshots.A-9_FireFar'
     FireSoundRand=0.080000
     Momentum=1100.000000
     bWaitForRelease=False
     TransientSoundVolume=1.800000
     FireAnim="Fire_Loop"
     FireLoopAnim="Fire_Loop"
     FireEndAnim="Fire_End"
     FireSound=Sound'DA2_WeaponSounds.Gunshots.A-9_Fire'
     FireRate=0.080000
     AmmoClass=Class'DA2.da_weapons_A9Ammo_SR'
     ShakeRotMag=(X=50.000000,Y=50.000000,Z=50.000000)
     ShakeRotRate=(X=1000.000000,Y=1000.000000,Z=1000.000000)
     ShakeRotTime=1.500000
     ShakeOffsetMag=(X=-7.000000,Y=6.500000,Z=9.000000)
     ShakeOffsetTime=1.000000
     BotRefireRate=0.990000
     aimerror=30.000000
     Spread=0.038000
}
