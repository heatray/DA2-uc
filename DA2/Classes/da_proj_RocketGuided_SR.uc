class da_proj_rocketGuided_SR extends da_proj_rocket_SR;


simulated function PostBeginPlay()
{
    super.PostBeginPlay();
    SetTimer(0.05, true);
}

simulated function Timer()
{
	local float seek, VelMag;
	local vector targ, ForceDir;

    if(instigator!=none)
    {
        if(instigator.controller!=none && aicontroller(instigator.controller)==none)
            targ=instigator.location+vector(instigator.GetViewRotation())*(vsize(instigator.location-location)*1.2);

        seek=0.05;
    }
    else
    {
        targ=location+vrand()*3000;
        seek=0.3;
    }

    ForceDir=Normal(targ-Location);
	VelMag = VSize(Velocity);
	ForceDir = Normal(ForceDir * seek * VelMag + Velocity);
	Velocity =  VelMag * ForceDir;
	SetRotation(rotator(Velocity));

	if(frand()<0.2)
       super.Timer();
}

defaultproperties
{
     Dispersion=40.000000
     ProjFX=Class'DA2.da_effects_RocketFXGuided'
     Speed=500.000000
     MaxSpeed=1500.000000
}
