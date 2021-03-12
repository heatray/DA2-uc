class da_effects_BloodLoss extends Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter7
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ScaleSizeYByVelocity=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-100.000000)
         ColorScale(0)=(Color=(B=10,G=20,R=214,A=255))
         ColorScale(1)=(RelativeTime=0.300000,Color=(B=10,G=20,R=214,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=10,G=20,R=214))
         ColorMultiplierRange=(Z=(Min=0.800000))
         MaxParticles=20
         UseRotationFrom=PTRS_Actor
         SizeScale(0)=(RelativeSize=0.800000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.800000)
         StartSizeRange=(X=(Min=1.000000,Max=3.000000),Y=(Min=50.000000,Max=50.000000),Z=(Min=50.000000,Max=50.000000))
         ScaleSizeByVelocityMultiplier=(Y=0.020000)
         InitialParticlesPerSecond=15.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'da2effects2.EmitterTextures.MatDirtParticleTex'
         TextureUSubdivisions=16
         TextureVSubdivisions=16
         LifetimeRange=(Min=0.200000,Max=0.700000)
         StartVelocityRange=(X=(Min=150.000000,Max=200.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Min=-50.000000,Max=50.000000))
         VelocityLossRange=(X=(Min=4.000000,Max=4.000000),Y=(Min=4.000000,Max=4.000000),Z=(Min=4.000000,Max=4.000000))
     End Object
     Emitters(0)=SpriteEmitter'DA2.da_effects_BloodLoss.SpriteEmitter7'

     AutoDestroy=True
     CullDistance=2000.000000
     bNoDelete=False
}
