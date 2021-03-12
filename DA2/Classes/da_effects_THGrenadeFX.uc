class da_effects_THGrenadeFX extends Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=221,G=236,R=251,A=255))
         ColorScale(1)=(RelativeTime=0.200000,Color=(B=218,G=228,R=239,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=38,G=73,R=132,A=255))
         MaxParticles=1
         StartLocationOffset=(Y=3.000000)
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-5.000000,Max=5.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=0.100000,RelativeSize=0.500000)
         SizeScale(4)=(RelativeTime=1.000000,RelativeSize=0.200000)
         StartSizeRange=(X=(Min=18.000000,Max=22.000000))
         InitialParticlesPerSecond=100.000000
         Texture=Texture'da2effects2.EmitterTextures.SparkGlowTex'
         TextureUSubdivisions=1
         TextureVSubdivisions=1
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(0)=SpriteEmitter'DA2.da_effects_THGrenadeFX.SpriteEmitter5'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter7
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-150.000000)
         ColorScale(0)=(Color=(B=221,G=236,R=251,A=255))
         ColorScale(1)=(RelativeTime=0.171429,Color=(B=151,G=210,R=251,A=255))
         ColorScale(2)=(RelativeTime=0.896429,Color=(B=4,G=34,R=123,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(A=255))
         MaxParticles=50
         StartLocationOffset=(Y=3.000000)
         UseRotationFrom=PTRS_Actor
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000)
         StartSizeRange=(X=(Min=1.000000,Max=3.000000),Y=(Min=5.000000,Max=9.000000),Z=(Min=4.500000,Max=9.000000))
         InitialParticlesPerSecond=50.000000
         Texture=Texture'da2effects2.EmitterTextures.plasmastar'
         TextureUSubdivisions=1
         TextureVSubdivisions=1
         LifetimeRange=(Min=0.100000,Max=0.200000)
         StartVelocityRange=(X=(Min=-60.000000,Max=60.000000),Y=(Min=100.000000,Max=200.000000),Z=(Min=-60.000000,Max=60.000000))
         VelocityLossRange=(X=(Min=1.000000,Max=2.000000),Y=(Min=1.000000,Max=2.000000),Z=(Min=1.000000,Max=2.000000))
     End Object
     Emitters(1)=SpriteEmitter'DA2.da_effects_THGrenadeFX.SpriteEmitter7'

     AutoDestroy=True
     bNoDelete=False
     Physics=PHYS_Trailer
     bHardAttach=True
}
