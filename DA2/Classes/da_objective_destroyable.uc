// ============================================================================
//	DA2.da_objective_destroyable: destroyable objective
//	By: Dante
//  This is a destroyable static mesh that can have heatlh. It will spawn an
//  explosion (Emitter->ExplosionTYpe) once Health is <= 0.
// ============================================================================
class da_objective_destroyable extends da_objective_base;

#EXEC OBJ LOAD FILE=DA2_WeaponSounds.uax
#EXEC OBJ LOAD FILE=DAIndustrySM.usx

var(Destroyable) int   Health; //Health of this objective
var(Destroyable) int   damageThresHold; //Damage threshold (Armor)
var(Destroyable) int   damageEventPause; //Events
var(Destroyable) Sound AlarmSound; //Sound that plays when this objective is under attack
var(Destroyable) name  TakeDamageEvent; //For events
var(Destroyable) StaticMesh DestroyedStaticMesh; //Mesh to use after this objective is destroyed
var(Destroyable) class<Emitter> ExplosionType; //Exposion effect once destroyed
var(Destroyable) float explosionRadius; //Radious of explosion
var(Destroyable) float alarmRadius; //Used for bots to come back and defend if they close.
var(Destroyable) int   explosionDamage; //Damage of explosion
var(Destroyable) class<DamageType> explosionDamageType; //Damage type

//1.1
var(Destroyable) vector AIShootOffset; //Just like in UT. Help bots aim better.


var float lastWarnTime;
var int MaxHealth;
var ShootTarget ShootTarget;

// NOTE: Whoever did do this:
// 	reliable if(role == Role_AUTHORITY)
//		doEffects;
// A short lection in replication: methods are NEVER replicated to more than one client
// and that would be the owner. Also if you want the replication to work for that client,
// and you're not in a class which is ROLE_Autonomous, you need to make that method
// simulated.

replication {
	reliable if(role == Role_AUTHORITY)
		Health;
}

// ============================================================================
function PostBeginPlay()
{
	MaxHealth=Health;
    Super.PostBeginPlay();
    if (AIShootOffset != vect(0,0,0))
	{
		ShootTarget = spawn(class'ShootTarget', self,, Location + AIShootOffset);
		ShootTarget.SetBase(self);
	}
	Reset();
}

// ============================================================================
function bool TellBotHowToDisable(Bot B)
{
	if ( B.CanAttack(GetShootTarget()) )
	{
      if (da_AI_HumanBot(B) != none )
      {
         if (da_AI_HumanBot(B).classNumber == 4)
         {
          B.SetOrders('Freelance', B); //Do not allow snipers shoot at objectives, its useless -aBs
          return false;
         }
         if (da_AI_HumanBot(B).classNumber == 5) //Close distance promote plasma
         {
              if (da_AI_HumanBot(B).shouldThrowNade() &&
              da_AI_HumanBot(B).grenades.canThrowNades())
              {
                  B.StopFiring();
                  da_AI_HumanBot(B).grenades.throwGrenade();
              }
         }
      }
      //If they are not sniper give a slight random chance to the
      // bot to kill the enemy if it has any.
	  if (KillEnemyFirst(B))
	     return false;

        B.GoalString = "Attack Objective";
		B.DoRangedAttackOn(self);
		return true;
	}
	return Super.TellBotHowToDisable(B);
}

function bool KillEnemyFirst(Bot B)
{
 return B.Enemy != none && B.LineOfSightTo(B.Enemy);
}

function Actor GetShootTarget()
{
	if (ShootTarget != None)
		return ShootTarget;

	return self;
}

/* Reset()
reset actor to initial state - used when restarting level without reloading.
*/
// ============================================================================
function Reset()
{
	Health = MaxHealth;
    Score=default.Score;
	damageEventPause = 0;
	SetStaticMesh(self.StaticMesh);
	bHidden=false;
	SetCollision(default.bCollideActors, default.bBlockActors, default.bBlockPlayers);
	Super.Reset();
}

function explode(vector hitLocation, vector momentum) {
    doEffects(hitLocation, momentum);
    AmbientSound = none;
  	if (DestroyedStaticMesh == none)
       SetCollision(false, false, false);
}

function PlayAlarm()
{
	 makeNoise(1.0);
     SetTimer(10, false);
     AmbientSound = AlarmSound;
}

function Timer()
{
      AmbientSound = none;
      super.Timer();
}

simulated function array<string> getInfo() {
    local array<string> info;
    info[0] = ObjectiveName;
    info[1] = "Health:"@health;

    return info;
}

function DisableObjective(Pawn Instigator)
{
    Score=0; //Score is not awarded absolute for destruction -Levi
    super.DisableObjective(Instigator);
}

// ============================================================================
function TakeDamage( int Damage, Pawn instigatedBy, Vector hitlocation,
						Vector momentum, class<DamageType> damageType, optional int HitIndex)
{
	local pawn iHack;

	if ( bDisabled || !bActive || (Damage <= 0) )
		return;

    //AN fix -aBs
	if (InstigatedBy == none || InstigatedBy.PlayerReplicationInfo == none || InstigatedBy.PlayerReplicationInfo.Team == none)
	   return;

    //No FF to avoid messing with gameplay.
	if (DefenderTeamIndex == InstigatedBy.PlayerReplicationInfo.Team.TeamIndex)
		return;

    if (DamageType!=None)
       damage*=damagetype.default.vehicledamagescaling;

	Damage -= damageThresHold;
	if (damage <= 0)   // Did armor prevent damage ?
	   return;

    if (level.timeSeconds > damageEventPause) {
        TriggerEvent(TakeDamageEvent,self, InstigatedBy);
        damageEventPause = level.timeSeconds + default.damageEventPause;
    }


    //Award score relative to damage -Levi
    Level.Game.ScoreObjective(InstigatedBy.PlayerReplicationInfo, Score*fmin(health,damage)/MaxHealth);

	iHack = instigator;
	instigator = instigatedBy;
    PlayAlarm();
	instigator = iHack;
    Health -= Damage;

	if ((DefenseSquad != None) && (instigatedBy.Controller != None) && (Level.TimeSeconds - LastWarnTime > 0.5) ) {
        LastWarnTime = Level.TimeSeconds;
        DefenseSquad.Team.AI.CriticalObjectiveWarning(self, InstigatedBy);
    }

	//log(self@"took"@damage@"damage with"@health@"health");
	if (InstigatedBy != none && Health <= 0) {
	    explode(hitLocation, momentum);
        DisableObjective(instigatedBy);
    }
}

// ============================================================================
function doEffects(vector HitLoc, vector momentum)
{
    Spawn(ExplosionType,,,HitLoc).remoteRole = ROLE_SimulatedProxy;

	if (DestroyedStaticMesh != none)
	{
     SetStaticMesh(DestroyedStaticMesh);
    }
    else
    {
     bHidden=true;
    }

    hurtRadius(explosionDamage, explosionRadius, explosionDamageType, vsize(momentum), hitLoc);
}

simulated function Destroyed()
{
    super.Destroyed();

	if (ShootTarget != None)
	{
		ShootTarget.Destroy();
		ShootTarget=none;
	}
}

// ============================================================================

defaultproperties
{
     Health=100
     AlarmSound=Sound'DA2_WeaponSounds.alarm1'
     ExplosionType=Class'DA2.da_effects_ExplosionBigFire'
     alarmRadius=6000.000000
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'DA2_StaticMeshes2.switches.Switch'
     bStatic=False
     bHidden=False
     RemoteRole=ROLE_SimulatedProxy
     bCollideActors=True
     bBlockActors=True
     bProjTarget=True
}
