//=============================================================================
// KFMZombieBoss.
//=============================================================================
class KFMZombieBoss extends ZombieBoss
	placeable;

simulated function PostBeginPlay()
{
    super.PostBeginPlay();

    if( Role < ROLE_Authority )
    {
        return;
    }

	// Difficulty Scaling
	if (Level.Game != none)
	{
        //log(self$" Beginning ground speed "$default.GroundSpeed);

        // If you are playing by yourself,  reduce the MG damage
        if( Level.Game.NumPlayers == 1 )
        {
            if( Level.Game.GameDifficulty < 2.0 )
            {
                MGDamage = default.MGDamage * 0.375;
            }
            else if( Level.Game.GameDifficulty < 4.0 )
            {
                MGDamage = default.MGDamage * 0.75;
            }
            else if( Level.Game.GameDifficulty < 5.0 )
            {
                MGDamage = default.MGDamage * 1.15;
            }
            else // Hardest difficulty
            {
                MGDamage = default.MGDamage * 1.3;
            }
        }
        else
        {
            if( Level.Game.GameDifficulty < 2.0 )
            {
                MGDamage = default.MGDamage * 0.375;
            }
            else if( Level.Game.GameDifficulty < 4.0 )
            {
                MGDamage = default.MGDamage * 1.0;
            }
            else if( Level.Game.GameDifficulty < 5.0 )
            {
                MGDamage = default.MGDamage * 1.15;
            }
            else // Hardest difficulty
            {
                MGDamage = default.MGDamage * 1.3;
            }
        }
	}

	HealingLevels[0] = 0;
	HealingLevels[1] = 0;
	HealingLevels[2] = 0;

	HealingAmount = Health/4; // 1750 HP

}
function Died(Controller Killer, class<DamageType> damageType, vector HitLocation)
{
	local Controller C;

    super(kfmonster).Died(Killer,damageType,HitLocation);

}
function bool SetBossLaught()
{}

state KnockDown // Knocked
{
    function bool ShouldChargeFromDamage()
    {
        return false;
    }

Begin:
    if( Health > 0 )
    {
    	//Sleep(GetAnimDuration('KnockDown'));
    	PlaySound(sound'KF_EnemiesFinalSnd.Patriarch.Kev_SaveMe', SLOT_Misc, 2.0,,500.0);



        GotoState('healing');
	}
	else
	{
	   GotoState('');
	}
}
function TakeDamage( int Damage, Pawn InstigatedBy, Vector Hitlocation, Vector Momentum, class<DamageType> damageType, optional int HitIndex)
{
	local float DamagerDistSq;

    //log(GetStateName()$" Took damage. Health="$Health$" Damage = "$Damage$" HealingLevels "$HealingLevels[SyringeCount]);

    Super.TakeDamage(Damage,instigatedBy,hitlocation,vect(0,0,0),damageType);



    if( Level.TimeSeconds - LastDamageTime > 10 )
    {
        ChargeDamage = 0;
    }
    else
    {
        LastDamageTime = Level.TimeSeconds;
        ChargeDamage += Damage;
    }

    if( ShouldChargeFromDamage() && ChargeDamage > 200 )
    {
        // If someone close up is shooting us, just charge them
        if( InstigatedBy != none )
        {
            DamagerDistSq = VSizeSquared(Location - InstigatedBy.Location);

            if( DamagerDistSq < (700 * 700) )
            {
                SetAnimAction('transition');
        		ChargeDamage=0;
        		LastForceChargeTime = Level.TimeSeconds;
        		GoToState('Charging');
        		return;
    		}
        }
    }

	if( Health<=0 || SyringeCount==3 || IsInState('Escaping') || IsInState('KnockDown') /*|| bShotAnim*/ )
		Return;

	if( (SyringeCount==0 && Health<HealingLevels[0]) || (SyringeCount==1 && Health<HealingLevels[1]) || (SyringeCount==2 && Health<HealingLevels[2]) )
	{


		GoToState('healing');
	}
}

defaultproperties
{
     HealingLevels(0)=1
     HealingLevels(1)=1
     HealingLevels(2)=1
     PlayerCountHealthScale=0.200000
     Begin Object Class=KarmaParamsSkel Name=KarmaParamsSkel3
         KConvulseSpacing=(Max=2.200000)
         KLinearDamping=0.150000
         KAngularDamping=0.050000
         KBuoyancy=1.000000
         KStartEnabled=True
         KVelDropBelowThreshold=50.000000
         bHighDetailOnly=False
         KFriction=1.300000
         KRestitution=0.200000
         KImpactThreshold=85.000000
     End Object
     KParams=KarmaParamsSkel'DA2.KFMZombieBoss.KarmaParamsSkel3'

}
