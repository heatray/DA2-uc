class da_weapons_SniperFireNew extends ProjectileFire;

var()           class<Emitter>  ShellEjectClass;            // class of the shell eject emitter
var()           Emitter         ShellEjectEmitter;          // The shell eject emitter
var()           name            ShellEjectBoneName;         // name of the shell eject bone


event ModeDoFire()
{
	super.modedofire();
			
		if (Instigator.Owner != none && Owner != none)
		{
			if (da_SteamStatsAndAchievements(da_Players_PlayerController(Instigator.Owner).SteamStatsAndAchievements).Sniper2Completed) 
				FireRate=1.30;
			else if (da_SteamStatsAndAchievements(da_Players_PlayerController(Instigator.Owner).SteamStatsAndAchievements).Sniper1Completed) 
				FireRate=1.65;
			else 
				FireRate=2.00; 
		}
}

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


function ServerPlayFiring()
{
    Weapon.PlayOwnedSound(FireSound,SLOT_None,TransientSoundVolume,,TransientSoundRadius,0.95+(frand()*0.1),false);
    Weapon.PlayOwnedSound(Sound'DA2_WeaponSounds.Gunshots.R86_FireFar',SLOT_None,TransientSoundVolume/3,,TransientSoundRadius*15,0.95+(frand()*0.1),false);
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
    Weapon.PlayOwnedSound(Sound'DA2_WeaponSounds.Gunshots.R86_FireFar',SLOT_None,TransientSoundVolume/3,,TransientSoundRadius*15,0.95+(frand()*0.1),false);

    ClientPlayForceFeedback(FireForce);
    FireCount++;
}

defaultproperties
{
     ProjSpawnOffset=(X=25.000000,Y=5.000000,Z=-6.000000)
     bWaitForRelease=True
     TransientSoundVolume=3.400000
     TransientSoundRadius=500.000000
     FireSound=Sound'DA2_WeaponSounds.Gunshots.R86_Fire'
     FireRate=2.000000
     AmmoClass=Class'DA2.da_weapons_SniperAmmo_SR'
     AmmoPerFire=1
     ShakeRotMag=(X=100.000000,Y=100.000000,Z=100.000000)
     ShakeRotRate=(X=1000.000000,Y=1000.000000,Z=1000.000000)
     ShakeRotTime=2.500000
     ShakeOffsetMag=(X=-7.600000,Y=5.000000,Z=10.500000)
     ShakeOffsetTime=1.700000
     ProjectileClass=Class'DA2.da_proj_Sniper'
     BotRefireRate=0.980000
     FlashEmitterClass=Class'ROEffects.MuzzleFlash1stSTG'
     aimerror=1.000000
     Spread=0.750000
}
