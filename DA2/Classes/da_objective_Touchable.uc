// ============================================================================
//  DA2.da_objective_Touchable:
// This is a static mesh that if touched it will be triggered.
// Used for Doors, Switches and other events.
// ============================================================================

class da_objective_Touchable extends da_objective_base placeable;

var() bool bAreaEffect;
var() class<emitter> AreaEffectClass;
var emitter AreaEffect;

simulated function PostBeginPlay()
{

  if(ROLE == ROLE_Authority && bAreaEffect) SpawnAreaEffect();

  super.PostBeginPlay();
}

simulated function SpawnAreaEffect()
{
    local vector loc, hn;

    if(areaeffect!=none)
        return;

    Trace(loc,hn,location-vect(0,0,512),Location,false);
    areaeffect=spawn(areaeffectclass,,,loc);
}

function Touch( Actor Other )
{
 if ((Pawn(Other) == None))
		return;

    if (Pawn(Other) != none && Pawn(Other).PlayerReplicationInfo != none
        && Pawn(Other).PlayerReplicationInfo.Team != none
        && DefenderTeamIndex != Pawn(Other).PlayerReplicationInfo.Team.TeamIndex)
    {

        if (PlayerController(Pawn(Other).Controller) != none)
            da_players_PlayerController(Pawn(Other).Controller).AMIAnnouncement(Sound'AMISounds.Player.NewObjective2');

       DisableObjective(Pawn(Other));

        if(bDisabled) {
            setCollision(false, false, false);

            if(areaeffect != none)
                areaeffect.kill();
	   }
    }
}

function Reset()
{
  Super.Reset();

  SetCollision(Default.bCollideActors, Default.bBlockActors, Default.bBlockPlayers);
  if(bAreaEffect) SpawnAreaEffect();
}

simulated function Destroyed()
{
    super.Destroyed();

    if( AreaEffect != none )
    {
        AreaEffect.Destroy();
        AreaEffect = none;
    }
}

defaultproperties
{
     bAreaEffect=True
     AreaEffectClass=Class'DA2.da_effects_AreaEffect'
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'DA2_StaticMeshes2.switches.Switch'
     bHidden=False
     bCollideActors=True
}
