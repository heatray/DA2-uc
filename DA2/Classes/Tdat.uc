//=============================================================================
// Tdat.
//=============================================================================
class Tdat extends da_turrets_TurretController;


function bool IsTargetRelevant( Pawn Target ) {
	local float minYaw, maxYaw;

	if (ASTurret(pawn).turretbase != none) {
		minYaw = scanRange.Min + ASTurret(pawn).TurretBase.rotation.yaw;
		maxYaw = scanRange.Max + ASTurret(pawn).TurretBase.rotation.yaw;
	}

	return super.isTargetRelevant(target) &&
	(minYaw > maxYaw ^^ (pawn.rotation.yaw >= min(minYaw, maxYaw) &&
				pawn.rotation.yaw <= max(minYaw, maxYaw)));

}
 
//   
auto state Searching {


      event SeePlayer (Pawn SeenPlayer)
    {
        if ( IsTargetRelevant( SeenPlayer ) )
		{
			Enemy = SeenPlayer;
			GotoState('Engaged');
        }


    }

    function tick(float delta)
    {
        local monster m;


     foreach visibleactors(class'monster', m, 40000,pawn.location)
      {
            if(m.isa('kfmonster'))seeplayer(m);
           
      }  


    }
event SeeMonster(Pawn Seen)
{
    if ( !Seen.bAmbientCreature )
        SeePlayer(Seen);

     
}

    function ScanRotation() {
        local float minYaw, maxYaw;
		if (pawn == none) {
			destroy();
			return;
		}
        if (!pawn.isa('da_turrets_Turret'))
            return;

    	if (ASTurret(pawn).turretbase != none) {
	        minYaw = scanRange.Min + ASTurret(pawn).TurretBase.rotation.yaw;
    	    maxYaw = scanRange.Max + ASTurret(pawn).TurretBase.rotation.yaw;
		}
        if (bScanMax)
            desiredRotation.yaw = minYaw;
        else
            desiredRotation.yaw = maxYaw;
        bScanMax = !bScanMax;


    }

    function beginState() {
        rotationRate.yaw = 5000;
//        desiredRotation = rotation;
        super.beginState();

    }

    function endState() {
        RotationRate = default.RotationRate;
        super.endState();
    }
}

state Engaged {
	function BeginState() {
	   if ((target.isa('da_proj_Rocket') && Enemy != none) ||  enemy.isa('monster'))
	   {
   		Focus = Enemy.GetAimTarget();
        Target = Enemy;
       }
	}

	function bool checkFire() {
		if (target.isa('da_Turrets_Turret') || target.isa('da_proj_Rocket') || isTargetRelevant(enemy) ) {
			bFire = 1;
			if (pawn.weapon != none)
				pawn.weapon.botFire(false);
			return true;
		}
		return false;
	}

     

Begin:
	finishRotation();
loop:
	if (!checkFire())
		gotoState('Searching');
	sleep(1);
	goto('loop');

}

defaultproperties
{
}
