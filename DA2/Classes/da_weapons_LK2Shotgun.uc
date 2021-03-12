// ============================================================================
//	DA2.da_weapons_LK2Shotgun:
//	By: aBsOlUt, Dante
// ============================================================================

class da_weapons_LK2Shotgun extends da_weapons_BasicGun;

function bool RecommendRangedAttack() {
    local Bot B;

    B = Bot(Instigator.Controller);
    if ( (B == None) || (B.Enemy == None) )
        return true;

    return vsize(b.enemy.location - instigator.location) < 1000 * (1 + Frand());
}



// ============================================================================
function float GetAIRating()
{
	local Bot B;
	local float EnemyDist;
	local vector EnemyDir;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0.1;

	EnemyDir = B.Enemy.Location - Instigator.Location;
	EnemyDist = VSize(EnemyDir);

	if (B.Enemy != none)
	   if (EnemyDist > 500)
	      return 1.0;

    return AIRating;
}
// ============================================================================

defaultproperties
{
     MeleeDamage(0)=100
     DACrosshair=Texture'DA2Crosshairs.Weapon.shotguncross'
     RecoilAddPerSec=2.500000
     RecoilMax=10.000000
     RecoilRegenPerSec=2.150000
     RecoilMoveMalus=0.550000
     ReloadAnim="Reload_Mid"
     bWeaponReadyWhileReloading=True
     FireModeClass(0)=Class'DA2.da_weapons_LK2Fire'
     FireModeClass(1)=Class'DA2.da_weapons_ModeMelee'
     PutDownTime=0.000050
     BringUpTime=1.500000
     SelectSound=Sound'DA2_WeaponSounds.Reload.LK2_Reload_2'
     AIRating=0.800000
     DisplayFOV=60.000000
     InventoryGroup=2
     PlayerViewPivot=(Yaw=-16384,Roll=16384)
     BobDamping=2.000000
     AttachmentClass=Class'DA2.da_weapons_LK2Attachment'
     ItemName="LK2 AutoShotgun"
     Mesh=SkeletalMesh'DA2_Weapons.LK2_1st'
}
