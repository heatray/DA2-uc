// ============================================================================
// By: Leviathan
// Backward Exhaust Flame
// ============================================================================
class da_effects_MS25RocketLaunch extends da_effects_MuzzleFlashes;

simulated event SpawnParticle( int Amount )
{
	local int i;

	for( i=0; i<Emitters.Length; i++ )
		if( Emitters[i] != none )
            Emitters[i].SpawnParticle(Emitters[i].MaxParticles);
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=255,G=255,R=255))
         ColorScale(1)=(RelativeTime=0.500000,Color=(B=119,G=182,R=227,A=255))
         ColorScale(2)=(RelativeTime=1.000000)
         CoordinateSystem=PTCS_Relative
         MaxParticles=8
         SpinsPerSecondRange=(X=(Min=-3.000000,Max=3.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.300000)
         SizeScale(1)=(RelativeTime=0.280000,RelativeSize=1.200000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.500000)
         StartSizeRange=(X=(Min=15.000000,Max=25.000000),Y=(Min=60.000000,Max=60.000000),Z=(Min=60.000000,Max=60.000000))
         InitialParticlesPerSecond=800.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'da2effects2.EmitterTextures.Part_explode2'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.250000,Max=0.500000)
         StartVelocityRange=(X=(Min=-300.000000,Max=-200.000000),Y=(Min=-80.000000,Max=80.000000),Z=(Min=-80.000000,Max=80.000000))
         VelocityLossRange=(X=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(0)=SpriteEmitter'DA2.da_effects_MS25RocketLaunch.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-200.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=64))
         ColorScale(1)=(RelativeTime=0.500000,Color=(B=64,G=128,R=200,A=255))
         ColorScale(2)=(RelativeTime=1.000000)
         FadeOutStartTime=0.500000
         FadeInEndTime=0.050000
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Max=3.000000)
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Max=0.200000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.100000)
         StartSizeRange=(X=(Min=1.500000,Max=5.000000),Y=(Min=20.000000,Max=30.000000),Z=(Min=20.000000,Max=20.000000))
         InitialParticlesPerSecond=800.000000
         Texture=Texture'da2effects2.EmitterTextures.plasmastar'
         TextureUSubdivisions=1
         TextureVSubdivisions=1
         LifetimeRange=(Min=0.200000,Max=0.400000)
         StartVelocityRange=(X=(Min=-800.000000,Max=-200.000000),Y=(Min=-150.000000,Max=150.000000),Z=(Min=-150.000000,Max=150.000000))
         VelocityLossRange=(X=(Min=1.000000,Max=1.500000),Y=(Min=1.000000,Max=1.500000),Z=(Min=1.000000,Max=1.500000))
     End Object
     Emitters(1)=SpriteEmitter'DA2.da_effects_MS25RocketLaunch.SpriteEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
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
         MaxParticles=8
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Max=3.000000)
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Max=0.200000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.400000)
         SizeScale(1)=(RelativeTime=0.280000,RelativeSize=0.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=20.000000,Max=70.000000))
         InitialParticlesPerSecond=100.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'DA2Effects.Weapon.SmokePanels2'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.500000,Max=1.500000)
         StartVelocityRange=(X=(Min=-600.000000,Max=-300.000000),Y=(Min=-100.000000,Max=100.000000),Z=(Min=-100.000000,Max=100.000000))
         VelocityLossRange=(X=(Min=3.000000,Max=4.000000),Y=(Min=3.000000,Max=4.000000),Z=(Min=3.000000,Max=4.000000))
     End Object
     Emitters(2)=SpriteEmitter'DA2.da_effects_MS25RocketLaunch.SpriteEmitter4'

}
