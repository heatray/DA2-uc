class SurvivalInteraction extends Interaction;

var HUD ThisHudOfMine;
event Initialized()
{
	ThisHudOfMine = ViewportOwner.Actor.spawn(class'SurvivalHud', ViewportOwner.Actor);
	Log("SurvivalInteraction initialized!");
}
 
function PostRender(Canvas c)
{
	ThisHudOfMine.PostRender(c);
}

defaultproperties
{
     bVisible=True
}
