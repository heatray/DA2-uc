//=============================================================================
// Defence Alliance Specimen Survival.
// made by Black Cheetah.
//=============================================================================
class mutkf extends mutator config;

var int num,n,da,Zdead;
var() config int Maxlives,MaxZedsPerPerson,Starttime,Killsforpat;
var bool bstarted,bcanzedy,bstartwave,bpat,patriarchspawned;
var teaminfo teami;
var musictrigger tri;
var float startnum;
var GameRules G;
var() config bool bZedTime;
var float CheckInterval;

static function FillPlayInfo(PlayInfo PlayInfo) {
  Super.FillPlayInfo(PlayInfo);  // Always begin with calling parent

PlayInfo.AddSetting("Wave Start Time", "starttime", "Wave Start Time", 0, 0, "Text", "3;0:60",);
PlayInfo.AddSetting("Max Lives", "maxlives", "Max Lives", 0, 0, "Text", "2;0:10",);
PlayInfo.AddSetting("Max Zeds Per Person", "maxzedsperperson", "Max Zeds Per Person", 0, 0, "Text", "3;0:60",);
PlayInfo.AddSetting("Kills before facing Patriarch", "killsforpat", "Kills before facing Patriarch", 0, 0, "Text", "3;10:500",);
PlayInfo.AddSetting("Zed Time", "bzedtime", "Zed Time", 0, 0, "Check",);

}

function modifyplayer(pawn other)
{
local messagetrigger m;
local int playerclass;
local string playername;

if(bstarted==false)
{settimer(starttime,false);
g.settimer(1.0,true);
playthemusic(level.song);

bstarted=true;startnum=level.timeseconds;}
//else if(bstartwave == true)
  //     {other.playerreplicationinfo.deaths=maxlives; other.playerreplicationinfo.boutoflives=true;}

if(other.controller.isa('playercontroller')&& playercontroller(other.controller).myhud != none
    && !playercontroller(other.controller).myhud.isa('da_players_zhud'))
{

if(!other.controller.playerreplicationinfo.isa('da_players_zpri'))
{
playername=playercontroller(other.controller).playerreplicationinfo.playername;
playerclass=da_players_pri(playercontroller(other.controller).playerreplicationinfo).playerclass;
playercontroller(other.controller).playerreplicationinfo.destroy();
playercontroller(other.controller).playerreplicationinfo=spawn(class'da_players_zpri',other.controller);
other.controller.InitPlayerReplicationInfo();
other.playerreplicationinfo=other.controller.playerreplicationinfo;
other.controller.playerreplicationinfo.playername=playername;
other.controller.playerreplicationinfo.team=teamgame(level.game).teams[0];
da_players_pri(other.controller.playerreplicationinfo).playerclass=playerclass;
}

playercontroller(other.controller).ClientSetHUD(class'da_players_zhud',class'da_game_zscoreboard');

}

}

Function KBroadcast(string msg,int r,int b, int g)
{
local controller C;


for ( C = Level.ControllerList; C != None; C = C.NextController )
{
if(c!=none&&playercontroller(C)!=none)
{PlayerController(C).ClearProgressMessages();
			PlayerController(C).SetProgressTime(6);
			PlayerController(C).SetProgressMessage(0, Msg, class'Canvas'.Static.MakeColor(r,b,g));


}

}

}
function prebeginplay(){
local vehicle t;
local controller c;

foreach allactors(class'vehicle', t)
{

if(t!=none&&t.isa('da_turrets_Turret'))
{

//da_turrets_Turret(t).bstartbuilt=false;

t.autoturretcontrollerclass=class'tdat';

t.controller=spawn(class'tdat',,,);
c.possess(t);
aicontroller(c).skill=t.skillmodifier;}


}

}

function postbeginplay(){

local vehicle t;
local controller c;
local actor l;

teamgame(level.game).bforcerespawn = true;

level.game.bAllowMPGameSpeed = true;


foreach allactors(class'actor', l)
{


if(l!=none&&l.isa('mover'))
mover(l).InterpolateTo( 1, 1);


}
foreach allactors(class'vehicle', t)
{

if(t!=none&&t.isa('da_turrets_Turret'))
{t.autoturretcontrollerclass=class'tdat';

t.controller=spawn(class'tdat',,,);
c.possess(t);
aicontroller(c).skill=t.skillmodifier;}


}


	Super.PostBeginPlay();

		G = spawn(class'kfRules');
		if ( Level.Game.GameRulesModifiers == None )
			Level.Game.GameRulesModifiers = G;
		else
			Level.Game.GameRulesModifiers.AddGameRules(G);




kfrules(g).kfmut=self;


//settimer(0.5,true);

}

function tick(float delta)
{

    local pawn xp;
    local da_turrets_turret t;
    local controller c;


    if(bstarted==true&&(starttime)>(level.timeseconds)-startnum)
    {
        KBroadcast( "Specimens are Free! They'll reach you in "$starttime-int(level.timeseconds-startnum)$" seconds",255,255,255);
    }

    // At least do this ten times a second instead of every tick. There has GOT to be a better way to do this - Ramm
    if( CheckInterval > 0 )
    {
        CheckInterval -= delta;

        if( CheckInterval <= 0 )
        {
            CheckInterval = default.CheckInterval;

            foreach dynamicactors(class'da_turrets_turret', t)
            {
                if( t!=none && /*t.isa('da_turrets_Turret') &&*/ t.autoturretcontrollerclass != class'tdat' )
                {
                    t.autoturretcontrollerclass=class'tdat';

                    t.controller=spawn(class'tdat',,,);
                    c.possess(t);
                    aicontroller(c).skill=t.skillmodifier;
                }
            }


            foreach dynamicactors(class'pawn', xp)
            {
                if( XP != none )
                {
                    if(xp.isa('zombieclot')&&xp.health>125)
                        xp.health=125;

                    if(xp.isa('da_players_classplayer')&&xp.playerreplicationinfo!=none&&xp.playerreplicationinfo.team.teamindex!=0)
                    {
                        xp.playerreplicationinfo.team=teamgame(level.game).teams[0];
                    }

                    //else if(xp.isa('monster')&&xp.playerreplicationinfo!=none&&xp.playerreplicationinfo.teamid!=0)
                    //{xp.playerreplicationinfo.team.teamindex=1;xp.playerreplicationinfo.teamid=0;}

                    if(xp.isa('da_players_classplayer')&& xp.controller != none &&
                        xp.controller.enemy!=none && xp.controller.enemy.isa('da_players_classplayer')&&xp.controller.isa('bot'))
                    {
                        xp.controller.enemy=none;
                        xp.controller.gotostate('roaming');
                    }
                }
             }
         }
     }
}

function timer()
{

    local navigationpoint p,pnum[32];
    local int i;
    local vector loc;
    local KFMonster xp;
    local int z;
    local actor a;
    local pathnode seee;
    local playerreplicationinfo pi;
    local controller c,patc;
    local int j;
    local int MaxZeds;

    foreach allactors(class'actor',a)
    if(a.isa('blockedpath'))
    {
        navigationpoint(a).bblocked = false;
    }

    if(bcanzedy==false)
    settimer(1.0,true);

    bcanzedy=true;

    i=0;
    n=0;
    For ( c=Level.ControllerList; c!=None; c=c.NextController )
    {
        if(c.pawn!=none && c.pawn.isa('zombieboss'))
        patc=c;

        if(c.isa('playercontroller')&&c.playerreplicationinfo.boutoflives==false){playercontroller(c).bbehindview=false;playercontroller(c).setviewtarget(none);}

        if(c.pawn!=none && c.pawn.isa('monster'))
        {n++;}




        if(c.pawn!=none && C.pawn.isa('da_players_classplayer')&&c.playerreplicationinfo.team!=teamgame(level.game).teams[0]&&c.playerreplicationinfo!=none)
        c.playerreplicationinfo.team=teamgame(level.game).teams[0];

        if(c.pawn!=none&&c.pawn.isa('da_players_classplayer')&&c.bisplayer)
        {
            //c.pawn.groundspeed=175;
            i++;
        }

        if(c.isa('playercontroller')&& playercontroller(c).myhud!=none &&playercontroller(c).myhud.isa('da_players_zhud'))
        playercontroller(c).playerreplicationinfo.kills=default.killsforpat - kfrules(g).mdead;
    }


    if(bpat==true&&patc==none&&patriarchspawned==true)
    {bpat=false;playthemusic(level.song);patriarchspawned=false;}

    MaxZeds = (Level.Game.NumPlayers + Level.Game.NumBots) * MaxZedsPerPerson;


//    c=none;
//    For ( c=Level.ControllerList; c!=None; c=c.NextController )
//    {
//        for ( p=Level.NavigationPointList; p!=None; p=p.NextNavigationPoint )
//        {
//            if(p!=none&&c.pawn!=none&&vsize(p.location-c.pawn.location) < 200)
//            {return;}

            p = Level.Game.FindPlayerStart( none, 1);
            if(bpat==false && p!=none && n<(i*MaxZedsPerPerson))
            {
//                for ( j=0; j < MaxZeds; j++ )
//                {
                loc=p.location;
                loc.z+=50;
                i=rand(100);

                if(i<60&&n<(i*MaxZedsPerPerson))
                {
                    if(bstartwave==false)
                    bstartwave=true;

                	xp=spawn(class'clot',,,loc);
    //            	xp.playerreplicationinfo=spawn(class'playerreplicationinfo');
    //            	xp.controller.playerreplicationinfo=xp.playerreplicationinfo;
    //            	xp.playerreplicationinfo.playername="Clot";
                	n++;
                	//xp.groundspeed+=300;
                	xp.groundspeed *= 1.4;
                	xp.OriginalGroundSpeed *= 1.4;
                	xp.ragdolloverride="clot_Trip";
                }
                else if(i<70&&n<(i*MaxZedsPerPerson))
                {
                	xp=spawn(class'stalker',,,loc);
    //            	xp.playerreplicationinfo=spawn(class'playerreplicationinfo');
    //            	xp.controller.playerreplicationinfo=xp.playerreplicationinfo;
    //            	xp.playerreplicationinfo.playername="Stalker";
                	n++;
                	//xp.groundspeed+=300;
                	xp.groundspeed *= 1.4;
                	xp.OriginalGroundSpeed *= 1.4;
                    xp.ragdolloverride="Stalker_Trip";
                }
                else if(i<75&&n<(i*MaxZedsPerPerson))
                {
                	xp=spawn(class'crawler',,,loc);
    //            	xp.playerreplicationinfo=spawn(class'playerreplicationinfo');
    //            	xp.controller.playerreplicationinfo=xp.playerreplicationinfo;
    //            	xp.playerreplicationinfo.playername="Crawler";
                	n++;
                	//xp.groundspeed+=300;
                	xp.groundspeed *= 1.4;
                	xp.OriginalGroundSpeed *= 1.4;
                	xp.ragdolloverride="Crawler_Trip";
                }
                else if(i<85&&n<(i*MaxZedsPerPerson))
                {
                	xp=spawn(class'gorefast',,,loc);
    //            	xp.playerreplicationinfo=spawn(class'playerreplicationinfo');
                	//xp.groundspeed+=300;
                	xp.groundspeed *= 1.4;
                	xp.OriginalGroundSpeed *= 1.4;
    //            	xp.controller.playerreplicationinfo=xp.playerreplicationinfo;
    //            	xp.playerreplicationinfo.playername="GoreFast";
                	n++;
                	xp.ragdolloverride="GoreFast_Trip";
                }
                else if(i<90&&n<(i*MaxZedsPerPerson))
                {
                	xp=spawn(class'Husk',,,loc);
    //            	xp.playerreplicationinfo=spawn(class'playerreplicationinfo');
                	//xp.groundspeed+=300;
                	xp.groundspeed *= 1.4;
                	xp.OriginalGroundSpeed *= 1.4;
    //            	xp.controller.playerreplicationinfo=xp.playerreplicationinfo;
    //            	xp.playerreplicationinfo.playername="Husk";
                	//xp.health=700;
                	n++;
                	xp.ragdolloverride="Burns_Trip";
                }
                else if(i<95&&n<(i*MaxZedsPerPerson))
                {
                	xp=spawn(class'siren',,,loc);
    //            	xp.playerreplicationinfo=spawn(class'playerreplicationinfo');
                	//xp.groundspeed+=300;
                	xp.groundspeed *= 1.4;
                	xp.OriginalGroundSpeed *= 1.4;
    //            	xp.controller.playerreplicationinfo=xp.playerreplicationinfo;
    //            	xp.playerreplicationinfo.playername="Siren";
                	n++;
                	xp.ragdolloverride="Siren_Trip";
                }
                else if(i==98)
                {
                	xp=spawn(class'fleshpound',,,loc);
    //            	xp.playerreplicationinfo=spawn(class'playerreplicationinfo');
                	//xp.groundspeed+=300;
                	xp.groundspeed *= 1.4;
                	xp.OriginalGroundSpeed *= 1.4;
    //            	xp.controller.playerreplicationinfo=xp.playerreplicationinfo;
    //            	xp.playerreplicationinfo.playername="FleshPound";
                	//xp.health=1200;
                	n++;
                	xp.ragdolloverride="FleshPound_Trip";
                }
                else if(i==96&&n<(i*MaxZedsPerPerson))
                {
                	xp=spawn(class'scrake',,,loc);
    //            	xp.playerreplicationinfo=spawn(class'playerreplicationinfo');
                	//xp.groundspeed+=100;
                	xp.groundspeed *= 1.3;
                	xp.OriginalGroundSpeed *= 1.3;
    //            	xp.controller.playerreplicationinfo=xp.playerreplicationinfo;
    //            	xp.playerreplicationinfo.playername="Scrake";
                	//xp.health=700;
                	n++;
                	xp.ragdolloverride="Scrake_Trip";
                }

                if(xp!=none)
                xp.settimer(0,false);

            }
            else
            {
                if(bpat==true&&p!=none)
                {
                    loc=p.location;
                    loc.z+=50;

                    if(patriarchspawned==false)
                    {
                    	playthemusic("snowfallaction");
                    	patriarchspawned=true;
                    	xp=spawn(class'kfmzombieboss',,,loc);
        //            	xp.playerreplicationinfo=spawn(class'playerreplicationinfo');
        //            	xp.controller.playerreplicationinfo=xp.playerreplicationinfo;
        //            	xp.playerreplicationinfo.playername="MR Patriarch";
                    	//xp.groundspeed+=100;
                    	xp.groundspeed *= 1.4;
                    	xp.OriginalGroundSpeed *= 1.4;
                        //xp.health=2500;
                    	n++;
                    	xp.ragdolloverride="Patriarch_Trip";
                    }
                }
            }
        //}
    //}
}

function playthemusic(string song)
{
local controller c;

For ( c=Level.ControllerList; c!=None; c=c.NextController )
{
if(c.isa('playercontroller')){
playercontroller(c).ClientSetMusic( Song, mtran_fade );
}

	   // PlayMusic( Song, 3.0 );
	}
}

defaultproperties
{
     MaxLives=3
     MaxZedsPerPerson=4
     StartTime=60
     Killsforpat=100
     CheckInterval=0.100000
     FriendlyName="Defence Alliance Specimen Survival"
     Description="Survive the incoming waves of specimens!"
}
