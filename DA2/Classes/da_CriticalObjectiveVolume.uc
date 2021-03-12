class da_CriticalObjectiveVolume extends ASCriticalObjectiveVolume;

var Pawn lastToucher;

auto state Safe
{
    event Touch( Actor Other ) {
        if (pawn(other) != none)
            lastToucher = pawn(other);
        super.touch(other);
    }
}

state Critical {
    function beginState() {
        super.beginState();
        triggerEvent(event, self, lastToucher);
    }

    function TimerPop(VolumeTimer T)
    {
        if ( !IsStillCritical() ) {
            GotoState('Safe');
            untriggerEvent(event, self, lastToucher);
        }
    }
}

defaultproperties
{
}
