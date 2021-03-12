class da_effects_BloodSplat extends ProjectedDecal;

var texture Splats[3];

simulated function PostBeginPlay()
{
    ProjTexture = splats[Rand(3)];
    Super.PostBeginPlay();
}

defaultproperties
{
     Splats(0)=Texture'Effects_Tex.GoreDecals.Splatter_001'
     Splats(1)=Texture'Effects_Tex.GoreDecals.Splatter_002'
     Splats(2)=Texture'Effects_Tex.GoreDecals.Splatter_003'
     ProjTexture=Texture'Effects_Tex.GoreDecals.Splatter_001'
     FOV=16
     MaxTraceDistance=220
     bClipStaticMesh=True
     bGradient=True
     CullDistance=4000.000000
     LifeSpan=5.000000
     DrawScale=0.500000
}
