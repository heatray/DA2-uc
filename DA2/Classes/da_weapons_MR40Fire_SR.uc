class da_weapons_MR40Fire_SR extends da_weapons_GunFire;


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
		DamageMin=17;
		DamageMax=21; }
	else {
		DamageType=Class'DA2.da_damtypes_MR40Heavy';
		DamageMin=26;
		DamageMax=32; }
	
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
     MuzEmitterClass=Class'DA2.da_effects_MR40Muzzle1st'
     FireSoundFar=Sound'DA2_WeaponSounds.Gunshots.MR40_FireFar'
     FireSoundRand=0.070000
     Momentum=1500.000000
     bWaitForRelease=False
     TransientSoundVolume=2.500000
     TransientSoundRadius=400.000000
     FireAnim="Fire_Loop"
     FireLoopAnim="Fire_Loop"
     FireEndAnim="Fire_End"
     FireSound=Sound'DA2_WeaponSounds.Gunshots.MR40_Fire'
     FireRate=0.130000
     AmmoClass=Class'DA2.da_weapons_MR40Ammo'
     ShakeRotMag=(X=80.000000,Y=80.000000,Z=127.000000)
     ShakeRotRate=(X=3000.000000,Y=3000.000000,Z=3000.000000)
     ShakeRotTime=1.500000
     ShakeOffsetMag=(X=-7.000000,Y=4.500000,Z=7.000000)
     ShakeOffsetTime=2.000000
     aimerror=140.000000
     Spread=0.025000
}
