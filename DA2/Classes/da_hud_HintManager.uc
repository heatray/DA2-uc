//=============================================================================
// da_hud_HintManager
//=============================================================================
// This class manages (most) of the hinting system stuff. It is spawned and
// referenced in da_players_PlayerController. It also interfaces with the Hud 
// to display the hints on screen. Finally, config variables are used to
//=============================================================================
class da_hud_HintManager extends Info
    config(User);

// Data structures
struct HintInfo
{
    var() int                   type;
    var() int                   priority; 	// 1 = highest priority, 2 = lower than 0, etc
    var() int                   delay; 		// how many seconds to wait before displaying the hint
    var() string      			title;
    var() string      			hint;   	// actual hint text
    var int                     index; 		// set in code, do not use!
};

// Constants
const                           MAX_HINT_TYPES = 61;
const                           MAX_HINTS = 61;

// config variables
var()   float                   PostHintDisplayDelay;           // How long to wait before displaying any other hint (value higher than 0 needed)
var()   float                   SameHintTypePostDisplayDelay;   // How long to wait before authorizing a hint from same type to be displayed (value higher than 0 needed)
var()   HintInfo                Hints[MAX_HINTS];
var     config  int             bUsedUpHints[MAX_HINTS]; 		// 0 = hint unused, 1 = hint used before
var     float                   RandomHintTimerDelay;

// Hints array
var     int                     HintsAvailableByType[MAX_HINT_TYPES];
var     array<HintInfo>         SortedHints;

// State variables
var     HintInfo                CurrentHint; 					// Copy of hint for convenience
var     int                     CurrentHintIndex; 				// Index in the SortedHints array
var     float                   LastHintDisplayTime;
var     int                     LastHintType;


function PostBeginPlay()
{
    super.PostBeginPlay();
    LastHintType = -1;
    LoadHints();
}

static function StaticReset()
{
    local int i;
    for (i = 0; i < MAX_HINT_TYPES; i++)
        default.bUsedUpHints[i] = 0;
    StaticSaveConfig();
}

function NonStaticReset()
{
    local int i;
    for (i = 0; i < MAX_HINT_TYPES; i++)
        bUsedUpHints[i] = 0;
    SaveConfig();
    Reload();
}

function Reload()
{
    StopHinting();
    LoadHints();
}

function LoadHints()
{
    local int i, j, index, priority;

    // Initialize arrays to 0
    SortedHints.Length = 0;
    for (i = 0; i < MAX_HINT_TYPES; i++)
        HintsAvailableByType[i] = 0;

    // Sort hints in the SortedHints by priority -- highest priority hints
    // get placed first. At same time, build array of available hints
    // using id of used hints
    for (i = 0; i < MAX_HINT_TYPES; i++)
    {
        Hints[i].index = i;

        // Check if we should add this hint
        if (bUsedUpHints[i] == 0 && Hints[i].title != "")
        {
            HintsAvailableByType[Hints[i].type]++;

            // Find where we should insert the new hint
            priority = Hints[i].priority;
            index = -1;
            for (j = 0; j < SortedHints.Length; j++)
                if (SortedHints[j].priority >= priority)
                {
                    index = j;
                    break;
                }

            // Add hint to proper position
            if (index == -1)
                SortedHints[SortedHints.Length] = Hints[i];
            else
            {
                SortedHints.Insert(index, 1);
                SortedHints[index] = Hints[i];
            }
        }
    }
}

function CheckForHint(int hintType)
{
    local int i;

	if (HintsAvailableByType[hintType] == 0)
	{
		return;
    }

    // Check if we're allowed to display a hint of this type at this time
    if (LastHintType == hintType)
    {
        if (level.TimeSeconds - LastHintDisplayTime < SameHintTypePostDisplayDelay)
        {
			return;
        }
	}

    // We have available hints! Search array for first non-used hint of that type.
    // (first == highest priority)
    for (i = 0; i < SortedHints.Length; i++)
    {
		if (SortedHints[i].type == hintType)
        {
			CurrentHint = SortedHints[i];
            CurrentHintIndex = i;
            SetTimer(0, false);
            GotoState('PreHintDelay');
            return;
        }
    }

    // If we got here it means that hint couldn't be found. wtf?
    warn("Unable to find hint type '" $ hintType $ "' in SortedHints array, even though HintsAvailableByType"
        $ " indicates that there are " $ HintsAvailableByType[hintType] $ " hints of that type available!");
}

function StopHinting()
{
    GotoState('');
    SetTimer(0, false);
}

// Implemented in WaitHintDone state
function NotifyHintRenderingDone() {}

// Used to dump hint info to console
function DumpHints()
{
    local int i;
    log("Hint availability list:");
    for (i = 0; i < MAX_HINT_TYPES; i++)
        log("#" $ i $ " availability: " $ HintsAvailableByType[i]);
    log("Max number of hints in db: " $ MAX_HINT_TYPES);
    for (i = 0; i < MAX_HINT_TYPES; i++)
        log("#" $ i $ ", type = " $ hints[i].type
            $ ", pri = " $ hints[i].priority
            $ ", delay = " $ hints[i].delay
            $ ", used = " $ bUsedUpHints[i]
            $ ", title = '" $ hints[i].title $ "'"
            $ ", text = '" $ hints[i].hint $ "'");
    log("Hints in sorted array: " $ SortedHints.Length);
    for (i = 0; i < SortedHints.length; i++)
        log("#" $ i $ ", type = " $ SortedHints[i].type
            $ ", pri = " $ SortedHints[i].priority
            $ ", delay = " $ SortedHints[i].delay
            $ ", used = " $ bUsedUpHints[SortedHints[i].index]
            $ ", title = '" $ SortedHints[i].title $ "'"
            $ ", text = '" $ SortedHints[i].hint $ "'");

}

simulated function Timer()
{
    CheckForHint(60);
}

// This state is used when we want to show a hint.
state PreHintDelay
{
    function BeginState()
    {
		if (CurrentHint.delay ~= 0)
            GotoState('WaitHintDone');
        else
            SetTimer(CurrentHint.delay, false);
    }

    // Don't allow another hint to be scheduled when we have one scheduled already
    function CheckForHint(int hintType) {}

    function Timer()
    {
        GotoState('WaitHintDone');
    }
}

state WaitHintDone
{
    function BeginState()
    {
        local da_players_PlayerController player;
        
		// Tell da_players_Hud to display the hint
        player = da_players_PlayerController(Owner);
        
		if ( player != none && da_players_Hud(player.myHud) != none &&
             !da_players_Hud(player.myHud).bHideHud )
        {
            da_players_Hud(player.myHud).ShowHint(CurrentHint.title, CurrentHint.hint);
        }
        else
        {
            SetTimer(RandomHintTimerDelay, true);
            GotoState('');
        }
    }

    // Don't allow another hint to be scheduled when we're displaying one already
    function CheckForHint(int hintType) {}

    function NotifyHintRenderingDone()
    {
        // Hurray, hint done rendering! Switch to post-hint state.
        GotoState('PostDisplay');
    }
}

state PostDisplay
{
    function BeginState()
    {
        LastHintType = CurrentHint.type;
        LastHintDisplayTime = Level.TimeSeconds;
        SetTimer(PostHintDisplayDelay, false);
    }

    // Don't allow another hint to be scheduled until post-display delay is completed.
    function CheckForHint(int hintType) {}

    function Timer()
    {
        // Mark this hint as used up
        //log("setting hint #" $ CurrentHint.index $ " as used up.");
        log("bUsedUpHints["$CurrentHint.index$"] was:" @ bUsedUpHints[CurrentHint.index]);
		bUsedUpHints[CurrentHint.index] = 1;
        //SaveConfig();
		
        log("bUsedUpHints["$CurrentHint.index$"] is now:" @ bUsedUpHints[CurrentHint.index]);

        // Update hint availability list
        // HintsAvailableByType[CurrentHint.type]--;

        // Remove current hint from hints list
        //log("Removing from sortedhints array. old length = " $ SortedHints.Length);
        //SortedHints.Remove(CurrentHintIndex, 1);
        //log("                                 new length = " $ SortedHints.Length);

        // Go back to 'idle' state
        SetTimer(RandomHintTimerDelay, true);
        GotoState('');
    }
}

defaultproperties
{
     PostHintDisplayDelay=1.000000
     SameHintTypePostDisplayDelay=2.000000
     Hints(0)=(Type=10,Delay=1,Title="Grenades",Hint="Press %throwNade% to throw a grenade.")
     Hints(1)=(Type=11,Delay=1,Title="Aiming",Hint="Press %ToggleAiming% to go into iron sights.")
     Hints(2)=(Type=12,Delay=1,Title="Objectives",Hint="Press %showMissionObjectives% | to highlight the current objective and show a path to it")
     Hints(3)=(Type=13,Delay=1,Title="Flares",Hint="Press %throwFlare% to launch a flare.")
     Hints(4)=(Type=14,Delay=1,Title="Class Menu",Hint="Press %showccmenu% to change your class.")
     Hints(5)=(Type=15,Delay=1,Title="Melee",Hint="Press %MeleeAttack% to to melee")
     Hints(6)=(Type=16,Delay=1,Title="Stealth",Hint="You become less visible as a sniper | when not moving")
     Hints(7)=(Type=17,Delay=1,Title="Rockets",Hint="Press %AltFire% to launch a rocket | you can guide with your mouse")
     Hints(8)=(Type=18,Delay=1,Title="Medic",Hint="You are healed by a nearby medic!")
     Hints(9)=(Type=19,Delay=1,Title="Medic",Hint="You are healing a nearby teammate!")
     Hints(10)=(Type=20,Delay=1,Title="Survival",Hint="Your team has no lives left | kill additional specimens to accumulate more lives.")
     RandomHintTimerDelay=29.000000
}
