// ============================================================================
// Effects by: aBsOlUt
// Coded by: aBsOlUt
// Simple flare you can use to display certain points. (Big)
// ============================================================================

class da_effects_FlareB extends Emitter;

//#exec OBJ LOAD FILE=..\Textures\AW-2004Particles.utx

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=FlareBigSmoke
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
         Acceleration=(Z=110.000000)
         ColorScale(0)=(RelativeTime=0.200000,Color=(B=84,G=150,R=99,A=255))
         ColorScale(1)=(RelativeTime=0.800000,Color=(B=37,G=226,R=22,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=62,G=111,R=60))
         FadeOutFactor=(W=0.400000,X=0.400000,Y=0.400000,Z=0.400000)
         FadeOutStartTime=0.400000
         MaxParticles=35
         StartSpinRange=(X=(Min=0.250000,Max=0.750000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
         StartSizeRange=(X=(Min=50.000000,Max=60.000000))
         ParticlesPerSecond=8.500000
         InitialParticlesPerSecond=8.500000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'DA2Effects.Weapon.SmokePanels2'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         SecondsBeforeInactive=0.700000
         LifetimeRange=(Min=2.000000,Max=7.000000)
         AddVelocityMultiplierRange=(Z=(Min=0.500000,Max=0.500000))
     End Object
     Emitters(0)=SpriteEmitter'DA2.da_effects_FlareB.FlareBigSmoke'

     AutoDestroy=True
     bNoDelete=False
}
