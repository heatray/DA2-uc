class da_buildable_Useable extends Actor placeable;

var()   float	  maxUseDistance; //How far can player be to use this item
var()   string  itemName;    //This items name
var()   sound   useSound; //Sound to play once used
var()   int     health;
var()   bool    bStartBuilt;
var     float   buildTime;      // Total time required to build this
var     float   currentBuild;   // Current build progress time
var     bool    bBuilt, bBuilding, bRepairing, bDeconstructing;
var 	int 	buildCount, repairCount;
var		int 	RepairTeam;	// NOT neccessarily the team that owns it, but the team that prefers repairing it
var 	float 	importance;
var		class<Emitter>		buildFX;
var		class<Emitter>		repairFX;

var     float   Reward; //Score for building/destroying

replication {
    reliable if (ROLE == ROLE_Authority)
        currentBuild, bBuilt, health, bStartBuilt,
		bBuilding, bRepairing, bDeconstructing;
}

simulated function bool isBuilt() {
    return bBuilt || bStartBuilt;
}


simulated function bool isDeconstructed() {
	return !bBuilt && currentBuild < 0.0001;
}

event TakeDamage(int Damage, Pawn EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional int HitIndex) {
    // Will drop out if already dead
    if (health < 0)
        return;

    if (DamageType!=None)
       damage*=damagetype.default.vehicledamagescaling;

    health -= damage;

    if(health<=0 && isBuilt()) {
        instigator=eventinstigator;
        explode(hitLocation, momentum);
    }
	else if (health <= 0)
		destroy();
}

function explode(vector hitLocation, vector momentum);

/** Returns if the Controller c can use this object.
*/
function bool canUse(Controller c) {
	if (c == none || c.pawn == none || ROLE < ROLE_Authority)
		return false;

	// That the player sees us is ensured in our custom controllerclass!
	return (vsize(location - c.pawn.location) < maxUseDistance) && isBuilt();
}

function UsedBy( Pawn user ) {
	if (!canUse(user.controller))
		return;
}

simulated function timer() {
	if (bDeconstructing && !isInState('Building'))
		gotoState('Building');
	if (bBuilding) {
		buildCount = min(buildCount + 1, 100);
		if (buildCount > 10 && ROLE == ROLE_Authority) {
			bBuilding = false;
			bDeconstructing = false;
			buildCount = 0;
		} else
			updateBuildProgress();
	} else
		buildCount = 0;
	if (bRepairing) {
		repairCount = min(repairCount + 1, 100);
		if (repairCount > 10 && ROLE == ROLE_Authority) {
			bRepairing = false;
			repairCount = 0;
		} else
			updateRepairProgress();
	} else
		repairCount = 0;
}

simulated function postBeginPlay() {
	super.postBeginPlay();
	setTimer(0.1, true);
}

auto state Building {
    /** While building it's not possible to use it
    */
    function bool canUse(Controller c) {
        return false;
    }

	simulated function timer() {
		global.timer();
		if (isBuilt())
			gotoState('');
	}

    simulated event beginState() {
        if (bStartBuilt && !bDeconstructing) {
            currentBuild = buildTime;
            gotoState('');
            return;
        }
        buildingStarted();
    }

    simulated event endState() {
        bBuilt = true;
        if (bStartBuilt) {
			bStartBuilt = false;
            return;
		}
        buildingEnded();
    }

    /** One can only continue to build if it's not damaged
    */
    simulated function build(float amount, playerreplicationinfo PRI) {
        if (health < default.health)
            return;

        if(PRI!=none)
            PRI.Score+=(fmin(amount, buildtime-currentbuild)/buildtime)*reward/2;

        currentBuild = FMin(currentBuild + amount, buildTime);
		bBuilding = true;
		bDeconstructing = false;
		buildCount = 0;
        if (currentBuild >= buildTime && ROLE == ROLE_Authority)
            gotoState('');
    }

	simulated function deconstruct(float amount) {
		currentBuild = FMax(currentBuild - amount, 0);
		bBuilt = false;
		bBuilding = true;
		bDeconstructing = true;
		buildCount = 0;
        if (ROLE == ROLE_Authority && isDeconstructed())
            destroy();
	}
}

simulated function deconstruct(float amount) {
	currentBuild = FMax(currentBuild - amount, 0);
	bBuilt = false;
	bBuilding = true;
	bDeconstructing = true;
	if (ROLE == ROLE_Authority && isDeconstructed())
		destroy();
}

simulated function float getCompletedPercentage() {
    return currentBuild / buildTime;
}

simulated function float getHealthPercentage() {
	return float(health) / default.health;
}

simulated function build(float amount, playerreplicationinfo PRI);

simulated function repair(int amount, PlayerReplicationInfo PRI) {
	if (health < default.health) {
	    if(PRI!=none)
            PRI.Score+=(fmin(amount, default.health-health)/default.health)*reward/2;

		if (ROLE == ROLE_Authority)
			health = min(health + amount, default.health);
		bRepairing = true;
	}
}

simulated function buildingStarted() {
    local int i;
    local OpacityModifier mod;
	local FinalBlend fb;

    for (i = 0; i < skins.length; i++)
        if (skins[i].isa('Shader')) {
			fb = new class'FinalBlend';
			fb.zWrite = true;
			fb.FrameBufferBlending=FB_AlphaBlend;
            mod = new class'OpacityModifier';
            mod.material = skins[i];
            mod.opacity = new class'ConstantColor';
			fb.material = mod;
            ConstantColor(mod.opacity).color.a = currentBuild * 200 / buildTime + 20;
            skins[i] = fb;
        } else
            warn("Cannot change skin opacity of"@self@"reason: It's not a shader!");
}

simulated function buildingEnded() {
    local int i;
    for (i = 0; i < skins.length; i++)
        if (skins[i].isa('FinalBlend') && FinalBlend(skins[i]).material.isa('OpacityModifier')) {
//            OpacityModifier(FinalBlend(skins[i]).material).opacity = none;
			skins[i] = default.skins[i];
//            skins[i] = OpacityModifier(skins[i]).material;
        }
}

simulated function randomPlace(out vector loc, out rotator rot) {
	loc = location + collisionradius * vrand() * vect(1, 1, 0) + collisionHeight * vect(0, 0, 1) * frand();
	rot = rotator(loc - location);
}

simulated function playWorkSound() {
	if (frand() < 0.333)
		playSound(sound'DA2_Various.Bzzzt1', SLOT_Interact, 1);
	else if (frand() < 0.5)
		playSound(sound'DA2_Various.Bzzzt2', SLOT_Interact, 1);
	else
		playSound(sound'DA2_Various.Bzzzt3', SLOT_Interact, 1);
}

simulated function updateRepairProgress() {
	local vector loc;
	local rotator rot;
	if (frand() < 0.4) {
		randomPlace(loc, rot);
		spawn(repairFX,,,loc, rot);
	}
	if (frand() < 0.2)
		playWorkSound();
}

simulated function updateBuildProgress() {
    local int i;
	local vector loc;
	local rotator rot;

	if (frand() < 0.4) {
		randomPlace(loc, rot);
		spawn(buildFX,,,loc, rot);
	}
	if (frand() < 0.2)
		playWorkSound();
    for (i = 0; i < skins.length; i++)
        if (skins[i].isa('FinalBlend') && FinalBlend(skins[i]).material.isa('OpacityModifier'))
            ConstantColor(OpacityModifier(FinalBlend(skins[i]).material).opacity).color.a = currentBuild * 200 / buildTime + 20;
}

simulated function array<string> getInfoForMech() {
    local array<string> info;
    info[0] = itemName;

    info[1]="Health:"@health$"/"$default.health;
    if (!isBuilt())
        info[2]="Build Progress:"@int(currentBuild*100.0/buildTime)$"%";

    return info;
}

defaultproperties
{
     maxUseDistance=120.000000
     Health=100
     buildTime=5.000000
     BuildFX=Class'DA2.da_effects_BuildSparks'
     RepairFX=Class'DA2.da_effects_RepairSparks'
     Reward=1.000000
     Physics=PHYS_Falling
     RemoteRole=ROLE_SimulatedProxy
}
