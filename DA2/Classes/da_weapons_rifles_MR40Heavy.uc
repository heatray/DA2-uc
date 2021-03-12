class da_weapons_rifles_MR40Heavy extends da_weapons_Rifle;

function float GetAIRating() {
	if (Instigator.Controller.Target == None)
		return AIRating;

	return AIRating - Fclamp(vsize(Instigator.Controller.Target.location - Instigator.location) / 4000.0 - 0.5, 0, 0.3);
}

defaultproperties
{
     bHasIronsight=True
     IronsightOffset=(Y=-10.600000,Z=3.000000)
     minZoom=0.350000
     maxZoom=0.350000
     zoomStep=0.350000
     MeleeDamage(0)=90
     DACrosshair=Texture'DA2Crosshairs.Weapon.mgcross'
     RecoilAddPerSec=2.600000
     RecoilMax=8.000000
     RecoilRegenPerSec=2.250000
     RecoilMoveMalus=3.800000
     FireModeClass(0)=Class'DA2.da_weapons_MR40Fire'
     PutDownTime=0.000050
     BringUpTime=0.900000
     SelectSound=Sound'Inf_Weapons_Foley.mg42.mg42_reload04_142'
     AIRating=0.700000
     bSniping=True
     DisplayFOV=60.000000
     PlayerViewPivot=(Yaw=-16384,Roll=16384)
     BobDamping=2.000000
     AttachmentClass=Class'DA2.da_weapons_MR40Attachment'
     ItemName="MR-40 Machine Gun"
     Mesh=SkeletalMesh'DA2_Weapons.MR40_1st'
}
