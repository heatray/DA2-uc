//-----------------------------------------------------------
//
//-----------------------------------------------------------
class da_weapons_rifles_SniperRifle extends da_weapons_Rifle;

var da_CameraTextureClient SniperScreen;

// AI Interface
function float SuggestAttackStyle()
{
    return -0.6;
}

function float SuggestDefenseStyle()
{
    return 0.4;
}

function byte BestMode()
{
    return 0;
}

function bool RecommendRangedAttack()
{
    local Bot B;

    B = Bot(Instigator.Controller);
    if ( (B == None) || (B.Enemy == None) )
        return true;

    return ( VSize(B.Enemy.Location - Instigator.Location) > 2000 * (1 + FRand()) );
}

function bool RecommendLongRangedAttack()
{
	return true;
}

// end AI Interface

simulated function attachScreens()
{
    // Don't need screens on bots or the server
	if (Level.NetMode != NM_DedicatedServer && Instigator != none && Instigator.IsLocallyControlled() &&
		Instigator.IsHumanControlled() )
	{
    	bInitializedScope = true;
        if (sniperScreen == none)
    	    SniperScreen=Spawn(class'da_CameraTextureClient'/*,level.GetLocalPlayerController()*/);//,,Instigator.Location, Instigator.Rotation);
        attachToBone(SniperScreen.cameraActor, 'S_Cam');
        SniperScreen.init(,10, true);
	}
}

simulated event Destroyed() {

	if( SniperScreen != none )
    {
       DetachFromBone(SniperScreen.cameraActor);
//	   SniperScreen.cameraActor.destroy();
	   SniperScreen.Destroy();
	}
	super.Destroyed();
}

simulated function PreTravelCleanUp()
{
    if( SniperScreen != none )
    {
        SniperScreen.PreTravelCleanUp();
        SniperScreen.Destroy();
    }
}

defaultproperties
{
     bHasScope=True
     minZoom=0.600000
     maxZoom=0.900000
     zoomStep=0.050000
     MeleeDamage(0)=101
     allMeleeTime=2.200000
     DACrosshair=Texture'DA2Crosshairs.Weapon.snipecross'
     RecoilAddPerSec=6.000000
     RecoilMax=8.000000
     RecoilRegenPerSec=3.500000
     RecoilMoveMalus=0.600000
     ReloadAnim="reload_empty"
     FireModeClass(0)=Class'DA2.da_weapons_SniperFire'
     PutDownTime=0.000050
     BringUpTime=0.900000
     SelectSound=Sound'Inf_Weapons_Foley.svt40.svt40_reloadempty04_150'
     bSniping=True
     DisplayFOV=60.000000
     PlayerViewPivot=(Yaw=-16384,Roll=16384)
     BobDamping=2.000000
     AttachmentClass=Class'DA2.da_weapons_SniperAttachment'
     ItemName="R86 Sniper Rifle"
     Mesh=SkeletalMesh'DA2_Weapons.R86_1st'
}
