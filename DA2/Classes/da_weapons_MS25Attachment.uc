class da_weapons_MS25Attachment extends da_weapons_weaponAttachment;

simulated event ThirdPersonEffects()
{
    super.ThirdPersonEffects();

    if(mMuzFlash3rd!= none)
        AttachToBone(mMuzFlash3rd, 'Muzzle');
}

defaultproperties
{
     mMuzFlashClass=Class'DA2.da_effects_MS25RocketLaunch'
     bUseSpewer=False
     KarmaDrop=StaticMesh'DA2KarmaStatics.MS25'
     PlayerIdleAnim="Idle_MS25"
     PlayerFireAnim="Fire_MS25"
     PlayerReloadAnim="Reload_MS25"
     PlayerMeleeAnim="Melee_MS25"
     Mesh=SkeletalMesh'DA2_Weapons.MS25_3rd'
}
