// ============================================================================
// Effects by: Czar
// Coded by: aBsOlUt
// Spawns explosion effect after a HumanGrenade detonates (GROUND ONLY).
// ============================================================================

class da_effects_ExplosionF extends Emitter;

#EXEC OBJ LOAD FILE=ParticleMeshes.usx
#EXEC OBJ LOAD FILE=DA2Effects.utx
simulated function PostBeginPlay()
{
	setTimer(0.10, false);
}

simulated function Timer()
{
  bDynamicLight=false;
  super.Timer();
}

defaultproperties
{
     Emitters(0)=SpriteEmitter'DA2.da_effects_ExplosionE.HumanExplosionFlash'

     Emitters(1)=SpriteEmitter'DA2.da_effects_ExplosionE.HumanExplosion'

     Emitters(2)=SpriteEmitter'DA2.da_effects_ExplosionE.HumanExplosionSmoke'

     AutoDestroy=True
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=95
     LightBrightness=300.000000
     LightRadius=16.000000
     LightPeriod=3
     bNoDelete=False
     bDynamicLight=True
}
