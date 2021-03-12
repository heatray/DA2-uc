// ============================================================================
//  DA2.da_effects_Flare
//  By: aBsOlUt
//  Players can throw flares to notify other players (enemies too?) what is
//  their position.
// ============================================================================


class da_effects_Flare extends Emitter;

#exec OBJ LOAD FILE=AS_FX_TX.utx

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter22
         ProjectionNormal=(X=1.000000,Z=0.000000)
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=800.000000)
         ColorScale(0)=(Color=(G=136,R=54))
         ColorScale(1)=(RelativeTime=0.750000,Color=(B=68,G=215,R=251))
         ColorScale(2)=(RelativeTime=1.000000)
         Opacity=0.670000
         CoordinateSystem=PTCS_Relative
         MaxParticles=15
         SpinCCWorCW=(X=0.000000,Y=0.000000,Z=0.000000)
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.200000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=0.100000,RelativeSize=1.500000)
         SizeScale(2)=(RelativeTime=0.150000,RelativeSize=1.000000)
         SizeScale(3)=(RelativeTime=1.000000,RelativeSize=0.750000)
         StartSizeRange=(X=(Min=90.000000,Max=140.000000))
         InitialParticlesPerSecond=85.000000
         Texture=Texture'da2effects2.EmitterTextures.BrightFlareTex'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=12.000000)
         InitialDelayRange=(Min=0.050000,Max=0.050000)
     End Object
     Emitters(0)=SpriteEmitter'DA2.da_effects_Flare.SpriteEmitter22'

     bNoDelete=False
     bNetTemporary=True
     RemoteRole=ROLE_SimulatedProxy
}
