//-----------------------------------------------------------
// Like medic aura etc.
//-----------------------------------------------------------

#EXEC OBJ LOAD FILE=DA2Hud.utx

class da_hud_PlayerEffects extends da_HudElement;

const NUMICONS = 3;
const HEALICON = 0;
const STEALTHICON = 1;
const ARMORICON = 2;

var struct SPulsingIcon {
    var bool bShowIcon;
    var bool bPulse;
    var float pulseDir;
    var float pulseValue;
    var Hudbase.SpriteWidget icon;
} icons[NUMICONS];

var Hudbase.SpriteWidget icon[NUMICONS];

function postRender(Canvas c) {
    local int i;

    if(playerowner.myHUD.bShowScoreBoard)
        return;

    for (i = 0; i < NUMICONS; i++)
        if (icons[i].bShowIcon)
            hud.DrawSpriteWidget(c, icon[i]);
}

function tick(float deltatime) {
    local int i;
    local byte pMin;

    for (i = 0; i < NUMICONS; i++)
        if (icons[i].bShowIcon) {
            if(i==0) pMin=128;
            else if(i==1) pMin=16;
            else pMin=192;

            icons[i].pulseValue+=icons[i].pulseDir * deltaTime;
            if(icons[i].pulseValue<=pMin || icons[i].pulseValue>=255) {
                icons[i].pulseValue=fclamp(icons[i].pulseValue, pMin, 255);
                icons[i].pulseDir*=-1;
            }
            icon[i].tints[0].a=icons[i].pulseValue;
        }
}

function updateHudData() {
    icons[HEALICON].bShowIcon = pawnOwner() != none && pawnOwner().bPlayerIsHealing;
    if (pawnOwner() != none && pawnOwner().resolveClassInfo() != none) {
        icons[STEALTHICON].bShowIcon = pawnOwner().resolveClassInfo().bStealth;
        icons[ARMORICON].bShowIcon = pawnOwner().resolveClassInfo().armor > 0;
        if (pawnOwner().resolveClassInfo().bStealth)
            icons[STEALTHICON].pulseValue = 255 - (pawnOwner().curStealth-30)*1.3;
    }
}

defaultproperties
{
     Icons(0)=(bPulse=True,pulseDir=200.000000)
     Icons(1)=(pulseDir=200.000000)
     Icons(2)=(bPulse=True,pulseDir=200.000000)
     Icon(0)=(WidgetTexture=Texture'DA2HUD.HUD.Healing',RenderStyle=STY_Alpha,TextureCoords=(X2=127,Y2=127),TextureScale=0.300000,DrawPivot=DP_MiddleMiddle,PosX=0.810000,PosY=0.260000,ScaleMode=SM_Left,Scale=1.000000,Tints[0]=(B=255,G=255,R=255,A=255),Tints[1]=(B=255,G=255,R=255,A=255))
     Icon(1)=(WidgetTexture=Texture'DA2HUD.HUD.cloak',RenderStyle=STY_Alpha,TextureCoords=(X2=127,Y2=127),TextureScale=0.300000,DrawPivot=DP_MiddleMiddle,PosX=0.810000,PosY=0.160000,ScaleMode=SM_Left,Scale=1.000000,Tints[0]=(B=255,G=255,R=255,A=255),Tints[1]=(B=255,G=255,R=255,A=255))
     Icon(2)=(WidgetTexture=Texture'DA2HUD.HUD.Armor',RenderStyle=STY_Alpha,TextureCoords=(X2=127,Y2=127),TextureScale=0.300000,DrawPivot=DP_MiddleMiddle,PosX=0.810000,PosY=0.160000,ScaleMode=SM_Left,Scale=1.000000,Tints[0]=(B=255,G=255,R=255,A=255),Tints[1]=(B=255,G=255,R=255,A=255))
}
