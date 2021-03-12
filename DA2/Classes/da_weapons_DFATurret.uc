class da_weapons_DFATurret extends Weapon;

/*
//NO IDLE ANIMATIONS
simulated function Timer() {
          super(Weapon).Timer();

}
*/

defaultproperties
{
     FireModeClass(0)=Class'DA2.da_weapons_DFATurret_MainFireMode'
     FireModeClass(1)=Class'DA2.da_weapons_NullFire'
     DisplayFOV=40.000000
     PlayerViewPivot=(Yaw=-16384,Roll=16384)
     AttachmentClass=Class'DA2.da_weapons_DFATurretAttachment'
}
