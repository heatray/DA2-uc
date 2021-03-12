class da_weapons_AVeRTurretAttachment extends da_weapons_weaponAttachment;

var bool leftside;

simulated event ThirdPersonEffects()
{
    local vector leftpack, rightpack;

    if ( (Level.NetMode == NM_DedicatedServer) || (Instigator == None) )
        return;

    if ( FlashCount > 0 )
	{
         //Do not use real muzzles, just show an "explosion" effect for muzzle instead for each barrel
         leftpack=instigator.GetBoneCoords('muzzle01').Origin;
         rightpack=instigator.GetBoneCoords('muzzle02').Origin;

         if(leftside)
             Spawn(class'da_effects_AVeRMuzzle',,,leftpack, Instigator.Rotation);
         else Spawn(class'da_effects_AVeRMuzzle',,,rightpack, Instigator.Rotation);

         leftside=!leftside;
     }

}

defaultproperties
{
     DrawScale=1.200000
}
