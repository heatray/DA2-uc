// ============================================================================
//	DA2.da_weapons_MS25RocketLauncher:
//	By: aBsOlUt
//  Updated: Leviathan
//  NOTE: This is a projectile class and should be treated differently instead
//  using the da_weapons_InstantFire class.
// ============================================================================
class da_weapons_MS25Fire extends ProjectileFire;

var Emitter MuzEmitter;
var class<Emitter> MuzEmitterClass;


/*var() vector ProjSpawnOffset;


simulated function PlayFiring()
{
    Super.PlayFiring();
    da_Weapons_MS25RocketLauncher(Weapon).PlayFiring();
}

simulated function vector GetFireStart(vector X, vector Y, vector Z)
{
return Instigator.GetBoneCoords('Release').Origin;
}

//#LEVI - Copied from projectilefire (cut spread-stuff out)
function DoFireEffect()
{
    local Vector StartProj, StartTrace, X,Y,Z;
    local Vector HitLocation, HitNormal;
    local Actor Other;

    Instigator.MakeNoise(1.0);
    Weapon.GetViewAxes(X,Y,Z);

    StartTrace = Instigator.Location + Instigator.EyePosition();// + X*Instigator.CollisionRadius;
    StartProj = StartTrace + X*ProjSpawnOffset.X;
    if ( !Weapon.WeaponCentered() )
	    StartProj = StartProj + Weapon.Hand * Y*ProjSpawnOffset.Y + Z*ProjSpawnOffset.Z;

    // check if projectile would spawn through a wall and adjust start location accordingly
    Other = Weapon.Trace(HitLocation, HitNormal, StartProj, StartTrace, false);
    if (Other != None)
    {
        StartProj = HitLocation;
    }

    SpawnProjectile(StartProj, AdjustAim(StartProj, AimError));

}

//#LEVI - Copied, too
function projectile SpawnProjectile(Vector Start, Rotator Dir)
{
    local Projectile p;

    if( ProjectileClass != None )
        p = Weapon.Spawn(ProjectileClass,,, Start, Dir);

    if( p == None )
        return None;

    p.Damage *= DamageAtten;
    return p;
}
*/

function ServerPlayFiring()
{
    Weapon.PlayOwnedSound(FireSound,SLOT_None,TransientSoundVolume,,TransientSoundRadius,0.95+(frand()*0.1),false);
    Weapon.PlayOwnedSound(Sound'DA2_WeaponSounds.MS25_FireFar',SLOT_None,TransientSoundVolume/3,,TransientSoundRadius*15,0.95+(frand()*0.1),false);
}

function PlayFiring()
{
	if ( Weapon.Mesh != none && FireCount > 0 )
	{
		if ( Weapon.HasAnim(FireLoopAnim) )
			Weapon.PlayAnim(FireLoopAnim, FireLoopAnimRate, 0.0);
		else
			Weapon.PlayAnim(FireAnim, FireAnimRate, TweenTime);
	}
	else
		Weapon.PlayAnim(FireAnim, FireAnimRate, TweenTime);

    Weapon.PlayOwnedSound(FireSound,SLOT_None,TransientSoundVolume,,TransientSoundRadius,0.95+(frand()*0.1),false);
    Weapon.PlayOwnedSound(Sound'DA2_WeaponSounds.MS25_FireFar',SLOT_None,TransientSoundVolume/3,,TransientSoundRadius*15,0.95+(frand()*0.1),false);

    ClientPlayForceFeedback(FireForce);
    FireCount++;
}

defaultproperties
{
     ProjSpawnOffset=(X=35.000000,Y=8.000000,Z=-6.000000)
     TransientSoundVolume=2.800000
     FireSound=Sound'DA2_WeaponSounds.Gunshots.MS25_Fire'
     FireRate=2.500000
     AmmoClass=Class'DA2.da_weapons_MS25Ammo'
     AmmoPerFire=1
     ShakeRotMag=(X=200.000000,Y=200.000000,Z=200.000000)
     ShakeRotRate=(X=3000.000000,Y=3000.000000,Z=3000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-40.000000,Y=23.000000,Z=27.000000)
     ShakeOffsetTime=1.500000
     ProjectileClass=Class'DA2.da_proj_rocket'
     aimerror=0.000000
}
