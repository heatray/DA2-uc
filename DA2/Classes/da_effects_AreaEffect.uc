class da_effects_AreaEffect extends Emitter;

defaultproperties
{
     Begin Object Class=MeshEmitter Name=MeshEmitter1
         StaticMesh=StaticMesh'SpecialEffectsSM.LightCasting.sh_lightcast_M_jm'
         UseMeshBlendMode=False
         RenderTwoSided=True
         UseColorScale=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorScale(1)=(RelativeTime=0.250000,Color=(B=255,G=255,R=255))
         ColorScale(2)=(RelativeTime=0.750000,Color=(B=115,G=175,R=80,A=255))
         ColorScale(3)=(RelativeTime=1.000000)
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         SpinsPerSecondRange=(X=(Min=-0.100000,Max=0.100000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.500000)
         StartSizeRange=(X=(Min=0.400000,Max=0.400000),Y=(Min=0.400000,Max=0.400000),Z=(Min=-0.100000,Max=-0.100000))
         InitialParticlesPerSecond=1.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'Effects_Tex.explosions.explosion_1frame'
         LifetimeRange=(Min=2.000000,Max=2.000000)
     End Object
     Emitters(0)=MeshEmitter'DA2.da_effects_AreaEffect.MeshEmitter1'

     AutoDestroy=True
     bNoDelete=False
     RemoteRole=ROLE_SimulatedProxy
     Skins(0)=Texture'Effects_Tex.explosions.explosion_1frame'
}
