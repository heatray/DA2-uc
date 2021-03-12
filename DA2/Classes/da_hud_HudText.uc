//-----------------------------------------------------------
//
//-----------------------------------------------------------
class da_hud_HudText extends da_HudElement;

struct SKillMessage {
    var string  killText;
    var float   msgTime;
};

const messageTime = 12.0;
const maxMessages = 8.0;

var array<SKillMessage> killMessages;


simulated function string clampText(string s, int l) {
	if (len(s) > l - 3)
		return left(s, l)$"...";
	return s;
}

simulated function addKillMessage( class<LocalMessage> Message, optional int Switch, optional PlayerReplicationInfo RelatedPRI_1, optional PlayerReplicationInfo RelatedPRI_2, optional Object OptionalObject, optional String CriticalString) {
    local SKillMessage m;
    local string text;
    local int i;

    text=message.static.getString(switch, RelatedPRI_1, RelatedPRI_2, OptionalObject);
    if(InStr(text,"You")!=-1)
        return;

    if (killMessages.length >= maxMessages) {
        for (i = 0; i < maxMessages - 1; i++)
            killMessages[i] = killMessages[i + killMessages.length - maxMessages + 1];
        killMessages.length = maxMessages - 1;
    }

    //m.killText = left(message.static.getString(switch, RelatedPRI_1, RelatedPRI_2, OptionalObject), 30);
    m.killText = text;
    m.msgTime = level.TimeSeconds;
    killMessages[killMessages.length] = m;
}


function postRender(Canvas c) {
    local int i;
    local float y, tx, ty, alpha;
    local array<Color> shadowColor;

    if(pri()==none || playerowner.myHUD.bShowScoreBoard)
       return;

    c.Reset();
    shadowColor[0]= c.MakeColor(0,0,0);
	c.font = Font(DynamicLoadObject("DA2FontsDialog.DIN10", class'Font'));
    //c.Font = hud.LoadFont(8);

    y = c.sizeY*0.88;
    for (i = killMessages.Length; i > 0; i--) {
        c.TextSize(killMessages[i-1].killText, tx, ty);

        alpha=0.8*fmin(255,302-(level.timeseconds-killMessages[i-1].msgTime)*(299/messageTime));
        C.Style = ERenderStyle.STY_Alpha;

        c.DrawColor=c.MakeColor(0, 0, 0, alpha*0.5);

        c.SetPos(c.SizeX*0.14+1, y+1);
        c.DrawText(killMessages[i-1].killText);

        if(InStr(killMessages[i-1].killText,pri().playername)!=-1)
            c.DrawColor = c.MakeColor(200, 200, 200, alpha);
        else c.DrawColor = c.MakeColor(10, 110, 160, alpha);

        c.SetPos(c.SizeX*0.14, y);
        c.DrawText(killMessages[i-1].killText);
        y += ty;
    }

}

function updateHudData() {
    local int i, j;
    for (i = 0; i < killMessages.length; i++) {
        if (killMessages[i].msgTime + messageTime < level.TimeSeconds) {
            for (j = i; j < killMessages.length - 1; j++)
                killMessages[j] = killMessages[j + 1];
            killMessages.length = killMessages.length - 1;
        }
    }
}

defaultproperties
{
}
