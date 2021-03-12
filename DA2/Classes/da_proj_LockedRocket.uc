class da_proj_LockedRocket extends da_proj_rocket;

var Actor lockedActor;

replication {
	reliable if (ROLE == ROLE_Authority)
		lockedActor;
}

simulated function tick(float deltaTime) {
    local vector tmp;

	if (lockedActor != none) {
		velocity = vsize(velocity) * vector(rotation);
		tmp = lockedActor.location - location;
		desiredRotation = rotator(lockedActor.velocity * vsize(tmp) / vsize(velocity) + tmp);
	}
}

defaultproperties
{
     bRotateToDesired=True
     RotationRate=(Pitch=16384,Yaw=16384)
}
