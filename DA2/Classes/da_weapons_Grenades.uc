//-----------------------------------------------------------
//
//-----------------------------------------------------------
class da_weapons_Grenades extends Inventory;

var class<projectile> grenadeClass;
var sound throwSound;
var int grenadeAmount;
var float grenadeThrowDelay, lastGrenadeThrowTime;
var float grenadeAimError;
var vector adjustThrowAiming;

replication {
    reliable if (ROLE == ROLE_Authority)
        grenadeAmount, throwGrenade;
    reliable if (ROLE < ROLE_Authority)
        serverThrowGrenade;
}

// Check if owner could throw if he was ready
simulated function bool couldThrowNades() {
    return (grenadeAmount > 0) &&
            (Level.TimeSeconds >= lastGrenadeThrowTime + grenadeThrowDelay);
}


simulated function bool canThrowNades() {
    local da_ConstrainedVolume v;
    if (instigator.controller.IsA('Bot')) {
        foreach Instigator.TouchingActors(class'da_ConstrainedVolume', v)
            if (v.bNoGrenades)
                return false;
    }
	return couldThrowNades() && da_weapons_reloadable(Instigator.weapon) != none &&
            da_weapons_reloadable(Instigator.weapon).isWeaponReady();
}

simulated function throwGrenade() {
    if (!canThrowNades())
        return;
    if (ROLE < ROLE_Authority)
        lastGrenadeThrowTime = level.TimeSeconds;
	da_weapons_Reloadable(instigator.weapon).bGrenadeHack = true;
    serverThrowGrenade();
    clientPlayThrowing();
    gotoState('throwing');
}

simulated function clientPlayThrowing() {
    local da_weapons_reloadable w;
    w = da_weapons_reloadable(Instigator.weapon);
    w.PlayAnim(w.ThrowAnimGrenade, 1, 0.1); //1st person
}

function playThrowing() {
    da_players_classPlayer(owner).PlayerThrowNade();
}

function serverThrowGrenade() {
    if (!canThrowNades())
        return;
    lastGrenadeThrowTime = level.TimeSeconds;
    playThrowing();
    gotoState('throwing');
}

function vector getGrenadeStart() {
    local pawn pOwner;
    local Controller cOwner;

    pOwner = Pawn(Owner);
    if (pOwner == none)
        return vect(0, 0, 0);

    cOwner = pOwner.Controller;
    if (cOwner == none)
         return vect(0, 0, 0);

    return owner.Location +
		vector(cOwner.GetViewRotation()) * (pOwner.CollisionRadius) +	// forward by colRadius
		vect(0,0,1) * (pOwner.CollisionHeight / 2 + pOwner.EyeHeight) +	// top of the col Cylinder
		Normal(normal(vector(cOwner.GetViewRotation())) cross vect(0, 0, 1)) * pOwner.CollisionRadius; // left by colRadius

}

function spawnGrenade() {
    local vector spawnLocation;
    local projectile g;
    local pawn pOwner;
    local Controller cOwner;

    pOwner = Pawn(Owner);
    if (pOwner == none)
        return;

    cOwner = pOwner.Controller;
    if (cOwner == none)
        return;

    // This calculation is ugly... who wrote this ?
   	spawnLocation = getGrenadeStart();

    g = Spawn(grenadeClass, Instigator,, spawnLocation, Rotation);
    GrenadeAmount--; //You just lost one grenade buddy like it or not. :)

    if (da_players_PlayerController(cOwner) != none && GrenadeAmount == 0)
        da_players_PlayerController(cOwner).AMIAnnouncement(sound'AMISounds.Player.GrenadesDepleted');

    if (g != None)
    {
//		g.InstigatorController = self;
//        g.Speed = grenadeSpeed;

        if (da_players_PlayerController(cOwner) != none)
        {
            g.velocity = vector(da_players_PlayerController(cOwner).adjustGrenadeAiming(g)) * g.Speed + adjustThrowAiming;
            //da_players_PlayerController(cOwner).EndZoom();
        }
        else
            g.velocity = vector(da_ai_HumanBot(cOwner).adjustGrenadeAiming(g)) * g.Speed;

        g.velocity += VRand() * grenadeAimError;
    }
}

simulated state throwing {
    simulated function endState() {
    	if (instigator == none || instigator.weapon == none)
    		return;
		
    }
Begin:
    sleep(0.45);    // Hack burrowed ;)
    if (throwSound != none) {
       instigator.playOwnedSound(throwSound,, 1.5);
    }
    if (pawn(owner).health > 0)
        spawnGrenade();
    sleep(1.15);
    gotoState('donethrowing');
}

simulated state donethrowing{

Begin:
	sleep(0.10);
	da_weapons_Reloadable(instigator.weapon).bGrenadeHack = false;
	gotoState('');
}

defaultproperties
{
     GrenadeClass=Class'DA2.da_weapons_HumanGrenade'
     ThrowSound=Sound'DA2_WeaponSounds.Misc.Human_GrenadeThrow'
     grenadeThrowDelay=2.200000
     grenadeAimError=40.000000
     adjustThrowAiming=(Z=75.000000)
     bReplicateInstigator=True
}
