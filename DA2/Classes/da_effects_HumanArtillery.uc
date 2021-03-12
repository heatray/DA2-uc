// ============================================================================
// Effects by: aBsOlUt
// Coded by: aBsOlUt
// Human Artillery effect.
// ============================================================================

class da_effects_HumanArtillery extends Emitter;

 #EXEC OBJ LOAD FILE=DA2_WeaponSounds.uax

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=HumanArtillery
         UseColorScale=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         UseRandomSubdivision=True
         ColorScale(1)=(RelativeTime=0.100000,Color=(B=253,G=255,R=255))
         ColorScale(2)=(RelativeTime=0.800000,Color=(B=94,G=247,R=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=126,G=29,R=48))
         CoordinateSystem=PTCS_Relative
         MaxParticles=40
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=-35.000000)
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=0.300000,RelativeSize=0.900000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.250000)
         StartSizeRange=(X=(Min=20.000000,Max=45.000000))
         Texture=Texture'DA2Effects.Weapon.SmokePanels2'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.350000,Max=0.350000)
         StartVelocityRange=(X=(Min=400.000000,Max=500.000000))
         WarmupTicksPerSecond=1.000000
         RelativeWarmupTime=3.000000
     End Object
     Emitters(0)=SpriteEmitter'DA2.da_effects_HumanArtillery.HumanArtillery'

     AutoDestroy=True
     bNoDelete=False
     Physics=PHYS_Trailer
     AmbientSound=Sound'DA2_WeaponSounds.Artillery_Ambient'
}
