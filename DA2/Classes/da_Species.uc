// ============================================================================
//  DA2.da_Species: Used to define attributes for each DATeam player class in DA2
//  By: aBsOlUt, Dante
// ============================================================================
class da_Species extends SpeciesType
	abstract;

#EXEC OBJ LOAD FILE=DA2_PlayerModels.ukx

static function SetTeamSkin(xPawn P, xUtil.PlayerRecord rec, int TeamNum) {
    local da_players_ClassPlayer cp;
    local OpacityModifier opm;
	local FinalBlend fb;
    local int i;

    super.setTeamSkin(P, rec, teamnum);
    cp = da_players_ClassPlayer(p);
    if (cp != none && cp.resolveClassInfo() != none) {
/*        log("Successfully retrieved playerclass:"@P);
        if (cp.PlayerReplicationInfo != none)
                log(cp.PlayerReplicationInfo.PlayerName);
*/
        if (cp.resolveClassInfo().bStealth) {
			cp.bAcceptsProjectors=false;
            cp.Visibility = 64;
            for (i = 0; i < cp.skins.length; i++) {
                if (cp.skins[i].isa('Shader')) {
					fb = new class'FinalBlend';
					fb.zWrite = true;
					fb.FrameBufferBlending=FB_AlphaBlend;
                    opm = new class'OpacityModifier';
                    opm.Material = cp.skins[i];
                    opm.Opacity = new class'ConstantColor';
					fb.material = opm;
                    cp.skins[i] = fb;
                }
            }
        }
    }
}

// Overridden to not force the juggvoice ever
static function LoadResources( xUtil.PlayerRecord rec, LevelInfo Level, PlayerReplicationInfo PRI, int TeamNum )
{
	local string BodySkinName, VoiceType, SkelName, FaceSkinName;
	local Material NewBodySkin, NewFaceSkin, TeamFaceSkin;
	local class<VoicePack> VoiceClass;
	// if _RO_
	//local class<xPawnGibGroup> GibGroupClass;
	local mesh customskel;

	if ( (Level.NetMode != NM_DedicatedServer) && class'DeathMatch'.default.bForceDefaultCharacter )
		return;
    DynamicLoadObject(rec.MeshName,class'Mesh');

	if ( (Level.NetMode != NM_DedicatedServer) && (rec.Skeleton != "") )
		customskel = mesh(DynamicLoadObject(rec.Skeleton,class'Mesh'));

//	if ( rec.Sex ~= "Female" )
//	{
//		SkelName = Default.FemaleSkeleton;
//		if ( Level.bLowSoundDetail )
//			DynamicLoadObject("XGame.xJuggFemaleSoundGroup", class'Class');
//		else
//			DynamicLoadObject(Default.FemaleSoundGroup, class'Class');
//	}
//	else
//	{
		SkelName = Default.MaleSkeleton;
//		if ( Level.bLowSoundDetail )
//			DynamicLoadObject("XGame.xJuggMaleSoundGroup", class'Class');
//		else
			DynamicLoadObject(Default.MaleSoundGroup, class'Class');
//	}
	if ( Level.NetMode == NM_DedicatedServer )
	{
//        if ( rec.Sex ~= "Female" )
//			VoiceClass = class<VoicePack>(DynamicLoadObject("XGame.JuggFemaleVoice",class'Class'));
//		else
			VoiceClass = class<VoicePack>(DynamicLoadObject(Default.MaleVoice,class'Class'));
		if ( PRI != None )
		{
        	PRI.VoiceType = VoiceClass;
		}
		return;
	}

	if ( !Level.bLowSoundDetail && (rec.VoiceClassName != "") )
	{
		VoiceType = rec.VoiceClassName;
		VoiceClass = class<VoicePack>(DynamicLoadObject(VoiceType,class'Class'));
	}
	if ( VoiceClass == None )
	{
		VoiceType = GetVoiceType(rec.Sex ~= "Female", Level);
		class<VoicePack>(DynamicLoadObject(VoiceType,class'Class'));
	}

	if ( (CustomSkel == None) && (SkelName != "") )
		DynamicLoadObject(SkelName,class'Mesh');

	NewFaceSkin = Material(DynamicLoadObject(rec.FaceSkinName, class'Material'));

	if ( (TeamNum == 255) && (Level.GRI != None) && Level.GRI.bForceTeamSkins )
		TeamNum = Default.DMTeam;
	if ( (TeamNum != 255) && ((Level.GRI == None) || !Level.GRI.bNoTeamSkins) )
	{
		if ( class'DMMutator'.Default.bBrightSkins && (Left(rec.BodySkinName,12) ~= "PlayerSkins.") )
		{
			BodySkinName = "Bright"$rec.BodySkinName$"_"$TeamNum$"B";
			NewBodySkin = Material(DynamicLoadObject(BodySkinName, class'Material',true));
		}
		if ( NewBodySkin == None )
		{
			BodySkinName = rec.BodySkinName$"_"$TeamNum;
			NewBodySkin = Material(DynamicLoadObject(BodySkinName, class'Material'));

			// allow team head skins with new skins
			if ( rec.TeamFace )
			{
				FaceSkinName = rec.FaceSkinName$"_"$TeamNum;
				TeamFaceSkin = Material(DynamicLoadObject(FaceSkinName, class'Material'));
				if ( TeamFaceSkin != None )
					NewFaceSkin = TeamFaceSkin;
			}
		}
		if ( NewBodySkin == None )
		{
			log("TeamSkin not found "$NewBodySkin);
			NewBodySkin = Material(DynamicLoadObject(rec.BodySkinName, class'Material'));
		}
	}
	else
		NewBodySkin = Material(DynamicLoadObject(rec.BodySkinName, class'Material'));

	// Xan hack
	if ( Rec.BodySkinName ~= "UT2004PlayerSkins.XanMk3V2_Body" )
		DynamicLoadObject("UT2004PlayerSkins.XanMk3V2_abdomen", class'Material');

	Level.AddPrecacheMaterial(NewBodySkin);
	Level.AddPrecacheMaterial(NewFaceSkin);
	Level.AddPrecacheMaterial(rec.Portrait);
	// if _RO_
	//GibGroupClass = class<xPawnGibGroup>(DynamicLoadObject(Default.GibGroup, class'Class'));
	//GibGroupClass.static.PrecacheContent(Level);
}

// Overridden to not force the juggvoice ever
static function bool Setup(Pawn P, xUtil.PlayerRecord rec)
{
	local mesh NewMesh, customskel;
	local string VoiceType, SkelName;
	local class<VoicePack> VoiceClass;
	local int TeamNum, i,j;
	local XPawn XP;

	// Cast the pawn to an XPawn
	XP = XPawn(P);

	if ( XP == none )
	{
		log("SpeciesType setup error.");
		return false;
	}

	if ( XP.bAlreadySetup )
	{
		// make sure correct teamskin
		if ( XP.Level.NetMode == NM_Client )
		{
			if ( (XP.PlayerReplicationInfo != None) && (XP.PlayerReplicationInfo.Team != None) )
				TeamNum = XP.PlayerReplicationInfo.Team.TeamIndex;
			else if ( (XP.DrivenVehicle != None) && (XP.DrivenVehicle.PlayerReplicationInfo != None) && (XP.DrivenVehicle.PlayerReplicationInfo.Team != None) )
				TeamNum = XP.DrivenVehicle.PlayerReplicationInfo.Team.TeamIndex;
			if ( XP.TeamSkin == TeamNum )
				return true;

			SetTeamSkin(XP,rec,TeamNum);
		}
		return true;
	}
    NewMesh = Mesh(DynamicLoadObject(rec.MeshName,class'Mesh'));
    if ( NewMesh == None )
    {
		log("Failed to load player mesh "$rec.MeshName);
		return false;
	}

	XP.bAlreadySetup = true;
	XP.LinkMesh(NewMesh);
	XP.AssignInitialPose();

	XP.bIsFemale = ( rec.Sex ~= "Female" );
	if ( XP.PlayerReplicationInfo != None )
		XP.PlayerReplicationInfo.bIsFemale = XP.bIsFemale;
	if ( (XP.Level.NetMode != NM_DedicatedServer) && (rec.Skeleton != "") )
		customskel = mesh(DynamicLoadObject(rec.Skeleton,class'Mesh'));

	if ( XP.bIsFemale )
	{
		SkelName = Default.FemaleSkeleton;
		if ( XP.Level.bLowSoundDetail )
			XP.SoundGroupClass = class<xPawnSoundGroup>(DynamicLoadObject("XGame.xJuggFemaleSoundGroup", class'Class'));
		else
			XP.SoundGroupClass = class<xPawnSoundGroup>(DynamicLoadObject(Default.FemaleSoundGroup, class'Class'));
	}
	else
	{
		SkelName = Default.MaleSkeleton;
		if ( XP.Level.bLowSoundDetail )
			XP.SoundGroupClass = class<xPawnSoundGroup>(DynamicLoadObject("XGame.xJuggMaleSoundGroup", class'Class'));
		else
			XP.SoundGroupClass = class<xPawnSoundGroup>(DynamicLoadObject(Default.MaleSoundGroup, class'Class'));
	}

	if ( XP.Level.NetMode != NM_DedicatedServer )
	{
		if ( CustomSkel != None )
			XP.SkeletonMesh = CustomSkel;
		else if ( SkelName != "" )
			XP.SkeletonMesh = mesh(DynamicLoadObject(SkelName,class'Mesh'));

		TeamNum = 255;
		if ( (XP.PlayerReplicationInfo != None) && (XP.PlayerReplicationInfo.Team != None) )
			TeamNum = XP.PlayerReplicationInfo.Team.TeamIndex;
		else if ( (XP.DrivenVehicle != None) && (XP.DrivenVehicle.PlayerReplicationInfo != None) && (XP.DrivenVehicle.PlayerReplicationInfo.Team != None) )
			TeamNum = XP.DrivenVehicle.PlayerReplicationInfo.Team.TeamIndex;
		else if ( (XP.Level.GRI != None) && XP.Level.GRI.bForceTeamSkins )
			TeamNum = Default.DMTeam;

		SetTeamSkin(XP,rec,TeamNum);

		if ( rec.UseSpecular && (XP.Level.DetailMode!=DM_Low) )
		{
			// ifndef _RO_
			//XP.HighDetailOverlay = Material'UT2004Weapons.WeaponShader';
			// Xan hack
			if ( Rec.BodySkinName ~= "UT2004PlayerSkins.XanMk3V2_Body" )
				XP.Skins[2] = Material(DynamicLoadObject("UT2004PlayerSkins.XanMk3V2_abdomen", class'Material'));
		}
	}
	// if _RO_
	//XP.GibGroupClass = class<xPawnGibGroup>(DynamicLoadObject(Default.GibGroup, class'Class'));

	if ( XP.Level.NetMode == NM_DedicatedServer )
	{
//		if ( rec.Sex ~= "Female" )
//			VoiceType = "XGame.JuggFemaleVoice";
//		else
//		{
        	VoiceType = Default.MaleVoice;
//		}
		VoiceClass = class<VoicePack>(DynamicLoadObject(VoiceType,class'Class'));
		XP.VoiceType = VoiceType;
		if ( XP.PlayerReplicationInfo != None )
			XP.PlayerReplicationInfo.VoiceType = VoiceClass;
		XP.VoiceClass = class<TeamVoicePack>(VoiceClass);
	}
	else
	{
		if ( !XP.Level.bLowSoundDetail )
		{
			if ( (XP.PlayerReplicationInfo != None) && (XP.PlayerReplicationInfo.VoiceTypeName != "") )
				VoiceType = XP.PlayerReplicationInfo.VoiceTypeName;
			else
				VoiceType = rec.VoiceClassName;
			if ( VoiceType != "" )
				VoiceClass = class<VoicePack>(DynamicLoadObject(VoiceType,class'Class'));
		}
		if ( VoiceClass == None )
		{
			VoiceType = GetVoiceType(XP.bIsFemale, XP.Level);
			VoiceClass = class<VoicePack>(DynamicLoadObject(VoiceType,class'Class'));
		}
		XP.VoiceType = VoiceType;
		if ( XP.PlayerReplicationInfo != None )
			XP.PlayerReplicationInfo.VoiceType = VoiceClass;
		XP.VoiceClass = class<TeamVoicePack>(VoiceClass);
	}

	// add unique taunts
	for ( i=0; i<16; i++ )
		if ( Default.TauntAnims[i] != '' )
		{
			j = XP.TauntAnims.Length;
			XP.TauntAnims[j] = Default.TauntAnims[i];
			XP.TauntAnimNames[j] = Default.TauntAnimNames[i];
			if ( j == 15 )
				break;
		}
	return true;
}

// Overridden to not force the juggvoice ever
static function string GetVoiceType( bool bIsFemale, LevelInfo Level )
{
//	if ( bIsFemale )
//	{
//		if ( Level.bLowSoundDetail )
//			return "XGame.JuggFemaleVoice";
//		else
//			return Default.FemaleVoice;
//	}

	if ( Level.bLowSoundDetail )
	{
    	return Default.MaleVoice;
	}
	else
		return Default.MaleVoice;
}


// ============================================================================

defaultproperties
{
     MaleVoice="DA2.da_Sounds_HumanVoicePack"
     MaleRagSkelName="DA2_Human"
     MaleSkeleton="DA2_PlayerModels.FrontLine"
     PawnClassName="DA2.da_players.ClassPlayer"
     SpeciesName="Generic"
     RaceNum=1
     AirControl=0.000000
     ReceivedDamageScaling=0.700000
     WalkingPct=0.750000
     CrouchedPct=0.500000
     DodgeSpeedFactor=0.900000
     DodgeSpeedZ=0.900000
}
