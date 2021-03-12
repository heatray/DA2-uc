class da_effects_MuzzleFlashes extends Emitter;

var float smokeamount, sparkamount;

simulated event SpawnParticle( int Amount )
{
	local int i;

	for( i=0; i<Emitters.Length; i++ )
		if( Emitters[i]!=none)
            if(i<10) Emitters[i].SpawnParticle(Emitters[i].MaxParticles/2);
            else if(i==10) Emitters[i].SpawnParticle(frand()*smokeamount+0.5);
            else if(i==11 && frand()<0.75) Emitters[i].SpawnParticle(frand()*sparkamount);
}

simulated function Trigger(Actor Other, Pawn EventInstigator)
{
	Emitters[0].SpawnParticle(1);
}

defaultproperties
{
     sparkamount=2.000000
     Begin Object Class=SpriteEmitter Name=SpriteEmitter21
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=200.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=220,G=220,R=220,A=255))
         FadeOutStartTime=0.150000
         FadeInEndTime=0.096000
         MaxParticles=20
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-0.300000,Max=0.300000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.300000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=0.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=20.000000,Max=50.000000))
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'Effects_Tex.Smoke.LightSmoke_8Frame'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.400000,Max=0.600000)
         StartVelocityRange=(X=(Min=400.000000,Max=700.000000),Y=(Min=-60.000000,Max=60.000000),Z=(Min=-60.000000,Max=60.000000))
         VelocityLossRange=(X=(Min=5.000000,Max=5.000000),Y=(Min=5.000000,Max=5.000000),Z=(Min=5.000000,Max=5.000000))
     End Object
     Emitters(10)=SpriteEmitter'DA2.da_effects_MuzzleFlashes.SpriteEmitter21'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter22
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
         ColorMultiplierRange=(Y=(Min=0.850000,Max=0.950000),Z=(Min=0.800000,Max=0.900000))
         FadeOutStartTime=0.069000
         FadeInEndTime=0.013500
         CoordinateSystem=PTCS_Relative
         MaxParticles=20
         StartLocationOffset=(X=-6.000000)
         UseRotationFrom=PTRS_Offset
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.300000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=0.500000,Max=1.000000),Y=(Min=-14.000000,Max=-8.000000),Z=(Min=150.000000,Max=150.000000))
         Texture=Texture'da2effects2.EmitterTextures.MuzParticleSideTex'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.075000,Max=0.150000)
         StartVelocityRange=(X=(Min=200.000000,Max=400.000000),Y=(Min=-250.000000,Max=250.000000),Z=(Min=-250.000000,Max=250.000000))
         VelocityLossRange=(X=(Min=3.000000,Max=3.000000),Y=(Min=3.000000,Max=3.000000),Z=(Min=3.000000,Max=3.000000))
     End Object
     Emitters(11)=SpriteEmitter'DA2.da_effects_MuzzleFlashes.SpriteEmitter22'

     bNoDelete=False
     bHardAttach=True
}
