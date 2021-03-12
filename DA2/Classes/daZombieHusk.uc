//=============================================================================
// ZombieHusk
//=============================================================================
// Husk burned up fire projectile launching zed pawn class
//=============================================================================
// Killing Floor Source
// Copyright (C) 2009 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================
class daZombieHusk extends ZombieHusk;

//----------------------------------------------------------------------------
// NOTE: All Variables are declared in the base class to eliminate hitching
//----------------------------------------------------------------------------


function SpawnTwoShots()
{
	local vector X,Y,Z, FireStart;
	local rotator FireRotation;
	local KFMonsterController KFMonstControl;

	if( Controller!=None && KFDoorMover(Controller.Target)!=None )
	{
		Controller.Target.TakeDamage(22,Self,Location,vect(0,0,0),Class'DamTypeVomit');
		return;
	}

	GetAxes(Rotation,X,Y,Z);
	FireStart = GetBoneCoords('Barrel').Origin;
	if ( !SavedFireProperties.bInitialized )
	{
		SavedFireProperties.AmmoClass = Class'SkaarjAmmo';
		SavedFireProperties.ProjectileClass = Class'HuskFireProjectile';
		SavedFireProperties.WarnTargetPct = 1;
		SavedFireProperties.MaxRange = 65535;
		SavedFireProperties.bTossed = False;
		SavedFireProperties.bTrySplash = true;
		SavedFireProperties.bLeadTarget = True;
		SavedFireProperties.bInstantHit = False;
		SavedFireProperties.bInitialized = True;
	}

    // Turn off extra collision before spawning vomit, otherwise spawn fails
    ToggleAuxCollision(false);

	FireRotation = Controller.AdjustAim(SavedFireProperties,FireStart,600);

	foreach DynamicActors(class'KFMonsterController', KFMonstControl)
	{
        if( KFMonstControl != Controller )
        {
            if( PointDistToLine(KFMonstControl.Pawn.Location, vector(FireRotation), FireStart) < 75 )
            {
                KFMonstControl.GetOutOfTheWayOfShot(vector(FireRotation),FireStart);
            }
        }
	}

    Spawn(Class'daHuskFireProjectile',,,FireStart,FireRotation);

	// Turn extra collision back on
	ToggleAuxCollision(true);
}


// New Hit FX for Zombies!
function PlayHit(float Damage, Pawn InstigatedBy, vector HitLocation, class<DamageType> damageType, vector Momentum, optional int HitIdx )
{
	local Vector HitNormal;
	local Vector HitRay ;
	local Name HitBone;
	local float HitBoneDist;
	local PlayerController PC;
	local bool bShowEffects, bRecentHit;
	local ProjectileBloodSplat BloodHit;
	local rotator SplatRot;

	bRecentHit = Level.TimeSeconds - LastPainTime < 0.2;

    LastDamageAmount = Damage;

	// Call the modified version of the original Pawn playhit
	OldPlayHit(Damage, InstigatedBy, HitLocation, DamageType,Momentum);

	if ( Damage <= 0 )
		return;

	if( Health>0 && Damage>(float(Default.Health)/1.5) )
	{
		FlipOver();
	}
	else if( Health > 0 && (damageType == class'da_damtypes_Sniper' || damageType == class'da_damtypes_SniperHeadshot' ) &&  Damage > 200 )
	{
        FlipOver();
	}

	PC = PlayerController(Controller);
	bShowEffects = ( (Level.NetMode != NM_Standalone) || (Level.TimeSeconds - LastRenderTime < 2.5)
					|| ((InstigatedBy != None) && (PlayerController(InstigatedBy.Controller) != None))
					|| (PC != None) );
	if ( !bShowEffects )
		return;

	if ( BurnDown > 0 && !bBurnified )
	{
    	bBurnified = true;
	}

	HitRay = vect(0,0,0);
	if( InstigatedBy != None )
		HitRay = Normal(HitLocation-(InstigatedBy.Location+(vect(0,0,1)*InstigatedBy.EyeHeight)));

	if( DamageType.default.bLocationalHit )
	{
		CalcHitLoc( HitLocation, HitRay, HitBone, HitBoneDist );
	}
	else
	{
		HitLocation = Location ;
		HitBone = FireRootBone;
		HitBoneDist = 0.0f;
	}

	if( DamageType.default.bAlwaysSevers && DamageType.default.bSpecial )
		HitBone = 'head';

	if( InstigatedBy != None )
		HitNormal = Normal( Normal(InstigatedBy.Location-HitLocation) + VRand() * 0.2 + vect(0,0,2.8) );
	else
		HitNormal = Normal( Vect(0,0,1) + VRand() * 0.2 + vect(0,0,2.8) );

	//log("HitLocation "$Hitlocation) ;

	if ( DamageType.Default.bCausesBlood && (!bRecentHit || (bRecentHit && (FRand() > 0.8))))
	{
		if ( !class'GameInfo'.static.NoBlood() && !class'GameInfo'.static.UseLowGore() )
		{
        	if ( Momentum != vect(0,0,0) )
				SplatRot = rotator(Normal(Momentum));
			else
			{
				if ( InstigatedBy != None )
					SplatRot = rotator(Normal(Location - InstigatedBy.Location));
				else
					SplatRot = rotator(Normal(Location - HitLocation));
			}

		 	BloodHit = Spawn(ProjectileBloodSplatClass,InstigatedBy,, HitLocation, SplatRot);
		}
	}

	if( InstigatedBy != none && InstigatedBy.PlayerReplicationInfo != none &&
        KFSteamStatsAndAchievements(InstigatedBy.PlayerReplicationInfo.SteamStatsAndAchievements) != none &&
		Health <= 0 && Damage > DamageType.default.HumanObliterationThreshhold && Damage != 1000 && (!bDecapitated || bPlayBrainSplash) )
	{
		KFSteamStatsAndAchievements(InstigatedBy.PlayerReplicationInfo.SteamStatsAndAchievements).AddGibKill(class<DamTypeM79Grenade>(damageType) != none);

		if ( self.IsA('ZombieFleshPound') )
		{
			KFSteamStatsAndAchievements(InstigatedBy.PlayerReplicationInfo.SteamStatsAndAchievements).AddFleshpoundGibKill();
		}
	}

	DoDamageFX( HitBone, Damage, DamageType, Rotator(HitNormal) );

	if (DamageType.default.DamageOverlayMaterial != None && Damage > 0 ) // additional check in case shield absorbed
		SetOverlayMaterial( DamageType.default.DamageOverlayMaterial, DamageType.default.DamageOverlayTime, false );
}

defaultproperties
{
}
