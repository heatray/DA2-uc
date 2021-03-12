class da_effects_MortarTrail extends Emitter;

defaultproperties
{
     Begin Object Class=TrailEmitter Name=TrailEmitter0
         TrailShadeType=PTTST_Linear
         TrailLocation=PTTL_FollowEmitter
         MaxPointsPerTrail=200
         DistanceThreshold=200.000000
         UseCrossedSheets=True
         PointLifeTime=0.700000
         AutomaticInitialSpawning=False
         Opacity=0.200000
         MaxParticles=1
         StartSizeRange=(X=(Min=12.000000,Max=12.000000))
         InitialParticlesPerSecond=2000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'DA2Effects.TrailBlura'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=999999.000000,Max=999999.000000)
     End Object
     Emitters(0)=TrailEmitter'DA2.da_effects_MortarTrail.TrailEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=30.000000)
         ColorScale(0)=(Color=(B=191,G=217,R=255,A=64))
         ColorScale(1)=(RelativeTime=0.300000,Color=(B=222,G=222,R=222,A=100))
         ColorScale(2)=(RelativeTime=1.000000)
         Opacity=0.300000
         FadeOutStartTime=1.995000
         FadeInEndTime=0.105000
         MaxParticles=50
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Max=3.000000)
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Max=0.200000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.400000)
         SizeScale(1)=(RelativeTime=0.280000,RelativeSize=0.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=10.000000,Max=80.000000))
         InitialParticlesPerSecond=100.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'Effects_Tex.Vehicles.Gasoline_Smoke'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=1.000000,Max=3.000000)
         StartVelocityRange=(X=(Min=-500.000000,Max=-300.000000))
         VelocityLossRange=(X=(Min=2.500000,Max=3.000000),Y=(Min=2.500000,Max=3.000000),Z=(Min=2.500000,Max=3.000000))
     End Object
     Emitters(1)=SpriteEmitter'DA2.da_effects_MortarTrail.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter121
         UseColorScale=True
         RespawnDeadParticles=False
         AutoDestroy=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ColorScale(1)=(RelativeTime=0.150000,Color=(B=186,G=237,R=252))
         ColorScale(2)=(RelativeTime=0.725000,Color=(B=2,G=80,R=208))
         ColorScale(3)=(RelativeTime=1.000000)
         Opacity=0.800000
         MaxParticles=1
         StartLocationOffset=(X=15.000000)
         SpinsPerSecondRange=(X=(Min=1.000000,Max=1.000000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.750000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=1.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.200000)
         StartSizeRange=(X=(Min=300.000000,Max=400.000000))
         InitialParticlesPerSecond=2000.000000
         Texture=Texture'da2effects2.EmitterTextures.hardspot'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.200000,Max=0.300000)
     End Object
     Emitters(2)=SpriteEmitter'DA2.da_effects_MortarTrail.SpriteEmitter121'

     AutoDestroy=True
     bNoDelete=False
     Physics=PHYS_Trailer
     bHardAttach=True
}
