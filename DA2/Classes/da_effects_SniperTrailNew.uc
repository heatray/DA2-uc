class da_effects_SniperTrailNew extends Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseDirectionAs=PTDU_Up
         FadeOut=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=189,G=207,R=227,A=64))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=160,G=160,R=160))
         Opacity=0.800000
         FadeOutStartTime=0.750000
         MaxParticles=100
         StartLocationRange=(X=(Min=250.000000,Max=250.000000))
         SphereRadiusRange=(Max=3.000000)
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=0.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=2.000000,Max=3.000000),Y=(Min=250.000000,Max=250.000000),Z=(Min=250.000000,Max=250.000000))
         InitialParticlesPerSecond=30000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'Effects_Tex.explosions.LSmoke1'
         TextureUSubdivisions=1
         TextureVSubdivisions=1
         LifetimeRange=(Min=0.900000,Max=0.900000)
         StartVelocityRange=(X=(Min=-300.000000,Max=-200.000000))
         VelocityLossRange=(X=(Min=2.500000,Max=3.000000),Y=(Min=2.500000,Max=3.000000),Z=(Min=2.500000,Max=3.000000))
     End Object
     Emitters(1)=SpriteEmitter'DA2.da_effects_SniperTrailNew.SpriteEmitter0'

     AutoDestroy=True
     bNoDelete=False
     Physics=PHYS_Trailer
     bHardAttach=True
}
