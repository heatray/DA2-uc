class DA2Whisp extends WillowWhisp;


simulated function StartNextPath()
{
	if ( Position >= NumPoints )
	{
		mregen = false;
		LifeSpan = 10;
		LifeLeft = 10;
		Velocity = vect(0,0,0);
		Acceleration = vect(0,0,0);
		return;
	}
	bHeadedRight = false;
	Destination = WayPoints[Position];
	Acceleration = 1200 * Normal(Destination - Location);
	Velocity *= 0.5;
	Velocity.Z = 0.5 * (Velocity.Z + Acceleration.Z);
	SetRotation(rotator(Acceleration));
	Position++;
}

defaultproperties
{
     mParticleType=PT_Mesh
     mMaxParticles=300
     mLifeRange(0)=2.000000
     mLifeRange(1)=2.000000
     mRegenRange(0)=10.000000
     mRegenRange(1)=10.000000
     bSuspendWhenNotVisible=False
     mAirResistance=3.000000
     mRandOrient=False
     mSizeRange(0)=0.200000
     mSizeRange(1)=0.200000
     mGrowthRate=0.150000
     mMeshNodes(0)=StaticMesh'DA2_Misc_StaticMeshes.Misc.objArrow'
     LifeSpan=30.000000
     Skins(0)=Combiner'da2effects2.Skins.HUDArrowCmb'
}
