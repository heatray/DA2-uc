//==============================================================================
// Creates a realistic battle effect on top of the map skybox
// WARNING: Only one of those is needed, just increase the actor radious to
//          spawn effects all around the map.
//==============================================================================

class da_effects_PlanetBombardement extends Actor placeable;

var() Range delayBetweenExplosion;
var() class<Emitter> emitterClass;

replication {
    reliable if (bNetInitial && ROLE == ROLE_Authority)
        delayBetweenExplosion, emitterClass;
}

simulated function PostBeginPlay() {
    if (level.netmode != NM_DedicatedServer)
        Timer();
}

simulated function Timer() {
    spawn(emitterClass,,,location + (frand() * vect(2, 0, 0) - vect(1, 0, 0)) * collisionRadius +
            (frand() * vect(0, 2, 0) - vect(0, 1, 0)) * collisionRadius +
            (frand() * vect(0, 0, 2) - vect(0, 0, 1)) * collisionHeight, rotation);
    setTimer(delayBetweenExplosion.MIN + (delayBetweenExplosion.MAX - delayBetweenExplosion.MIN) * frand(), false);
}

defaultproperties
{
     delayBetweenExplosion=(Min=0.400000,Max=1.200000)
     EmitterClass=Class'DA2.da_effects_ExplosionA'
     bHidden=True
     bNoDelete=True
     bAlwaysRelevant=True
     RemoteRole=ROLE_SimulatedProxy
     Texture=Texture'DA2Textures.editing.Planetbomb'
     bCollideWorld=True
}
