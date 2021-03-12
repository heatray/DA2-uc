class da_weapons_SniperAttachment extends da_weapons_WeaponAttachment;

simulated function UpdateTracer()
{
    local vector SpawnLoc, SpawnDir;

    if (Level.NetMode == NM_DedicatedServer)
        return;

    SpawnLoc=GetTracerStart();
//    if(mHitLocation == mOldHitLocation)
		SpawnDir = vector( Instigator.GetViewRotation() );
//	else SpawnDir = Normal(mHitLocation - SpawnLoc);

    //if(mhitlocation!=vect(0,0,0))

    Spawn(mTracerClass,,, spawnloc, rotator(spawndir));

	mOldHitLocation = mHitLocation;
}

defaultproperties
{
     mMuzFlashClass=Class'DA2.da_effects_R86Muzzle3rd'
     mTracerClass=Class'DA2.da_effects_SniperTraceMaker'
     mTracerPullback=0.000000
     mTracerSpeed=16000.000000
     KarmaDrop=StaticMesh'DA2KarmaStatics.R86'
     PlayerIdleAnim="Idle_Rifles"
     PlayerFireAnim="Fire_R86"
     PlayerReloadAnim="Reload_Rifles"
     PlayerMeleeAnim="Melee_Rifles"
     Mesh=SkeletalMesh'DA2_Weapons.R86_3rd'
}
