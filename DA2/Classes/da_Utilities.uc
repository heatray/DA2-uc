//-----------------------------------------------------------
//
//-----------------------------------------------------------
class da_Utilities extends Actor;

simulated static final function fillRect(Canvas c, float x, float y, float width, float height) {
	local float _x, _y;
	_x = c.curX;
	_y = c.curY;
	c.curX = x;
	c.curY = y;
	c.DrawTile(Texture'engine.WhiteSquareTexture', width, height, 0, 0, 2, 2);
	c.curX = _x;
	c.curY = _y;
}

simulated static function float getWidth(Canvas c, string txt) {
	local float w, h;
	c.textSize(txt, w, h);
	return w;
}

simulated static function drawText(Canvas c, float x, float y, string txt, optional bool bCenter) {
	if (bCenter)
		c.setPos(x - getWidth(c, txt) / 2.0, y);
	else
		c.setPos(x, y);
	c.drawText(txt);
}

simulated static function string format(float number, int decPlaces) {
    local int tmp;
    local string result;
    tmp = int(number * (10 ** decPlaces));
    result = string(tmp);
    while (len(result) < decPlaces + 1)
        result = "0"$result;
    tmp = len(result);
    result = left(result, tmp - decPlaces) $ "." $ right(result, decPlaces);
    return result;
}

simulated static function string getVersionString() {
	return "Beta 2.2 for Killing Floor";
}

defaultproperties
{
     bHidden=True
}
