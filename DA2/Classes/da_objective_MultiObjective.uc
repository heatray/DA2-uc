/** This objective is not intended for players or bots to be disabled
  * directly. It will be disabled if all objectives belonging to it are
  * disabled. A objective belongs to this one if it's tag is listed in
  * the "tags" array under (array).
  */

class da_objective_MultiObjective extends da_objective_base;

var(DA)	array<name> tags;
var array<GameObjective> objectives;


function GameObjective getClosestObjective(Bot b) {
	local int i;
	local int best;

	best = rand(objectives.length);

	for (i = 0; i < objectives.length; i++) {
		if (i != best && objectives[i].NearObjective(b.pawn))
			best = i;
	}
	return objectives[best];
}

function bool BotNearObjective(Bot B) {
	local int i;

	for (i = 0; i < objectives.length; i++)
		if (objectives[i].BotNearObjective(b))
			return true;
	return false;
}

function bool NearObjective(Pawn P) {
	local int i;

	for (i = 0; i < objectives.length; i++)
		if (objectives[i].NearObjective(P))
			return true;
	return false;
}

function bool OwnsDefenseScript(UnrealScriptedSequence S) {
	local int i;

	for (i = 0; i < objectives.length; i++)
		if (objectives[i].OwnsDefenseScript(S))
			return true;
	return false;
}

function bool TellBotHowToDisable(Bot B) {
	local GameObjective o;
	o = getClosestObjective(b);
	if (o == none)
		return false;
	return o.TellBotHowToDisable(b);
}

function int GetNumDefenders() {
	local int i, def;

	for (i = 0; i < objectives.length; i++)
		def += objectives[i].getNumDefenders();
	return def;
}

function bool BetterObjectiveThan(GameObjective Best, byte DesiredTeamNum, byte RequesterTeamNum) {
	return false;
}

simulated function PostBeginPlay() {
	local GameObjective o;
	local int i;

	super.postBeginPlay();

	if (ROLE == ROLE_Authority) {
		foreach AllActors(class'GameObjective', O) {
			for (i = 0; i < tags.length; i++) {
				if (o.tag == tags[i]) {
					objectives[objectives.length] = o;
					break;
				}
			}
		}
	}

	spawn(class'da_objective_MOHack', self);
}


function check() {
	local int i;
	for (i = 0; i < objectives.length; i++) {
		if (!objectives[i].bDisabled)
			return;
	}
	DisableObjective(none);

}

defaultproperties
{
}
