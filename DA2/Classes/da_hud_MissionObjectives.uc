//-----------------------------------------------------------
//
//-----------------------------------------------------------
class da_hud_MissionObjectives extends da_HudElement;

//Mission Update Box
var color ob_TitleColor;
var font ob_TitleFont;
var color ob_textColor;
var font ob_TextFont;
//==================

var float MUBSeconds;
var string MUBText;
var Texture mubFrame;
var material MUBImage;
var float frameBorderY, frameBorderX;
var bool bNoDrawBoxTemp;
var float faX, faY, fbX, fbY;

var ObjectivePointingArrow  OBJPointingArrow;
var da_objective_base currentObjective;


/* Commented for font loading
function init(da_HudElementList list, da_players_Hud h) {
    super.init(list, h);
    ob_TextFont = hud.LoadFont(6);
}
*/

function showObjectives() {
    if (currentObjective == none || PRI().Team == none)
        return;

    MUBSeconds = currentObjective.MUB[PRI().Team.TeamIndex].messageSeconds;
    MUBText = currentObjective.MUB[PRI().Team.TeamIndex].messageText;
    MUBImage = currentObjective.MUB[PRI().Team.TeamIndex].messageImage;
}

function updateObjective(da_objective_base old) {
    local da_objective_base obj, best;
    local int priority;
    if (PRI() == none) {
        currentObjective = none;
        return;
    }

    priority = -1;
    foreach allActors(class'da_objective_base', obj) {
        if (!obj.bDisabled && obj.DefensePriority > priority) {
            priority = obj.DefensePriority;
            best = obj;
        }
    }
    currentObjective = best;
    showObjectives();
	DA_players_playercontroller(playerowner).ServerShowPathToBase(1);
}

function postRender(Canvas c) {
    if (currentObjective==none || playerowner.myHUD.bShowScoreBoard)
        return;
    if (MUBSeconds > 0) {
        drawMissionBox(C);
        bNoDrawBoxTemp = false;
//        drawMissionImage(c);
    } 
	else
        bNoDrawBoxTemp = true;
    Draw3dObjectiveArrow(c);
}

simulated event tick(float deltaTime) {
    MUBSeconds = fmax(MUBSeconds - deltaTime, 0);
    if (PRI() != none && (currentObjective == none || currentObjective.bDisabled))
        updateObjective(none);
}

function GameObjective GetClosestObj()
{
    local float Distance, BestDistance;
    local int i;
    local da_objective_MultiObjective O;
    local GameObjective Best;

    BestDistance = 99999;

    foreach AllActors(class'da_objective_MultiObjective', O)
    {
          //Try to look for a closer one
            for (i = 0; i < O.objectives.length; i++)
            {
               Distance = VSize(PlayerOwner.Location - O.objectives[i].Location);
                  if ( Distance < BestDistance && !O.objectives[i].bDisabled ) {
                      BestDistance = Distance;
                      Best = O.objectives[i];
                  }
            }
     }
     return Best;
}

/* Draw Objective Pointing Arrow */
simulated function Draw3dObjectiveArrow( Canvas C )
{
    local GameObjective best;
    if(currentObjective==none || playerowner.myHUD.bShowScoreBoard)
        return;

    if ( OBJPointingArrow == None )
    {
        OBJPointingArrow = Spawn(class'da_hud_Arrow', PlayerOwner );

        if ( OBJPointingArrow == None )
            return;
    }

    c.Style=ERenderStyle.STY_Normal;
    C.DrawActor(None, false, true);

    if (da_objective_MultiObjective(currentObjective) != none)
    {
   	    best = GetClosestObj();
   	    OBJPointingArrow.Render( C, PlayerOwner, best );
    }
    else
        OBJPointingArrow.Render( C, PlayerOwner, currentObjective );
}

simulated function Destroyed()
{
    super.Destroyed();

    if( OBJPointingArrow != none )
    {
        OBJPointingArrow.Destroy();
        OBJPointingArrow = none;
    }

    currentObjective = none;
}

simulated function int instr2(String s, string t, int from) {
         local int tmp;
         if (from >= len(s))
           return -1;
//         log(from@"TXT"@"'"$right(s, len(s) - from)$"'");
         tmp = instr(right(s, len(s) - from), t);
         if (tmp < 0)
           return tmp;
        return tmp + from;
}

simulated function int drawTextBoxed(Canvas c, string text, float x, float y, float width, optional bool bNoDraw) {
    local int startPos, endPos, newEndPos;
    local float xl, yl, curY;
    local string tmp;

    curY = y;
	
	c.Font = da_players_hud(PlayerOwner.myHUD).GetMyTinyFont(C);
    
	while ( startPos < len(text) ) 
	{
		newEndPos = instr2(text, " ", endPos + 1);
		
		//             log(newEndPos);
		
		if ( newEndPos < 0 )
		{
			newEndPos = len(text);
		}
		
		tmp = c.mid(text, startPos, newEndPos - startPos);
		c.TextSize(tmp, xl, yl);
		
		if ( xl >= width || endPos >= len(text) )
		{
			c.SetPos(x, curY);
			//               log("Writing:"$tmp@"at"@x$"/"$c.sizeX@curY$"/"$c.sizeY);
			if ( !bNoDraw )
			{
				c.DrawText(c.mid(text, startPos, endPos - startPos));
			}
			
			curY += yl;
			startPos = ++endPos;
		} 
		else
		{
			endPos = newEndPos;
		}
    }

    return curY;
}

simulated function drawObjectivesBox(Canvas c, float x, float y, float width, string title, string text) {
        local float posY, posX, imgY;
        local float borderY, borderX;
        faX = x;
        faY = y;
        fbX = faX + width ;

        if (!bNoDrawBoxTemp) {
            c.Style = ERenderStyle.STY_Alpha;
            c.DrawColor = c.makeColor(255, 255, 255);
            borderY = frameBorderY * c.sizeY;
            borderX = frameBorderX * c.SizeX;
            c.setPos(faX - borderX, faY - borderY);
            c.DrawTile(mubFrame, fbX - faX + borderX * 2, fbY - faY + borderY * 1.5, 160, 340, 351, 171);
        }

        c.reset();
        c.drawColor = ob_TitleColor;
        if (ob_TitleFont != none)
          c.font = ob_TitleFont;
        posY = drawTextBoxed(c, title, x, y, width, bNoDrawBoxTemp);
        c.setPos(x, posY);
        if (MUBimage != none) {
            c.DrawTileScaled(MUBimage, 0.625, 0.625);
            posX += MUBimage.MaterialUSize() * 0.625;
			imgY = posY + MUBimage.MaterialVSize() * 0.625;
        }
        c.drawColor = ob_TextColor;
        if (ob_TextFont != none)
          c.font = ob_TextFont;
        fbY = drawTextBoxed(c, text, x + posX, posy, width - posX, bNoDrawBoxTemp);
		if (MUBimage != none)
			fbY = max(fbY, imgY);
}

simulated function drawMissionBox(Canvas c) {
//    drawObjectivesBox(c, c.SizeX * 0.825, c.SizeY * 0.3, c.SizeX * 0.15, "Mission Update", MUBtext);
    drawObjectivesBox(c, c.SizeX * 0.7425, c.SizeY * 0.3, c.SizeX * 0.23, "Mission Update", MUBtext);
}

simulated function drawObjectivesImage (Canvas c, float x, float y, material image)
{
        local float posY, posX, ImageScale;
        C.Style = ERenderStyle.STY_Alpha;
        ImageScale = 50 * hud.resScaleX;
        c.setPos(x, y);
          if (image != none) {
            c.DrawTile(image, ImageScale / 1.0, imageScale / 1.0, 0, 0, 128, 128);
            posX = 64.0;
            posY = 96.0;
        }
}


// ,RenderStyle=STY_Alpha,TextureCoords=(X1=160,Y1=340,X2=511,Y2=511),TextureScale=.5000,PosX=0.725,PosY=0.25,scaleMode=SM_DOWN,scale=1.00000,Tints[0]=(B=255,G=255,R=255,A=255),Tints[1]=(B=255,G=255,R=255,A=255))

defaultproperties
{
     ob_TitleColor=(B=255,G=255,R=255,A=255)
     ob_textColor=(B=255,G=255,R=255,A=255)
     mubFrame=Texture'DA2HUD.HUD.HUDIR5'
     frameBorderY=0.050000
     frameBorderX=0.020000
     bNoDrawBoxTemp=True
}
