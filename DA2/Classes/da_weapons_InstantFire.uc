class da_weapons_InstantFire extends old2k4.InstantFire;

var int	tracesPerShot;
var Projectile Tracer;

var sound FireSoundFar;
var float FireSoundPitch;
var float FireSoundRand;

function DoFireEffect() {
	local int i;

	for (i = 0; i < tracesPerShot; i++)
		super.DoFireEffect();
}

//##LEVI - Distant Sounds
function ServerPlayFiring()
{
    Weapon.PlayOwnedSound(FireSound,SLOT_None,TransientSoundVolume,,TransientSoundRadius,FireSoundPitch+(frand()-0.5)*FireSoundRand,false);
    if(FireSoundFar!=none) Weapon.PlayOwnedSound(FireSoundFar,SLOT_None,TransientSoundVolume/3,,TransientSoundRadius*15,FireSoundPitch+(frand()-0.5)*FireSoundRand,false);
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

    Weapon.PlayOwnedSound(FireSound,SLOT_None,TransientSoundVolume,,TransientSoundRadius,FireSoundPitch+(frand()-0.5)*FireSoundRand,false);
    if(FireSoundFar!=none) Weapon.PlayOwnedSound(FireSoundFar,SLOT_None,TransientSoundVolume/3,,TransientSoundRadius*15,FireSoundPitch+(frand()-0.5)*FireSoundRand,false);

    ClientPlayForceFeedback(FireForce);
    FireCount++;
}

defaultproperties
{
     tracesPerShot=1
     FireSoundPitch=1.000000
     FireSoundRand=0.100000
     TransientSoundVolume=1.000000
     TransientSoundRadius=300.000000
     ShakeOffsetRate=(X=500.000000,Y=800.000000,Z=1000.000000)
}
