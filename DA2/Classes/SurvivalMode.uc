class SurvivalMode extends GameRules;
var DA2Survival mut;

function ScoreKill(Controller Killer, Controller Other)
{
	if (Other!=none && Other.Pawn != none && Other.Pawn.IsA('KFMonster'))
	{
		mut.RegisterZombieKill(Other, Killer);
		if (Other.Pawn.IsA('ZombieBoss'))
		{
			mut.RegisterBossDeath(Other, Killer);
		}
		else
		{
			mut.RegisterKill(KFMonster(Other.Pawn));

			if (mut.ShowDebug)

			{
				//mut.Debug("ZombiesKilled", "Killed"@mut.zombiesKilled@"zombies, currently remaining:"@mut.GetZombieCount()@" ("$int(mut.GetInfestationPercentage())$"%)");
			}
			
			if (Killer != none && Killer.bIsPlayer && Killer.Pawn.Health > 0)
			{
				mut.playerKills++;
				if (mut.ShareLives)
				{
					//mut.Debug("PlayerKills", "Player kills:"@mut.playerKills@"Life Gain MOD:"@mut.GetLifeGainMod()@"Modulus:"@mut.playerKills % mut.GetLifeGainMod());
					if (mut.playerKills > 10 && mut.playerKills % mut.GetLifeGainMod() == 0)
					{
						mut.ModifyLife(false, Other);

						//mut.BroadcastMessage("Your team has gained 1 life!", mut.GetColor(0, 255,0),,2);
						mut.UpdateGameInfo();
					}
				}

				Killer.PlayerReplicationInfo.Score -= 1;
			}
		}
	}
	else if (Other!=None && Other.bIsPlayer && Killer != none && Killer.Pawn != none && Killer.Pawn.IsA('monster'))
	{
		mut.ModifyLife(true, Other);
		mut.UpdateGameInfo();
	}
}

function int NetDamage(int originalDamage, int damage, pawn injured, pawn instigatedBy, vector hitLocation, out vector momentum, class<DamageType> DamageType )
{
	super.NetDamage(originalDamage, damage, injured, instigatedBy, HitLocation, Momentum, DamageType);

	if (ZombieBoss(injured) != none) // && instigatedBy.controller.bIsPlayer
	{
		if (mut.ShowDebug)
		{
			mut.Debug("PatriarchHealth", "Patriarch has a wooping"@injured.Health@"health points left.");
		}
		SurvivalGameReplicationInfo(Level.Game.GameReplicationInfo).bossHealth = injured.Health;
	}

	if(KFMonster(injured)!=none && KFMonster(injured).IsHeadShot(hitLocation, normal(momentum), 1.7) && KFMonster(injured).bIsSquadLeader==false)
	{
		KFMonster(injured).RemoveHead();
	}

	if(instigatedby != none)
	{
		if(instigatedby.isa('vehicle'))
			damage *= 0.5+(0.1* mut.GetGameDifficulty());

		//if(instigatedby.isa('zombieboss')&&injured.isa('da_players_classplayer'))
		//    momentum.z=0;

		//if(instigatedby.isa('vehicle') && injured.isa('zombieboss'))
		//    damage *= 0.85;

		//if(injured.isa('kfmonster') && instigatedby.isa('da_players_classplayer'))
		//    damage *= 1.0*(1.01*instigatedBy.controller.PlayerReplicationInfo.Score);

		//if(injured.isa('vehicle'))
		//    damage*=1.5;

		//if(KFMonster(injured) != none && instigatedby.weapon != none && instigatedby.weapon.isa('da_weapons_rifles_SniperRifle'))
		//	damage += 300;

		if(KFMonster(injured) != none && instigatedby.weapon != none && instigatedby.weapon.isa('da_weapons_MS25RocketLauncher'))
			damage += 180;
	}

	if (KFMonster(injured) != none && damage > 0)
	{
		if (instigatedBy != none)
			mut.RegisterDamage(KFMonster(injured), instigatedby.Controller, damage);

		//spawn(class'kfbloodtrail',,,hitlocation);

		//if (instigatedBy!=none && instigatedBy.Controller.IsA('PlayerController'))
		//	mut.Debug("Damage", PlayerController(instigatedBy.Controller).PlayerOwnerName@"did"@damage@"(Original:"@originalDamage@") to"@injured.name@" (Health:"@injured.Health@"/"@injured.HealthMax$")");
	}
	return damage;	
}

defaultproperties
{
}
