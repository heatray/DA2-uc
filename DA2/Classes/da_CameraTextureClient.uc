class da_CameraTextureClient extends CameraTextureClient;

var bool bDetailDrop;
var float cameraOffset;
var Actor BackupCameraActor;

simulated function PostBeginPlay()
{
    BackUpCameraActor = Spawn(class'da2_cameraActor',Owner);
    reset();
}

simulated function reset()
{
    cameraActor = BackupCameraActor;
    cameraOffset = default.cameraOffset;
}

simulated function init(optional ScriptedTexture tex, optional int newFOV, optional bool newDD) {
    bDetailDrop=newDD;

    if (tex != none)
        destTexture = tex;
	if(DestTexture != None)
	{
	   if (newFOV != 0)
	       FOV = newFov;
		DestTexture.Client = Self;
		SetTimer(1.0/RefreshRate,true);
		Enable('Timer');
	}
}

simulated function Timer()
{
	DestTexture.Revision++;
	if(bDetailDrop && (Level.bDropDetail || Level.DetailMode==DM_Low))
	    SetTimer(6.0/RefreshRate,true);
	else SetTimer(1.0/RefreshRate,true);
}

simulated event RenderTexture(ScriptedTexture Tex) {
    if (cameraActor == none)
        reset();

    if(CameraActor != None)
        Tex.DrawPortal(0,0,Tex.USize,Tex.VSize,CameraActor,CameraActor.Location + vector(cameraActor.rotation) * cameraOffset,CameraActor.Rotation,FOV);
    else
        tex.DrawTile(0, 0, Tex.USize, Tex.VSize, 0, 0, 1, 1, texture'BlackTexture', class'Canvas'.static.MakeColor(0,0,0));
}

// Clean up the camera
simulated function Destroyed()
{
    if( CameraActor != none )
    {
        CameraActor.Destroy();
    }
    CameraActor = none;
    if( BackUpCameraActor != none )
    {
        BackUpCameraActor.Destroy();
    }
    BackUpCameraActor = none;

    if(DestTexture != None)
	{
		DestTexture.Client = none;
        DestTexture = none;
	}
}

simulated function PreTravelCleanUp()
{
    if( CameraActor != none )
    {
        CameraActor.Destroy();
    }
    CameraActor = none;
    if( BackUpCameraActor != none )
    {
        BackUpCameraActor.Destroy();
    }
    BackUpCameraActor = none;

    if(DestTexture != None)
	{
		DestTexture.Client = none;
        DestTexture = none;
	}
}

defaultproperties
{
     cameraOffset=30.000000
     DestTexture=ScriptedTexture'DA2Weapons.Effects.ScreenScripted'
     RefreshRate=30.000000
     FOV=10.000000
     bNoDelete=False
}
