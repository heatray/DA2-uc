//=============================================================================
// Our own ladder volume, built in animations to climb and finish climbing
// No strafing allowed by default.
// Coded by: aBsOlUt
//===============================================================================

class da_map_LadderVolume extends LadderVolume;

defaultproperties
{
     ClimbingAnimation="ladderClimb"
     TopAnimation="ladderFinish"
}
