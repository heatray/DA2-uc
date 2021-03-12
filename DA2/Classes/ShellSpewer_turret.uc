class ShellSpewer_turret extends xEmitter;

var() sound ShellImpactSnd;

function CollisionSound()
{
    PlaySound(ShellImpactSnd);
}

defaultproperties
{
     ShellImpactSnd=SoundGroup'Inf_Weapons.shells.ShellRifleConcrete'
     mParticleType=PT_Mesh
     mStartParticles=0
     mMaxParticles=150
     mLifeRange(0)=0.500000
     mLifeRange(1)=1.000000
     mRegenRange(0)=0.000000
     mRegenRange(1)=0.000000
     mDirDev=(X=0.500000,Y=0.200000,Z=0.600000)
     mSpeedRange(0)=200.000000
     mSpeedRange(1)=250.000000
     mMassRange(0)=2.000000
     mMassRange(1)=2.000000
     mSpinRange(0)=-100.000000
     mSpinRange(1)=100.000000
     mAttenFunc=ATF_None
     mMeshNodes(0)=StaticMesh'DA2_Weapon_Effects.shells.DA_bullet_shell'
     mColMakeSound=True
     bHighDetail=True
     bNetTemporary=False
     DrawScale=0.120000
     Skins(0)=Texture'DA2Weapons.Skins.bullet_Shell'
}
