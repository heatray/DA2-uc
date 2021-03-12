class da_weapons_rifles_A9SMG extends da_weapons_Rifle;

function float GetAIRating() {
         return AIRating;
}

defaultproperties
{
     bHasIronsight=True
     IronsightOffset=(X=11.500000,Y=-11.470000,Z=8.500000)
     maxZoom=0.200000
     zoomStep=0.200000
     MeleeDamage(0)=75
     allMeleeTime=2.200000
     DACrosshair=Texture'DA2Crosshairs.Weapon.smgcross'
     RecoilAddPerSec=7.250000
     RecoilMax=8.000000
     RecoilRegenPerSec=5.000000
     RecoilMoveMalus=0.350000
     ReloadSound=Sound'DA2_WeaponSounds.A-9_Reload'
     reloadEmptySound=Sound'DA2_WeaponSounds.A-9_Reload_Empty'
     FireModeClass(0)=Class'DA2.da_weapons_A9Fire'
     PutDownTime=0.000050
     SelectSound=Sound'Inf_Weapons_Foley.g43.g43_reloadempty04_139'
     DisplayFOV=60.000000
     PlayerViewPivot=(Yaw=-16384,Roll=16384)
     BobDamping=2.000000
     AttachmentClass=Class'DA2.da_weapons_A9Attachment'
     ItemName="A9 Submachine Gun"
     Mesh=SkeletalMesh'DA2_Weapons.A9_1st'
}
