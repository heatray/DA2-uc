class da_effects_HitDust extends Effects;

var sound bulletImpact[6];

simulated function PostNetBeginPlay()
{
	Super.PostNetBeginPlay();

	if ( Role == ROLE_Authority )
	{
		if ( Instigator != None )
			MakeNoise(0.3);
	}
	if ( Level.NetMode != NM_DedicatedServer )
		SpawnEffects();
}

simulated function SpawnEffects()
{
    local playercontroller P;

	if ( PhysicsVolume.bWaterVolume )
		return;

    P = Level.GetLocalPlayerController();
	if ( (P != None) && (P.ViewTarget != None) && (VSize(P.Viewtarget.Location - Location) < 1600*P.FOVBias) && ((vector(P.Rotation) dot (Location - P.ViewTarget.Location)) > 0) )
		Spawn(class'BulletHoleDirt',self,,Location, rotator(-1 * vector(Rotation)));

    if ( PhysicsVolume.bWaterVolume )
		return;

	PlaySound(bulletImpact[Rand(6)],,0.8,,450);

    Spawn(class'DA2.da_effects_Dust');
}

defaultproperties
{
     bulletImpact(0)=Sound'DA2_Various.BulletHit1'
     bulletImpact(1)=Sound'DA2_Various.BulletHit2'
     bulletImpact(2)=Sound'DA2_Various.BulletHit3'
     bulletImpact(3)=Sound'DA2_Various.BulletHit4'
     bulletImpact(4)=Sound'DA2_Various.BulletHit5'
     bulletImpact(5)=Sound'DA2_Various.BulletHit6'
     DrawType=DT_None
     CullDistance=7000.000000
     LifeSpan=1.000000
     Style=STY_Additive
}
