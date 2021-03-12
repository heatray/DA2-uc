class da_effects_PlasmaDecal extends ProjectedDecal;

#exec OBJ LOAD FILE=..\Textures\Effects_Tex.utx

defaultproperties
{
     FrameBufferBlendingOp=PB_Add
     ProjTexture=Texture'DA2Weapons.Effects.plasma_decal'
     MaxTraceDistance=256
     CullDistance=7000.000000
     LifeSpan=4.000000
     DrawScale=1.800000
}
