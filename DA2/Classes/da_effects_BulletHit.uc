// ============================================================================
// Coded by: Leviathan
// Directional bulletspark
// ============================================================================
class da_effects_BulletHit extends Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         RespawnDeadParticles=False
         ScaleSizeXByVelocity=True
         AutomaticInitialSpawning=False
         UseVelocityScale=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.800000,Color=(B=157,G=160,R=172,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(A=255))
         FadeOutFactor=(Y=0.800000,Z=0.650000)
         FadeOutStartTime=0.160000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=6.000000)
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=4.000000)
         StartSizeRange=(X=(Min=3.000000,Max=6.000000),Y=(Min=4.000000,Max=16.000000),Z=(Min=50.000000,Max=50.000000))
         ScaleSizeByVelocityMultiplier=(X=0.012000)
         InitialParticlesPerSecond=500.000000
         Texture=Texture'da2effects2.EmitterTextures.SparkSprayTex'
         LifetimeRange=(Min=0.080000,Max=0.100000)
         StartVelocityRange=(X=(Min=120.000000,Max=160.000000),Y=(Min=-20.000000,Max=20.000000),Z=(Min=-20.000000,Max=20.000000))
         VelocityLossRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=1.000000,Max=1.000000))
         VelocityScale(0)=(RelativeVelocity=(X=1.000000,Y=1.000000,Z=1.000000))
         VelocityScale(1)=(RelativeTime=1.000000,RelativeVelocity=(X=0.050000,Y=0.050000,Z=0.050000))
     End Object
     Emitters(0)=SpriteEmitter'DA2.da_effects_BulletHit.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         ProjectionNormal=(X=1.000000,Z=0.000000)
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.800000,Color=(B=147,G=152,R=170,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(A=255))
         FadeOutFactor=(Y=0.750000,Z=0.500000)
         FadeOutStartTime=0.160000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=4.000000)
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.200000)
         StartSizeRange=(X=(Min=10.000000,Max=20.000000))
         InitialParticlesPerSecond=50.000000
         Texture=Texture'da2effects2.EmitterTextures.SparkGlowTex'
         LifetimeRange=(Min=0.080000,Max=0.100000)
     End Object
     Emitters(1)=SpriteEmitter'DA2.da_effects_BulletHit.SpriteEmitter1'

     AutoDestroy=True
     bNoDelete=False
}
