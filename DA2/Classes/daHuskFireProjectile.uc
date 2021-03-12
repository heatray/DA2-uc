//=============================================================================
// HuskFireProjectile
//=============================================================================
// Fireball projectile for the Husk zombie
//=============================================================================
class daHuskFireProjectile extends HuskFireProjectile;

//Prevents players from flying all over the map when hit by huskproj.

defaultproperties
{
     MomentumTransfer=2500.000000
}
