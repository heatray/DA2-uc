class da_weapons_P280Handgun extends da_weapons_rifle;

defaultproperties
{
     bHasIronsight=True
     IronsightOffset=(X=11.500000,Y=-7.400000,Z=7.200000)
     minZoom=0.160000
     maxZoom=0.160000
     zoomStep=0.160000
     allMeleeTime=2.100000
     DACrosshair=Texture'DA2Crosshairs.Weapon.pistolcross'
     RecoilAddPerSec=8.000000
     RecoilMax=10.000000
     RecoilRegenPerSec=5.000000
     RecoilMoveMalus=0.260000
     ReloadSound=Sound'DA2_WeaponSounds.XD40_Reload'
     reloadEmptySound=Sound'DA2_WeaponSounds.XD40_Reload_Empty'
     FireModeClass(0)=Class'DA2.da_weapons_P280Fire'
     PutDownTime=0.000050
     BringUpTime=0.930000
     SelectSound=Sound'KF_9MMSnd.9mm_Dual_Reload_093'
     AIRating=0.200000
     DisplayFOV=60.000000
     Priority=4
     InventoryGroup=1
     PlayerViewPivot=(Yaw=-16384,Roll=16384)
     BobDamping=1.900000
     AttachmentClass=Class'DA2.da_weapons_P280Attachment'
     ItemName="P2-80 Pistol"
     Mesh=SkeletalMesh'DA2_Weapons.P280_1st'
}
