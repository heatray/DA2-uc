// ============================================================================
//	DA2.da_weapons_GK2Shotgun:
//	By: aBsOlUt, Dante
// ============================================================================

class da_weapons_GK2Shotgun extends da_weapons_BasicGun;

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
	   if (EnemyDist > 400)
	      return 1.0;

    return AIRating;
}

// ============================================================================

defaultproperties
{
     MeleeDamage(0)=100
     DACrosshair=Texture'DA2Crosshairs.Weapon.shotguncross'
     RecoilAddPerSec=5.500000
     RecoilMax=10.000000
     RecoilRegenPerSec=4.500000
     RecoilMoveMalus=0.600000
     FireModeClass(0)=Class'DA2.da_weapons_GK2Fire'
     FireModeClass(1)=Class'DA2.da_weapons_ModeMelee'
     PutDownTime=0.000050
     BringUpTime=0.900000
     SelectSound=Sound'DA2_WeaponSounds.Reload.GK2_Pull'
     AIRating=0.800000
     DisplayFOV=60.000000
     InventoryGroup=2
     PlayerViewPivot=(Yaw=-16384,Roll=16384)
     BobDamping=2.000000
     AttachmentClass=Class'DA2.da_weapons_GK2Attachment'
     ItemName="GK2 Shotgun"
     Mesh=SkeletalMesh'DA2_Weapons.GK2_1st'
}
