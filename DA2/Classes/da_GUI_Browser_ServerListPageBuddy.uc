// D:\mods\UT2004Script3339\GUI2K4\Classes\UT2K4Browser_ServerListPageBuddy.uc

class da_GUI_Browser_ServerListPageBuddy extends UT2K4Browser_ServerListPageBuddy;

function InternalOnCreateComponent(GUIComponent NewComp, GUIComponent Sender)
{
	if (GUISplitter(NewComp) != None)
	{
		// This splitter already has a panel
		if (GUISplitter(Sender).Panels[0] != None)
		{
			// This splitter is the main splitter
			if (UT2K4Browser_ServerListPageBuddy(Sender.MenuOwner) != None)
			{
				sp_Buddy = GUISplitter(NewComp);
				sp_Buddy.DefaultPanels[0] = "DA2.da_GUI_Browser_ServerListBox"; // "GUI2K4.UT2K4Browser_ServerListBox";
				sp_Buddy.DefaultPanels[1] = "DA2.da_GUI_Splitter"; // "XInterface.GUISplitter";
				sp_Buddy.WinTop=0;
				sp_Buddy.WinLeft=0;
				sp_Buddy.WinWidth=1.0;
				sp_Buddy.WinHeight=1.0;
				sp_Buddy.bNeverFocus=True;
				sp_Buddy.bAcceptsInput=True;
				sp_Buddy.RenderWeight=0;
				sp_Buddy.OnCreateComponent=InternalOnCreateComponent;
				sp_Buddy.OnLoadIni=InternalOnLoadIni;
				sp_Buddy.OnReleaseSplitter=InternalReleaseSplitter;
				sp_Buddy.SplitOrientation=SPLIT_Vertical;
			}

			// This is the second panel of sp_Buddy splitter
			else Super.InternalOnCreateComponent(NewComp, Sender);
		}

		else
			Super.InternalOnCreateComponent(NewComp, Sender);
	}

	else if (UT2K4Browser_BuddyListBox(NewComp) != None)
	{
		lb_Buddy = UT2K4Browser_BuddyListBox(NewComp);
	}

	else Super.InternalOnCreateComponent(NewComp, Sender);
}

defaultproperties
{
     BuddyListBoxClass="DA2.da_GUI_Browser_BuddyListBox"
     Begin Object Class=da_GUI_Splitter Name=HorzSplitter
         SplitOrientation=SPLIT_Horizontal
         DefaultPanels(0)="DA2.da_GUI_Browser_BuddyListBox"
         DefaultPanels(1)="DA2.da_GUI_Splitter"
         OnReleaseSplitter=da_GUI_Browser_ServerListPageBuddy.InternalReleaseSplitter
         OnCreateComponent=da_GUI_Browser_ServerListPageBuddy.InternalOnCreateComponent
         IniOption="@Internal"
         WinHeight=1.000000
         RenderWeight=1.000000
         bBoundToParent=True
         bScaleToParent=True
         OnLoadINI=da_GUI_Browser_ServerListPageBuddy.InternalOnLoadINI
     End Object
     sp_Main=da_GUI_Splitter'DA2.da_GUI_Browser_ServerListPageBuddy.HorzSplitter'

     RulesListBoxClass="DA2.da_GUI_Browser_RulesListBox"
     PlayersListBoxClass="DA2.da_GUI_Browser_PlayersListBox"
     PanelCaption="Server Browser | Internet"
     bStandardized=True
     StandardHeight=0.800000
}
