mp5()
{

				if (self.pers["team"] == "allies")
				
				{
				self takeallweapons();
				self giveWeapon("mp5_mp");
				self givemaxammo("mp5_mp");
self switchtoweapon( "mp5_mp" );
				self iPrintlnbold( "^1Have a potato...sounds nice." );
				}
				else
					{
						self iPrintlnbold( "^1The Activator can't have a weapon!" );
					}
}