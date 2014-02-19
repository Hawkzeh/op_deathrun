deagle()
{

				if (self.pers["team"] == "allies")
				
				{
self takeallweapons();
self giveWeapon ("deserteagle_mp");
self switchtoweapon( "deserteagle_mp" );
self SetWeaponAmmoClip( "deserteagle_mp", 5 );
self SetWeaponAmmoStock( "deserteagle_mp", 1 );
				self iPrintlnbold( "^1Have a Deagle...oh wait want a clip?" );
				}
				else
					{
						self iPrintlnbold( "^1The Activator can't have a weapon!" );
					}
}