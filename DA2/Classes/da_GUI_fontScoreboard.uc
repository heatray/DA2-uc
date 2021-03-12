class da_GUI_fontScoreboard extends GUIFont;

var int FontScreenWidth[6];

static function Font GetMidGameFont(int xRes) {
   local int i;
   for(i=0; i<6; i++) {
      if (default.FontScreenWidth[i] <= XRes) return LoadFontStatic(i);
   }

   return LoadFontStatic(5);
}

event Font GetFont(int XRes) {
   return GetMidGameFont(xRes);
}

defaultproperties
{
     FontScreenWidth(0)=2048
     FontScreenWidth(1)=1600
     FontScreenWidth(2)=1280
     FontScreenWidth(3)=1024
     FontScreenWidth(4)=800
     FontScreenWidth(5)=640
     KeyName="DA2ScoreboardFont"
     FallBackRes=640
     FontArrayNames(0)="DA2FontsDialog.DIN22"
     FontArrayNames(1)="DA2FontsDialog.DIN18"
     FontArrayNames(2)="DA2FontsDialog.DIN14"
     FontArrayNames(3)="DA2FontsDialog.DIN11"
     FontArrayNames(4)="DA2FontsDialog.DIN10"
     FontArrayNames(5)="DA2FontsDialog.DIN9"
}
