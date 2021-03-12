//-----------------------------------------------------------
//
//-----------------------------------------------------------
class da_GUI_Utilities extends Actor;

simulated static function material getCorrectBackground (canvas c) {

	local int sw, sh;

	sw = c.SizeX;
	sh = c.SizeY;
	
	// Sets the main dialog background according to the current resolution.
	// This is crazyness but it's the best way to do it
	// IF images could be correctly aligned to each other or IF you could set an arbitrary scale on ISTY_Streched, the additional images wouldn't be need
	if (sh <= 240) {
		return material'DA2GUI.window_320x240';
	} else if (sh <= 384) {
		return material'DA2GUI.window_512x384';
	} else if (sh <= 480) {
		return material'DA2GUI.window_640x480';
	} else if (sh <= 600) {
		return material'DA2GUI.window_800x600';
	} else if (sh <= 768) {
		return material'DA2GUI.window_1024x768';
	} else if (sh <= 864) {
		return material'DA2GUI.window_1152x864';
	} else if (sh <= 900) {
		return material'DA2GUI.window_1280x900';
	} else if (sh <= 960) {
		return material'DA2GUI.window_1280x960';
	} else if (sh <= 1024) {
		return material'DA2GUI.window_1280x1024';
	} else if (sh <= 1200) {
		return material'DA2GUI.window_1600x1200';
	} else {
		return material'DA2GUI.window_2048x1536';
	}
}

defaultproperties
{
     bHidden=True
}
