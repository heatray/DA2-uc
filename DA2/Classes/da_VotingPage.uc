class da_VotingPage extends da_GUI_FloatingWindow_MapVote; //Largewindow DependsOn (da_VotingHandler);

var automated MapVoteFooter f_Chat;
var() editconst noexport VotingReplicationInfo MVRI;

//------------------------------------------------------------------------------------------------
function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	local PlayerController PC;

	Super.Initcomponent(MyController, MyOwner);

	PC = PlayerOwner();
	MVRI = VotingReplicationInfo(PC.VoteReplicationInfo);

	// Turn pause off if currently paused (stops replication)
	if(PlayerOwner() != None && PlayerOwner().Level.Pauser != None)
		PlayerOwner().SetPause(false);
}
//------------------------------------------------------------------------------------------------
function Free()
{
	MVRI = None;
    Super.Free();
}
//------------------------------------------------------------------------------------------------

defaultproperties
{
     Begin Object Class=da_MapVoteFooter Name=MatchSetupFooter
         WinTop=0.703124
         TabOrder=10
     End Object
     f_Chat=da_MapVoteFooter'DA2.da_VotingPage.MatchSetupFooter'

     bRequire640x480=False
     bAllowedAsLast=True
     WinTop=0.031250
     WinLeft=0.100000
     WinWidth=0.800000
     WinHeight=0.900000
     bAcceptsInput=False
}
