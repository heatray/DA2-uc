class da_effects_SniperTraceMaker extends emitter;

/*simulated event SpawnParticle( int Amount )
{
    if( Emitters[1] != none )
        Emitters[1].SpawnParticle(1);
}*/

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseDirectionAs=PTDU_Up
         UseCollision=True
         UseMaxCollisions=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         DampingFactorRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(A=255))
         Opacity=0.400000
         FadeOutStartTime=0.200000
         FadeInEndTime=0.200000
         MaxParticles=75
         UseRotationFrom=PTRS_Actor
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=6.000000)
         StartSizeRange=(X=(Min=0.200000,Max=1.000000),Y=(Min=75.000000),Z=(Min=75.000000,Max=150.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'Effects_Tex.explosions.LSmoke1'
         TextureUSubdivisions=1
         TextureVSubdivisions=1
         LifetimeRange=(Min=0.300000,Max=1.200000)
         StartVelocityRange=(X=(Min=500.000000,Max=9000.000000),Y=(Min=-2.000000,Max=2.000000),Z=(Min=-2.000000,Max=2.000000))
     End Object
     Emitters(0)=SpriteEmitter'DA2.da_effects_SniperTraceMaker.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         UseDirectionAs=PTDU_Right
         UseCollision=True
         UseMaxCollisions=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         DampingFactorRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         ColorMultiplierRange=(Y=(Min=0.750000,Max=0.750000),Z=(Min=0.600000,Max=0.500000))
         MaxParticles=1
         UseRotationFrom=PTRS_Actor
         SizeScale(1)=(RelativeTime=0.030000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=250.000000,Max=300.000000),Y=(Min=6.000000,Max=6.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'da2effects2.EmitterTextures.TracerShot'
         LifetimeRange=(Min=1.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=12000.000000,Max=12000.000000))
     End Object
     Emitters(1)=SpriteEmitter'DA2.da_effects_SniperTraceMaker.SpriteEmitter2'

     AutoDestroy=True
     bNoDelete=False
}
