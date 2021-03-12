//=============================================================================
// da_players_ZHud.
//=============================================================================
class da_players_ZHud extends da_players_Hud
	placeable;

var const int ZLeft;

simulated function checkDrawInfoBox(Canvas c) {
    local Actor a;
    local vector hitL, hitNorm, traceStart;

  traceStart = PawnOwner.Location + PawnOwner.BaseEyeHeight * vect(0,0,1) + PawnOwner.CollisionRadius * vector(playerOwner.getViewRotation());
  a = trace(hitL, hitNorm, traceStart + vector(playerOwner.getViewRotation()) * 2500, traceStart, true);

  if (pawn(a) != none && pawn(a).playerReplicationInfo != none && !a.IsA('Vehicle') && !a.isa('monster'))
       drawPlayerInfoBox(c, da_players_ClassPlayer(a));
  else if (da_buildable_Useable(a) != none)
     drawBuildableInfoBox(c, da_buildable_Useable(a));
  else if (da_turrets_Turret(a) != none)
    drawTurretInfoBox(c, da_turrets_Turret(a));
}

function postrender(canvas c)
{

local int i;

  super.postrender(c);

DrawShadowedText(c, c.SizeX, c.SizeX, whitecolor, "", true);

   c.style=erenderstyle.STY_normal;
   c.drawcolor.r=255;
   c.drawcolor.b=255;
   c.drawcolor.g=255;
   c.font=Font(DynamicLoadObject("DA2FontsDialog.DIN25", class'Font'));
   c.setpos(0.0 * c.clipx, 0.0835 * c.clipy);
   c.drawtile(texture'DA2HUD.HUD.HUDIR5',140,60,164,254,175,75);
   c.setpos(0.030 * c.clipx, 0.10 * c.clipy);
   c.drawtext(""$da_players_zpri(playerowner.playerreplicationinfo).zleft,true);

}

simulated function drawRadar(Canvas c)
{
    local actor A;
    local pawn p;
    local float Dist, RadarRadius, Angle, offset, DotSize, rCenterX, rCenterY;
    local rotator Dir;
    local vector Start;
    local float fade;
    local texture tex;
    local bool dnd;

    if(PRI==none || PRI.Team == none)
       return;

    RadarRadius=50*resScaleX;

    if(PawnOwner==None) Start=PlayerOwner.Location;
    else Start=PawnOwner.Location;

    rCenterX = C.ClipX-55*resScaleX;
    rCenterY = radarRadius+5*resScaleX;

    C.Style = ERenderStyle.STY_Alpha;
    c.SetPos(rCenterX - radarRadius, rCenterY - radarRadius);
    c.DrawTile(Texture'DA2Hud.HUD.HUDIR5', radarRadius * 2, radarRadius * 2, 270, 0, 242, 242);

    ForEach DynamicActors(class'Actor', A)
    {

        if(A!= none && A == PawnOwner)
            A=mos.currentObjective;

        Dist=VSize(Start*vect(1,1,0)-A.Location*vect(1,1,0));
        dnd=false;

        if(dist<3000) {

        fade=1-((level.timeseconds+(1-dist/4000.0))%1.0)*0.9;
        if(Dist>=2500) fade/=2.5;

        DotSize=C.ClipX*HUDScale/75;
        tex=texture'DA2Hud.SoftDot';
        c.DrawColor=C.MakeColor(0,0,0);

        P = Pawn(a);

        if( P != none && P.Health > 0)
        {
            if(da_turrets_turret(A) != none) {
                if(!da_turrets_turret(A).bBuilt)
                    fade/=3;
                tex=texture'DA2Hud.SoftBox';
            }

            if (P.GetTeamNum() == PRI.Team.TeamIndex)
            {
                if(da_players_classplayer(p)!=none && da_players_classplayer(p).resolveClassInfo().auraHealPerSec>0)
                    tex=texture'DA2Hud.SoftDotM';
                C.DrawColor.G = 255.0*fade;
            }
            else
            {
                if(P.bIsCrouched) fade*=0.1;
                   C.DrawColor.R = 255.0*fade;
            }
        }
        else if( A != none && A==mos.currentObjective && !da_objective_base(A).bDisabled)
        {
            DotSize*=1.5;
            tex=texture'DA2Hud.SoftBox';
            C.DrawColor.R=255.0*fade;
            C.DrawColor.G=222.0*fade;
        }
        else
        {
            if(A != none && da_items_worldammobox(A)!=none) {
                if(!da_items_worldammobox(a).bBuilt)
                    fade/=3;
                tex=texture'DA2Hud.SoftBox';
                DotSize*=0.9;
                C.DrawColor.R=100.0*fade;
                C.DrawColor.G=180.0*fade;
                C.DrawColor.B=130.0*fade;
            }
            else {
                dnd=true;
            }
        }

        if(!dnd) {
            Dist=fmin(2500,dist);
            Dir=rotator(A.Location-Start);
            Offset=dist/2500.0*radarRadius*0.80; //Buffer from edge of radar
            Angle=((Dir.Yaw-PlayerOwner.Rotation.Yaw)&65535)*6.2832/65536;

            C.Style = ERenderStyle.STY_Translucent;
            C.SetPos(rCenterX+offset*sin(Angle)-0.5*DotSize,
            rCenterY-offset*cos(Angle)-0.5*DotSize);
            C.DrawTile(tex,DotSize,DotSize,0,0,64,64);
        }
      }
  }
}

defaultproperties
{
}
