class da_weapons_CrushTurret_MainFireMode extends da_weapons_BasicFire;

function projectile SpawnProjectile(Vector Start, Rotator Dir)
{
    local da_proj_Projectile p;

    p=Weapon.Spawn(class'da2.da_proj_crushershell',,, instigator.GetBoneCoords('muzzle01').Origin, Dir);
    p=Weapon.Spawn(class'da2.da_proj_crushershell',,, instigator.GetBoneCoords('muzzle02').Origin, Dir);

    return p;
}

function DoFireEffect()
{
    local rotator R;

    Instigator.MakeNoise(1.0);

    r=Instigator.GetViewRotation();

    if(playercontroller(instigator.controller)==none)
    {
        R.Yaw+=Spread*(FRand()-0.5);
        R.Pitch+=Spread*(FRand()-0.5);
        R.Roll+=Spread*(FRand()-0.5);
    }

    SpawnProjectile(Instigator.Location, R);
}

simulated function vector GetFireStart(vector X, vector Y, vector Z)
{
    return Instigator.Location;
}

function ServerPlayFiring()
{
    super.serverplayFiring();

    Weapon.PlayOwnedSound(Sound'DA2_WeaponSounds.CrusherReload',SLOT_None,1.5,,200);
}

function PlayFiring()
{
	super.playFiring();

    Weapon.PlayOwnedSound(Sound'DA2_WeaponSounds.CrusherReload',SLOT_None,1.5,,200);
    Weapon.instigator.PlayAnim(FireAnim, FireAnimRate, TweenTime);
}

defaultproperties
{
     FireSoundFar=Sound'DA2_WeaponSounds.Gunshots.CrusherFireFar'
     DamageType=Class'DA2.da_damtypes_CrusherTurret'
     TransientSoundVolume=5.000000
     TransientSoundRadius=600.000000
     FireLoopAnim=
     FireEndAnim=
     FireSound=Sound'DA2_WeaponSounds.Gunshots.CrusherFire'
     FireForce="TranslocatorFire"
     FireRate=2.000000
     AmmoClass=Class'ROEngine.Ammo_Dummy'
     ShakeRotMag=(X=40.000000)
     ShakeRotRate=(X=2000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=8.000000)
     ShakeOffsetRate=(X=-1500.000000)
     ShakeOffsetTime=5.000000
     BotRefireRate=0.990000
     WarnTargetPct=0.150000
     aimerror=0.000000
     Spread=1400.000000
}
