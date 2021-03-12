class da_players_HumanPlayer extends da_players_ClassPlayer;

var da_players_PRI daPRI;

// #exec OBJ load file=AS_FX_TX.utx

//var da_players_PRI  PRI;

function PlayTeleportEffect( bool bOut, bool bSound)
{
         playSound(sound'DA2_WeaponSounds.Human_Spawn',SLOT_None, 1.7);
}


simulated function string GetDefaultCharacter() {
    return "Generic";
}


//Adjusts skin based on class player/bot has -aBs
simulated function Setup(xUtil.PlayerRecord rec, optional bool bLoadNow)
{
    daPRI = da_players_PRI(PlayerReplicationInfo);

    if (playerReplicationInfo != none && playerReplicationInfo.team != none) 
    {
	if (daPRI.Team.TeamIndex == 0)
	{
		switch(daPRI.playerClass)
		{
		case 0:  rec = class'xUtil'.static.FindPlayerRecord("GreenInfantry");
		break;

		case 1:  rec = class'xUtil'.static.FindPlayerRecord("GreenMechanic");
		break;

		case 2:  rec = class'xUtil'.static.FindPlayerRecord("GreenMedic");
		break;

		case 3:  rec = class'xUtil'.static.FindPlayerRecord("GreenGunner");
		break;

		case 4:  rec = class'xUtil'.static.FindPlayerRecord("GreenSniper");
		break;

		case 5:  rec = class'xUtil'.static.FindPlayerRecord("GreenHeavy");
		break;

		case 6:  rec = class'xUtil'.static.FindPlayerRecord("GreenMechanic");
		break;

	      	default: rec = class'xUtil'.static.FindPlayerRecord("Jungle");
              	break;
		}
	}
	if (daPRI.Team.TeamIndex == 1)
	{
		switch(daPRI.playerClass)
		{
		case 0:  rec = class'xUtil'.static.FindPlayerRecord("UrbanInfantry");
		break;

		case 1:  rec = class'xUtil'.static.FindPlayerRecord("UrbanMechanic");
		break;

		case 2:  rec = class'xUtil'.static.FindPlayerRecord("UrbanMedic");
		break;

  		case 3:  rec = class'xUtil'.static.FindPlayerRecord("UrbanGunner");
		break;

		case 4:  rec = class'xUtil'.static.FindPlayerRecord("UrbanSniper");
		break;

		case 5:  rec = class'xUtil'.static.FindPlayerRecord("UrbanHeavy");
		break;

		case 6:  rec = class'xUtil'.static.FindPlayerRecord("UrbanMechanic");
		break;

		default: rec = class'xUtil'.static.FindPlayerRecord("Urban");
              	break;
        	}
   	}
     }

   if (rec.Species == none)
      rec.Species = class'da_HumanSpecies';

    super(xPawn).Setup(rec);
}

function Suicide()
{
  if (controller.isa('da_players_PlayerController'))
    da_players_PlayerController(Controller).AMIAnnouncement(sound'AMISounds.Player.InternalDamageDetected');
  super.Suicide();
}

function timer()
{
  if (BurnDown > 0)
  {
    LastBurnDamage *= 0.5;
        TakeFireDamage(LastBurnDamage, BurnInstigator);
  }
  else
  {
    RemoveFlamingEffects();
    StopBurnFX();
  }
}

function TakeDamage( int Damage, Pawn InstigatedBy, Vector Hitlocation, Vector Momentum, class<DamageType> damageType, optional int HitIndex)
{
    local float tmp;

if ( class<DamTypeBurned>(damageType) != none || class<da_damtypes_ThermiteGrenade>(damageType) != none)
  {
    if( TeamGame(Level.Game)!=None && TeamGame(Level.Game).FriendlyFireScale==0 && instigatedBy!=None && instigatedBy!=Self
     && instigatedBy.GetTeamNum()==GetTeamNum()  )
        {
            Return;
        }

        // Do burn damage if the damage was significant enough
        if( Damage > 2 )
        {
            // If we are already burning, and this damage is more than our current burn amount, add more burn time
            if( BurnDown > 0 && Damage > LastBurnDamage )
            {
                BurnDown = 5;
                BurnInstigator = instigatedBy;
            }

            LastBurnDamage = Damage;

            if (BurnDown <= 0 )
            {
                bBurnified = true;
                BurnDown = 5;
                BurnInstigator = instigatedBy;
                SetTimer(1.5,true);
            }
        }
  }

    //damage = max(damage - armor, min(damage, 2));
    tmp=fmax(0,damage*(1-armor/100));
    if(tmp<1 && frand()<tmp) tmp=1;
    damage=tmp;

    if (damage > 0)
    {
        if (da_players_PlayerController(Controller) != None && Health <= 26)
        {
           if (FRand() < 0.5)
             da_players_PlayerController(Controller).AMIAnnouncement(sound'AMISounds.Player.LifeSignsCritical');
           else
            da_players_PlayerController(Controller).AMIAnnouncement(sound'AMISounds.Player.LifeSignsCriticalSeekMedicalAttention');
        }
    }

    Super.TakeDamage(Damage, InstigatedBy, HitLocation, Momentum, damageType);
}

function TossWeapon(Vector TossVel)
{
  super.tossWeapon(tossVel);
  throwKarmaWeapon();
}

function throwKarmaWeapon()
{
  local da_weapons_Reloadable kwhack;

  if (Level.netMode == NM_DedicatedServer)
    return;

  kwhack = da_weapons_Reloadable(weapon);
  if (kwhack != none)
    kwhack.karmaThrowWeapon();
//  else
//    warn(weapon@" is no DA weapon!");

}

defaultproperties
{
     VoiceType="DA2.da_Sounds_HumanVoicePack"
     GroundSpeed=350.000000
     WaterSpeed=200.000000
     AirSpeed=150.000000
     AccelRate=675.000000
     MaxFallSpeed=800.000000
     Mesh=SkeletalMesh'DA2_PlayerModels.FrontLine'
}
