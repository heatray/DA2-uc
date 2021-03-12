class da_AI_SquadAI extends SquadAI;

function bool ShouldSuppressEnemy(Bot B)
{
    return ( Frand() < 0.8 && (VSize(B.Pawn.Location - B.FocalPoint) < 400)
            && (Level.TimeSeconds - B.LastSeenTime < 8) );
}

function MergeWith(SquadAI S)
{
    if ( SquadObjective != S.SquadObjective )
    {
        SquadObjective = S.SquadObjective;
        NetUpdateTime = Level.Timeseconds - 1;
    }
}

function name GetOrders()
{
    bFreelanceAttack = true;
    return Super.GetOrders();
}

function float AssessThreat( Bot B, Pawn NewThreat, bool bThreatVisible )
{
    local float ThreatValue;

	ThreatValue = super.assessThreat(b, newThreat, bThreatVisible);

	if (da_players_PRI(b.playerReplicationInfo).playerClass == 5 && newThreat.IsA('da_turrets_Turret'))
		ThreatValue += 0.4;

	if (da_players_PRI(b.playerReplicationInfo).playerClass == 4 && newThreat.IsA('da_turrets_Turret'))
		ThreatValue -= 0.6;

    return ThreatValue;
}

function float ModifyThreat(float current, Pawn NewThreat, bool bThreatVisible, Bot B)
{
    if ( bThreatVisible && (NewThreat.PlayerReplicationInfo != None)
        && ((NewThreat.PlayerReplicationInfo.HasFlag != None) || ((Vehicle(NewThreat) != None) && Vehicle(NewThreat).bKeyVehicle)) )
    {
        if ( (VSize(B.Pawn.Location - NewThreat.Location) < 2500) || B.Pawn.Weapon.bSniping )
            return current + 6;
        else
            return current + 1.5;
    }
    else if ( (SquadObjective != None) && (SquadObjective.DefenderTeamIndex == Team.TeamIndex)
            && (SquadObjective.MyBaseVolume != None) && NewThreat.IsInVolume(SquadObjective.MyBaseVolume) )
        return current + 1.5;
    else if ( NewThreat.IsHumanControlled() )
        return current + 0.5;
    else if ( NewThreat.bStationary && bThreatVisible )
        return current + 0.3;
    else
        return current;
}


function bool isRelevantFor(Actor a, da_ai_HumanBot b) {
	if (squadObjective == none)
		return true;
	return vsize(squadObjective.location - a.location) < 5000 || vsize(a.location - b.pawn.location) < 1000;
}

function bool setBestRepairTurret(da_AI_HumanBot b) {
	local da_turrets_Turret t, bestTurret;
//	local controller c;
	local float r1, r2;

	foreach allactors(class'da_turrets_turret', t) {
	    if( vsize(t.location-b.pawn.location)>2000)
	        continue;
		if (t.isBuilt() && t.health>t.default.health*4/7 || t.team!=b.playerReplicationInfo.team.teamIndex)
			continue;
		if (!isRelevantFor(t, b) || b.findPathToward(t) == none)
			continue;
		if (bestTurret != none) {
			// Prefer repairing turrets
			if (!t.isBuilt() && bestTurret.isBuilt())
				continue;
			r1 = t.health * (1 + t.weapon.ammoStatus()) / vsize(t.location - b.pawn.location);
			r2 = bestTurret.health * (1 + bestTurret.weapon.ammoStatus())/ vsize(bestTurret.location - b.pawn.location);
			// Turrets with more health and closer position are preferred
			if (frand() * (r1 + r2) > r1)
				continue;
		}
    	bestTurret = t;
	}
	b.repairActor = bestTurret;
	return bestTurret != none;
}

function bool setBestRepairBuildable(da_AI_HumanBot b) {
	local da_buildable_Useable u, best;
	local float r1, r2;

	foreach b.pawn.radiusActors(class'da_buildable_Useable', u, 2000) {
		if (u.isBuilt() && u.health>u.default.health*4/7 || u.RepairTeam != b.PlayerReplicationInfo.team.teamIndex)
			continue;
		if (best != none) {
			if (!u.isBuilt() && best.isBuilt() && best.importance >= u.importance)
				continue;
			if (u.importance < best.importance || !isRelevantFor(u, b) || b.findPathToward(u) == none)
				continue;

			r1 = u.health / vsize(u.location - b.pawn.location) * u.importance;
			r2 = best.health / vsize(best.location - b.pawn.location) * best.importance;
			if (frand() * (r1 + r2) > r1)
				continue;
		}
		best = u;
	}

	b.repairActor = best;
	return best != none;
}

function bool setBestBuildTurret(da_AI_HumanBot bot) {
	local da_map_BuildBeacon bb, best;

	foreach bot.pawn.radiusActors(class'da_map_BuildBeacon', bb, 2000) {
//		log(isRelevantFor(bb, bot)@da_players_ClassPlayer(bot.pawn).AllowAdditional(bb.buildClass)@bb.allowBuildFor(bot));
		if (isRelevantFor(bb, bot) && da_players_ClassPlayer(bot.pawn).AllowAdditional(bb.buildClass) &&
			(best == none || bb.suggestBuild > best.suggestBuild) && bb.allowBuildFor(bot))
				best = bb;
	}
//	log("best is:"@best);

	if (best != none && frand() < fclamp(best.suggestBuild, 0.05, 1.0)) {
//		log("And it's beeing built!");
		bot.buildBeacon = best;
		return true;
	}
	return false;
}

function checkRepair(da_AI_HumanBot b) {
	local da_turrets_Turret t;
	local da_buildable_Useable u;
	t = da_turrets_Turret(b.repairActor);
	u = da_buildable_Useable(b.repairActor);
	if (t != none && (t.health > t.default.health * 3 / 4) ||
		u != none && u.health > u.default.health * 3 / 4)
		b.repairActor = none;
}

function checkBuild(da_AI_HumanBot b) {
	if (b.buildBeacon == none || !b.buildBeacon.allowBuildFor(b))
		b.buildBeacon = none;
}

function bool checkMechObjectives(da_AI_HumanBot b) {

	if (b == none || b.pawn == none || b.pawn.findInventoryType(class'da_weapons_MechTool') == none)
		return false;

	checkRepair(b);
	checkBuild(b);

	if (b.buildBeacon == none && b.repairActor == none && (b.enemy == none || vsize(b.enemy.location - b.pawn.location) > 500)) {
		if (setBestRepairTurret(b)) ;
		else if (setBestRepairBuildable(b)) ;
		else
			setBestBuildTurret(b);
	}

	if (b.repairActor != none) {
		if (b.actorReachable(b.repairActor)) {
			b.GoalString = "Repairing "@b.repairActor;
			b.moveTarget = b.repairActor;
			b.doRepairObject();
			return true;
		}

		b.GoalString = "Going to repair "@b.repairActor;
		if (b.findBestPathToward(b.repairActor, true, true)) {
			b.setAttractionState();
			return true;
		}
		return false;
	}

	if (b.buildBeacon != none) {
		if (b.actorReachable(b.buildBeacon)) {
			b.GoalString = "Constructing "@b.buildBeacon.buildClass;
			b.moveTarget = b.buildBeacon;
			b.doConstructObject();
			return true;
		}

		b.GoalString = "Going to build "@b.buildBeacon.buildClass;
		if (b.findBestPathToward(b.buildBeacon, true, true)) {
			b.setAttractionState();
			return true;
		}
		return false;
	}
	return false;
}

function bool AssignSquadResponsibility(Bot B) {
	if ( (SquadObjective == None) || SquadObjective.bDisabled || !SquadObjective.bActive || !UnrealMPGameInfo(Level.Game).CanDisableObjective( SquadObjective ) )
    {
        Team.AI.FindNewObjectiveFor(self,true);
        if ( (SquadObjective == None) || SquadObjective.bDisabled || !SquadObjective.bActive )
        {
            if ( (PlayerController(SquadLeader) != None) && (HoldSpot(B.GoalScript) == None) )
            {
                return TellBotToFollow(B,SquadLeader);
            }
            if ( B.Enemy == None && !B.Pawn.bStationary )
            {
                // suggest inventory hunt
                if ( B.FindInventoryGoal(0) )
                {
                    B.SetAttractionState();
                    return true;
                }
            }
            return false;
        }
    }

	if (checkMechObjectives(da_ai_HumanBot(b)))
		return true;
	return super.AssignSquadResponsibility(b);
}

defaultproperties
{
     GatherThreshold=0.000000
     MaxSquadSize=3
     bRoamingSquad=False
     bAddTransientCosts=True
}
