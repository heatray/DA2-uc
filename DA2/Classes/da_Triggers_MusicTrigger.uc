class da_Triggers_MusicTrigger extends MusicTrigger;

function Trigger( Actor Other, Pawn EventInstigator )
{
	if( !Triggered )
	{
		Triggered	= true;

		if( FadeOutAllSongs )
			StopAllMusic( FadeOutTime );

		SongHandle	= PlayMusic( Song, FadeInTime );
	}
	else
	{
	 return;
    }
}

defaultproperties
{
     Texture=Texture'DA2Textures.editing.MusicTrigger'
}
