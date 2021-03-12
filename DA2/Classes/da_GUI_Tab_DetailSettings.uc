class da_GUI_Tab_DetailSettings extends UT2K4Tab_DetailSettings;

var automated moComboBox	    co_GlobalDetails;
var automated moComboBox	    co_ScopeDetail;

var automated moCheckbox        ch_HDR;
var automated moCheckbox        ch_Advanced;
var automated moCheckbox        ch_MotionBlur;
var automated moCheckbox        ch_VSync;
var automated moCheckbox        ch_TripBuff;
var automated moCheckbox        ch_WideScreen;

var() noexport transient int    iGlobalDetails,//, iScopeDetail,
                                iGlobalDetailsD;//, iScopeDetailD;

var() noexport transient bool   bMotionBlur, bMotionBlurD,
                                bHDR, bHDRD,
                                bVSync, bVSyncD,
                                bTripBuff, bTripBuffD,
								bWideScreen, bWideScreenD;

const                           MAX_DETAIL_OPTIONS = 7;
var() localized string          DetailOptions[MAX_DETAIL_OPTIONS];
var() localized string          ScopeLevels[3];

var bool                        bShowPerfWarning;   // Used to disable performance warnings

function bool RenderDeviceClick( byte Btn )
{
	switch ( Btn )
	{
	case QBTN_Yes:
		SaveSettings();
		Console(Controller.Master.Console).DelayedConsoleCommand("relaunch -mod=da2");
		break;

	case QBTN_Cancel:
		sRenDev = sRenDevD;
		co_RenderDevice.Find(sRenDev);
		co_RenderDevice.SetComponentValue(sRenDev,true);
		break;
	}

	return true;
}


function bool InternalOnPreDraw(canvas Canvas)
{
    local bool result;

    result = super.OnPreDraw(canvas);

    if (iGlobalDetails == -1) // We need to pick default settings
    {
        iGlobalDetails = 3;
        co_GlobalDetails.SilentSetIndex(3);
        UpdateGlobalDetails();
    }
	else
	    UpdateGlobalDetailsVisibility();

	return result;
}

/*
function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	Super.InitComponent(MyController, MyOwner);

	RemoveComponent(sl_DistanceLOD);
}*/

function SetupPositions()
{
    sb_Section1.ManageComponent(co_RenderDevice);
    sb_Section1.ManageComponent(co_Resolution);
    sb_Section1.ManageComponent(co_ColorDepth);
    sb_Section1.ManageComponent(ch_Fullscreen);
	sb_Section1.ManageComponent(ch_WideScreen);
	sb_Section1.ManageComponent(ch_VSync);
	sb_Section1.ManageComponent(ch_TripBuff);
    sb_Section1.ManageComponent(sl_Gamma);
    sb_Section1.ManageComponent(sl_Brightness);
    sb_Section1.ManageComponent(sl_Contrast);
    sb_Section1.ManageComponent(co_GlobalDetails);
    sb_Section1.ManageComponent(ch_Advanced);

    sb_Section2.Managecomponent(co_Texture);
    sb_Section2.ManageComponent(co_Char);
    sb_Section2.ManageComponent(co_World);
    sb_Section2.ManageComponent(co_Physics);
    sb_Section2.ManageComponent(co_Decal);
    sb_Section2.ManageComponent(co_Shadows);
    sb_Section2.ManageComponent(co_MeshLOD);
    sb_Section2.ManageComponent(co_MultiSamples);
    sb_Section2.ManageComponent(co_Anisotropy);
    sb_Section2.ManageComponent(ch_ForceFSAAScreenshotSupport);
    sb_Section2.ManageComponent(ch_Decals);
    sb_Section2.ManageComponent(ch_DynLight);
    sb_Section2.ManageComponent(ch_Coronas);
    sb_Section2.ManageComponent(ch_Textures);
    sb_Section2.ManageComponent(ch_Projectors);
    sb_Section2.ManageComponent(ch_DecoLayers);
    sb_Section2.ManageComponent(ch_Trilinear);
    sb_Section2.ManageComponent(ch_Weather);
    //sb_Section2.ManageComponent(co_ScopeDetail);
    sb_Section2.ManageComponent(ch_MotionBlur);
    sb_Section2.Managecomponent(ch_HDR);

    sb_Section3.ManageComponent(i_GammaBar);
    sb_Section2.ManageComponent(sl_DistanceLOD);
}

function InitializeCombos()
{
	local int i;
	local array<GUIListElem> Options;

	for (i = 0; i < Components.Length; i++)
	{
		if (moComboBox(Components[i]) != None)
		{
			MyGetComboOptions( moComboBox(Components[i]), Options );
			moComboBox(Components[i]).MyComboBox.List.Elements = Options;
			moComboBox(Components[i]).MyComboBox.List.ItemCount = Options.Length;
			moComboBox(Components[i]).ReadOnly(True);
		}
	}
}

function MyGetComboOptions(moComboBox Combo, out array<GUIListElem> Ar)
{
	local int i;
	//local string tempStr;

	Ar.Remove(0, Ar.Length);
	if (Combo == None)
		return;

	switch (Combo)
	{
	    case co_GlobalDetails:
            for (i = 0; i < ArrayCount(DetailOptions); i++)
			{
				Ar.Length = Ar.Length + 1;
				Ar[i].Item = DetailOptions[i];
			}
			break;

		case co_ScopeDetail:
			for (i = 0; i < ArrayCount(ScopeLevels); i++)
			{
				Ar.Length = Ar.Length + 1;
				Ar[i].Item = ScopeLevels[i];
			}
			break;
	}

	if (Ar.length == 0)
	    GetComboOptions(Combo, Ar);
}

function InternalOnLoadINI(GUIComponent Sender, string s)
{
    local bool a, b;
    local PlayerController PC;
    local string tempStr;

    PC = PlayerOwner();
    switch (Sender)
    {
        case co_GlobalDetails:
    		iGlobalDetails = class'ROPlayer'.default.GlobalDetailLevel;
    		iGlobalDetailsD = iGlobalDetails;
    		co_GlobalDetails.SilentSetIndex(iGlobalDetails);
            ch_Advanced.SetComponentValue(iGlobalDetailsD == MAX_DETAIL_OPTIONS, true);
    		break;

        /*case co_ScopeDetail:
            switch (class'KFWeapon'.default.KFScopeDetail)
            {
                case KF_ModelScope:
                    iScopeDetail = 0;
                    break;

                case KF_TextureScope:
                    iScopeDetail = 1;
                    break;

                case KF_ModelScopeHigh:
                    iScopeDetail = 2;
                    break;

                default:
                    iScopeDetail = -1;
            }

            iScopeDetailD = iScopeDetail;
            if (iScopeDetail < 0)
                co_ScopeDetail.SilentSetIndex(0);
            else
                co_ScopeDetail.SilentSetIndex(iScopeDetail);
            break;*/

    	case ch_MotionBlur:
    		bMotionBlur =  bool(PC.ConsoleCommand("get DA2.da_players_PlayerController bUseBlurEffect"));
    		bMotionBlurD = bMotionBlur;
    		ch_MotionBlur.SetComponentValue(bMotionBlur,true);
    		break;

    	case ch_HDR:
    	    bHDR = bool(PC.ConsoleCommand("get ini:Engine.Engine.ViewportManager Bloom"));
    	    bHDRD = bHDR;
    	    ch_HDR.SetComponentValue(bHDR,true);
    	    break;

    	case ch_Advanced:
    	    break; // value is set by co_GlobalDetails

    	case co_Shadows:
        tempStr = GetNativeClassName("Engine.Engine.RenderDevice");

        // No render-to-texture on anything but Direct3D.
        if ((tempStr == "D3DDrv.D3DRenderDevice") ||
            (tempStr == "D3D9Drv.D3D9RenderDevice"))
        {
            a = bool(PC.ConsoleCommand("get UnrealGame.UnrealPawn bPlayerShadows"));
            b = bool(PC.ConsoleCommand("get UnrealGame.UnrealPawn bBlobShadow"));

            if ( b )
                iShadow = 1;
            else if (a)
                iShadow = 2;
            else
                iShadow = 0;
        }
        else
        {
            b = bool(PC.ConsoleCommand("get UnrealGame.UnrealPawn bBlobShadow"));
            if ( b )
                iShadow = 1;
            else
                iShadow = 0;
        }

        iShadowD = iShadow;
        co_Shadows.SilentSetIndex(iShadow);
        break;

     	case ch_VSync:
	     	bVSync = bool(PC.ConsoleCommand("get ini:Engine.Engine.RenderDevice UseVSync"));
	     	bVSyncD = bVSync;
	     	ch_VSync.SetComponentValue(bVSync, true);
	        break;

    	case ch_TripBuff:
	     	bTripBuff = bool(PC.ConsoleCommand("get ini:Engine.Engine.RenderDevice UseTripleBuffering"));
	     	bTripBuffD = bTripBuff;
	     	ch_TripBuff.SetComponentValue(bTripBuff, true);
	        break;

	    case ch_WideScreen:
	     	bWideScreen = bool(PC.ConsoleCommand("get kfmod.KFPlayerController bUseTrueWideScreenFOV"));
	     	bWideScreenD = bWideScreen;
	     	ch_WideScreen.SetComponentValue(bWideScreen, true);
	        break;

    default:
    		super.InternalOnLoadINI(sender, s);
    }

	// Post-super checks
	switch (Sender)
	{
	    case co_RenderDevice:
            DisableHDRControlIfNeeded();

            // Disable control if card doesn't support hdr
            if (PlayerOwner() != none)
                if (!PlayerOwner().PostFX_IsBloomCapable())
                    ch_HDR.DisableMe();

            break;
	}
}

function InternalOnChange(GUIComponent Sender)
{
    local bool bGoingUp;
    local int i;

    Super.InternalOnChange(Sender);

    if ( bIgnoreChange )
        return;

    switch (Sender)
    {
		// These changes are saved together on SaveSettings
        case co_GlobalDetails:
            i = co_GlobalDetails.GetIndex();
			bGoingUp = i > iGlobalDetails && i != iGlobalDetailsD && (i != MAX_DETAIL_OPTIONS - 1);
			iGlobalDetails = i;
			ch_Advanced.SetComponentValue(i == MAX_DETAIL_OPTIONS, true);
			UpdateGlobalDetails();
			break;

		/*case co_ScopeDetail:
			i = co_ScopeDetail.GetIndex();
			bGoingUp = i > iScopeDetail && i != iScopeDetailD;
			iScopeDetail = i;
			break;*/

		case ch_MotionBlur:
			bMotionBlur = ch_MotionBlur.IsChecked();
			bGoingUp = bMotionBlur && bMotionBlur != bMotionBlurD;
			break;

    	case ch_HDR:
    	    bHDR = ch_HDR.IsChecked();
    	    bGoingUp = bHDR && bHDR != bHDRD;
    	    break;

		case ch_Advanced:
		    if (ch_Advanced.IsChecked())
		    {
		        iGlobalDetails = MAX_DETAIL_OPTIONS - 1;
    		    co_GlobalDetails.SilentSetIndex(iGlobalDetails);
    		}
            UpdateGlobalDetailsVisibility();
            break;

		case ch_VSync:
    	    bVSync = ch_VSync.IsChecked();
    	    break;

   		case ch_TripBuff:
    	    bTripBuff = ch_TripBuff.IsChecked();
    	    break;

    	case ch_WideScreen:
    	    bWideScreen = ch_WideScreen.IsChecked();
    	    break;
    }

    if (bGoingUp)
        ShowPerformanceWarning();
}

function ShowPerformanceWarning(optional float Seconds)
{
	if (bShowPerfWarning)
	    super.ShowPerformanceWarning(Seconds);
}

function UpdateGlobalDetails()
{
    local PlayerController PC;
	PC = PlayerOwner();

    UpdateGlobalDetailsVisibility();

    if ( iGlobalDetails == MAX_DETAIL_OPTIONS - 1 )
        return; // do not change settings if we picked custom

    bShowPerfWarning = false;

    switch (iGlobalDetails)
    {
        case 0: // Lowest
            co_Texture.SetIndex(0);         // Range = 0 - 8
            co_Char.SetIndex(0);            // Range = 0 - 8
            co_World.SetIndex(0);           // Range = 0 - 2
            co_ScopeDetail.SetIndex(1);     // Range = 0 - 2 , 1 being lowest
            co_Physics.setindex(0);         // Range = 0 - 2
            co_Decal.setindex(0);           // Range = 0 - 2
            co_Shadows.setindex(0);         // Range = 0 - 2 (0 - 1 sometimes -- check that!)
            co_MeshLOD.setindex(0);         // Range = 0 - 3
            co_MultiSamples.setindex(0);
            co_Anisotropy.setindex(0);
            ch_ForceFSAAScreenshotSupport.SetComponentValue(false,false);
            ch_Decals.SetComponentValue(false, false);
            ch_DynLight.SetComponentValue(false, false);
            ch_Coronas.SetComponentValue(false, false);
            ch_Textures.SetComponentValue(false, false);
            ch_Projectors.SetComponentValue(false, false);
            ch_DecoLayers.SetComponentValue(false, false);
            ch_Trilinear.SetComponentValue(false, false);
            ch_Weather.SetComponentValue(false, false);
            ch_DecoLayers.SetComponentValue(false, false);
            ch_MotionBlur.SetComponentValue(false, false);
            ch_HDR.SetComponentValue(false, false);
            break;

        case 1: // Low
            co_Texture.SetIndex(3);         // Range = 0 - 8
            co_Char.SetIndex(3);            // Range = 0 - 8
            co_World.SetIndex(0);           // Range = 0 - 2
            co_ScopeDetail.SetIndex(1);     // Range = 0 - 2 , 1 being lowest
            co_Physics.setindex(0);         // Range = 0 - 2
            co_Decal.setindex(1);           // Range = 0 - 2
            co_Shadows.setindex(1);         // Range = 0 - 2 (0 - 1 sometimes -- check that!)
            co_MeshLOD.setindex(1);         // Range = 0 - 3
            co_MultiSamples.setindex(0);

            if (AnisotropyModes.Length>1)
                 co_Anisotropy.SetIndex(1);
            else
                 co_Anisotropy.setindex(0);

            ch_ForceFSAAScreenshotSupport.SetComponentValue(false,false);
            ch_Decals.SetComponentValue(true, false);
            ch_DynLight.SetComponentValue(false, false);
            ch_Coronas.SetComponentValue(true, false);
            ch_Textures.SetComponentValue(false, false);
            ch_Projectors.SetComponentValue(true, false);
            ch_DecoLayers.SetComponentValue(true, false);
            ch_Trilinear.SetComponentValue(false, false);
            ch_Weather.SetComponentValue(true, false);
            ch_MotionBlur.SetComponentValue(true, false);
            ch_HDR.SetComponentValue(false, false);
            break;

        case 2: // Medium
            co_Texture.SetIndex(5);         // Range = 0 - 8
            co_Char.SetIndex(5);            // Range = 0 - 8
            co_World.SetIndex(1);           // Range = 0 - 2
            co_ScopeDetail.SetIndex(1);     // Range = 0 - 2 , 1 being lowest
            co_Physics.setindex(1);         // Range = 0 - 2
            co_Decal.setindex(1);           // Range = 0 - 2
            co_Shadows.setindex(1);         // Range = 0 - 2 (0 - 1 sometimes -- check that!)
            co_MeshLOD.setindex(2);         // Range = 0 - 3
            co_MultiSamples.setindex(0);

            if (AnisotropyModes.Length>2)
                 co_Anisotropy.setindex(2);
            else if (AnisotropyModes.Length>1)
                 co_Anisotropy.SetIndex(1);
            else
                 co_Anisotropy.setindex(0);

            ch_ForceFSAAScreenshotSupport.SetComponentValue(false,false);
            ch_Decals.SetComponentValue(true, false);
            ch_DynLight.SetComponentValue(true, false);
            ch_Coronas.SetComponentValue(true, false);
            ch_Textures.SetComponentValue(true, false);
            ch_Projectors.SetComponentValue(true, false);
            ch_DecoLayers.SetComponentValue(true, false);
            ch_Trilinear.SetComponentValue(false, false);
            ch_Weather.SetComponentValue(true, false);
            ch_MotionBlur.SetComponentValue(true, false);
            ch_HDR.SetComponentValue(false, false);
            break;

        case 3: // High
            co_Texture.SetIndex(6);         // Range = 0 - 8
            co_Char.SetIndex(6);            // Range = 0 - 8
            co_World.SetIndex(2);           // Range = 0 - 2
            co_ScopeDetail.SetIndex(0);     // Range = 0 - 2 , 1 being lowest
            co_Physics.setindex(1);         // Range = 0 - 2
            co_Decal.setindex(2);           // Range = 0 - 2
            co_Shadows.setindex(1);         // Range = 0 - 2 (0 - 1 sometimes -- check that!)
            co_MeshLOD.setindex(2);         // Range = 0 - 3
            co_MultiSamples.setindex(0);

            if (MultiSampleModes.Length>1)
                 co_MultiSamples.setindex(1);
            else
                 co_MultiSamples.setindex(0);

            if(AnisotropyModes.Length>3)
                 co_Anisotropy.setindex(3);
            else if (AnisotropyModes.Length>2)
                 co_Anisotropy.setindex(2);
            else if (AnisotropyModes.Length>1)
                 co_Anisotropy.SetIndex(1);
            else
                 co_Anisotropy.setindex(0);

            ch_ForceFSAAScreenshotSupport.SetComponentValue(false,false);
            ch_Decals.SetComponentValue(true, false);
            ch_DynLight.SetComponentValue(true, false);
            ch_Coronas.SetComponentValue(true, false);
            ch_Textures.SetComponentValue(true, false);
            ch_Projectors.SetComponentValue(true, false);
            ch_DecoLayers.SetComponentValue(true, false);
            ch_Trilinear.SetComponentValue(false, false);
            ch_Weather.SetComponentValue(true, false);
            ch_MotionBlur.SetComponentValue(true, false);
            ch_HDR.SetComponentValue(true, false);
            break;

        case 4: // Higher
            co_Texture.SetIndex(7);         // Range = 0 - 8
            co_Char.SetIndex(7);            // Range = 0 - 8
            co_World.SetIndex(2);           // Range = 0 - 2
            co_ScopeDetail.SetIndex(2);     // Range = 0 - 2 , 1 being lowest
            co_Physics.setindex(1);         // Range = 0 - 2
            co_Decal.setindex(2);           // Range = 0 - 2
            co_Shadows.setindex(min(co_Shadows.ItemCount() - 1, 3));  // Range = 0 - 2 (0 - 1 sometimes -- check that!)
            co_MeshLOD.setindex(2);         // Range = 0 - 3

            if(MultiSampleModes.Length>2)
                 co_MultiSamples.setindex(2);
            else if (MultiSampleModes.Length>1)
                 co_MultiSamples.setindex(1);
            else
                 co_MultiSamples.setindex(0);

            if(AnisotropyModes.Length>3)
                 co_Anisotropy.setindex(3);
            else if (AnisotropyModes.Length>2)
                 co_Anisotropy.SetIndex(2);
            else if (AnisotropyModes.Length>1)
                 co_Anisotropy.SetIndex(1);
            else
                 co_Anisotropy.setindex(0);

            ch_ForceFSAAScreenshotSupport.SetComponentValue(false,false);
            ch_Decals.SetComponentValue(true, false);
            ch_DynLight.SetComponentValue(true, false);
            ch_Coronas.SetComponentValue(true, false);
            ch_Textures.SetComponentValue(true, false);
            ch_Projectors.SetComponentValue(true, false);
            ch_DecoLayers.SetComponentValue(true, false);
            ch_Trilinear.SetComponentValue(false, false);
            ch_Weather.SetComponentValue(true, false);
            ch_MotionBlur.SetComponentValue(true, false);
            ch_HDR.SetComponentValue(true, false);
            break;

        case 5: // Highest
            co_Texture.SetIndex(8);         // Range = 0 - 8
            co_Char.SetIndex(8);            // Range = 0 - 8
            co_World.SetIndex(2);           // Range = 0 - 2
            //co_ScopeDetail.SetIndex(2);     // Range = 0 - 2 , 1 being lowest
            co_Physics.setindex(2);         // Range = 0 - 2
            co_Decal.setindex(2);           // Range = 0 - 2
            co_Shadows.setindex(min(co_Shadows.ItemCount() - 1, 3));  // Range = 0 - 2 (0 - 1 sometimes -- check that!)
            co_MeshLOD.setindex(3);         // Range = 0 - 3

            if(
                  (
                      (true==bool(PC.ConsoleCommand("ISNVIDIAGPU")))
                       && (false==bool(PC.ConsoleCommand("SUPPORTEDMULTISAMPLE 4"))
                   )
                   || (false==bool(PC.ConsoleCommand("ISNVIDIAGPU"))))
                   && (MultiSampleModes.Length>3)
               )
                 co_MultiSamples.setindex(3);
            else if(MultiSampleModes.Length>2)
                 co_MultiSamples.setindex(2);
            else if (MultiSampleModes.Length>1)
                 co_MultiSamples.setindex(1);
            else
                 co_MultiSamples.setindex(0);

            co_Anisotropy.setindex(AnisotropyModes.Length-1);
            ch_ForceFSAAScreenshotSupport.SetComponentValue(false,false);
            ch_Decals.SetComponentValue(true, false);
            ch_DynLight.SetComponentValue(true, false);
            ch_Coronas.SetComponentValue(true, false);
            ch_Textures.SetComponentValue(true, false);
            ch_Projectors.SetComponentValue(true, false);
            ch_DecoLayers.SetComponentValue(true, false);
            ch_Trilinear.SetComponentValue(true, false);
            ch_Weather.SetComponentValue(true, false);
            ch_MotionBlur.SetComponentValue(true, false);
            ch_HDR.SetComponentValue(true, false);
            break;
    }

    bShowPerfWarning = true;

}

function UpdateGlobalDetailsVisibility()
{
    if (iGlobalDetails == MAX_DETAIL_OPTIONS - 1 || ch_Advanced.IsChecked()) // custom
    {
        //sb_Section2.SetVisibility(true);
        /*sb_Section1.WinLeft = SavedContainer1Pos;
        sb_Section2.WinLeft = SavedContainer2Pos;
        sb_Section3.WinLeft = SavedContainer3Pos;*/
        sb_Section2.EnableMe();
        DisableHDRControlIfNeeded();

        // wtf m8 _RO_
        if (co_RenderDevice.GetExtra() != RenderMode[0])
        {
           co_MultiSamples.DisableMe();
           ch_ForceFSAAScreenshotSupport.DisableMe();
        }
        // _RO_

        //ch_Advanced.SetComponentValue(true ,true);
    }
    else
    {
        //sb_Section2.SetVisibility(false);
        /*sb_Section1.WinLeft = Container1PosAlt;
        sb_Section2.WinLeft = 1.0;
        sb_Section3.WinLeft = Container3PosAlt;*/
        sb_Section2.DisableMe();
        //ch_Advanced.SetComponentValue(false ,true);
    }
}

function DisableHDRControlIfNeeded()
{
    // Bloom only available when using direct3d 9.0
    if (co_RenderDevice.GetExtra() != RenderMode[0])
        ch_HDR.DisableMe();
}

function SaveSettings()
{
	local PlayerController PC;
	local bool bSavePlayerConfig;

	Super.SaveSettings();

	PC = PlayerOwner();

	if ( bVSync != bVSyncD )
	{
		PC.ConsoleCommand("set ini:Engine.Engine.RenderDevice UseVSync" @ bVSync);
		bVSyncD = bVSync;
	}

	if ( bTripBuff != bTripBuffD )
	{
		PC.ConsoleCommand("set ini:Engine.Engine.RenderDevice UseTripleBuffering" @ bTripBuff);
		bTripBuffD = bTripBuff;
	}

	if ( bWideScreen != bWideScreenD )
	{
		PC.ConsoleCommand("set kfmod.KFPlayerController bUseTrueWideScreenFOV" @ bWideScreen);
		bWideScreenD = bWideScreen;
	}

	if (bMotionBlur != bMotionBlurD)
	{
		class'DA2.da_players_PlayerController'.default.bUseBlurEffect = bMotionBlur;
		bSavePlayerConfig = true;

		if (da_players_PlayerController(PC) != none)
			da_players_PlayerController(PC).bUseBlurEffect = bMotionBlur;

		bMotionBlurD = bMotionBlur;
	}

	if (bHDR != bHDRD)
	{
		PC.ConsoleCommand("set ini:Engine.Engine.ViewportManager Bloom"@bHDR);

		if (PC != none)
		{
			PC.PostFX_SetActive(0, bHDR);
		}

		bHDRD = bHDR;
	}
/*
	if (iScopeDetail != iScopeDetailD)
	{
        class'KFMod.KFWeapon'.default.KFScopeDetail = KFScopeDetailSettings(iScopeDetail);
        class'KFMod.KFWeapon'.static.StaticSaveConfig();

        if (PC.Pawn != none && PC.Pawn.Weapon != none && KFWeapon(PC.Pawn.Weapon) != None)
        {
            KFWeapon(PC.Pawn.Weapon).KFScopeDetail = class'KFMod.KFWeapon'.default.KFScopeDetail;
            KFWeapon(PC.Pawn.Weapon).AdjustIngameScope();
        }

        iScopeDetailD = iScopeDetail;
	}*/
// KFTODO: Implement this in the KF player class
	if (iGlobalDetails != iGlobalDetailsD)
	{
        class'ROEngine.ROPlayer'.default.GlobalDetailLevel = iGlobalDetails;
        bSavePlayerConfig = true;

        iGlobalDetailsD = iGlobalDetails;
	}

	if ( iShadow != iShadowD )
	{
		if ( PC.Pawn != None && UnrealPawn(PC.Pawn) != None )
		{
            UnrealPawn(PC.Pawn).bBlobShadow = iShadow == 1;
			UnrealPawn(PC.Pawn).bPlayerShadows = iShadow > 0;
		}

		class'UnrealPawn'.default.bBlobShadow = iShadow == 1;
		class'UnrealPawn'.default.bPlayerShadows = iShadow > 0;
		iShadowD = iShadow;

		if (PC.Pawn != None && UnrealPawn(PC.Pawn) != None)
			UnrealPawn(PC.Pawn).SaveConfig();
		else
            class'UnrealPawn'.static.StaticSaveConfig();

   		UpdateShadows(iShadow == 1, iShadow > 0);
	}

	if ( class'Vehicle'.default.bVehicleShadows != (iShadow > 0) )
	{
		class'Vehicle'.default.bVehicleShadows = iShadow > 0;
		class'Vehicle'.static.StaticSaveConfig();
		UpdateVehicleShadows(iShadow > 0);
	}

	if (bSavePlayerConfig)
{
	   class'ROEngine.ROPlayer'.static.StaticSaveConfig();
	   class'DA2.da_players_PlayerController'.static.StaticSaveConfig();
}
}

simulated function UpdateShadows(bool bBlobShadow, bool bPlayerShadows)
{
    local PlayerController PC;
    local UnrealPawn pawn;

    PC = PlayerOwner();

    if (PC == none || PC.Level.NetMode == NM_DedicatedServer)
        return;

    foreach PC.DynamicActors(class'UnrealPawn', pawn)
    {
        pawn.bBlobShadow = bBlobShadow;
        pawn.bPlayerShadows = bPlayerShadows;
        if( KFPawn(Pawn) != none )
        {
            KFPawn(Pawn).UpdateShadow();
        }
        else if( KFMonster(Pawn) != none )
        {
            KFMonster(Pawn).UpdateShadow();
        }
    }
}

simulated function UpdateVehicleShadows(bool bVehicleShadows)
{
    local PlayerController PC;
    local Vehicle vehicle;

    PC = PlayerOwner();

    if (PC == none || PC.Level.NetMode == NM_DedicatedServer)
        return;

    foreach PC.DynamicActors(class'Vehicle', vehicle)
    {
        vehicle.bVehicleShadows = bVehicleShadows;
        vehicle.UpdateShadow();
    }
}

function ResetClicked()
{
	class'ROEngine.ROPlayer'.static.ResetConfig("GlobalDetailLevel");
	class'DA2.da_players_PlayerController'.static.ResetConfig("bUseBlurEffect");

	Super.ResetClicked();
}

defaultproperties
{
     Begin Object Class=da_GUI_moComboBox Name=GlobalDetails
         ComponentJustification=TXTA_Left
         CaptionWidth=0.550000
         Caption="Game details"
         OnCreateComponent=GlobalDetails.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="Higher"
         Hint="Changes the quality of the graphics in the game"
         WinTop=0.063021
         WinLeft=0.550000
         WinWidth=0.400000
         TabOrder=2
         OnChange=da_GUI_Tab_DetailSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_DetailSettings.InternalOnLoadINI
     End Object
     co_GlobalDetails=da_GUI_moComboBox'DA2.da_GUI_Tab_DetailSettings.GlobalDetails'

     Begin Object Class=da_GUI_moCheckBox Name=HDRCheckbox
         ComponentJustification=TXTA_Left
         CaptionWidth=0.940000
         Caption="HDR Bloom"
         OnCreateComponent=HDRCheckbox.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="True"
         Hint="Enables the Bloom effect"
         WinTop=0.479308
         WinLeft=0.600000
         WinWidth=0.300000
         WinHeight=0.040000
         TabOrder=18
         OnChange=da_GUI_Tab_DetailSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_DetailSettings.InternalOnLoadINI
     End Object
     ch_HDR=da_GUI_moCheckBox'DA2.da_GUI_Tab_DetailSettings.HDRCheckbox'

     Begin Object Class=da_GUI_moCheckBox Name=Advanced
         ComponentJustification=TXTA_Left
         CaptionWidth=0.940000
         Caption="Show Advanced Options"
         OnCreateComponent=Advanced.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="True"
         Hint="Enables you to configure display options more precisely"
         WinTop=0.479308
         WinLeft=0.600000
         WinWidth=0.300000
         WinHeight=0.040000
         TabOrder=2
         OnChange=da_GUI_Tab_DetailSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_DetailSettings.InternalOnLoadINI
     End Object
     ch_Advanced=da_GUI_moCheckBox'DA2.da_GUI_Tab_DetailSettings.Advanced'

     Begin Object Class=da_GUI_moCheckBox Name=MotionBlur
         ComponentJustification=TXTA_Left
         CaptionWidth=0.940000
         Caption="Motion Blur"
         OnCreateComponent=MotionBlur.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="True"
         Hint="Enables motion blur effects"
         WinTop=0.479308
         WinLeft=0.600000
         WinWidth=0.300000
         WinHeight=0.040000
         TabOrder=17
         OnChange=da_GUI_Tab_DetailSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_DetailSettings.InternalOnLoadINI
     End Object
     ch_MotionBlur=da_GUI_moCheckBox'DA2.da_GUI_Tab_DetailSettings.MotionBlur'

     Begin Object Class=da_GUI_moCheckBox Name=VSyncbox
         ComponentJustification=TXTA_Left
         CaptionWidth=0.940000
         Caption="Vertical Sync"
         OnCreateComponent=VSyncbox.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="False"
         Hint="Syncs the frame rate to your monitor's refresh rate"
         WinTop=0.479308
         WinLeft=0.600000
         WinWidth=0.300000
         WinHeight=0.040000
         TabOrder=4
         OnChange=da_GUI_Tab_DetailSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_DetailSettings.InternalOnLoadINI
     End Object
     ch_VSync=da_GUI_moCheckBox'DA2.da_GUI_Tab_DetailSettings.VSyncbox'

     Begin Object Class=da_GUI_moCheckBox Name=TripBuffbox
         ComponentJustification=TXTA_Left
         CaptionWidth=0.940000
         Caption="Triple Buffering"
         OnCreateComponent=TripBuffbox.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="False"
         Hint="May help framerate/smoothness if VSync is turned on"
         WinTop=0.479308
         WinLeft=0.600000
         WinWidth=0.300000
         WinHeight=0.040000
         TabOrder=4
         OnChange=da_GUI_Tab_DetailSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_DetailSettings.InternalOnLoadINI
     End Object
     ch_TripBuff=da_GUI_moCheckBox'DA2.da_GUI_Tab_DetailSettings.TripBuffbox'

     Begin Object Class=da_GUI_moCheckBox Name=WideScreenbox
         ComponentJustification=TXTA_Left
         CaptionWidth=0.940000
         Caption="Widescreen"
         OnCreateComponent=WideScreenbox.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="True"
         Hint="Enables widescreen support"
         WinTop=0.479308
         WinLeft=0.600000
         WinWidth=0.300000
         WinHeight=0.040000
         TabOrder=4
         OnChange=da_GUI_Tab_DetailSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_DetailSettings.InternalOnLoadINI
     End Object
     ch_WideScreen=da_GUI_moCheckBox'DA2.da_GUI_Tab_DetailSettings.WideScreenbox'

     DetailOptions(0)="Lowest"
     DetailOptions(1)="Low"
     DetailOptions(2)="Medium"
     DetailOptions(3)="High"
     DetailOptions(4)="Higher"
     DetailOptions(5)="Highest"
     DetailOptions(6)="Custom"
     ScopeLevels(0)="Model (Low)"
     ScopeLevels(1)="Textured"
     ScopeLevels(2)="Model (High)"
     RenderModeText(0)="Direct 3D 9.0"
     RenderModeText(1)="Direct 3D"
     RenderModeText(2)="Software"
     RenderMode(0)="D3D9Drv.D3D9RenderDevice"
     RenderMode(1)="D3DDrv.D3DRenderDevice"
     RenderMode(2)="PixoDrv.PixoRenderDevice"
     DisplayPromptMenu="DA2.da_GUI_VideoChangeOk"
     bPlayedSound=True
     Begin Object Class=da_GUI_SectionBackground Name=sbSection1
         Caption="Resolution"
         WinTop=0.012761
         WinLeft=0.000948
         WinWidth=0.485000
         WinHeight=0.540729
         RenderWeight=0.010000
         OnPreDraw=sbSection1.InternalPreDraw
     End Object
     sb_Section1=da_GUI_SectionBackground'DA2.da_GUI_Tab_DetailSettings.sbSection1'

     Begin Object Class=da_GUI_SectionBackground Name=sbSection2
         Caption="Options"
         WinTop=0.012761
         WinLeft=0.505000
         WinWidth=0.490000
         WinHeight=0.975228
         RenderWeight=0.010000
         OnPreDraw=sbSection2.InternalPreDraw
     End Object
     sb_Section2=da_GUI_SectionBackground'DA2.da_GUI_Tab_DetailSettings.sbSection2'

     Begin Object Class=da_GUI_SectionBackground Name=sbSection3
         bFillClient=True
         Caption="Gamma Test"
         WinTop=0.576061
         WinLeft=0.000948
         WinWidth=0.485000
         WinHeight=0.411928
         RenderWeight=0.010000
         OnPreDraw=sbSection3.InternalPreDraw
     End Object
     sb_Section3=da_GUI_SectionBackground'DA2.da_GUI_Tab_DetailSettings.sbSection3'

     Begin Object Class=GUIImage Name=GammaBar
         Image=Texture'DA2GUI.Generic.GammaShot'
         ImageStyle=ISTY_Scaled
         ImageRenderStyle=MSTY_Normal
         WinTop=0.450001
         WinLeft=0.013477
         WinWidth=0.456250
         WinHeight=0.532117
         OnChange=da_GUI_Tab_DetailSettings.InternalOnChange
     End Object
     i_GammaBar=GUIImage'DA2.da_GUI_Tab_DetailSettings.GammaBar'

     Begin Object Class=da_GUI_moComboBox Name=DetailTextureDetail
         ComponentJustification=TXTA_Left
         CaptionWidth=0.650000
         Caption="Texture Detail"
         OnCreateComponent=DetailTextureDetail.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="High"
         Hint="Changes how much world detail will be rendered."
         WinTop=0.063021
         WinLeft=0.550000
         WinWidth=0.400000
         TabOrder=7
         OnChange=da_GUI_Tab_DetailSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_DetailSettings.InternalOnLoadINI
     End Object
     co_Texture=da_GUI_moComboBox'DA2.da_GUI_Tab_DetailSettings.DetailTextureDetail'

     Begin Object Class=da_GUI_moComboBox Name=DetailCharacterDetail
         ComponentJustification=TXTA_Left
         CaptionWidth=0.650000
         Caption="Character Detail"
         OnCreateComponent=DetailCharacterDetail.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="High"
         Hint="Changes how much character detail will be rendered."
         WinTop=0.116667
         WinLeft=0.550000
         WinWidth=0.400000
         TabOrder=8
         OnChange=da_GUI_Tab_DetailSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_DetailSettings.InternalOnLoadINI
     End Object
     co_Char=da_GUI_moComboBox'DA2.da_GUI_Tab_DetailSettings.DetailCharacterDetail'

     Begin Object Class=da_GUI_moComboBox Name=DetailWorldDetail
         ComponentJustification=TXTA_Left
         CaptionWidth=0.650000
         Caption="World Detail"
         OnCreateComponent=DetailWorldDetail.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="High"
         Hint="Changes the level of detail used for optional geometry and effects."
         WinTop=0.170312
         WinLeft=0.550000
         WinWidth=0.400000
         TabOrder=9
         OnChange=da_GUI_Tab_DetailSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_DetailSettings.InternalOnLoadINI
     End Object
     co_World=da_GUI_moComboBox'DA2.da_GUI_Tab_DetailSettings.DetailWorldDetail'

     Begin Object Class=da_GUI_moComboBox Name=DetailPhysics
         ComponentJustification=TXTA_Left
         CaptionWidth=0.650000
         Caption="Physics Detail"
         OnCreateComponent=DetailPhysics.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="High"
         Hint="Changes the physics simulation level of detail."
         WinTop=0.223958
         WinLeft=0.550000
         WinWidth=0.400000
         TabOrder=10
         OnChange=da_GUI_Tab_DetailSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_DetailSettings.InternalOnLoadINI
     End Object
     co_Physics=da_GUI_moComboBox'DA2.da_GUI_Tab_DetailSettings.DetailPhysics'

     Begin Object Class=da_GUI_moComboBox Name=DetailDecalStay
         ComponentJustification=TXTA_Left
         CaptionWidth=0.650000
         Caption="Decal Stay"
         OnCreateComponent=DetailDecalStay.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="Normal"
         Hint="Changes how long weapon scarring effects stay around."
         WinTop=0.282032
         WinLeft=0.550000
         WinWidth=0.400000
         TabOrder=12
         OnChange=da_GUI_Tab_DetailSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_DetailSettings.InternalOnLoadINI
     End Object
     co_Decal=da_GUI_moComboBox'DA2.da_GUI_Tab_DetailSettings.DetailDecalStay'

     Begin Object Class=da_GUI_moComboBox Name=MeshLOD
         ComponentJustification=TXTA_Left
         CaptionWidth=0.650000
         Caption="Dynamic Mesh LOD"
         OnCreateComponent=MeshLOD.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Adjusts how aggressively character and vehicle details are reduced at a distance.  Higher settings increase the distance at which details are reduced, possibly improving visual detail at a cost in performance"
         WinTop=0.223958
         WinLeft=0.550000
         WinWidth=0.400000
         TabOrder=11
         OnChange=da_GUI_Tab_DetailSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_DetailSettings.InternalOnLoadINI
     End Object
     co_MeshLOD=da_GUI_moComboBox'DA2.da_GUI_Tab_DetailSettings.MeshLOD'

     Begin Object Class=da_GUI_moComboBox Name=VideoResolution
         bReadOnly=True
         CaptionWidth=0.550000
         Caption="Resolution"
         OnCreateComponent=VideoResolution.InternalOnCreateComponent
         IniOption="@INTERNAL"
         IniDefault="640x480"
         Hint="Select the video resolution at which you wish to play."
         WinTop=0.060417
         WinLeft=0.030508
         WinWidth=0.390000
         TabOrder=1
         OnChange=da_GUI_Tab_DetailSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_DetailSettings.InternalOnLoadINI
     End Object
     co_Resolution=da_GUI_moComboBox'DA2.da_GUI_Tab_DetailSettings.VideoResolution'

     Begin Object Class=da_GUI_moComboBox Name=VideoColorDepth
         CaptionWidth=0.550000
         Caption="Color Depth"
         OnCreateComponent=VideoColorDepth.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="false"
         Hint="Select the maximum number of colors to display at one time."
         WinTop=0.117188
         WinLeft=0.030234
         WinWidth=0.390000
         TabOrder=2
         OnChange=da_GUI_Tab_DetailSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_DetailSettings.InternalOnLoadINI
     End Object
     co_ColorDepth=da_GUI_moComboBox'DA2.da_GUI_Tab_DetailSettings.VideoColorDepth'

     Begin Object Class=da_GUI_moComboBox Name=RenderDeviceCombo
         ComponentJustification=TXTA_Left
         CaptionWidth=0.550000
         Caption="Render Device"
         OnCreateComponent=RenderDeviceCombo.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Alternate rendering devices may offer better performance on your machine."
         WinTop=0.335021
         WinLeft=0.547773
         WinWidth=0.401953
         TabOrder=0
         bBoundToParent=True
         bScaleToParent=True
         OnChange=da_GUI_Tab_DetailSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_DetailSettings.InternalOnLoadINI
     End Object
     co_RenderDevice=da_GUI_moComboBox'DA2.da_GUI_Tab_DetailSettings.RenderDeviceCombo'

     Begin Object Class=da_GUI_moComboBox Name=DetailCharacterShadows
         ComponentJustification=TXTA_Left
         CaptionWidth=0.650000
         Caption="Character Shadows"
         OnCreateComponent=DetailCharacterShadows.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Adjust the detail of character shadows.  'Blob' or 'None' recommended for low-performance PC's"
         WinTop=0.431378
         WinLeft=0.600000
         WinWidth=0.300000
         TabOrder=13
         OnChange=da_GUI_Tab_DetailSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_DetailSettings.InternalOnLoadINI
     End Object
     co_Shadows=da_GUI_moComboBox'DA2.da_GUI_Tab_DetailSettings.DetailCharacterShadows'

     Begin Object Class=da_GUI_moComboBox Name=DetailAntialiasing
         ComponentJustification=TXTA_Left
         CaptionWidth=0.650000
         Caption="Antialiasing"
         OnCreateComponent=DetailAntialiasing.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Adjust the detail of multisampling for antialiasing.  'None' recommended for low-performance PC's"
         WinTop=0.450000
         WinLeft=0.550000
         WinWidth=0.400000
         TabOrder=14
         OnChange=da_GUI_Tab_DetailSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_DetailSettings.InternalOnLoadINI
     End Object
     co_MultiSamples=da_GUI_moComboBox'DA2.da_GUI_Tab_DetailSettings.DetailAntialiasing'

     Begin Object Class=da_GUI_moComboBox Name=DetailAnisotropy
         ComponentJustification=TXTA_Left
         CaptionWidth=0.650000
         Caption="Anisotropic Filtering"
         OnCreateComponent=DetailAnisotropy.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Adjust the level of anisotropic filtering.  'None' recommended for low-performance PC's"
         WinTop=0.480000
         WinLeft=0.600000
         WinWidth=0.400000
         TabOrder=15
         OnChange=da_GUI_Tab_DetailSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_DetailSettings.InternalOnLoadINI
     End Object
     co_Anisotropy=da_GUI_moComboBox'DA2.da_GUI_Tab_DetailSettings.DetailAnisotropy'

     Begin Object Class=da_GUI_moCheckBox Name=DetailDecals
         ComponentJustification=TXTA_Left
         CaptionWidth=0.940000
         Caption="Decals"
         OnCreateComponent=DetailDecals.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="True"
         Hint="Enables weapon scarring effects."
         WinTop=0.479308
         WinLeft=0.600000
         WinWidth=0.300000
         WinHeight=0.040000
         TabOrder=19
         OnChange=da_GUI_Tab_DetailSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_DetailSettings.InternalOnLoadINI
     End Object
     ch_Decals=da_GUI_moCheckBox'DA2.da_GUI_Tab_DetailSettings.DetailDecals'

     Begin Object Class=da_GUI_moCheckBox Name=DetailDynamicLighting
         ComponentJustification=TXTA_Left
         CaptionWidth=0.940000
         Caption="Dynamic Lighting"
         OnCreateComponent=DetailDynamicLighting.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="True"
         Hint="Enables dynamic lights."
         WinTop=0.526716
         WinLeft=0.600000
         WinWidth=0.300000
         WinHeight=0.040000
         TabOrder=20
         OnChange=da_GUI_Tab_DetailSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_DetailSettings.InternalOnLoadINI
     End Object
     ch_DynLight=da_GUI_moCheckBox'DA2.da_GUI_Tab_DetailSettings.DetailDynamicLighting'

     Begin Object Class=da_GUI_moCheckBox Name=DetailCoronas
         ComponentJustification=TXTA_Left
         CaptionWidth=0.940000
         Caption="Coronas"
         OnCreateComponent=DetailCoronas.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="True"
         Hint="Enables coronas."
         WinTop=0.624136
         WinLeft=0.600000
         WinWidth=0.300000
         WinHeight=0.040000
         TabOrder=22
         OnChange=da_GUI_Tab_DetailSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_DetailSettings.InternalOnLoadINI
     End Object
     ch_Coronas=da_GUI_moCheckBox'DA2.da_GUI_Tab_DetailSettings.DetailCoronas'

     Begin Object Class=da_GUI_moCheckBox Name=DetailDetailTextures
         ComponentJustification=TXTA_Left
         CaptionWidth=0.940000
         Caption="Detail Textures"
         OnCreateComponent=DetailDetailTextures.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="True"
         Hint="Enables detail textures."
         WinTop=0.575425
         WinLeft=0.600000
         WinWidth=0.300000
         WinHeight=0.040000
         TabOrder=21
         OnChange=da_GUI_Tab_DetailSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_DetailSettings.InternalOnLoadINI
     End Object
     ch_Textures=da_GUI_moCheckBox'DA2.da_GUI_Tab_DetailSettings.DetailDetailTextures'

     Begin Object Class=da_GUI_moCheckBox Name=DetailProjectors
         ComponentJustification=TXTA_Left
         CaptionWidth=0.940000
         Caption="Projectors"
         OnCreateComponent=DetailProjectors.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="True"
         Hint="Enables projectors."
         WinTop=0.721195
         WinLeft=0.600000
         WinWidth=0.300000
         WinHeight=0.040000
         TabOrder=24
         OnChange=da_GUI_Tab_DetailSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_DetailSettings.InternalOnLoadINI
     End Object
     ch_Projectors=da_GUI_moCheckBox'DA2.da_GUI_Tab_DetailSettings.DetailProjectors'

     Begin Object Class=da_GUI_moCheckBox Name=DetailDecoLayers
         ComponentJustification=TXTA_Left
         CaptionWidth=0.940000
         Caption="Foliage"
         OnCreateComponent=DetailDecoLayers.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="True"
         Hint="Enables grass and other decorative foliage."
         WinTop=0.769906
         WinLeft=0.599727
         WinWidth=0.300000
         WinHeight=0.040000
         TabOrder=25
         OnChange=da_GUI_Tab_DetailSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_DetailSettings.InternalOnLoadINI
     End Object
     ch_DecoLayers=da_GUI_moCheckBox'DA2.da_GUI_Tab_DetailSettings.DetailDecoLayers'

     Begin Object Class=da_GUI_moCheckBox Name=DetailTrilinear
         ComponentJustification=TXTA_Left
         CaptionWidth=0.940000
         Caption="Trilinear Filtering"
         OnCreateComponent=DetailTrilinear.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="False"
         Hint="Enables trilinear filtering, recommended for high-performance PCs."
         WinTop=0.673263
         WinLeft=0.600000
         WinWidth=0.300000
         WinHeight=0.040000
         TabOrder=23
         OnChange=da_GUI_Tab_DetailSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_DetailSettings.InternalOnLoadINI
     End Object
     ch_Trilinear=da_GUI_moCheckBox'DA2.da_GUI_Tab_DetailSettings.DetailTrilinear'

     Begin Object Class=da_GUI_moCheckBox Name=VideoFullScreen
         ComponentJustification=TXTA_Left
         CaptionWidth=0.940000
         Caption="Full Screen"
         OnCreateComponent=VideoFullScreen.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="True"
         Hint="Check this box to run the game full screen."
         WinTop=0.169531
         WinLeft=0.030976
         WinWidth=0.401953
         TabOrder=3
         OnChange=da_GUI_Tab_DetailSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_DetailSettings.InternalOnLoadINI
     End Object
     ch_FullScreen=da_GUI_moCheckBox'DA2.da_GUI_Tab_DetailSettings.VideoFullScreen'

     Begin Object Class=da_GUI_moCheckBox Name=WeatherEffects
         ComponentJustification=TXTA_Left
         CaptionWidth=0.940000
         Caption="Weather Effects"
         OnCreateComponent=WeatherEffects.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="False"
         Hint="Enable weather effects like rain-drops and lightning."
         WinTop=0.864910
         WinLeft=0.599727
         WinWidth=0.300000
         WinHeight=0.040000
         TabOrder=26
         OnChange=da_GUI_Tab_DetailSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_DetailSettings.InternalOnLoadINI
     End Object
     ch_Weather=da_GUI_moCheckBox'DA2.da_GUI_Tab_DetailSettings.WeatherEffects'

     Begin Object Class=da_GUI_moCheckBox Name=DetailForceFSAASS
         ComponentJustification=TXTA_Left
         CaptionWidth=0.940000
         Caption="Force FSAA Screenshots"
         OnCreateComponent=DetailForceFSAASS.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="False"
         Hint="Forces screenshots to work in fullscreen if driver AA is implemented and not game AA."
         WinTop=0.499308
         WinLeft=0.600000
         WinWidth=0.300000
         WinHeight=0.040000
         TabOrder=16
         OnChange=da_GUI_Tab_DetailSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_DetailSettings.InternalOnLoadINI
     End Object
     ch_ForceFSAAScreenshotSupport=da_GUI_moCheckBox'DA2.da_GUI_Tab_DetailSettings.DetailForceFSAASS'

     Begin Object Class=da_GUI_moSlider Name=GammaSlider
         MaxValue=2.500000
         MinValue=0.500000
         SliderCaptionStyleName=
         CaptionWidth=0.550000
         Caption="Gamma"
         OnCreateComponent=GammaSlider.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="0.8"
         Hint="Use the slider to adjust the Gamma to suit your monitor."
         WinTop=0.272918
         WinLeft=0.012501
         WinWidth=0.461133
         TabOrder=5
         OnChange=da_GUI_Tab_DetailSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_DetailSettings.InternalOnLoadINI
     End Object
     sl_Gamma=da_GUI_moSlider'DA2.da_GUI_Tab_DetailSettings.GammaSlider'

     Begin Object Class=da_GUI_moSlider Name=BrightnessSlider
         MaxValue=1.000000
         SliderCaptionStyleName=
         CaptionWidth=0.550000
         Caption="Brightness"
         OnCreateComponent=BrightnessSlider.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="0.8"
         Hint="Use the slider to adjust the Brightness to suit your monitor."
         WinTop=0.229951
         WinLeft=0.012188
         WinWidth=0.461445
         TabOrder=4
         OnChange=da_GUI_Tab_DetailSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_DetailSettings.InternalOnLoadINI
     End Object
     sl_Brightness=da_GUI_moSlider'DA2.da_GUI_Tab_DetailSettings.BrightnessSlider'

     Begin Object Class=da_GUI_moSlider Name=ContrastSlider
         MaxValue=1.000000
         SliderCaptionStyleName=
         CaptionWidth=0.550000
         Caption="Contrast"
         OnCreateComponent=ContrastSlider.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="0.8"
         Hint="Use the slider to adjust the Contrast to suit your monitor."
         WinTop=0.313285
         WinLeft=0.012188
         WinWidth=0.461133
         TabOrder=6
         OnChange=da_GUI_Tab_DetailSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_DetailSettings.InternalOnLoadINI
     End Object
     sl_Contrast=da_GUI_moSlider'DA2.da_GUI_Tab_DetailSettings.ContrastSlider'

     Begin Object Class=da_GUI_moSlider Name=DistanceLODSlider
         MaxValue=1.000000
         Value=0.500000
         SliderCaptionStyleName=
         CaptionWidth=0.650000
         Caption="Fog Distance"
         OnCreateComponent=DistanceLODSlider.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Reduce the fog distance to improve performance."
         WinTop=0.910000
         WinLeft=0.560000
         WinWidth=0.400000
         TabOrder=27
         OnChange=da_GUI_Tab_DetailSettings.InternalOnChange
         OnLoadINI=da_GUI_Tab_DetailSettings.InternalOnLoadINI
     End Object
     sl_DistanceLOD=da_GUI_moSlider'DA2.da_GUI_Tab_DetailSettings.DistanceLODSlider'

     PerformanceWarningMenu="DA2.da_GUI_PerformWarn"
     OnPreDraw=da_GUI_Tab_DetailSettings.InternalOnPreDraw
}
