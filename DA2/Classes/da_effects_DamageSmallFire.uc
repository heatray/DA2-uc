// ============================================================================
// Effects by: aBsOlUt
// Coded by: aBsOlUt
// Small Fire
// ============================================================================

class da_effects_DamageSmallFire extends Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SmallSmoke
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         AddVelocityFromOwner=True
         LowDetailFactor=1.000000
         Acceleration=(Z=120.000000)
         ColorScale(1)=(RelativeTime=0.200000,Color=(B=128,G=128,R=128,A=255))
         ColorScale(2)=(RelativeTime=0.800000,Color=(B=64,G=64,R=64,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=64,G=64,R=64))
         MaxParticles=15
         StartSpinRange=(X=(Min=0.250000,Max=0.750000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=50.000000,Max=60.000000))
         ParticlesPerSecond=7.500000
         InitialParticlesPerSecond=7.500000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'DA2Effects.Weapon.SmokePanels2'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=2.000000,Max=2.000000)
         AddVelocityMultiplierRange=(Z=(Min=0.500000,Max=0.500000))
     End Object
     Emitters(0)=SpriteEmitter'DA2.da_effects_DamageSmallFire.SmallSmoke'

     Begin Object Class=SpriteEmitter Name=SmallFire
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         AddVelocityFromOwner=True
         LowDetailFactor=1.000000
         Acceleration=(Z=120.000000)
         ColorScale(1)=(RelativeTime=0.200000,Color=(B=128,G=128,R=128,A=255))
         ColorScale(2)=(RelativeTime=0.800000,Color=(B=64,G=64,R=64,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=64,G=64,R=64))
         FadeOutFactor=(W=0.700000,X=0.700000,Y=0.700000,Z=0.700000)
         FadeOutStartTime=0.400000
         MaxParticles=30
         StartSpinRange=(X=(Min=0.250000,Max=0.750000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=50.000000,Max=60.000000))
         ParticlesPerSecond=6.800000
         InitialParticlesPerSecond=6.800000
         DrawStyle=PTDS_Brighten
         Texture=Texture'Effects_Tex.explosions.fire_16frame'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=2.000000,Max=2.000000)
         AddVelocityFromOtherEmitter=-2
         AddVelocityMultiplierRange=(Z=(Min=0.500000,Max=0.500000))
     End Object
     Emitters(1)=SpriteEmitter'DA2.da_effects_DamageSmallFire.SmallFire'

     AutoDestroy=True
     bNoDelete=False
}
