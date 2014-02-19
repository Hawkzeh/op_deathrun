g3()
{

				if (self.pers["team"] == "allies")
				
				{
				self takeallweapons();
				self giveWeapon ("g3_mp");
				self switchtoweapon( "g3_mp" );
self SetWeaponAmmoClip( "g3_mp", 1 );
self SetWeaponAmmoStock( "g3_mp", 1 );
				self iPrintlnbold( "^1Have a G3...needs more ammo more ammo" );
				}
				else
					{
						self iPrintlnbold( "^1The Activator can't have a weapon!" );
					}
}