class da_effects_Dust extends xEmitter;

simulated function PostNetBeginPlay()
{
	if ( Level.NetMode == NM_DedicatedServer )
		LifeSpan = 0.2;
}

defaultproperties
{
     mRegen=False
     mStartParticles=20
     mMaxParticles=20
     mLifeRange(0)=0.700000
     mLifeRange(1)=0.900000
     mRegenRange(0)=0.000000
     mRegenRange(1)=0.000000
     mDirDev=(X=0.100000,Y=0.100000,Z=0.100000)
     mSpeedRange(0)=120.000000
     mSpeedRange(1)=170.000000
     mMassRange(0)=0.400000
     mMassRange(1)=0.600000
     mAirResistance=0.500000
     mRandOrient=True
     mSizeRange(0)=3.500000
     mSizeRange(1)=7.500000
     mGrowthRate=2.700000
     mRandTextures=True
     mNumTileColumns=2
     mNumTileRows=2
     bOnlyRelevantToOwner=True
     RemoteRole=ROLE_SimulatedProxy
     LifeSpan=2.500000
     Texture=Texture'Effects_Tex.BulletHits.dirtcloud'
     Skins(0)=Texture'Effects_Tex.BulletHits.dirtcloud'
     Style=STY_Alpha
}
