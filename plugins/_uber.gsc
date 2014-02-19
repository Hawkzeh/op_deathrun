//
// Plugin name: Uber Equipment 
// Author: BraXi
// Version: 1.0
// Website: <a href="http://www.braxi.boo.pl" target="_blank">http://www.braxi.boo.pl</a>
// Description: Does give a specified weapon to admin
//
// This plugin was designed for Death Run, after some tweaks it may also work with 
// other mods, but please give credits to me if you find this useful in your mod.
//
 
init( modVersion )
{
	braxi\_dvar::addDvar( "ua_weapon", "ua_weapon", "g36c_mp", "mp5_mp", "rpg_mp", "string" );
 
	precacheItem( level.dvar["ua_weapon"] );
	while( 1 )
	{
		level waittill( "player_spawn", player );
 
		if( player.pers["admin"] )
		{
			player giveWeapon( level.dvar["ua_weapon"] );
			player giveMaxAmmo( level.dvar["ua_weapon"] );
		}
	}
}