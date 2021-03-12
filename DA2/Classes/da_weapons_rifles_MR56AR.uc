class da_weapons_rifles_MR56AR extends da_weapons_Rifle;

var da_cameraTextureClient RifleScreen;

simulated function attachScreens()
{
    // Don't need screens on bots or the server
	if (Level.NetMode != NM_DedicatedServer && Instigator != none && Instigator.IsLocallyControlled() &&
		Instigator.IsHumanControlled() )
	{
    	bInitializedScope = true;
        if (RifleScreen == none)
    	    RifleScreen=Spawn(class'da_CameraTextureClient'/*,level.GetLocalPlayerController()*/);//,,Instigator.Location, Instigator.Rotation);
        attachToBone(RifleScreen.cameraActor, 'S_Cam');
        RifleScreen.init(,20, true);
	}
}

simulated event Destroyed() {

	if( RifleScreen != none )
    {
	   DetachFromBone(RifleScreen.cameraActor);
       RifleScreen.cameraActor.destroy();
	   RifleScreen.Destroy();
	}
	super.Destroyed();
}

simulated function PreTravelCleanUp()
{
    if( RifleScreen != none )
    {
        RifleScreen.PreTravelCleanUp();
        RifleScreen.Destroy();
    }
}

function float GetAIRating() {
	if (Instigator.Controller.Target == None)
		return AIRating;

	return AIRating - Fclamp(vsize(Instigator.Controller.Target.location - Instigator.location) / 4000.0 - 0.5, 0, 0.3);
}

defaultproperties
{
     bHasScope=True
     minZoom=0.500000
     maxZoom=0.500000
     zoomStep=0.500000
     MeleeDamage(0)=90
     allMeleeTime=2.200000
     RecoilAddPerSec=5.500000
     RecoilMax=7.000000
     RecoilRegenPerSec=4.500000
     RecoilMoveMalus=0.500000
     FireModeClass(0)=Class'DA2.da_weapons_MR56Fire'
     PutDownTime=0.000050
     BringUpTime=0.960000
     SelectSound=Sound'DA2_WeaponSounds.Reload.MR56_Reload_3'
     DisplayFOV=70.000000
     PlayerViewPivot=(Yaw=-16384,Roll=16384)
     BobDamping=2.000000
     AttachmentClass=Class'DA2.da_weapons_MR56Attachment'
     ItemName="MR-56 Assault Rifle"
     Mesh=SkeletalMesh'DA2_Weapons.MR56_Scope_1st'
}
