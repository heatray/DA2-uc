//-----------------------------------------------------------
//
//-----------------------------------------------------------
class da_weapons_rifles_SniperRifle_SR extends da_weapons_rifles_SniperRifle;

var bool playAMIsound;

simulated function firedShot() {
    local rotator rot;
    local vector ShakeMag;
    local da_players_playercontroller PC;
	
    if(instigator.Controller.IsA('da_players_PlayerController'))
        PC=da_players_PlayerController(Instigator.Controller);
    else return;  
	
	instigator=pc.Pawn;

  if(instigator==none || PC!=level.getLocalPlayerController())
    return;

    UpdateRecoil(true);
    ShakeMag=FireMode[0].ShakeOffsetMag;
    shakemag=FireMode[0].default.ShakeOffsetMag*RecoilFactor;

    rot=pc.rotation;
    if(rot.pitch>0 && rot.pitch<16380) rot.pitch=fmin(16380,rot.pitch-(shakemag.x*frand()*15)+shakemag.x*3);
    else if(rot.pitch>49160 && rot.pitch<65536) rot.pitch=fmax(49160,rot.pitch-(shakemag.x*frand()*15)+shakemag.x*3);
    rot.yaw+=(shakemag.y*frand()*12)-shakemag.y*4;

    pc.setrotation(rot);
	
if (Instigator.Owner != none && Owner != none)
{
	if (da_SteamStatsAndAchievements(da_Players_PlayerController(Instigator.Owner).SteamStatsAndAchievements).Sniper1Completed) {
		RecoilRegenPerSec = 4.2;
		RecoilAddPerSec = 5.200000; }
	else if (da_SteamStatsAndAchievements(da_Players_PlayerController(Instigator.Owner).SteamStatsAndAchievements).Sniper2Completed) { 
		RecoilRegenPerSec = 4.9;
		RecoilAddPerSec = 4.800000; }
	else {
		RecoilRegenPerSec = 3.5;
		RecoilAddPerSec = 5.900000; }
		
	if(!hasAmmo()) da_players_PlayerController(Instigator.Owner).AMIAnnouncement(Sound'AMISounds.player.AmmoDepleted'); 

	if (hasLowAmmo() && playAMIsound) { da_players_PlayerController(Instigator.Owner).AMIAnnouncement(Sound'AMISounds.player.AmmoLow'); playAMIsound = false; }
	else if (!hasLowAmmo()  && !playAMIsound) playAMIsound = true;
}

    //USE for DEBUG
  //instigator.ClientMessage(recoil);
}

defaultproperties
{
     MeleeDamage(0)=175
     FireModeClass(0)=Class'DA2.da_weapons_SniperFireNew'
     MinReloadPct=0.250000
     AttachmentClass=Class'DA2.da_weapons_SniperAttachment_SR'
}
