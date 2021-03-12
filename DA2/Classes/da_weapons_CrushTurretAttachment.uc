class da_weapons_CrushTurretAttachment extends da_weapons_weaponAttachment;

simulated event ThirdPersonEffects()
{
    local vector barrelA, barrelB;

    if ( (Level.NetMode == NM_DedicatedServer) || (Instigator == None) )
        return;

    if ( FlashCount > 0 )
	{
         //Do not use real muzzles, just show an "explosion" effect for muzzle instead for each barrel
         barrelA=instigator.GetBoneCoords('muzzle01').Origin;
         barrelB=instigator.GetBoneCoords('muzzle02').Origin;

         Spawn(class'da_effects_CrusherMuzzle',,,BarrelA, Instigator.Rotation);
         Spawn(class'da_effects_CrusherMuzzle',,,barrelB, Instigator.Rotation);
   	}

}

defaultproperties
{
     DrawScale=1.200000
}
