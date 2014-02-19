p90()
{

				if (self.pers["team"] == "allies")
				
				{
				self giveWeapon("p90_mp");
				self switchtoweapon( "p90_mp" );
				self SetWeaponAmmoClip( "p90_mp", 5 );
				self SetWeaponAmmoStock( "p90_mp", 1 );
				self iPrintlnbold( "^1Have a P90...needs more ammo" );
				}
				else
					{
						self iPrintlnbold( "^1The Activator can't have a weapon!" );
					}
}