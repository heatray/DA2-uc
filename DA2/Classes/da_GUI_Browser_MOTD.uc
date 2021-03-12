// D:\mods\UT2004Script3339\GUI2K4\Classes\UT2K4Browser_MOTD.uc
// 25th Sep. 2005 : Added support for our own motd - Dante

class da_GUI_Browser_MOTD extends UT2K4Browser_MOTD;

var da_net_HttpLink link;
var String host, path;


function ReceivedMOTD( MasterServerClient.EMOTDResponse Command, string Data )
{
  if (Command != MR_MOTD)
    super.receivedMOTD(command, data);
  else {
    GotMOTD = true;
//    log(data);

        EnableComponent(b_QuickConnect);
  }
}

function Refresh()
{
	KillTimer();
	bUpgrade = false;

	CheckJoinButton(False);

	lb_MOTD.Stop();
	RetryCount = 0;
	ResetQueryClient( Browser.Uplink() );
	Browser.Uplink().StartQuery(CTM_GetMOTD);

	if (link == none)
		link = controller.viewPortOwner.actor.spawn(class'da_net_HttpLink');
	link.contentReceived = received;
	link.GETRequest(host, path);
}

function received(String text)
{
//  if (text == "")
//    lb_MOTD.setContent("Error retrieving news!", chr(13));
//  else
//     lb_MOTD.SetContent(text, Chr(13));

    lb_MOTD.setContent("Welcome to Defence Alliance 2 Multiplayer!", chr(13)); // Replacement
}

function QueryComplete( MasterServerClient.EResponseInfo ResponseInfo, int Info )
{
}

defaultproperties
{
     Host="www.defencealliancegame.com"
     Path="http://www.defencealliancegame.com/da/news.txt"
     Begin Object Class=da_GUI_ScrollTextBox Name=MyMOTDText
         bNoTeletype=True
         CharDelay=0.050000
         EOLDelay=0.100000
         bVisibleWhenEmpty=True
         OnCreateComponent=MyMOTDText.InternalOnCreateComponent
         StyleName="DA2Style_Lowered"
         WinLeft=0.010000
         WinWidth=0.980000
         WinHeight=0.833203
         RenderWeight=0.600000
         TabOrder=1
         bNeverFocus=True
     End Object
     lb_MOTD=da_GUI_ScrollTextBox'DA2.da_GUI_Browser_MOTD.MyMOTDText'

     Begin Object Class=GUILabel Name=VersionNum
         TextAlign=TXTA_Right
         StyleName="DA2Style_BodyText"
         WinTop=0.890000
         WinLeft=0.789000
         WinWidth=0.202128
         WinHeight=0.040000
         RenderWeight=20.700001
     End Object
     l_Version=GUILabel'DA2.da_GUI_Browser_MOTD.VersionNum'

     Begin Object Class=da_GUI_Button Name=QuickPlay
         Caption="QUICK PLAY"
         Hint="Open a dialog that can help you easily find the best online server based on your criteria"
         WinTop=0.866146
         WinLeft=0.400000
         WinWidth=0.200000
         WinHeight=0.079063
         TabOrder=2
         OnClick=da_GUI_Browser_MOTD.InternalOnClick
         OnKeyEvent=QuickPlay.InternalOnKeyEvent
     End Object
     b_QuickConnect=da_GUI_Button'DA2.da_GUI_Browser_MOTD.QuickPlay'

     QuickConnectMenu="DA2.da_GUI_QuickPlay"
     PanelCaption="News from Defence Alliance Studios"
}
