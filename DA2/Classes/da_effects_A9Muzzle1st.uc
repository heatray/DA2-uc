class da_effects_A9Muzzle1st extends xEmitter;

#exec OBJ LOAD FILE=DA2Weapons.utx
#exec OBJ LOAD FILE=DA2_Weapon_Effects.usx

var int mNumPerFlash;

simulated function Trigger(Actor Other, Pawn EventInstigator)
{
    mStartParticles += mNumPerFlash;
}

defaultproperties
{
     mNumPerFlash=1
     mParticleType=PT_Mesh
     mStartParticles=0
     mMaxParticles=1
     mLifeRange(0)=0.100000
     mLifeRange(1)=0.120000
     mRegenRange(0)=0.000000
     mRegenRange(1)=0.000000
     mSpeedRange(0)=0.000000
     mSpeedRange(1)=0.000000
     mPosRelative=True
     mAirResistance=0.000000
     mSizeRange(0)=0.030000
     mSizeRange(1)=0.050000
     mGrowthRate=2.000000
     mTileAnimation=True
     mMeshNodes(0)=StaticMesh'DA2_Weapon_Effects.Muzzle_Flashes.A9_MFlash'
     DrawScale=9.000000
     Skins(0)=FinalBlend'DA2Weapons.Effects.A9_MFlash_Final'
}
