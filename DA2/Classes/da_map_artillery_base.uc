class da_map_artillery_base extends Mover;

var		Controller	ControlledBy;
var		rotator		oldViewRotation;
var		rotator		initialRotation;
var()	float		maxYawDeltaPerSecond;	// max rotation per second
var()	int			maxYawDeltaAngle;			// max angular difference
var()	bool		bUseMaxYaw;

replication {
	reliable if ( ROLE == ROLE_Authority )
		ControlledBy;
}

state() ControlledBase {
	event BeginState() {
		initialRotation= Normalize( Rotation );
	}

	event Trigger( Actor Other, Pawn EventInstigator ) {
		if ( EventInstigator.Controller == None )
			return;
		ControlledBy= EventInstigator.Controller;
		oldViewRotation= ControlledBy.getViewRotation();
		enable('Tick');
	}

	event UnTrigger( Actor Other, Pawn EventInstigator ) {
		if ( ControlledBy == none )
			return;
		removeController();
	}

	function removeController() {
		ControlledBy= None;
		disable('Tick');
	}

	simulated event Tick( float DeltaTime ) {
		local rotator	viewRotation, deltaRotation, newRot;
		local float	 	minYaw, maxYaw;
		if ( ControlledBy == None || ControlledBy.Pawn == None ) {
			if ( ROLE == ROLE_Authority )
				removeController();
			return;
		}
		if ( ROLE < ROLE_Authority && ( PlayerController( ControlledBy ) == None || ViewPort( PlayerController( ControlledBy ).Player ) == None ) )
			return;
// Only process this if server or player using that damn thing

		viewRotation= ControlledBy.getViewRotation();
		deltaRotation= Normalize( viewRotation - oldViewRotation );
		deltaRotation.yaw= FClamp( deltaRotation.yaw, -maxYawDeltaPerSecond * DeltaTime, maxYawDeltaPerSecond * DeltaTime );

		newRot= Normalize( Rotation );

		if ( bUseMaxYaw ) {
			minYaw= -( 131072 - ( ( initialRotation.yaw - maxYawDeltaAngle ) - newRot.yaw ) ) % 65536;
			maxYaw= ( 65536 + ( initialRotation.yaw + maxYawDeltaAngle ) - newRot.yaw ) % 65536;
			
			deltaRotation.yaw= FClamp( deltaRotation.yaw, minYaw, maxYaw );
		}
		
		newRot.yaw+= deltaRotation.yaw;
		setRotation( newRot );
		oldViewRotation= viewRotation;
	}
}

defaultproperties
{
     maxYawDeltaPerSecond=12000.000000
     bDirectional=True
}
