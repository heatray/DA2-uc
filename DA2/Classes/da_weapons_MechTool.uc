//-----------------------------------------------------------
//
//-----------------------------------------------------------
class da_weapons_MechTool extends Weapon;

var float   range;
var int     repairPerSec;
var float   buildPerSec;
var float   deconstPerSec;

var float   counter;
var Actor 	lastStructure;

replication {
    reliable if (ROLE == ROLE_Authority)
        clientSwitchToLastWeapon;
}

/* OutOfAmmo
 * This "weapon" has no ammo
 */
simulated function OutOfAmmo();

simulated function bool PutDown()
{
    local int Mode;

    if (ClientState == WS_BringUp || ClientState == WS_ReadyToFire)
    {
        if ( (Instigator.PendingWeapon != None) && !Instigator.PendingWeapon.bForceSwitch )
        {
            for (Mode = 0; Mode < NUM_FIRE_MODES; Mode++)
            {
                if ( FireMode[Mode].bFireOnRelease && FireMode[Mode].bIsFiring )
                    return false;
                if ( FireMode[Mode].NextFireTime > Level.TimeSeconds + FireMode[Mode].FireRate*(1.f - MinReloadPct))
                    DownDelay = FMax(DownDelay, FireMode[Mode].NextFireTime - Level.TimeSeconds - FireMode[Mode].FireRate*(1.f - MinReloadPct));
            }
        }

        if (Instigator.IsLocallyControlled())
        {
            for (Mode = 0; Mode < NUM_FIRE_MODES; Mode++)
            {
                if ( FireMode[Mode].bIsFiring )
                    ClientStopFire(Mode);
            }
        }
        ClientState = WS_PutDown;
        if ( Level.GRI.bFastWeaponSwitching )
            DownDelay = 0;
        if ( DownDelay > 0 )
            SetTimer(DownDelay, false);
        else
            SetTimer(PutDownTime, false);
    }
    for (Mode = 0; Mode < NUM_FIRE_MODES; Mode++)
    {
        FireMode[Mode].bServerDelayStartFire = false;
        FireMode[Mode].bServerDelayStopFire = false;
    }
    Instigator.AmbientSound = None;
    OldWeapon = None;
    return true; // return false if preventing weapon switch
}


simulated event RenderOverlays( Canvas Canvas ) {
	local float completed;
	local da_buildable_Useable bu;
	local da_turrets_Turret t;
	local float w, h;
	local bool bDeconst;
	local material barImg;

	super.renderOverlays(canvas);
	if (lastStructure != none) {
		bDeconst = da_players_playerController(Instigator.controller).bDeconstruct != 0;
//		canvas.setDrawColor(128, 128, 128);
		barImg = Material'DA2GUI.Dialog.raised_blurry_blue';
		w = canvas.clipX / 2;
		h = canvas.clipY / 30;
//		class'da_Utilities'.static.fillRect(canvas, (canvas.clipX - w) / 2 - 2, (canvas.clipY - h) / 2 - 2, w + 4, h + 4);

		canvas.Style = ERenderStyle.STY_Alpha;

		canvas.setDrawColor(255, 255, 255);
		canvas.SetPos((canvas.clipX - w) / 2 - 2, (canvas.clipY - h) / 2 - 2);
		canvas.DrawTileStretched(Material'DA2GUI.Dialog.lowered_blurry', w + 4, h + 4);

		bu = da_buildable_Useable(lastStructure);
		if ( bu != none) {
			if (bu.health < bu.default.health && !bDeconst) {
				//canvas.setDrawColor(200, 0, 0);
				barImg = Material'DA2GUI.Dialog.raised_blurry_red';
				completed = bu.getHealthPercentage();
			} else {
				//canvas.setDrawColor(0, 0, 200);
				completed = bu.getCompletedPercentage();
			}
		}
		t = da_turrets_Turret(lastStructure);
		if ( t != none) {
			if (t.health < t.default.health && !bDeconst) {
				//canvas.setDrawColor(200, 0, 0);
				barImg = Material'DA2GUI.Dialog.raised_blurry_red';
				completed = t.getHealthPercentage();
			} else {
				//canvas.setDrawColor(0, 0, 200);
				completed = t.getCompletedPercentage();
			}
		}

		canvas.SetPos((canvas.clipX - w) / 2, (canvas.clipY - h) / 2);
		canvas.DrawTileStretched(barImg, w * completed, h);

//		class'da_Utilities'.static.fillRect(canvas, (canvas.clipX - w) / 2, (canvas.clipY - h) / 2, w * completed, h);


	}
}

simulated function Weapon WeaponChange( byte F, bool bSilent ) {
    return super(Inventory).weaponChange(f, bsilent);
}

simulated function Weapon NextWeapon(Weapon CurrentChoice, Weapon CurrentWeapon) {
    return super(Inventory).nextWeapon(currentChoice, CurrentWeapon);
}

simulated function Weapon PrevWeapon(Weapon CurrentChoice, Weapon CurrentWeapon) {
    return super(Inventory).prevWeapon(currentChoice, CurrentWeapon);
}

simulated function clientSwitchToLastWeapon() {
    if (ClientState == WS_PutDown)
        return;


    if ( oldWeapon != none ) {
        instigator.PendingWeapon = oldWeapon;
        PutDown();
    } else
        instigator.controller.SwitchToBestWeapon();
}

simulated event WeaponTick(float dt) {
    local actor traced;
    local da_buildable_Useable b;
	local da_turrets_Turret t;
    local vector hitLocation, hitNormal, traceStart;
	local bool bDeconst, bIsBot;


    if (Bot(Instigator.controller) == none && da_players_PlayerController(Instigator.controller) != none &&
        da_players_playerController(Instigator.controller).bBuild == 0 &&
		da_players_playerController(Instigator.controller).bDeconstruct == 0) {
            clientSwitchToLastWeapon();
    } else {
		bIsBot = bot(instigator.controller) != none;
		if (!bIsBot)
			bDeconst = da_players_playerController(Instigator.controller).bDeconstruct != 0;
//		log(self@da_players_playerController(Instigator.controller).bDeconstruct@da_players_playerController(Instigator.controller).bBuild);
        traceStart = Instigator.Location + Instigator.EyeHeight * vect(0, 0, 1);
        traced = trace(hitLocation, hitNormal, traceStart + vector(firemode[0].adjustAim(traceStart, 0)) * range, traceStart, true);
        if (da_buildable_Useable(traced) != none) {
            b = da_buildable_Useable(traced);
//		   if (pawn(b.owner).playerReplicationInfo.team != instigator.playerReplicationInfo.team)
//			   return;
			lastStructure = b;
			if (bDeconst) {
				b.deconstruct(deconstPerSec * dt);
				counter = 0;
			} else if (b.health < b.default.health) {
                if (counter >= 0.2) {
                    b.repair(repairPerSec * 0.2, instigator.PlayerReplicationInfo);
                    counter = 0;
                }
            } else if (!b.isBuilt()) {
                b.build(buildPerSec * dt, instigator.PlayerReplicationInfo);
                counter = 0;
            } else {
                clientSwitchToLastWeapon();
			}
            counter += dt;
        } else if (da_turrets_Turret(traced) != none) {
           t = da_turrets_Turret(traced);
		   if (t.team != instigator.playerReplicationInfo.team.teamIndex)
			   return;
			lastStructure = t;
			if (bDeconst) {
				t.deconstruct(deconstPerSec * dt);
				counter = 0;
			} else if (t.health < t.default.health) {
                if (counter >= 0.2) {
                    t.repair(repairPerSec * 0.2, instigator.PlayerReplicationInfo);
                    counter = 0;
                }
            } else if (!t.isBuilt()) {
                t.build(buildPerSec * dt, instigator.PlayerReplicationInfo);
                counter = 0;
            } else if (t.isBuilt())
                clientSwitchToLastWeapon();
			counter += dt;
		} else
            clientSwitchToLastWeapon();
    }
}

/*
static function bool CanAddAmmo(da_turrets_Turret t) {
	return t.weapon.ammoStatus() < 1.0;
}

function serverAddAmmo(da_turrets_Turret t, int amount) {
	t.weapon.addAmmo(amount, 0);
}

simulated function bool TaddAmmo(da_turrets_Turret t, float ammo) {
	local int add;

	if (t.weapon.ammoStatus() >= 1.0) {
		ammoCounter = 0;
		return false;
	}

	ammoCounter += ammo;
	add = int(ammoCounter);
	if (add > 0) {
		serverAddAmmo(t, add);
		ammoCounter -= add;
	}
	return true;
}
*/

defaultproperties
{
     Range=175.000000
     repairPerSec=40
     buildPerSec=0.750000
     deconstPerSec=2.000000
     FireModeClass(0)=Class'DA2.da_weapons_NullFire'
     FireModeClass(1)=Class'DA2.da_weapons_NullFire'
     AIRating=-100.000000
     AttachmentClass=Class'DA2.da_weapons_MechToolAttachment'
}
