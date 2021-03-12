//-----------------------------------------------------------
//
//-----------------------------------------------------------
class da_weapons_GunFire extends da_weapons_BasicFire;

event ModeDoFire(){
    local bot b;
	local float dist;

	if (!AllowFire())
		return;

    firerate=default.firerate;

	//hack to make bots shoot in bursts
    b=bot(instigator.controller);
    if(default.firerate<=0.15 && b!=none && b.enemy!=none)
	{
        dist=VSize(b.Enemy.Location-Instigator.Location);
        if(frand()<fmax(0,fmin(1,((dist-500)/8000)*frand())))
            firerate=default.firerate*(2+frand()*4);
    }

	super.ModeDoFire();
	da_weapons_BasicGun(Weapon).firedShot();
}

defaultproperties
{
     DamageMin=12
     DamageMax=26
     bWaitForRelease=True
     FireSound=Sound'Inf_Weapons.stg44.stg44_fire_distant03'
     FireRate=0.200000
     AmmoPerFire=1
     BotRefireRate=0.900000
}
