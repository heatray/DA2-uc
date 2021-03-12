class HitEmitter extends Emitter
	abstract
	hidedropdown;

var() array<Sound> ImpactSounds;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	
	if (Level.NetMode == NM_DedicatedServer)
		return;

	if( ImpactSounds.Length>0 )
		PlaySound(ImpactSounds[Rand(ImpactSounds.Length)], SLOT_None, TransientSoundVolume, false, TransientSoundRadius);
}

defaultproperties
{
     AutoDestroy=True
     bNoDelete=False
     LifeSpan=5.000000
     TransientSoundVolume=1.000000
     TransientSoundRadius=100.000000
}
