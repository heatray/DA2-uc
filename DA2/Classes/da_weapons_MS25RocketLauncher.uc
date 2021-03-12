// ============================================================================
//	DA2.da_weapons_MS25RocketLauncher:
//	By: aBsOlUt, Dante
//  Thanks to: Epic for their RocketLauncher barrel code.
// ============================================================================

class da_weapons_MS25RocketLauncher extends da_weapons_BasicGun;

var float BarrelRotation;
var float FinalRotation;

const NUM_BARRELS = 4;
const BARREL_ROTATION_RATE = 2.95;

var bool bRotateBarrel;

var da_CameraTextureClient screen;

simulated function clientSetRocketView(projectile rocket)
{
	if (screen == none)
		return;

	screen.cameraActor = rocket;
	screen.cameraOffset = 100;
}

function bool RecommendLongRangedAttack()
{
	return true;
}

simulated function attachScreens()
{
    log("AttachScreens called");

    // Don't need screens on bots or the server
	if (Level.NetMode != NM_DedicatedServer && Instigator != none && Instigator.IsLocallyControlled() &&
		Instigator.IsHumanControlled() )
	{
        log("Attaching Screens");
        bInitializedScope = true;
        screen=Spawn(class'da_CameraTextureClient'/*,level.GetLocalPlayerController()*/);
        attachToBone(screen, 'Cam');
        screen.BackupCameraActor = none;
        screen.reset();
        screen.init(,30, false);
	}
}

simulated event Destroyed()
{
	if( screen != none )
    {
       DetachFromBone(screen);
       if (screen.cameraActor != none)
       {
//		   screen.cameraActor.destroy();
		   screen.Destroy();
	   }
	}
	super.Destroyed();
}

simulated function PreTravelCleanUp()
{
    if( screen != none )
    {
        screen.PreTravelCleanUp();
        screen.Destroy();
    }
}

simulated function PlayFiring()
{
        GotoState('AnimateLoad', 'Begin');
}
// ============================================================================

simulated function RotateBarrel()
{
    FinalRotation += 65535.0 / NUM_BARRELS;
    if (FinalRotation >= 65535.0)
    {
        FinalRotation -= 65535.0;
        BarrelRotation -= 65535.0;
    }
    bRotateBarrel = true;
}

simulated function UpdateBarrel(float dt)
{
    local Rotator R;

    BarrelRotation += dt * 65535.0 * BARREL_ROTATION_RATE / NUM_BARRELS;
    if (BarrelRotation > FinalRotation)
    {
        BarrelRotation = FinalRotation;
        bRotateBarrel = false;
    }

    R.Yaw = BarrelRotation;
    SetBoneRotation('Drum', R, 0, 1.0);
}

simulated state AnimateLoad extends BusyState
{
    simulated function Tick(float dt)
    {
        if (bRotateBarrel)
            UpdateBarrel(dt);
    }

Begin:
    Sleep(1.10);
    RotateBarrel();
    Sleep(0.10);
    //PlayOwnedSound(Sound'WeaponSounds.RocketLauncher.RocketLauncherLoad', SLOT_None,,,,,false);
    ClientPlayForceFeedback( "RocketLauncherLoad" );
    Sleep(0.30);
    GotoState('');
}

function float SuggestAttackStyle()
{
	local float EnemyDist;

	// recommend backing off if target is too close
	EnemyDist = VSize(Instigator.Controller.Enemy.Location - Owner.Location);
	if ( EnemyDist < 750 )
	{
		if ( EnemyDist < 500 )
			return -1.5;
		else
			return -0.7;
	}
	else if ( EnemyDist > 1600 )
		return 0.5;
	else
		return -0.1;
}

function float GetAIRating() {

    local Bot B;

	B = Bot(Instigator.Controller);

	if ( B == None )
		return 0.1;

	if ( B.Enemy == None )
	{
		if ( (da_objective_Destroyable(B.Target) != None) && !da_objective_Destroyable(B.Target).bDisabled)
			return 1.0;
	}

	if (da_turrets_Turret(B.Enemy) != none)
	   return 1.0;

    return 0.1;

}


// ============================================================================

defaultproperties
{
     MeleeDamage(0)=120
     MeleeRange=105.000000
     DACrosshair=Texture'DA2Crosshairs.Weapon.rocketcross'
     RecoilAddPerSec=1.500000
     RecoilMax=3.000000
     RecoilRegenPerSec=1.000000
     RecoilMoveMalus=0.500000
     FireModeClass(0)=Class'DA2.da_weapons_MS25Fire'
     FireModeClass(1)=Class'DA2.da_weapons_MS25FireGuided'
     PutDownTime=0.000050
     BringUpTime=0.610000
     AIRating=0.800000
     DisplayFOV=70.000000
     InventoryGroup=2
     PlayerViewPivot=(Yaw=-16384,Roll=16384)
     BobDamping=2.300000
     AttachmentClass=Class'DA2.da_weapons_MS25Attachment'
     ItemName="MS-25 Rocket Launcher"
     Mesh=SkeletalMesh'DA2_Weapons.MS25_1st'
}
