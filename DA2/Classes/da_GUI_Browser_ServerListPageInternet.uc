// D:\mods\UT2004Script3339\GUI2K4\Classes\UT2K4Browser_ServerListPageInternet.uc
// D:\mods\UT2004Script3339\GUI2K4\Classes\UT2K4Browser_ServerListPageMS.uc
// D:\mods\UT2004Script3339\GUI2K4\Classes\UT2K4Browser_ServerListPageBase.uc

class da_GUI_Browser_ServerListPageInternet extends UT2K4Browser_ServerListPageInternet;

var protected ROMasterServerClient  ROMSC;

var	bool						bQueryRunning;
var	localized 	string			ServerCountString;

function ShowPanel(bool bShow)
{
	if ( bShow )
	{
        if ( bInit )
        {
            sp_Main.SplitterUpdatePositions();
            sp_Detail.SplitterUpdatePositions();
        }

		Browser.t_Header.SetCaption(PanelCaption);
		RefreshFooter(self, string(!bCommonButtonWidth));
    	SetFooterCaption(CurrentFooterCaption);

		Uplink().bInternetQueryRunning = true;
		bQueryRunning = true;
		Refresh();

		bInit = false;
	}
    else if ( !bInit )
    {
    	// Remove all outstanding pings so that they will be repinged when this panel is made active again
    	// Otherwise, we'll get stuck if the new active tab is using the same masterserveruplink
		li_Server.OutstandingPings.Remove(0, li_Server.OutstandingPings.Length);
	}

	SetVisibility(bShow);
}

function InitServerList()
{
	super(UT2k4Browser_ServerListPageBase).InitServerList();
	li_Server.bPresort = True;
}

function BindQueryClient(ServerQueryClient Client)
{
}

function ROMasterServerClient Uplink()
{
	if ( ROMSC == None && PlayerOwner() != None )
	{
		ROMSC = PlayerOwner().Spawn(class'ROMasterServerClient');
		ROMSC.OnReceivedServer		= MyOnReceivedServer;
		ROMSC.OnQueryFinished		= QueryComplete;
		ROMSC.OnReceivedPingInfo	= ReceivedPingInfo;
		ROMSC.OnPingTimeout			= ReceivedPingTimeout;
	}

	return ROMSC;
}

function NewGameType(GUIComponent Sender)
{
}

function GameTypeChanged(UT2K4Browser_ServersList NewList)
{
}

function AddQueryTerm(coerce string Key, coerce string Value, MasterServerClient.EQueryType QueryType)
{
	local MasterServerClient.QueryData QD;
	local int i;

	for ( i = 0; i < Uplink().Query.Length; i++ )
	{
		QD = Uplink().Query[i];
		if ( QD.Key ~= Key && QD.Value ~= Value && QD.QueryType == QueryType )
			return;
	}

	QD.Key			= Key;
	QD.Value		= Value;
	QD.QueryType	= QueryType;

	Uplink().Query[i] = QD;
}

function bool ValidateQueryItem(CustomFilter.EDataType FilterType, MasterServerClient.QueryData Data)
{
	local int i;

	if ( Data.QueryType == QT_Disabled )
	{
		return false;
	}

	switch ( FilterType )
	{
		case DT_Unique:
			for ( i = 0; i < Uplink().Query.Length; i++ )
			{
				if ( Uplink().Query[i].Key == Data.Key )
				{
					return false;
				}
			}

   			return true;

		case DT_Ranged:
			if ( Data.QueryType == QT_NotEquals )
			{
				return false;
			}

			for (i = 0; i < Uplink().Query.Length; i++)
			{
				if (Uplink().Query[i].Key == Data.Key)
				{
					if (Data.QueryType == QT_Equals)
					   return false;

  					switch (Uplink().Query[i].QueryType)
					{
						case QT_GreaterThan:
							if (Data.QueryType == QT_GreaterThanEquals)
								return false;

						case QT_GreaterThanEquals:
							if (Data.QueryType == QT_GreaterThan)
								return false;

							if (Uplink().Query[i].Value >= Data.Value)
							   return false;

                            break;

						case QT_LessThan:
						     if (Data.QueryType == QT_LessThanEquals)
						        return false;

						case QT_LessThanEquals:
						     if (Data.QueryType == QT_LessThan)
						        return false;

			                 if (Uplink().Query[i].Value <= Data.Value)
			                    return false;

					}

					break;
				}
			}

			return true;

		case DT_Multiple:
		     for (i = 0; i < Uplink().Query.Length; i++)
		         if ((Uplink().Query[i].Key == Data.Key) &&
		         	 (Uplink().Query[i].Value == Data.Value))
		               return false;

			return true;
	}

	return false;
}

function NotifyLevelChange()
{
	if ( ROMSC != none )
	{
		ROMSC.Stop();
		ROMSC.Destroy();
		ROMSC = none;
	}
}

function MyOnReceivedServer(GameInfo.ServerResponseLine s)
{
	local int i;

	SetTimer(60.0);

	for ( i = 0; i < li_Server.Servers.Length; i++ )
	{
		if ( s.IP == li_Server.Servers[i].IP && s.Port == li_Server.Servers[i].Port )
		{
			return;
		}
	}

	li_Server.MyOnReceivedServer(s);
	li_Server.AddedItem();
	li_Server.SortList();
	li_Server.AutoPingServers();
	SetFooterCaption(Repl(ServerCountString, "%NumServers%", Uplink().ResultCount));
}

// We have list of servers from master server and are going to start pinging
function QueryComplete( MasterServerClient.EResponseInfo ResponseInfo, int Info )
{
	li_Server.MyQueryFinished(ResponseInfo, Info);

	switch ( ResponseInfo )
	{
		case RI_Success:
			SetFooterCaption(Repl(QueryCompleteString, "%NumServers%", Uplink().ResultCount));
			break;

		case RI_AuthenticationFailed:
			SetFooterCaption(AuthFailString);
			break;

		case RI_ConnectionFailed:
	    	UT2K4ServerBrowser(PageOwner).GetFromServerCache(li_Server);
	    	li_Server.FakeFinished();
			SetFooterCaption(ConnFailString);
			break;

		case RI_ConnectionTimeout:
	    	UT2K4ServerBrowser(PageOwner).GetFromServerCache(li_Server);
	    	li_Server.FakeFinished();
			SetFooterCaption(ConnTimeoutString);
			break;

		case RI_MustUpgrade:
			SetFooterCaption(MustUpgradeString);
			break;
	}

	li_Server.SortList();
}

event Timer()
{
	if ( bQueryRunning )
	{
		bQueryRunning = false;
		Uplink().Stop();
		QueryComplete(RI_Success, 0);
	}
}

function Refresh()
{
	local int i, j;
	local string TmpString;
	local array<CustomFilter.AFilterRule> Rules;
	local MasterServerClient.QueryData QueryItem;

	if ( bQueryRunning )
	{
		SetTimer(0.0);
		Uplink().Stop();
	}
	else
	{
		bQueryRunning = true;
	}

	ResetQueryClient(Uplink());

    if ( li_Server == none )
    {
        InitServerList();
    }
    else
    {
		li_Server.StopPings();
		li_Server.InvalidatePings();
    }

    li_Server.Clear();

	// Add any extra filtering to the query
	for ( i = 0; i < FilterMaster.AllFilters.Length; i++ )
	{
		if ( FilterMaster.IsActiveAt(i) )
		{
			Rules = FilterMaster.GetFilterRules(i);
			for ( j = 0; j < Rules.Length; j++ )
			{
				QueryItem = Rules[j].FilterItem;
				if ( ValidateQueryItem(Rules[j].FilterType, QueryItem) )
				{
					TmpString = QueryItem.Value;
					if ( QueryItem.QueryType < 2 )
					{
						class'CustomFilter'.static.ChopClass(TmpString);
					}

					AddQueryTerm(QueryItem.Key, TmpString, QueryItem.QueryType);
				}
			}
		}
	}

	// Run query
	Uplink().StartQuery(CTM_Query);
	SetFooterCaption(StartQueryString);
}

function UpdateStatusPingCount()
{
    CheckJoinButton(li_Server.IsValid());
    CheckSpectateButton(li_Server.IsValid());
}

function CancelPings()
{
    Uplink().CancelPings();
    SetFooterCaption(ReadyString);
}

function PingServer(int listid, ServerQueryClient.EPingCause PingCause, GameInfo.ServerResponseLine s)
{
    if( PingCause == PC_Clicked )
        Uplink().PingServer( listid, PingCause, s.IP, s.QueryPort, QI_RulesAndPlayers, s );
    else
        Uplink().PingServer( listid, PingCause, s.IP, s.QueryPort, QI_Ping, s );
}

function CloseMSConnection()
{
	if ( Browser != None )
	{
		Uplink().CancelPings();
	    Uplink().Stop();
	}
}

defaultproperties
{
     ServerCountString="Received: %NumServers% Servers"
     Begin Object Class=da_GUI_Splitter Name=HorzSplitter
         DefaultPanels(0)="DA2.da_GUI_Browser_ServerListBox"
         DefaultPanels(1)="DA2.da_GUI_Splitter"
         MaxPercentage=0.900000
         OnReleaseSplitter=da_GUI_Browser_ServerListPageInternet.InternalReleaseSplitter
         OnCreateComponent=da_GUI_Browser_ServerListPageInternet.InternalOnCreateComponent
         IniOption="@Internal"
         WinHeight=1.000000
         RenderWeight=1.000000
         OnLoadINI=da_GUI_Browser_ServerListPageInternet.InternalOnLoadINI
     End Object
     sp_Main=da_GUI_Splitter'DA2.da_GUI_Browser_ServerListPageInternet.HorzSplitter'

     RulesListBoxClass="DA2.da_GUI_Browser_RulesListBox"
     PlayersListBoxClass="DA2.da_GUI_Browser_PlayersListBox"
     PanelCaption="Server Browser | Internet"
     bStandardized=True
     StandardHeight=0.700000
}
