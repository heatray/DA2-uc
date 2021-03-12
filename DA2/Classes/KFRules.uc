//=============================================================================
// Defence Alliance Specimen Survival.
// made by Black Cheetah.
//=============================================================================
class kfrules extends gamerules config;

var int i,n,mdead,timez;
var bool bended;
var mutkf kfmut;
var() int KillsForPat;
var() bool bZedTime;


state ZedTime
{


  function beginstate()
  {


     setgamespeed(0.2);
    settimer(0.6,false);




   }


function timer()
{
local controller c;




if(bZedTime)
{

setgamespeed(1.0);

        For ( c=Level.ControllerList; c!=None; c=c.NextController )
       {
                if( PlayerController(C) != none )
					{
						PlayerController(C).PlaySound(Sound'KF_PlayerGlobalSnd.Zedtime_Exit', SLOT_Talk, 2.0,false,500.0,1.1/Level.TimeDilation,false);

                     }
        }
  bzedtime=false;
}

gotostate('');

settimer(1.0,true);

}



}
function timer()
{


doom();

if(bended==true)
level.game.gotostate('matchover');
else if(timerrate != 1)
        settimer(1.0,true);
}
function int NetDamage( int OriginalDamage, int Damage, pawn injured, pawn instigatedBy, vector HitLocation, out vector Momentum, class<DamageType> DamageType )
{

    if(instigatedby!=none&&!instigatedby.isa('monster')&&!injured.isa('monster')&&instigatedby!=injured)
    {
        damage=0;
    }
    else if(instigatedby!=none&&instigatedby.isa('monster')&&!injured.isa('monster'))
    {
        injured.health-=damage;

        if(instigatedby!=none&&!instigatedby.isa('zombiefleshpound')||!instigatedby.isa('zombiescrake'))
        injured.health-=5;
    }

    if(kfmonster(injured)!=none&&kfmonster(injured).IsHeadShot(HitLocation, normal(Momentum), 1.7))
    {
        kfmonster(injured).removehead();
    }

    if( instigatedby != none )
    {
        if(instigatedby.isa('vehicle'))
            damage*=0.4;

        if(instigatedby.isa('zombieboss')&&injured.isa('da_players_classplayer'))
            momentum.z=0;

        if(instigatedby.isa('vehicle')&&injured.isa('zombieboss'))
            damage*=0.1;

        if(injured.isa('kfmonster')&&instigatedby.isa('da_players_classplayer'))
            damage*=0.80;

        if(injured.isa('vehicle'))
            damage*=6;

        if( injured.isa('monster') && instigatedby.weapon != none &&
        (/*instigatedby.weapon.isa('da_weapons_MS25RocketLauncher')||*/instigatedby.weapon.isa('da_weapons_rifles_SniperRifle')))
            damage+=200;
    }

    return Damage;
}
function SetGameSpeed( float T )
{
    local float OldSpeed;
    local float gamespeed;

		OldSpeed = GameSpeed;
		GameSpeed = FMax(T, 0.1);
		Level.TimeDilation = 1.1 * GameSpeed;
		if ( GameSpeed != OldSpeed )
		{
			level.game.Default.GameSpeed = GameSpeed;
			class'GameInfo'.static.StaticSaveConfig();
		}

// if _RO_
    SetTimer(Level.TimeDilation/GameSpeed, true);
// else UT
//  SetTimer(Level.TimeDilation, true);
}
function ScoreKill(Controller Killer, Controller Other)
{
    local pawn p,pnum[32];
    local int i,n;
    local controller c;
    local fuelflame k;
    local playercontroller pc;
    local int Time;

    KillsForPat = kfmut.killsforpat;

    if(other.isa('playercontroller')||other.isa('bot'))
    {


        level.game.broadcast( other, other.PlayerReplicationInfo.PlayerName@"has "$(class'mutkf'.default.maxlives-other.playerreplicationinfo.deaths)$" lives.",'CriticalEvent');



        if(other.pawn.playerreplicationinfo.deaths >= class'mutkf'.default.maxlives)
        {
            other.pawn.playerreplicationinfo.boutoflives=true;
            other.GoToState('Spectating');
            //other.PlayerReplicationInfo.Team.RemoveFromTeam(other);
            //other.PlayerReplicationInfo.Team = None;

            kfmut.KBroadcast( other.PlayerReplicationInfo.PlayerName@"is out of lives.",255,0,0);
        }


        doom();
    }


    if(other.pawn.isa('zombieboss'))
    {
        kfmut.bpat=false;
        kfmut.patriarchspawned=false;
        kfmut.playthemusic(level.song);
        For ( c=Level.ControllerList; c!=None; c=c.NextController )
        {
        if(c.playerreplicationinfo.boutoflives==true)
        {

        c.playerreplicationinfo.deaths=0;
        c.playerreplicationinfo.boutoflives=false;
        					if( PlayerController(C) != none )
        					{
        						PlayerController(C).GotoState('PlayerWaiting');
        						PlayerController(C).SetViewTarget(C);
        						PlayerController(C).ClientSetBehindView(false);
        						PlayerController(C).bBehindView = False;
        						PlayerController(C).ClientSetViewTarget(C.Pawn);
        					}

        					C.ServerReStartPlayer();}
        }
        mdead=0;
    }
    if(other.pawn.isa('monster') && /*killer.bisplayer == true &&*/ kfmut.bpat==false)
    {
        mdead++;

        Time = rand(70);
        if(time <5&&killer.bisplayer == true)
        {

            for ( c=Level.ControllerList; c!=None; c=c.NextController )
            {
                if( PlayerController(C) != none )
        		{
        			PlayerController(C).PlaySound(Sound'KF_PlayerGlobalSnd.Zedtime_Enter', SLOT_Talk, 2.0,false,500.0,1.1/Level.TimeDilation,false);

                }
            }
            settimer(0.6,false);
            setgamespeed(0.2);gotostate('Zedtime'); bzedtime=true;
        }
    }

    if(mdead>=KillsForPat)
    {
        kfmut.bpat=true;
        mdead=0;
    }
}

function doom()
{
    local controller c;
    local pawn pp;
    local bool go;

    if( bended==true || kfmut.bstarted == false)
       return;

    foreach allactors(class'pawn',pp)
    {
    if(pp!=none&&pp.isa('da_players_classplayer'))
       {go=true;return;}


    }
    i=0;

    if(go==false)
    {
    For ( c=Level.ControllerList; c!=None; c=c.NextController )
    {
    if(c.bisplayer==true&&c.playerreplicationinfo.boutoflives==false&&(c.isa('playercontroller')||c.isa('bot'))&&c.pawn==none)
    i++;



    }

    if(i==0)
    {
    level.game.endgame(c.playerreplicationinfo,"LastMan");


    foreach allactors(class'controller', c)
    {

    level.game.restartplayer(c);
    c.clientgameended();
    c.gamehasended();
    kfmut.KBroadcast("Game Over",255,0,0);

    if(bended==false)
    settimer(10.0,false);

    bended=true;

    }


    }
    }
}

defaultproperties
{
}
