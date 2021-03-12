//==============================================================================
// Coded by: aBsOlUt
// Loading class for DA2 when a player joins a server. A screenshot of the map
// will be shown with the objectives of this map.
//==============================================================================

// D:\mods\UT2004Script3339\GUI2K4\Classes\UT2K4LoadingPageBase.uc
// D:\mods\UT2004Script3339\Engine\Classes\Vignette.uc

class da_ServerLoading extends UT2K4LoadingPageBase
	config(User);

#EXEC OBJ LOAD FILE=DA2Objectives.utx
#EXEC OBJ LOAD FILE=DA2GUI.utx PACKAGE=DA2GUI
// #EXEC OBJ LOAD FILE=DA2FontsBody.utx PACKAGE=DA2FontsBody

var() config array<string> Backgrounds;

simulated event Init()
{
    Super.Init();

	SetImage();
}

simulated function SetImage()
{
	local string str;
	local material mat;

    str = StripMap(MapName)$"OBJ";

		if ( str == "" )
			Warn("Invalid value for "$str);
		else mat = DLOTexture("DA2Objectives."$str);

	if ( mat == None )
	     mat = Material'DA2Objectives.Fallback';
         //log("Unable to find any valid objective image or custom map used. Using fallback.");


	DrawOpImage(Operations[0]).Image = mat;

	AddImage(Material'DA2GUI.logoMainMenu', 0.068, 0.0432, 0.171, 0.256); // [zeh]

    if ( Left(str, 3) == "MOV")
     	DrawOpText(Operations[1]).Text = "Loading...";
   	else
    	DrawOpText(Operations[1]).Text = "Loading "$StripMap(MapName)$"...";

}

simulated function string StripMap(string s)
{
	local int p;

	p = len(s);
	while (p>0)
	{
		if ( mid(s,p,1) == "." )
		{
			s = left(s,p);
			break;
		}
		else
		 p--;
	}

	p = len(s);
	while (p>0)
	{
		if ( mid(s,p,1) == "\\" || mid(s,p,1) == "/" || mid(s,p,1) == ":" )
			return Right(s,len(s)-p-1);
		else
		 p--;
	}

	return s;

}

defaultproperties
{
     Operations(0)=DrawOpImage'DA2.da_ServerLoading.OpBackground'
     Operations(1)=DrawOpText'DA2.da_ServerLoading.OpText'
}
