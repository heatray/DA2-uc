//-----------------------------------------------------------
//
//-----------------------------------------------------------
class da_weapons_XD40Handgun extends da_weapons_rifle;

defaultproperties
{
     bHasIronsight=True
     IronsightOffset=(X=2.000000,Y=-3.500000,Z=6.500000)
     minZoom=0.140000
     maxZoom=0.140000
     zoomStep=0.140000
     allMeleeTime=2.100000
     DACrosshair=Texture'DA2Crosshairs.Weapon.pistolcross'
     RecoilAddPerSec=7.000000
     RecoilMax=7.000000
     RecoilRegenPerSec=5.000000
     RecoilMoveMalus=0.200000
     ReloadAnim="Reload_Aim"
     reloadEmptyAnim="Reload_Empty_Aim"
     ReloadSound=Sound'DA2_WeaponSounds.XD40_Reload'
     reloadEmptySound=Sound'DA2_WeaponSounds.XD40_Reload_Empty'
     FireModeClass(0)=Class'DA2.da_weapons_XD40Fire'
     IdleAnim="Idle_Aim"
     PutDownAnim="'"
     PutDownTime=0.000050
     BringUpTime=0.920000
     SelectSound=Sound'KF_9MMSnd.9mm_Dual_Reload_093'
     AIRating=0.200000
     DisplayFOV=60.000000
     Priority=4
     PlayerViewPivot=(Yaw=-16384,Roll=16384)
     BobDamping=1.900000
     AttachmentClass=Class'DA2.da_weapons_XD40Attachment'
     ItemName="XD-40 Pistol"
     Mesh=SkeletalMesh'DA2_Weapons.XD40_1st'
}
