weappack()
{

				if (self.pers["team"] == "allies")
				
				{
self takeallweapons();
self giveWeapon ("g3_acog_mp");
self SetWeaponAmmoClip( "g3_acog_mp", 1 );
self SetWeaponAmmoStock( "g3_acog_mp", 1 );
self giveWeapon("brick_blaster_mp");
self SetWeaponAmmoClip( "brick_blaster_mp", 2 );
self SetWeaponAmmoStock( "brick_blaster_mp", 1 );
self giveWeapon("mp5_silencer_mp");
self SetWeaponAmmoClip( "mp5_silencer_mp", 2 );
self SetWeaponAmmoStock( "mp5_silencer_mp", 1 );
self giveWeapon("remington700_mp");
self SetWeaponAmmoClip( "remington700_mp", 1 );
self SetWeaponAmmoStock( "remington700_mp", 1 );
self giveWeapon("m4_acog_mp");
self SetWeaponAmmoClip( "m4_acog_mp", 1 );
self SetWeaponAmmoStock( "m4_acog_mp", 1 );
self giveWeapon("p90_silencer_mp");
self SetWeaponAmmoClip( "p90_silencer_mp", 2 );
self SetWeaponAmmoStock( "p90_silencer_mp", 1 );
				self iPrintlnbold( "^1Have alot of weapons" );
				}
				else
					{
						self iPrintlnbold( "^1The Activator can't have a weapon!" );
					}
}