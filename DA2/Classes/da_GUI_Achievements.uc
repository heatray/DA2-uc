class da_GUI_Achievements extends UT2K4MainPage;

var 	automated da_GUI_SectionBackground	sb_Stats, sb_Achievements;

var 	automated da_GUI_AltSectionBackground sb_classes, sb_weapons, sb_other, sb_rank, sb_unlocks;

var 	automated GUILabel	l_rifleman, l_score1, l_kills1 , l_mechanic, l_score2, l_kills2, l_medic, l_score3, l_kills3, 
							l_mg, l_score4, l_kills4, l_sniper, l_score5, l_kills5, l_rocketeer, l_score6, l_kills6, l_engineer,
							l_score7, l_kills7,l_weapon1,l_weapon2,l_weapon3,l_weapon4,l_weapon5,l_weapon6,l_weapon7,l_weapon8,l_weapon9,
							l_other1,l_other2,l_RankProgress,l_ranknumber,l_RankName,l_AchievementProgress1,l_AchievementProgress2,l_AchievementProgress3,
							l_AchievementProgress4,l_AchievementProgress5,l_AchievementAward1,l_AchievementAward2,l_AchievementAward3,l_AchievementAward4,
							l_AchievementAward5;
							
var int riflemanscore, riflemankills, mechanicscore, mechanickills, medicscore, medickills, mgscore, mgkills, sniperscore, sniperkills,
		rocketeerscore, rocketeerkills, engineerscore, engineerkills, a9,gk2,lk2,mr40,mr56,ms25,r86,p280,xd40,frag,thermite,mine,plasma,
		nuclear,aver,crusher,dfa,huskkills,grenadekills,sniperriflekills,rocketkills,ammoboxuses,totalscore;
		
var 	automated GUIImage i_weapon1,i_weapon2,i_weapon3,i_weapon4,i_weapon5,i_weapon6,i_weapon7,i_weapon8,i_weapon9,i_Rank1,i_bgClass1,
							i_locked1,i_locked2,i_locked3,i_locked4,i_locked5,i_firebullet,i_grenade,i_sniper,i_rocket,i_ammo,i_bgClass2,
							i_bgClass3,i_bgClass4,i_bgClass5,i_bgClass6;

var		automated da_GUI_ProgressBar pb_Rank,pb_firebullet,pb_grenade,pb_sniper,pb_rocket,pb_ammo;


//===============================================================================
function bool InternalOnPreDraw(canvas c) 
{
	i_Background.Image = class'da_GUI_Utilities'.static.getCorrectBackground(c);
	
	Initialize();
	ClassesPosition();
	//CompareScore();
	WeaponsPosition();
	SetupAchievements();
	SetupRank();
	
	return false;
}

//===============================================================================
function Initialize()
{
	local da_SteamStatsAndAchievements da_StatsAndAchievements;
	
	if ( PlayerOwner().SteamStatsAndAchievements == none )
        PlayerOwner().SteamStatsAndAchievements = PlayerOwner().Spawn(PlayerOwner().default.SteamStatsAndAchievementsClass, PlayerOwner());

	da_StatsAndAchievements = da_SteamStatsAndAchievements(PlayerOwner().SteamStatsAndAchievements);
	
	// Set score and kills from achievements
	riflemanscore = da_StatsAndAchievements.RifScoreStat.Value;
	mechanicscore = da_StatsAndAchievements.MechScoreStat.Value;
	medicscore = da_StatsAndAchievements.MedScoreStat.Value;
	mgscore = da_StatsAndAchievements.MgScoreStat.Value;
	sniperscore = da_StatsAndAchievements.SnipScoreStat.Value;
	rocketeerscore = da_StatsAndAchievements.RockScoreStat.Value;
	engineerscore = da_StatsAndAchievements.EngScoreStat.Value;
	
	riflemankills = da_StatsAndAchievements.RifKillsStat.Value;
	mechanickills = da_StatsAndAchievements.MechKillsStat.Value;
	medickills = da_StatsAndAchievements.MedKillsStat.Value;
	mgkills = da_StatsAndAchievements.MgKillsStat.Value;
	sniperkills = da_StatsAndAchievements.SnipKillsStat.Value;
	rocketeerkills = da_StatsAndAchievements.RockKillsStat.Value;
	engineerkills = da_StatsAndAchievements.EngKillsStat.Value;
	
	a9 = da_StatsAndAchievements.A9Stat.Value;
	gk2 = da_StatsAndAchievements.GK2Stat.Value;
	lk2 = da_StatsAndAchievements.LK2Stat.Value;
	mr40 = da_StatsAndAchievements.MR40Stat.Value;
	mr56 = da_StatsAndAchievements.MR56Stat.Value;
	ms25 = da_StatsAndAchievements.MS25Stat.Value;
	r86 = da_StatsAndAchievements.SniperStat.Value;
	p280 = da_StatsAndAchievements.P280Stat.Value;
	xd40 = da_StatsAndAchievements.XD40Stat.Value;
	
	frag = da_StatsAndAchievements.HandGrenadeStat.Value;
	thermite = da_StatsAndAchievements.ThermiteStat.Value;
	mine = da_StatsAndAchievements.APMineStat.Value;
	plasma = da_StatsAndAchievements.PlasmaStat.Value;
	nuclear = da_StatsAndAchievements.NuclearGrenadeStat.Value;
	aver = da_StatsAndAchievements.AVeRStat.Value;
	crusher = da_StatsAndAchievements.CrusherStat.Value;
	dfa = da_StatsAndAchievements.DFAStat.Value;
	
	huskkills = da_StatsAndAchievements.HuskKillsStat.Value;
	grenadekills = da_StatsAndAchievements.GrenadeKillsStat.Value;
	sniperriflekills = da_StatsAndAchievements.SniperKillsStat.Value;
	rocketkills = da_StatsAndAchievements.RocketKillsStat.Value;
	ammoboxuses = da_StatsAndAchievements.AmmoboxStat.Value;
	
	totalscore = da_StatsAndAchievements.ScoreStat.Value;
	
}

//===============================================================================
function ClassesPosition()
{
	// Config for Score and Kills per Class
	l_score1.caption = ("Score: "@riflemanscore);
	l_kills1.caption = ("Kills: "@riflemankills);
	
	l_mechanic.winleft = l_rifleman.winleft + 0.09;
	l_mechanic.caption = "MECHANIC";
	l_score2.winleft = l_mechanic.winleft;
	l_score2.caption = ("Score: "@mechanicscore);
	l_kills2.winleft = l_mechanic.winleft;
	l_kills2.caption = ("Kills: "@mechanickills);
	
	l_medic.winleft = l_mechanic.winleft + 0.09;
	l_medic.caption = "MEDIC";
	l_score3.winleft = l_medic.winleft;
	l_score3.caption = ("Score: "@medicscore);
	l_kills3.winleft = l_medic.winleft;
	l_kills3.caption = ("Kills: "@medickills);
	
	l_mg.winleft = l_medic.winleft + 0.09;
	l_mg.caption = "GUNNER";
	l_score4.winleft = l_mg.winleft;
	l_score4.caption = ("Score: "@mgscore);
	l_kills4.winleft = l_mg.winleft;
	l_kills4.caption = ("Kills: "@mgkills);
	
	l_sniper.winleft = l_mg.winleft + 0.09;
	l_sniper.caption = "SNIPER";
	l_score5.winleft = l_sniper.winleft;
	l_score5.caption = ("Score: "@sniperscore);
	l_kills5.winleft = l_sniper.winleft;
	l_kills5.caption = ("Kills: "@sniperkills);
	
	l_rocketeer.winleft = l_sniper.winleft + 0.09;
	l_rocketeer.caption = "ROCKETEER";
	l_score6.winleft = l_rocketeer.winleft;
	l_score6.caption = ("Score: "@rocketeerscore);
	l_kills6.winleft = l_rocketeer.winleft;
	l_kills6.caption = ("Kills: "@rocketeerkills);
	
	l_engineer.winleft = l_rocketeer.winleft + 0.09;
	l_engineer.caption = "ENGINEER";
	l_score7.winleft = l_engineer.winleft;
	l_score7.caption = ("Score: "@engineerscore);
	l_kills7.winleft = l_engineer.winleft;
	l_kills7.caption = ("Kills: "@engineerkills);
}

//===============================================================================
function CompareScore()
{
	local int score[7];
	local int i;
	
	score[0] = riflemanscore;
	score[1] = mechanicscore;
	score[2] = medicscore;
	score[3] = mgscore;
	score[4] = sniperscore;
	score[5] = rocketeerscore;
	score[6] = engineerscore;
	
	for (i=0; i < 7; i++)
	{
		if (score[i] >= score[0] && score[i] >= score[1] && score[i] >= score [2] &&
			score[i] >= score[3] && score[i] >= score[4] && score[i] >= score[5] &&
			score[i] >= score[6])
			{
				log("highest score: "@score[i]);
			
				if (score[i] == score[0]) l_Score1.TextFont="UT2HeaderFont";
				else if (score[i] == score[1]) l_Score2.TextFont="UT2HeaderFont";
				else if (score[i] == score[2]) l_Score3.TextFont="UT2HeaderFont";
				else if (score[i] == score[3]) l_Score4.TextFont="UT2HeaderFont";
				else if (score[i] == score[4]) l_score5.caption = ("-> Score: "@sniperscore$" <-");
				else if (score[i] == score[5]) l_Score6.TextFont="UT2HeaderFont";
				else if (score[i] == score[6]) l_Score7.TextFont="UT2HeaderFont";
			}
	}				
}

//===============================================================================
function WeaponsPosition()
{
	i_weapon1.Image = Texture'DA2GUI.Misc.sideviewA9';
	
	i_weapon2.WinLeft = i_weapon1.Winleft + 0.11;
	i_weapon2.Image = Texture'DA2GUI.Misc.sideviewGK2';
	
	i_weapon3.WinLeft = i_weapon2.Winleft + 0.11;
	i_weapon3.Image = Texture'DA2GUI.Misc.sideviewLK2';
	
	i_weapon4.WinLeft = i_weapon3.Winleft + 0.11;
	i_weapon4.Image = Texture'DA2GUI.Misc.sideviewMR40';
	
	i_weapon5.WinLeft = i_weapon4.Winleft + 0.11;
	i_weapon5.Image = Texture'DA2GUI.Misc.sideviewMR56';
	
	i_weapon6.WinLeft = i_weapon5.Winleft + 0.11;
	i_weapon6.Image = Texture'DA2GUI.Misc.sideviewMS25';
	
	i_weapon7.WinLeft = i_weapon6.Winleft + 0.11;
	i_weapon7.Image = Texture'DA2GUI.Misc.sideviewR86';
	
	i_weapon8.WinLeft = i_weapon7.Winleft + 0.11;
	i_weapon8.Image = Texture'DA2GUI.Misc.sideviewP280';
	
	i_weapon9.WinLeft = i_weapon8.Winleft + 0.11;
	i_weapon9.Image = Texture'DA2GUI.Misc.sideviewXD40';
	
	l_weapon1.Caption = "A9 Submachinegun | Kills: "@a9;
	
	l_weapon2.Caption = "GK-2 Shotgun | Kills: "@gk2;
	l_weapon2.WinLeft = l_weapon1.WinLeft + 0.11;
	
	l_weapon3.Caption = "LK-2 Shotgun | Kills: "@lk2;
	l_weapon3.WinLeft = l_weapon2.WinLeft + 0.11;
	
	l_weapon4.Caption = "MR-40 Machinegun | Kills: "@mr40;
	l_weapon4.WinLeft = l_weapon3.WinLeft + 0.11;
	
	l_weapon5.Caption = "MR-56 Assault Rifle | Kills: "@mr56;
	l_weapon5.WinLeft = l_weapon4.WinLeft + 0.11;
	
	l_weapon6.Caption = "MS-25 Rocket Launcher | Kills: "@ms25;
	l_weapon6.WinLeft = l_weapon5.WinLeft + 0.11;
	
	l_weapon7.Caption = "R-86 Sniper Rifle | Kills: "@r86;
	l_weapon7.WinLeft = l_weapon6.WinLeft + 0.11;
	
	l_weapon8.Caption = "P-280 Pistol | Kills: "@p280;
	l_weapon8.WinLeft = l_weapon7.WinLeft + 0.11;
	
	l_weapon9.Caption = "XD-40 Pistol | Kills: "@xd40;
	l_weapon9.WinLeft = l_weapon8.WinLeft + 0.11;
	
	l_other1.Caption=("Frag Grenade  Kills: "@frag$"|Thermite Grenade  Kills: "@thermite$"|Anti-Person Mine  Kills: "@mine$"|Plasma Bomb  Kills: "@plasma);
	l_other2.Caption=("Nuclear Grenade  Kills: "@nuclear$"|AVeR Turret  Kills: "@aver$"|Crusher Turret  Kills: "@crusher$"|DFA Turret  Kills: "@dfa) ;
}

//===============================================================================
function SetupRank()
{

	if (totalscore >= 252000)
	{
		i_Rank1.Image = Texture'DA2GUI.Misc.Star';
		l_RankName.Caption="General";
		l_RankNumber.Caption="***";
		pb_Rank.High = totalscore;
		pb_Rank.Value = totalscore;
		l_RankProgress.Caption=((totalscore)$" Total Score");
	}
	
	else if (totalscore >= 192000)
	{
		i_Rank1.Image = Texture'DA2GUI.Misc.Star';
		l_RankName.Caption="Supreme Commander|ELITE";
		l_RankNumber.Caption="3";
		l_RankProgress.Caption=((252000-totalscore)$" Score|needed for next rank");
		pb_Rank.High = 60000;
		pb_Rank.Value = totalscore - 192000;
	}
		
	else if (totalscore >= 144000)
	{
		i_Rank1.Image = Texture'DA2GUI.Misc.Star';
		l_RankName.Caption="Supreme Commander|Second Class";
		l_RankNumber.Caption="2";
		l_RankProgress.Caption=((192000-totalscore)$" Score|needed for next rank");
		pb_Rank.High = 60000;
		pb_Rank.Value = totalscore - 144000;
	}
		
	else if (totalscore >= 108000)
	{
		i_Rank1.Image = Texture'DA2GUI.Misc.Star';
		l_RankName.Caption="Supreme Commander|First Class";
		l_RankNumber.Caption="1";
		l_RankProgress.Caption=((144000-totalscore)$" Score|needed for next rank");
		pb_Rank.High = 36000;
		pb_Rank.Value = totalscore - 108000;
	}
		
	else if (totalscore >= 84000)
	{
		i_Rank1.Image = Texture'DA2GUI.Misc.Captain';
		l_RankName.Caption="Alliance Captain|of War";
		l_RankNumber.Caption="3";
		l_RankProgress.Caption=((108000-totalscore)$" Score|needed for next rank");
		pb_Rank.High = 36000;
		pb_Rank.Value = totalscore - 84000;
	}
		
	else if (totalscore >= 48000)
	{
		i_Rank1.Image = Texture'DA2GUI.Misc.Captain';
		l_RankName.Caption="Alliance Captain|Senior";
		l_RankNumber.Caption="2";
		l_RankProgress.Caption=((84000-totalscore)$" Score|needed for next rank");
		pb_Rank.High = 36000;
		pb_Rank.Value = totalscore - 48000;
	}
		
	else if (totalscore >= 36000)
	{
		i_Rank1.Image = Texture'DA2GUI.Misc.Captain';
		l_RankName.Caption="Alliance Captain|Junior";
		l_RankNumber.Caption="1";
		l_RankProgress.Caption=((48000-totalscore)$" Score|needed for next rank");
		pb_Rank.High = 12000;
		pb_Rank.Value = totalscore - 36000;
	}
		
	else if (totalscore >= 24000)
	{
		i_Rank1.Image = Texture'DA2GUI.Misc.Private';
		l_RankName.Caption="Advanced Gunner|Bombadier";
		l_RankNumber.Caption="3";
		l_RankProgress.Caption=((36000-totalscore)$" Score|needed for next rank");
		pb_Rank.High = 12000;
		pb_Rank.Value = totalscore - 24000;
	}
		
	else if (totalscore >= 12000)
	{
		i_Rank1.Image = Texture'DA2GUI.Misc.Private';
		l_RankName.Caption="Advanced Gunner|Regular Arms";
		l_RankNumber.Caption="2";
		l_RankProgress.Caption=((24000-totalscore)$" Score|needed for next rank");
		pb_Rank.High = 12000;
		pb_Rank.Value = totalscore - 12000;
	}
		
	else
	{
		i_Rank1.Image = Texture'DA2GUI.Misc.Private';
		l_RankName.Caption="Advanced Gunner|Recruit";
		l_RankNumber.Caption="1";
		l_RankProgress.Caption=((12000-totalscore)$" Score|needed for next rank");
		pb_Rank.High = 12000;
		pb_Rank.Value = totalscore;
	}
}

//===============================================================================
function SetupAchievements()
{
	i_bgClass3.WinTop = i_bgClass2.Wintop + 0.055;
	i_bgClass4.WinTop = i_bgClass3.Wintop + 0.055;
	i_bgClass5.WinTop = i_bgClass4.Wintop + 0.055;
	i_bgClass6.WinTop = i_bgClass5.Wintop + 0.055;
	
	i_FireBullet.Image = Texture'DA2GUI.Misc.FireBullet';
	i_firebullet.wintop = i_bgClass2.Wintop;
	i_Grenade.Image = Texture'DA2GUI.Misc.NuclearGrenade';
	i_grenade.wintop = i_bgClass3.Wintop;
	i_Sniper.Image = Texture'DA2GUI.Misc.Sniper';
	i_sniper.wintop = i_bgClass4.Wintop;
	i_Rocket.Image = Texture'DA2GUI.Misc.NuclearRocket';
	i_rocket.wintop = i_bgClass5.Wintop;
	i_Ammo.Image = Texture'DA2GUI.Misc.Ammo';
	i_ammo.wintop = i_bgClass6.WinTop;
	
	pb_firebullet.wintop = 0.613;
	if (huskkills < 250)
	{
		pb_firebullet.High = 250;
		pb_firebullet.Value = huskkills;
		i_locked1.Image=Texture'DA2GUI.Misc.locked';
	}
	else
	{
		pb_firebullet.High = 250;
		pb_firebullet.Value = 250;
		i_locked1.Image=Texture'DA2GUI.Misc.unlocked';
	}
	
	pb_grenade.wintop = pb_firebullet.wintop + 0.055;
	if (grenadekills < 1000)
	{
		pb_grenade.High = 1000;
		pb_grenade.Value = grenadekills;
		i_locked2.Image=Texture'DA2GUI.Misc.locked';
	}
	else
	{
		pb_grenade.High = 1000;
		pb_grenade.Value = 1000;
		i_locked2.Image=Texture'DA2GUI.Misc.unlocked';
	}
		
	pb_sniper.wintop = pb_grenade.wintop + 0.055;
	if (sniperriflekills < 500)
	{
		pb_sniper.High = 500;
		pb_sniper.Value = sniperriflekills;
		i_locked3.Image=Texture'DA2GUI.Misc.locked';
	}
	else if (sniperriflekills < 2000)
	{
		pb_sniper.High = 2000;
		pb_sniper.Value = sniperriflekills - 500;
		i_locked3.Image=Texture'DA2GUI.Misc.locked';
	}	
	else 
	{
		pb_sniper.High = 2000;
		pb_sniper.Value = 2000;
		i_locked3.Image=Texture'DA2GUI.Misc.unlocked';
	}		
	
	pb_rocket.wintop = pb_sniper.wintop + 0.055;
	if (rocketkills < 2000)
	{
		pb_rocket.High = 2000;
		pb_rocket.Value = rocketkills;
		i_locked4.Image=Texture'DA2GUI.Misc.locked';
	}
	else
	{
		pb_rocket.High = 2000;
		pb_rocket.Value = 2000;
		i_locked4.Image=Texture'DA2GUI.Misc.unlocked';
	}
	
	pb_ammo.wintop = pb_rocket.wintop + 0.055;
	if (rocketkills < 100)
	{
		pb_ammo.High = 100;
		pb_ammo.Value = ammoboxuses;
		i_locked5.Image=Texture'DA2GUI.Misc.locked';
	}
	else
	{
		pb_ammo.High = 2000;
		pb_ammo.Value = 2000;
		i_locked5.Image=Texture'DA2GUI.Misc.unlocked';
	}
	
	i_locked2.wintop = i_locked1.wintop + 0.055;
	i_locked3.wintop = i_locked2.wintop + 0.055;
	i_locked4.wintop = i_locked3.wintop + 0.055;
	i_locked5.wintop = i_locked4.wintop + 0.055;
	
	l_AchievementProgress1.Caption = ((250-huskkills)$" Husk kills|needed");
	l_AchievementProgress2.Caption = ((1000-grenadekills)$" Frag grenade kills|needed");
	
	if (sniperriflekills >= 500)
		l_AchievementProgress3.Caption = ((2500-sniperriflekills)$" Sniper rifle kills|needed");
	else
		l_AchievementProgress3.Caption = ((500-sniperriflekills)$" Sniper rifle kills|needed");
	
	l_AchievementProgress4.Caption = ((2000-rocketkills)$" Rocket kills|needed");
	l_AchievementProgress5.Caption = ((100-ammoboxuses)$" Ammobox uses|needed");
	
	l_AchievementProgress2.wintop = l_AchievementProgress1.wintop + 0.055;
	l_AchievementProgress3.wintop = l_AchievementProgress2.wintop + 0.055;
	l_AchievementProgress4.wintop = l_AchievementProgress3.wintop + 0.055;
	l_AchievementProgress5.wintop = l_AchievementProgress4.wintop + 0.055;
	
	l_AchievementAward1.Caption = "Unlock incendiary bullets";
	l_AchievementAward2.Caption = "Unlock nuclear grenades";
	
	if (sniperriflekills >= 500)
		l_AchievementAward3.Caption = "Unlock sniper upgrade 2|+35% rate of fire";
	else
		l_AchievementAward3.Caption = "Unlock sniper upgrade 1|+17.5% rate of fire";
	
	l_AchievementAward4.Caption = "Unlock nuclear rockets";
	l_AchievementAward5.Caption = "Unlock ammobox upgrade|Refill +25% additional ammo";
	
	l_AchievementAward2.wintop = l_AchievementAward1.wintop + 0.055;
	l_AchievementAward3.wintop = l_AchievementAward2.wintop + 0.055;
	l_AchievementAward4.wintop = l_AchievementAward3.wintop + 0.055;
	l_AchievementAward5.wintop = l_AchievementAward4.wintop + 0.055;
}

//===============================================================================
//===============================================================================
//===============================================================================
//===============================================================================
//===============================================================================
//===============================================================================

defaultproperties
{
     Begin Object Class=da_GUI_SectionBackground Name=InternalFrameImage1
         Caption="Statistics"
         WinTop=0.090000
         WinLeft=0.010000
         WinWidth=0.980000
         WinHeight=0.328000
         RenderWeight=0.020000
         OnPreDraw=InternalFrameImage1.InternalPreDraw
     End Object
     sb_Stats=da_GUI_SectionBackground'DA2.da_GUI_Achievements.InternalFrameImage1'

     Begin Object Class=da_GUI_SectionBackground Name=InternalFrameImage2
         Caption="Achievements"
         WinTop=0.428000
         WinLeft=0.010000
         WinWidth=0.980000
         WinHeight=0.480000
         RenderWeight=0.020000
         OnPreDraw=InternalFrameImage2.InternalPreDraw
     End Object
     sb_Achievements=da_GUI_SectionBackground'DA2.da_GUI_Achievements.InternalFrameImage2'

     Begin Object Class=da_GUI_AltSectionBackground Name=InternalFrameImageClasses
         WinTop=0.124000
         WinLeft=0.014125
         WinWidth=0.640000
         WinHeight=0.135000
         OnPreDraw=InternalFrameImageClasses.InternalPreDraw
     End Object
     sb_classes=da_GUI_AltSectionBackground'DA2.da_GUI_Achievements.InternalFrameImageClasses'

     Begin Object Class=da_GUI_AltSectionBackground Name=InternalFrameImageWeapons
         WinTop=0.265000
         WinLeft=0.014125
         WinWidth=0.971000
         WinHeight=0.145000
         OnPreDraw=InternalFrameImageWeapons.InternalPreDraw
     End Object
     sb_weapons=da_GUI_AltSectionBackground'DA2.da_GUI_Achievements.InternalFrameImageWeapons'

     Begin Object Class=da_GUI_AltSectionBackground Name=InternalFrameImageOther
         WinTop=0.124000
         WinLeft=0.657900
         WinWidth=0.327000
         WinHeight=0.135000
         OnPreDraw=InternalFrameImageOther.InternalPreDraw
     End Object
     sb_other=da_GUI_AltSectionBackground'DA2.da_GUI_Achievements.InternalFrameImageOther'

     Begin Object Class=da_GUI_AltSectionBackground Name=InternalFrameImageRank
         WinTop=0.461964
         WinLeft=0.014125
         WinWidth=0.971000
         WinHeight=0.100000
         OnPreDraw=InternalFrameImageRank.InternalPreDraw
     End Object
     sb_rank=da_GUI_AltSectionBackground'DA2.da_GUI_Achievements.InternalFrameImageRank'

     Begin Object Class=da_GUI_AltSectionBackground Name=InternalFrameImageUnlocks
         WinTop=0.568148
         WinLeft=0.014125
         WinWidth=0.971000
         WinHeight=0.330000
         OnPreDraw=InternalFrameImageUnlocks.InternalPreDraw
     End Object
     sb_unlocks=da_GUI_AltSectionBackground'DA2.da_GUI_Achievements.InternalFrameImageUnlocks'

     Begin Object Class=GUILabel Name=Classes
         Caption="RIFLEMAN"
         TextAlign=TXTA_Center
         StyleName="DA2Style_DialogText"
         WinTop=0.150000
         WinLeft=0.014125
         WinWidth=0.100000
         WinHeight=0.039000
         RenderWeight=0.300000
     End Object
     l_rifleman=GUILabel'DA2.da_GUI_Achievements.Classes'

     Begin Object Class=GUILabel Name=scorings
         Caption="Score: "
         TextAlign=TXTA_Center
         StyleName="DA2Style_BodyText"
         WinTop=0.181000
         WinLeft=0.014125
         WinWidth=0.100000
         WinHeight=0.039000
         RenderWeight=0.300000
     End Object
     l_score1=GUILabel'DA2.da_GUI_Achievements.scorings'

     Begin Object Class=GUILabel Name=Kills
         Caption="Kills: "
         TextAlign=TXTA_Center
         StyleName="DA2Style_BodyText"
         WinTop=0.205000
         WinLeft=0.014125
         WinWidth=0.100000
         WinHeight=0.039000
         RenderWeight=0.300000
     End Object
     l_kills1=GUILabel'DA2.da_GUI_Achievements.Kills'

     l_mechanic=GUILabel'DA2.da_GUI_Achievements.Classes'

     l_score2=GUILabel'DA2.da_GUI_Achievements.scorings'

     l_kills2=GUILabel'DA2.da_GUI_Achievements.Kills'

     l_medic=GUILabel'DA2.da_GUI_Achievements.Classes'

     l_score3=GUILabel'DA2.da_GUI_Achievements.scorings'

     l_kills3=GUILabel'DA2.da_GUI_Achievements.Kills'

     l_mg=GUILabel'DA2.da_GUI_Achievements.Classes'

     l_score4=GUILabel'DA2.da_GUI_Achievements.scorings'

     l_kills4=GUILabel'DA2.da_GUI_Achievements.Kills'

     l_sniper=GUILabel'DA2.da_GUI_Achievements.Classes'

     l_score5=GUILabel'DA2.da_GUI_Achievements.scorings'

     l_kills5=GUILabel'DA2.da_GUI_Achievements.Kills'

     l_rocketeer=GUILabel'DA2.da_GUI_Achievements.Classes'

     l_score6=GUILabel'DA2.da_GUI_Achievements.scorings'

     l_kills6=GUILabel'DA2.da_GUI_Achievements.Kills'

     l_engineer=GUILabel'DA2.da_GUI_Achievements.Classes'

     l_score7=GUILabel'DA2.da_GUI_Achievements.scorings'

     l_kills7=GUILabel'DA2.da_GUI_Achievements.Kills'

     Begin Object Class=GUILabel Name=lweapons
         TextAlign=TXTA_Center
         bMultiLine=True
         StyleName="DA2Style_BodyText"
         WinTop=0.340741
         WinLeft=0.010000
         WinWidth=0.098000
         WinHeight=0.100000
         RenderWeight=0.300000
     End Object
     l_weapon1=GUILabel'DA2.da_GUI_Achievements.lweapons'

     l_weapon2=GUILabel'DA2.da_GUI_Achievements.lweapons'

     l_weapon3=GUILabel'DA2.da_GUI_Achievements.lweapons'

     l_weapon4=GUILabel'DA2.da_GUI_Achievements.lweapons'

     l_weapon5=GUILabel'DA2.da_GUI_Achievements.lweapons'

     l_weapon6=GUILabel'DA2.da_GUI_Achievements.lweapons'

     l_weapon7=GUILabel'DA2.da_GUI_Achievements.lweapons'

     l_weapon8=GUILabel'DA2.da_GUI_Achievements.lweapons'

     l_weapon9=GUILabel'DA2.da_GUI_Achievements.lweapons'

     Begin Object Class=GUILabel Name=lother1
         bMultiLine=True
         StyleName="DA2Style_BodyText"
         WinTop=0.149119
         WinLeft=0.675000
         WinWidth=0.160000
         WinHeight=0.200000
         RenderWeight=0.300000
     End Object
     l_other1=GUILabel'DA2.da_GUI_Achievements.lother1'

     Begin Object Class=GUILabel Name=lother2
         bMultiLine=True
         StyleName="DA2Style_BodyText"
         WinTop=0.149119
         WinLeft=0.829100
         WinWidth=0.160000
         WinHeight=0.200000
         RenderWeight=0.300000
     End Object
     l_other2=GUILabel'DA2.da_GUI_Achievements.lother2'

     Begin Object Class=GUILabel Name=RankProgress
         TextAlign=TXTA_Center
         bMultiLine=True
         VertAlign=TXTA_Center
         StyleName="DA2Style_BodyTextBig"
         WinTop=0.461964
         WinLeft=0.638020
         WinWidth=0.125000
         WinHeight=0.100000
         RenderWeight=0.300000
     End Object
     l_RankProgress=GUILabel'DA2.da_GUI_Achievements.RankProgress'

     Begin Object Class=GUILabel Name=RankNumber
         bMultiLine=True
         StyleName="DA2Style_DialogText"
         WinTop=0.461964
         WinLeft=0.845634
         WinWidth=0.050000
         WinHeight=0.100000
         RenderWeight=0.500000
     End Object
     l_ranknumber=GUILabel'DA2.da_GUI_Achievements.RankNumber'

     Begin Object Class=GUILabel Name=RankName
         TextAlign=TXTA_Center
         bMultiLine=True
         VertAlign=TXTA_Center
         StyleName="DA2Style_BodyText"
         WinTop=0.461964
         WinLeft=0.850000
         WinWidth=0.110000
         WinHeight=0.100000
         RenderWeight=0.500000
     End Object
     l_RankName=GUILabel'DA2.da_GUI_Achievements.RankName'

     Begin Object Class=GUILabel Name=AchievementProgress
         TextAlign=TXTA_Center
         bMultiLine=True
         VertAlign=TXTA_Center
         StyleName="DA2Style_BodyText"
         WinTop=0.600000
         WinLeft=0.638020
         WinWidth=0.125000
         WinHeight=0.045000
     End Object
     l_AchievementProgress1=GUILabel'DA2.da_GUI_Achievements.AchievementProgress'

     l_AchievementProgress2=GUILabel'DA2.da_GUI_Achievements.AchievementProgress'

     l_AchievementProgress3=GUILabel'DA2.da_GUI_Achievements.AchievementProgress'

     l_AchievementProgress4=GUILabel'DA2.da_GUI_Achievements.AchievementProgress'

     l_AchievementProgress5=GUILabel'DA2.da_GUI_Achievements.AchievementProgress'

     Begin Object Class=GUILabel Name=AchievementAward
         TextAlign=TXTA_Center
         bMultiLine=True
         VertAlign=TXTA_Center
         StyleName="DA2Style_BodyText"
         WinTop=0.600000
         WinLeft=0.815000
         WinWidth=0.125000
         WinHeight=0.045000
     End Object
     l_AchievementAward1=GUILabel'DA2.da_GUI_Achievements.AchievementAward'

     l_AchievementAward2=GUILabel'DA2.da_GUI_Achievements.AchievementAward'

     l_AchievementAward3=GUILabel'DA2.da_GUI_Achievements.AchievementAward'

     l_AchievementAward4=GUILabel'DA2.da_GUI_Achievements.AchievementAward'

     l_AchievementAward5=GUILabel'DA2.da_GUI_Achievements.AchievementAward'

     Begin Object Class=GUIImage Name=Weapons
         ImageStyle=ISTY_Scaled
         ImageRenderStyle=MSTY_Normal
         WinTop=0.282000
         WinLeft=0.010000
         WinWidth=0.098000
         WinHeight=0.088000
         RenderWeight=0.400000
     End Object
     i_weapon1=GUIImage'DA2.da_GUI_Achievements.Weapons'

     i_weapon2=GUIImage'DA2.da_GUI_Achievements.Weapons'

     i_weapon3=GUIImage'DA2.da_GUI_Achievements.Weapons'

     i_weapon4=GUIImage'DA2.da_GUI_Achievements.Weapons'

     i_weapon5=GUIImage'DA2.da_GUI_Achievements.Weapons'

     i_weapon6=GUIImage'DA2.da_GUI_Achievements.Weapons'

     i_weapon7=GUIImage'DA2.da_GUI_Achievements.Weapons'

     i_weapon8=GUIImage'DA2.da_GUI_Achievements.Weapons'

     i_weapon9=GUIImage'DA2.da_GUI_Achievements.Weapons'

     Begin Object Class=GUIImage Name=Ranks
         ImageStyle=ISTY_Scaled
         ImageRenderStyle=MSTY_Normal
         WinTop=0.461964
         WinLeft=0.791875
         WinWidth=0.059000
         WinHeight=0.100000
         RenderWeight=0.500000
     End Object
     i_Rank1=GUIImage'DA2.da_GUI_Achievements.Ranks'

     Begin Object Class=GUIImage Name=BGClass1
         Image=Texture'DA2GUI.Dialog.htab_tab_l'
         ImageStyle=ISTY_Stretched
         ImageRenderStyle=MSTY_Normal
         WinTop=0.461964
         WinLeft=0.780000
         WinWidth=0.180000
         WinHeight=0.100000
         RenderWeight=0.300000
     End Object
     i_bgClass1=GUIImage'DA2.da_GUI_Achievements.BGClass1'

     Begin Object Class=GUIImage Name=locked1
         ImageStyle=ISTY_Scaled
         ImageRenderStyle=MSTY_Normal
         WinTop=0.606000
         WinLeft=0.034000
         WinWidth=0.020000
         WinHeight=0.034000
         RenderWeight=0.500000
     End Object
     i_locked1=GUIImage'DA2.da_GUI_Achievements.locked1'

     i_locked2=GUIImage'DA2.da_GUI_Achievements.locked1'

     i_locked3=GUIImage'DA2.da_GUI_Achievements.locked1'

     i_locked4=GUIImage'DA2.da_GUI_Achievements.locked1'

     i_locked5=GUIImage'DA2.da_GUI_Achievements.locked1'

     Begin Object Class=GUIImage Name=AchievementImage
         ImageStyle=ISTY_Scaled
         ImageRenderStyle=MSTY_Additive
         WinTop=0.600000
         WinLeft=0.790000
         WinWidth=0.026000
         WinHeight=0.045000
         RenderWeight=0.700000
     End Object
     i_firebullet=GUIImage'DA2.da_GUI_Achievements.AchievementImage'

     i_grenade=GUIImage'DA2.da_GUI_Achievements.AchievementImage'

     i_sniper=GUIImage'DA2.da_GUI_Achievements.AchievementImage'

     i_rocket=GUIImage'DA2.da_GUI_Achievements.AchievementImage'

     i_ammo=GUIImage'DA2.da_GUI_Achievements.AchievementImage'

     Begin Object Class=GUIImage Name=BGClass11
         Image=Texture'DA2GUI.Dialog.htab_tab_l'
         ImageStyle=ISTY_Stretched
         ImageRenderStyle=MSTY_Normal
         WinTop=0.600000
         WinLeft=0.020000
         WinWidth=0.960000
         WinHeight=0.045000
         RenderWeight=0.300000
     End Object
     i_bgClass2=GUIImage'DA2.da_GUI_Achievements.BGClass11'

     i_bgClass3=GUIImage'DA2.da_GUI_Achievements.BGClass11'

     i_bgClass4=GUIImage'DA2.da_GUI_Achievements.BGClass11'

     i_bgClass5=GUIImage'DA2.da_GUI_Achievements.BGClass11'

     i_bgClass6=GUIImage'DA2.da_GUI_Achievements.BGClass11'

     Begin Object Class=da_GUI_ProgressBar Name=ProgressBarBig
         CaptionWidth=0.000000
         ValueRightWidth=0.000000
         bShowValue=False
         WinTop=0.497154
         WinLeft=0.030000
         WinWidth=0.600000
         WinHeight=0.030000
     End Object
     pb_Rank=da_GUI_ProgressBar'DA2.da_GUI_Achievements.ProgressBarBig'

     Begin Object Class=da_GUI_ProgressBar Name=ProgressBar
         CaptionWidth=0.000000
         ValueRightWidth=0.000000
         bShowValue=False
         WinLeft=0.067707
         WinWidth=0.562000
         WinHeight=0.020000
     End Object
     pb_firebullet=da_GUI_ProgressBar'DA2.da_GUI_Achievements.ProgressBar'

     pb_grenade=da_GUI_ProgressBar'DA2.da_GUI_Achievements.ProgressBar'

     pb_sniper=da_GUI_ProgressBar'DA2.da_GUI_Achievements.ProgressBar'

     pb_rocket=da_GUI_ProgressBar'DA2.da_GUI_Achievements.ProgressBar'

     pb_ammo=da_GUI_ProgressBar'DA2.da_GUI_Achievements.ProgressBar'

     Begin Object Class=da_GUI_TabControl Name=PageTabs
         WinHeight=0.000000
         OnActivate=PageTabs.InternalOnActivate
     End Object
     c_Tabs=da_GUI_TabControl'DA2.da_GUI_Achievements.PageTabs'

     Begin Object Class=da_GUI_Header Name=Header
         Caption="Stats and Achievements"
     End Object
     t_Header=da_GUI_Header'DA2.da_GUI_Achievements.Header'

     Begin Object Class=da_GUI_Achievements_Footer Name=Footer
         RenderWeight=0.300000
         TabOrder=4
         OnPreDraw=Footer.InternalOnPreDraw
     End Object
     t_Footer=da_GUI_Achievements_Footer'DA2.da_GUI_Achievements.Footer'

     Begin Object Class=BackgroundImage Name=PageBackground
         Image=Texture'DA2GUI.Dialog.window_1024x768'
         RenderWeight=0.010000
     End Object
     i_Background=BackgroundImage'DA2.da_GUI_Achievements.PageBackground'

     OnPreDraw=da_GUI_Achievements.InternalOnPreDraw
}
