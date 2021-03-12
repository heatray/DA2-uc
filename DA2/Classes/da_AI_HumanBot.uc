// ============================================================================
//  DA2.da_AI_HumanBot: The bots that defend/attack along with the players.
//  By: aBsOlUt, Dante
//  The bots will be a random class. They will be seeking for the
//  nearest control point or defensive point and they will guard it. They will,
//  if ordered, attack the enemy objectives as well.
//  If they are running low on ammo they should be looking for the nearest
//  ammobox that will help them reload.
// ============================================================================

class da_AI_HumanBot extends xBot;

const NADETRACES = 5;
const NADETRACELENGTH = 600;

var int classNumber;
var da_weapons_Grenades grenades;
var da_players_PRI daPRI;

var Actor repairActor;
var da_map_BuildBeacon buildBeacon;

var float lastAmmoBoxUse;

// DEBUG
var Actor lastBuilt;

/* DisplayDebug()
list important controller attributes on canvas
*/
function DisplayDebug(Canvas Canvas, out float YL, out float YPos) {
	super.DisplayDebug(canvas, yl, ypos);
	if (pawn == none)
		return;

	Canvas.SetDrawColor(0, 255, 0);
	canvas.DrawText("Repairing:"@repairActor@"Building:"@buildBeacon@"Last built:"@lastBuilt);
	YPos += YL;
}

function Possess(Pawn aPawn) {
    if (daPRI != none) {
        switch (daPRI.playerClass) {
            case 0: // Infantry
                accuracy = -1000.0;
                baseAggressiveness = 0.4;
                strafingAbility = 0.5;
                combatStyle = -0.5;
                jumpiness = 0.3;
                break;
            case 1: // MECHANIC
                accuracy = -2.0;
                baseAggressiveness = 0.3;
                strafingAbility = 0.3;
                combatStyle = -0.4;
                jumpiness = 0.5;
                break;
            case 2: // Medic
                accuracy = -2.0;
                baseAggressiveness = 0.1;
                strafingAbility = -0.1;
                combatStyle = -0.7;
                jumpiness = 0.5;
                break;
            case 3: // MACHINE GUNNER
                accuracy = -1000.0;
                baseAggressiveness = 0.6;
                strafingAbility = -0.1;
                combatStyle = -0.6;
                jumpiness = 0.1;
                break;
            case 4: // SNIPER
                accuracy = -2.0;
                baseAggressiveness = 0.1;
                strafingAbility = -0.3;
                combatStyle = -0.8;
                jumpiness = 0.1;
                break;
            case 5: // ANTI-ARMOR
                accuracy = -2.0;
                baseAggressiveness = 0.6;
                strafingAbility = -0.2;
                combatStyle = -0.2;
                jumpiness = 0.1;
                break;
        }
    } else
        warn("Couldn't find DAPRI for"@self);
    Super.Possess(aPawn);
}

event SeePlayer(Pawn SeenPlayer) {
    if (seenPlayer.visibility >= frand() * 10)
        super.seePlayer(seenPlayer);
}

function bool LostContact(float MaxTime)
{
	if (super.LostContact(MaxTime)) {
		if (Pawn.Weapon.IsA('da_weapons_Reloadable') )
			da_weapons_Reloadable(pawn.weapon).reload();
		return true;
	} else
		return false;
}

function PawnDied(Pawn P) {
	chooseClass();
	super.pawnDied(p);
}

function bool LoseEnemy() {
	if (super.loseEnemy()) {
		if (Pawn.Weapon.IsA('da_weapons_Reloadable') )
			da_weapons_Reloadable(pawn.weapon).reload();
		return true;
	} else
		return false;
}

function bool ShouldFireAgain(float RefireRate)
{
    local da_objective_Destroyable ObjectiveTarget;

    if (super.shouldFireAgain(reFireRate))
        return true;

    if ( da_objective_Destroyable(Target) != None )
        ObjectiveTarget = da_objective_DestroyAble(Target);
    if ( ObjectiveTarget != None && ObjectiveTarget.health > 0 && ObjectiveTarget.bActive
         && !ObjectiveTarget.bDisabled )
        return true;

    return false;
}

function float getClassBaseRating(int cNum) {
	 switch (cNum) {
        case 0:
            return 7;
        case 1:
			if (daPRI != none && daPRI.team != none && daPri.team.teamIndex == 0)
				return 7;
			else
	            return 2;
        case 2:
            return 3;
        case 3:
            return 7;
        case 4:
            return 3;
        case 5:
			if (daPRI != none && daPRI.team != none && daPRI.team.teamindex == 0)
	            return 1;
			else
				return 5;
        default:
            return 0;
    }
}

function float getSituationClassModifier(int cNum) {
//    local int enemyTurrets;
//    local da_turrets_Turret turret;

    if (daPRI == none || daPRI.team == none)
        return 1.0;
    switch (cNum) {
        case 5:
			if (daPri.team.teamIndex == 0) // defenders
				return 1.3;
			return 0.7;
//            foreach allactors(class'da_turrets_Turret', turret)
//                if (turret.team != daPRI.team.teamIndex)
//                    enemyTurrets++;
//            return 1.0 + (enemyTurrets / 10.0);
        break;
        default:
            return 1.0;
    }
}

function float getClassRatingWeight(int cNum) {
    local int cNumPlayers; // Number of other players with this class
    local int i;
    local float weight;

    weight = 0;

    if (level.GRI == none)
        return 0;

     for (i = 0; i < level.GRI.PRIArray.length; i++) {
        if (da_players_PRI(level.GRI.PRIArray[i]) != none &&
            level.GRI.PRIArray[i].team == daPRI.team &&
        da_players_PRI(level.GRI.PRIArray[i]).playerClass == cNum &&
            level.GRI.PRIArray[i] != daPRI)
            cNumPlayers++;
	 }
    weight = getClassBaseRating(cNum) / (cNumPlayers + 1);
    weight *= getSituationClassModifier(cNum);
    return weight;
}

function chooseClass() {
    local int i;
    local float w[6];
    local float rand;

    w[0] = getClassRatingWeight(0);
    for (i = 1; i < 6; i++)
        w[i] = w[i - 1] + fmax(0.0, getClassRatingWeight(i));
    if (w[5] > 0)
        for (i = 0; i < 6; i++) {
            w[i] /= w[5];
        }
    rand = frand();
    for (i = 0; i < 6 && w[i] < rand; i++);
    classNumber = i;
    daPRI.playerClass = i;
	//daPRI.playerClass = 1;
	//classNumber = 1;
}

function InitPlayerReplicationInfo() {
    super.InitPlayerReplicationInfo();
    daPRI = da_players_PRI(PlayerReplicationInfo);
    chooseClass();
}

function SetPawnClass(string inClass, string inCharacter)
{
   PawnClass= class'DA2.da_players_HumanPlayer';
}

function SetCombatTimer()
{
    SetTimer(0.8 - 0.06 * FMin(10,Skill+ReactionTime), True);
}

// A bit formula by me and alot of solving from a CAS
// My first formulas included non pointing down gravities...
// But it's most likly DA2 will only have them so I ignored it
function bool calculateGrenadeAiming(out rotator result, optional float future) {
	local float t1, t2, t, k, inner, tmp;
	local vector aim, b, c, X, Y, Z;
	getAxes(target.rotation, X, Y, Z);

	// This gives the distance throw-location to destination
	// Tries to take enemies movement into account
	c = Target.location + vsize(Target.velocity) * X * grenades.grenadeClass.default.LifeSpan - grenades.getGrenadeStart() - vect(0, 0, 1) * Target.collisionHeight - pawn.velocity * future;
	b = pawn.physicsvolume.gravity * 0.5;

	t1 = -1;
	t2 = -1;
	k = grenades.grenadeClass.default.speed;
	inner = k ** 4  + 2 * b.z * c.z * k ** 2 - b.z ** 2 * c.y ** 2 - b.z ** 2 * c.x ** 2;
	if (inner >= 0) {
		tmp = sqrt(inner) + k ** 2 + b.z * c.z;
		if (tmp > 0)
			t1 = - sqrt(2) * sqrt(tmp) / b.z;
		tmp = k ** 2 + b.z * c.z - sqrt(inner);
		if (tmp > 0)
			t2 = - sqrt(2) * sqrt(tmp) / b.z;
	}

	t = t1;
	if (t < 0 || (t2 < t && t2 > 0))
		t = t2;
	if (t > 0) {
		aim.x = c.x / t;
		aim.y = c.y / t;
		aim.z = c.z / t - 0.5 * b.z * t;
		c = aim;
		c.x *= t;
		c.y *= t;
		c.z = aim.z * t + 0.5 * b.z * t**2;
		result = rotator(aim);
	}
	return t > 0;
}

function rotator getPossibleGrenadeAiming() {
//    local vector aim;
	local rotator rot;

    if (target != none) {
		calculateGrenadeAiming(rot);
		return rot;
//        aim = Target.Location - pawn.location;
//        return rotator(aim + vect(0, 0, 0.3) * vsize(aim * vect(1, 1, 0)));
    } else
        return GetViewRotation();
}

function bool shouldThrowNade() {
  //  local vector dir, mod;
   // local int i;
	local rotator rdir;

	if (!calculateGrenadeAiming(rdir, 0.45))
		return false;

  /*  dir = vector(rdir);
    for (i = 0; i < NADETRACES; i++) {
        mod = vrand() / 10.0 + vect(1, 1, 1);
a
        if (fastTrace(grenades.getGrenadeStart() + dir * NADETRACELENGTH * mod))
            return false;
    } */
    return true;
}

function rotator adjustGrenadeAiming(projectile g) {
	local rotator r;
	r = getPossibleGrenadeAiming();

	r.pitch += (1.0 - fmax(0.99, skill / 10.0)) * (frand() * 300 - 150);
	r.yaw += (1.0 - fmax(0.99, skill / 10.0)) * (frand() * 300 - 150);
    return r;
}

function bool Dodge(eDoubleClickDir DoubleClickMove) {
    return false;
}

function bool PerformDodge(eDoubleClickDir DoubleClickMove, vector Dir, vector Cross) {
    return false;
}

event SeeMonster(Pawn Seen)
{
    if ( !Seen.bAmbientCreature )
        SeePlayer(Seen);
}

function bool WeaponFireAgain(float RefireRate, bool bFinishedFire) {
    local Pawn p;
    local float enemies;
    local float distance;


    if (target == none)
        target = enemy;

    if (target != none) {
        distance = vsize(target.location - pawn.location);

    if ((distance > grenades.grenadeClass.default.damageRadius * 1.5 || pawn.Health < 12) && grenades.couldThrowNades() &&
          pawn.LineOfSightTo(target) && shouldThrowNade()) {   //Expremintal.

		// Current rating takes into account:
		// Number of enemies + number of enemy turrets - number of friends depending on friendlyfirescale
        foreach visibleCollidingActors(class'Pawn', p, grenades.grenadeClass.default.damageRadius * 1.5, Target.Location)
            if (p.PlayerReplicationInfo != none) {
		     	if (p.PlayerReplicationInfo.Team != PlayerReplicationInfo.Team)
	                    enemies += 1;
				else
						enemies -= teamgame(level.game).friendlyFireScale;
	        }
	            //Grenade value adjustment if we are aiming at a turret.
				else if (da_turrets_Turret(p) != none && da_turrets_Turret(p).team != PlayerReplicationInfo.Team.teamIndex) {
		    	    switch (grenades.grenadeClass) {
		                  case class'da_proj_EMPGrenade':
                              enemies += 5;
                              break;
                          case class'da_proj_ThermiteGrenade':
                              enemies += 2;
                              break;
                          case class'da_proj_APMine':
                              enemies -= 3;
                              break;
                          default:
                              enemies += 1;
                              break;
                        }
                   }

            // Update: I think it's fairly good with this condition now:
            if (frand() > 0.6 + fmin(0.2, pawn.health / 5.0) + 0.19 / enemies) {
                stopFiring();
                if (grenades.canThrowNades()) {
                    grenades.throwGrenade();
                    return true;
                }
            }
        }

    }
    return super.WeaponFireAgain(refireRate, bFinishedFire);
}

function bool checkMedical() {
	local da_players_classPlayer cp, best;

	// Pretty simple I know - Dante
	if (daPri == none || pawn == none || daPri.playerClass == 2 || frand() < 1.3 * pawn.health / float(pawn.default.health))
		return false;

	foreach pawn.radiusActors(class'da_players_ClassPlayer', cp, 1500)
		if (cp.health > 0 && cp.resolveClassInfo() != none && cp.resolveClassInfo().auraHealPerSec > 0 &&
				cp.resolveClassInfo().auraHealRadius > 0 &&
				cp.playerReplicationInfo.team == daPRI.team &&
				(best == none || vsize(cp.location - pawn.location) < vsize(best.location - pawn.location)))
			best = cp;
	if (best != none) {
		movetarget = findPathToward(best);
		return moveTarget != none;
	}
	return false;
}


function bool FindInventoryGoal(float BestWeight) {
    local da_items_WorldAmmoBox ammoBox, bestBox;
    local Actor path;


	if (checkMedical())
		return true;

    if (bestweight < 0.3 && (level.timeseconds - lastAmmoBoxUse) > 30 && needWeapon()) {
        foreach RadiusActors(class'da_items_WorldAmmoBox', ammoBox, 2000)
            if (bestBox == none || (vsize(ammoBox.location - pawn.location) < vsize(bestBox.location - pawn.location) && ammoBox.isBuilt()))
                bestBox = ammoBox;
        if (bestBox != none && bestBox.canUse(self)) {
            bestBox.usedBy(pawn);
            da_weapons_Reloadable(pawn.weapon).reload();
			lastAmmoboxUse = level.timeseconds;
		} else if (bestBox != none)
            path = FindPathToward(bestBox);
        if (path != none) {
            moveTarget = path;
            return true;
        }
    }
    if (enemy == none && target == none && (level.timeseconds - lastAmmoBoxUse) > 60 && !da_weapons_reloadable(pawn.weapon).HasAmmo() &&
        grenades.grenadeAmount == 0)
        Pawn.suicide(); // To allow bots to be of further use when no ammo left
    return super.findInventoryGoal(bestWeight);
}

function WanderOrCamp(bool bMayCrouch) {
	if (da_AI_SquadAI(squad).checkMechObjectives(self))
		return;
	super.wanderOrCamp(bMayCrouch);
}

function DoRepairObject() {
	gotoState('RepairingObject');
}

function DoConstructObject() {
	gotoState('ConstructObject');
}

state ConstructObject {
	function DoConstrutctObject();

	function executeConstructObject() {
		local Actor obj;
		obj = da_players_ClassPlayer(pawn).build(buildBeacon.getBuildName());
		// If we couldn't create the turret, there might either be some "mobile" object in it's way,
		// or it's not possible to build there
		lastBuilt = obj;
		if (obj == none)
			buildBeacon.suggestBuild /= 2.0;
		buildBeacon = none;
	}
Begin:
	moveToward(moveTarget);
	if (buildBeacon != none) {
		focus=none;
		focalPoint = Pawn.Location + 100 * vector(buildBeacon.rotation);
		finishRotation();
		if (buildBeacon != none)
			executeConstructObject();
		else
			warn(self@"lost his build target (1)!");
	} else
		warn(self@"lost his build target (2)");
//	log(buildBeacon.rotation@pawn.rotation);
	whatToDoNext(17);
}

state RepairingObject {
	function NotifyTakeHit(pawn InstigatedBy, vector HitLocation, int Damage, class<DamageType> damageType, vector Momentum) {
		local float reaction;

		// Reaction range:
		// low values : Low health and/or close enemy
		// high values : High health and/or far away enemy
		reaction = (pawn.health / float(pawn.default.health)) * vsize(pawn.location - instigatedBy.location) / 600.0;

		// Stop repairing if threat is too high or object not important
        if ( frand() > reaction || da_turrets_Turret(repairActor) == none) {
            if ( InstigatedBy == Enemy )
                AcquireTime = Level.TimeSeconds;
        	Super.NotifyTakeHit(InstigatedBy,HitLocation, Damage,DamageType,Momentum);
        }
    }

 	function SetFocus() {
		focus = repairActor;
	}

	function changedWeapon() {
		super.changedWeapon();
		if (!needsRepair()) {
			WhatToDoNext(7);
			return;
		}
		if (da_weapons_MechTool(pawn.weapon) != none) {
			focus = repairActor;
			target = repairActor;
		} else if (!isOutofRange()) {
			stopFiring();
		    da_players_ClassPlayer(pawn).mechTool.oldWeapon = pawn.weapon;
			Pawn.pendingWeapon = da_players_ClassPlayer(pawn).mechTool;
			pawn.weapon.putDown();
		} else
			WhatToDoNext(7);
	}

	function Timer() {
		setCombatTimer();
		if (da_weapons_mechtool(pawn.weapon) == none || !needsRepair())
			changedWeapon();
	}

	function bool needsRepair() {
		local da_buildable_Useable repairItem;
		local da_turrets_Turret repairTurret;
		repairItem = da_buildable_Useable(repairActor);
		repairTurret = da_turrets_Turret(repairActor);

		return (repairItem != none && (repairItem.health < repairItem.default.health || !repairItem.isBuilt()) ||
			repairTurret != none && (repairTurret.health < repairTurret.default.health || !repairTurret.isBuilt()));
	}

	function bool WeaponFireAgain(float RefireRate, bool bFinishedFire)	{
		if (da_weapons_MechTool(pawn.weapon) == none)
			changedWeapon();
		return false;
	}

	function bool isOutOfRange() {
		local Actor a;
		local vector hitL, hitN, hitS;
		local da_weapons_MechTool mt;

		target = repairActor;
		mt = da_weapons_MechTool(da_players_classPlayer(pawn).mechTool);

		hitS = pawn.location + pawn.eyeheight * vect(0, 0, 1);
		a = trace(hitL, hitN, hitS + normal(target.location - hitS) * mt.range, hitS, true);
//		log("traced:"@a@vsize(repairActor.location - (pawn.location + pawn.eyeheight * vect(0, 0, 1))));
		return (a != repairActor);
	}

	function endState() {
		repairActor = none;
	}

	event bool NotifyBump(actor other) {
		if (other == repairActor) {
			pawn.acceleration = vect(0, 0, 0);
			pawn.velocity = vect(0, 0, 0);
		}
		return true;
	}

	event beginState() {
		setCombatTimer();
	}

	 function EnemyChanged(bool bNewEnemyVisible) {
	 }

Begin:
	pawn.bWantsToCrouch = false;
	stopFiring();
	target = repairActor;
	focus = repairActor;
	moveToward(moveTarget, target);

	changedWeapon();
}

defaultproperties
{
     Accuracy=-2.000000
     ReactionTime=-2.000000
     Jumpiness=0.200000
     bAdrenalineEnabled=False
     PlayerReplicationInfoClass=Class'DA2.da_players_PRI'
     PawnClass=Class'DA2.da_players_HumanPlayer'
}
