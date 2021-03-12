/** A beacon for mech bots.
  * If they choose to build the object they will run to this beacon with it's rotation and setup the object.
  */
// 27th Sep 05 - Created - Dante.
class da_map_BuildBeacon extends JumpSpot;

var(BuildBeacon)	class<Actor>	buildClass; //What to build
var(BuildBeacon)    bool            bRandomObject; //Build a random DA2 object
var(BuildBeacon)	float			suggestBuild; // 0 Don't build, 1.0 Build this first
var(BuildBeacon)	GameObjective	objective; //For what objective to build it
var(BuildBeacon)	int 			team; //Which team it belongs to


function PostBeginPlay()
{
	Super.PostBeginPlay();
}

static function createBeaconFor(da_turrets_Turret t) {
	local da_map_BuildBeacon b;
	local vector hitL, hitN;

	foreach t.radiusActors(class'da_map_BuildBeacon', b, 300)
		break;
	// Maybe there is a build beacon already, or turrets too close
	if (b != none)
		return;
	hitL = t.location - (t.default.collisionRadius + class'da_players_ClassPlayer'.default.collisionRadius) * 1.5 * vector(t.rotation);
	t.trace(hitL, hitN, hitL - vect(0, 0, 10000), hitL);
	b = t.spawn(class'da_map_BuildBeacon',,, hitL + vect(0, 0, 1) * class'da_Players_ClassPlayer'.default.collisionHeight, t.rotation);
	if (b == none)
		return;
	b.suggestBuild = 0.1;
	b.buildClass = t.class;
	b.team = t.team;
}

static function decreaseRatingAt(Actor a) {
	local da_map_BuildBeacon b;

	if (a == none)
		return;

	foreach a.radiusActors(class'da_map_BuildBeacon', b, 200)
		b.suggestBuild /= 2.0;
}

function bool allowBuildFor(da_ai_HumanBot b) {
	local Actor a;

	if (b.PlayerReplicationInfo == none || b.PlayerReplicationInfo.Team.TeamIndex != team)
		return false;

	foreach collidingActors(class'Actor', a, 200)
		if (ClassIsChildOf(a.class, buildClass))
			return false;
	return b.actorReachable(self) || b.findPathToward(self) != none;
}

//A bit hacked, 1.1 update to support random
function name getBuildName() {

local float R;

    if (bRandomObject)
    {
		R = FRand();

		if( R < 0.25 )
			return 'dfaturret';
		else if( R > 0.25 && R < 0.50 )
			return 'crusher';
		else if( R > 0.50 && R < 0.75 )
			return 'aver';
		else
		    return 'AmmoBox';
    }

	switch (buildClass) {
		case class'da_items_WorldAmmoBox':
			return 'AmmoBox';
		case class'da_turrets_CrushTurret':
			return 'crusher';
		case class'da_turrets_DFATurret':
			return 'dfaTurret';
		case class'da_turrets_AVeRTurret':
			return 'aver';
	}

	return '';
}

defaultproperties
{
     bStatic=False
     bNoDelete=False
     bDirectional=True
}
