class da_effects_BulletHole extends ProjectedDecal;

function PostBeginPlay()
{
	if ( FRand() < 0.75 )
		LifeSpan *= 0.5;
	Super.PostBeginPlay();
}

defaultproperties
{
     RandomOrient=False
     ProjTexture=Texture'da2effects2.Skins.BulletHoleTex'
     bClipStaticMesh=True
     CullDistance=2000.000000
     bHighDetail=True
     DrawScale=0.130000
}
