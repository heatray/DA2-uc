//=============================================================================
// Husk.
//=============================================================================
class Husk extends ZombieHusk
	placeable;


function SpawnTwoShots()
{
	local vector X,Y,Z, FireStart;
	local rotator FireRotation;
	local KFMonsterController KFMonstControl;

	if( Controller!=None && KFDoorMover(Controller.Target)!=None )
	{
		Controller.Target.TakeDamage(22,Self,Location,vect(0,0,0),Class'DamTypeVomit');
		return;
	}

	GetAxes(Rotation,X,Y,Z);
	FireStart = GetBoneCoords('Barrel').Origin;
	if ( !SavedFireProperties.bInitialized )
	{
		SavedFireProperties.AmmoClass = Class'SkaarjAmmo';
		SavedFireProperties.ProjectileClass = Class'HuskFireProjectile';
		SavedFireProperties.WarnTargetPct = 1;
		SavedFireProperties.MaxRange = 65535;
		SavedFireProperties.bTossed = False;
		SavedFireProperties.bTrySplash = true;
		SavedFireProperties.bLeadTarget = True;
		SavedFireProperties.bInstantHit = False;
		SavedFireProperties.bInitialized = True;
	}

    // Turn off extra collision before spawning vomit, otherwise spawn fails
    ToggleAuxCollision(false);

	FireRotation = Controller.AdjustAim(SavedFireProperties,FireStart,600);

	foreach DynamicActors(class'KFMonsterController', KFMonstControl)
	{
        if( KFMonstControl != Controller )
        {
            if( PointDistToLine(KFMonstControl.Pawn.Location, vector(FireRotation), FireStart) < 75 )
            {
                KFMonstControl.GetOutOfTheWayOfShot(vector(FireRotation),FireStart);
            }
        }
	}

    Spawn(Class'daHuskFireProjectile',,,FireStart,FireRotation);

	// Turn extra collision back on
	ToggleAuxCollision(true);
}

simulated function takedamage( int Damage, Pawn InstigatedBy, Vector Hitlocation, Vector Momentum, class<DamageType> damageType, optional int HitIndex)
{

super.takedamage(Damage, InstigatedBy, Hitlocation, Momentum, damageType);

spawn(class'kfbloodtrail',,,hitlocation);
}

simulated function tick(float d){


super.tick(d);


ragdolloverride="Burns_Trip";


}

defaultproperties
{
     Begin Object Class=KarmaParamsSkel Name=KarmaParamsSkel17
         KConvulseSpacing=(Max=2.200000)
         KLinearDamping=0.150000
         KAngularDamping=0.050000
         KBuoyancy=1.000000
         KStartEnabled=True
         KVelDropBelowThreshold=50.000000
         bHighDetailOnly=False
         KFriction=1.300000
         KRestitution=0.200000
         KImpactThreshold=85.000000
     End Object
     KParams=KarmaParamsSkel'DA2.Husk.KarmaParamsSkel17'

}
