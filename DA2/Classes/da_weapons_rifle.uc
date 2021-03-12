class da_weapons_Rifle extends da_weapons_BasicGun;

#EXEC OBJ LOAD FILE=../DA2/Textures/DA2Weapons.utx

var bool bHasScope, bHasIronsight;
var vector IronsightOffset;
var float minZoom, maxZoom, zoomStep;
var sound scopeChange;

var	float  StandardDisplayFOV;   	// Stores the original nonadjusted display FOV (because we need to change the default, and want to know what the original default was)

var(Gfx) float innerArrowsX;
var(Gfx) float innerArrowsY;

var(Gfx) Color ArrowColor;

simulated function modeUpdated() {
	if (instigator == none || !bHasScope && !bHasIronSight || !instigator.isLocallyControlled() || !instigator.isHumanControlled())
		return;
	//playerController(instigator.controller).toggleZoom();

	if(bHasScope)
		playOwnedSound(scopeChange,SLOT_Interact, 1.5);
}

simulated function ClientStartReload() {
    if( Instigator.Controller.IsA( 'PlayerController' ) )
        PlayerController(Instigator.Controller).endZoom();
    super.clientStartReload();
}

simulated function bool PutDown()
{
    if( Instigator.Controller.IsA( 'PlayerController' ) )
        PlayerController(Instigator.Controller).EndZoom();
    if ( Super.PutDown() )
        return true;
    return false;
}

simulated event RenderOverlays( Canvas Canvas ) {

	local float tileScaleX;
	local float tileScaleY;
	local float CX,CY,Scale;
	local vector newScale;

    if(PlayerController(Instigator.Controller).DesiredFOV==PlayerController(Instigator.Controller).DefaultFOV) {
        Super.RenderOverlays(Canvas);
        return;
    }

    CX=Canvas.ClipX/2;
	CY=Canvas.ClipY/2;
	Scale=Canvas.ClipX/1024;

   if(bHasScope) 
    {
		tileScaleX=Canvas.SizeX/640.0f;
		tileScaleY=Canvas.SizeY/480.0f;

        //Visual Noise
        Canvas.SetPos(0,0);
        Canvas.DrawTile( Material'DA2Weapons.ZoomFuzz', Canvas.SizeX, Canvas.SizeY, 0, 0, 512, 512 ); // !! hardcoded size

        /*fX = innerArrowsX * tileScaleX;
		fY = innerArrowsY * tileScaleY;

         Canvas.DrawColor = ArrowColor;
		Canvas.SetPos((Canvas.SizeX*0.5)-fX,(Canvas.SizeY*0.5)-fY);
		Canvas.DrawTile(Material'DA2Weapons.Effects.ZoomCross', fX*2.0, fY*2.0, 0.0, 0.0, 256, 256 ); 

        Canvas.SetDrawColor(0,0,0); */
    } 
    else if(bHasIronsight) {
        if(FireMode[0]!=None)
            FireMode[0].DrawMuzzleFlash(Canvas);

        newScale=DrawScale3D;
        newScale.Z/=1.3;
        SetDrawScale3D(newScale);
        SetDrawScale(default.DrawScale*1.3);

	    PlayerViewOffset = IronsightOffset;
        SetLocation( Instigator.Location + Instigator.CalcDrawOffset(self) );
        SetRotation( Instigator.GetViewRotation() );
	    PreDrawFPWeapon();
        bDrawingFirstPerson = true;
        Canvas.DrawActor(self, false, false, DisplayFOV);

        bDrawingFirstPerson = false;
        SetDrawScale3D(default.DrawScale3D);
        SetDrawScale(default.DrawScale);

        Canvas.SetDrawColor(0,0,0,128);
    } 

    Canvas.Style = ERenderStyle.STY_Alpha;

    // Draw the 4 corners
    
	Canvas.SetPos(0,0);
	Canvas.DrawTile(texture'DA2HUD.SniperZoomed',160*Scale,160*Scale, 0, 274, 159, -158);
	Canvas.SetPos(Canvas.ClipX-160*Scale,0);
	Canvas.DrawTile(texture'DA2HUD.SniperZoomed',160*Scale,160*Scale, 159,274, -159, -158);
	Canvas.SetPos(0,Canvas.ClipY-160*Scale);
	Canvas.DrawTile(texture'DA2HUD.SniperZoomed',160*Scale,160*Scale, 0,116, 159, 158);
	Canvas.SetPos(Canvas.ClipX-160*Scale,Canvas.ClipY-160*Scale);
	Canvas.DrawTile(texture'DA2HUD.SniperZoomed',160*Scale,160*Scale, 159, 116, -159, 158);

	// Draw the Horz Borders
	Canvas.SetPos(160*Scale,0);
	Canvas.DrawTile(texture'DA2HUD.SniperZoomed', Canvas.ClipX-320*Scale, 160*Scale, 284, 512, 32, -160);
	Canvas.SetPos(160*Scale,Canvas.ClipY-160*Scale);
	Canvas.DrawTile(texture'DA2HUD.SniperZoomed', Canvas.ClipX-320*Scale, 160*Scale, 284, 352, 32, 160);

	// Draw the Vert Borders
	Canvas.SetPos(0,160*Scale);
	Canvas.DrawTile(texture'DA2HUD.SniperZoomed', 160*Scale, Canvas.ClipY-320*Scale, 0,308, 160,32);
    Canvas.SetPos(Canvas.ClipX-160*Scale,160*Scale);
	Canvas.DrawTile(texture'DA2HUD.SniperZoomed', 160*Scale, Canvas.ClipY-320*Scale, 160,308, -160,32);
	
}
 
simulated function bool drawCrosshair() {
    return (!bHasIronsight || PlayerController(Instigator.Controller).DesiredFOV==PlayerController(Instigator.Controller).DefaultFOV);
}


simulated event renderZoomedRifle(Canvas canvas);

simulated function ROIronSights()
{
        if( Instigator.Controller.IsA( 'PlayerController' ) )
            PlayerController(Instigator.Controller).ToggleZoom();
}

defaultproperties
{
     minZoom=0.200000
     maxZoom=0.800000
     zoomStep=0.100000
     scopeChange=Sound'DA2_WeaponSounds.Scope_Change'
     innerArrowsX=42.000000
     innerArrowsY=42.000000
     ArrowColor=(B=255,G=255,R=255,A=255)
     FireModeClass(1)=Class'DA2.da_weapons_ModeMelee'
     SelectSound=Sound'DA2_WeaponSounds.Human_WeaponChange'
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.800000
     InventoryGroup=2
}
