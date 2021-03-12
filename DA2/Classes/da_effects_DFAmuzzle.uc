class da_effects_DFAmuzzle extends da_effects_MuzzleFlashes;

defaultproperties
{
     smokeamount=1.500000
     sparkamount=9.000000
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.041000
         FadeInEndTime=0.013000
         CoordinateSystem=PTCS_Relative
         MaxParticles=6
         UseRotationFrom=PTRS_Offset
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.800000)
         StartSizeRange=(X=(Min=10.000000,Max=30.000000),Y=(Min=200.000000,Max=200.000000),Z=(Min=200.000000,Max=200.000000))
         Texture=Texture'da2effects2.EmitterTextures.MuzParticleTexB'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.080000,Max=0.120000)
         StartVelocityRange=(X=(Max=300.000000))
         VelocityLossRange=(X=(Min=3.000000,Max=3.000000),Y=(Min=3.000000,Max=3.000000),Z=(Min=3.000000,Max=3.000000))
     End Object
     Emitters(0)=SpriteEmitter'DA2.da_effects_DFAmuzzle.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.041000
         FadeInEndTime=0.013000
         CoordinateSystem=PTCS_Relative
         MaxParticles=6
         StartLocationOffset=(X=2.500000)
         UseRotationFrom=PTRS_Offset
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.800000)
         StartSizeRange=(X=(Min=8.000000,Max=16.000000),Y=(Min=200.000000,Max=200.000000),Z=(Min=200.000000,Max=200.000000))
         Texture=Texture'da2effects2.EmitterTextures.MuzParticleTexB'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.080000,Max=0.100000)
         StartVelocityRange=(X=(Min=200.000000,Max=400.000000))
         VelocityLossRange=(X=(Min=3.000000,Max=3.000000),Y=(Min=3.000000,Max=3.000000),Z=(Min=3.000000,Max=3.000000))
     End Object
     Emitters(1)=SpriteEmitter'DA2.da_effects_DFAmuzzle.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
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
         ColorScale(0)=(Color=(B=255,G=90,R=30,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.700000,Max=0.800000),Z=(Min=0.400000,Max=0.400000))
         FadeOutStartTime=0.041000
         FadeInEndTime=0.013000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         UseRotationFrom=PTRS_Offset
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.100000)
         StartSizeRange=(X=(Min=80.000000),Y=(Min=200.000000,Max=200.000000),Z=(Min=200.000000,Max=200.000000))
         Texture=Texture'da2effects2.EmitterTextures.hardspot'
         TextureUSubdivisions=1
         TextureVSubdivisions=1
         LifetimeRange=(Min=0.080000,Max=0.120000)
         StartVelocityRange=(X=(Min=200.000000,Max=400.000000))
         VelocityLossRange=(X=(Min=3.000000,Max=3.000000),Y=(Min=3.000000,Max=3.000000),Z=(Min=3.000000,Max=3.000000))
     End Object
     Emitters(2)=SpriteEmitter'DA2.da_effects_DFAmuzzle.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         UseDirectionAs=PTDU_Up
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.046000
         FadeInEndTime=0.019000
         CoordinateSystem=PTCS_Relative
         MaxParticles=4
         StartLocationOffset=(X=5.000000)
         UseRotationFrom=PTRS_Offset
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=0.070000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.100000)
         StartSizeRange=(X=(Min=10.000000,Max=20.000000),Y=(Min=50.000000,Max=80.000000),Z=(Min=200.000000,Max=200.000000))
         Texture=Texture'da2effects2.EmitterTextures.MuzParticleTexB'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.080000,Max=0.120000)
         StartVelocityRange=(X=(Min=400.000000,Max=1000.000000))
         VelocityLossRange=(X=(Min=3.000000,Max=3.000000),Y=(Min=3.000000,Max=3.000000),Z=(Min=3.000000,Max=3.000000))
     End Object
     Emitters(3)=SpriteEmitter'DA2.da_effects_DFAmuzzle.SpriteEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         UseDirectionAs=PTDU_Up
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.081600
         FadeInEndTime=0.018000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         UseRotationFrom=PTRS_Offset
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.400000)
         SizeScale(1)=(RelativeTime=0.560000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.400000)
         StartSizeRange=(X=(Min=5.000000,Max=10.000000),Y=(Min=19.000000,Max=24.000000))
         Texture=Texture'da2effects2.EmitterTextures.MuzParticleSideTexB'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.080000,Max=0.120000)
         StartVelocityRange=(X=(Min=150.000000,Max=200.000000),Z=(Min=300.000000,Max=500.000000))
         VelocityLossRange=(X=(Min=4.500000,Max=4.500000),Y=(Min=4.500000,Max=4.500000),Z=(Min=4.500000,Max=4.500000))
     End Object
     Emitters(4)=SpriteEmitter'DA2.da_effects_DFAmuzzle.SpriteEmitter4'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         UseDirectionAs=PTDU_Up
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.081600
         FadeInEndTime=0.018000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         UseRotationFrom=PTRS_Offset
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.400000)
         SizeScale(1)=(RelativeTime=0.560000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.400000)
         StartSizeRange=(X=(Min=5.000000,Max=10.000000),Y=(Min=19.000000,Max=24.000000))
         Texture=Texture'da2effects2.EmitterTextures.MuzParticleSideTexB'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.080000,Max=0.120000)
         StartVelocityRange=(X=(Min=150.000000,Max=200.000000),Y=(Min=-400.000000,Max=-350.000000),Z=(Min=100.000000,Max=150.000000))
         VelocityLossRange=(X=(Min=4.500000,Max=4.500000),Y=(Min=4.500000,Max=4.500000),Z=(Min=4.500000,Max=4.500000))
     End Object
     Emitters(5)=SpriteEmitter'DA2.da_effects_DFAmuzzle.SpriteEmitter5'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter6
         UseDirectionAs=PTDU_Up
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.081600
         FadeInEndTime=0.018000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         UseRotationFrom=PTRS_Offset
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.400000)
         SizeScale(1)=(RelativeTime=0.560000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.400000)
         StartSizeRange=(X=(Min=5.000000,Max=10.000000),Y=(Min=19.000000,Max=24.000000))
         Texture=Texture'da2effects2.EmitterTextures.MuzParticleSideTexB'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.080000,Max=0.120000)
         StartVelocityRange=(X=(Min=150.000000,Max=200.000000),Y=(Min=350.000000,Max=400.000000),Z=(Min=100.000000,Max=150.000000))
         VelocityLossRange=(X=(Min=4.500000,Max=4.500000),Y=(Min=4.500000,Max=4.500000),Z=(Min=4.500000,Max=4.500000))
     End Object
     Emitters(6)=SpriteEmitter'DA2.da_effects_DFAmuzzle.SpriteEmitter6'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter7
         UseDirectionAs=PTDU_Up
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.081600
         FadeInEndTime=0.018000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         UseRotationFrom=PTRS_Offset
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.400000)
         SizeScale(1)=(RelativeTime=0.560000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.400000)
         StartSizeRange=(X=(Min=5.000000,Max=10.000000),Y=(Min=19.000000,Max=24.000000))
         Texture=Texture'da2effects2.EmitterTextures.MuzParticleSideTexB'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.080000,Max=0.120000)
         StartVelocityRange=(X=(Min=150.000000,Max=200.000000),Y=(Min=-250.000000,Max=-200.000000),Z=(Min=-400.000000,Max=-350.000000))
         VelocityLossRange=(X=(Min=4.500000,Max=4.500000),Y=(Min=4.500000,Max=4.500000),Z=(Min=4.500000,Max=4.500000))
     End Object
     Emitters(7)=SpriteEmitter'DA2.da_effects_DFAmuzzle.SpriteEmitter7'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter8
         UseDirectionAs=PTDU_Up
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.081600
         FadeInEndTime=0.018000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         UseRotationFrom=PTRS_Offset
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.400000)
         SizeScale(1)=(RelativeTime=0.560000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.400000)
         StartSizeRange=(X=(Min=5.000000,Max=10.000000),Y=(Min=19.000000,Max=24.000000))
         Texture=Texture'da2effects2.EmitterTextures.MuzParticleSideTexB'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.080000,Max=0.120000)
         StartVelocityRange=(X=(Min=150.000000,Max=200.000000),Y=(Min=200.000000,Max=250.000000),Z=(Min=-400.000000,Max=-350.000000))
         VelocityLossRange=(X=(Min=4.500000,Max=4.500000),Y=(Min=4.500000,Max=4.500000),Z=(Min=4.500000,Max=4.500000))
     End Object
     Emitters(8)=SpriteEmitter'DA2.da_effects_DFAmuzzle.SpriteEmitter8'

}
