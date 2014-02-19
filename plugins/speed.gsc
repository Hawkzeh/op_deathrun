speed()
{

				if (self.pers["team"] == "allies")
				
				{
					self iPrintlnbold( "^2You have ^6SUPER SPEEDZ" );
    				self SetMoveSpeedScale( 1.6 );
    				self.maxhealth = 100;
    				self.health = self.maxhealth;
				}
				else
					{
						self iPrintlnbold( "^1The Activator can't have super speed!" );
					}
}

nospeed()
{
				if (self.pers["team"] == "allies")
				
				{
					self iPrintlnbold( "^2You no longer have speed now." );
    				self SetMoveSpeedScale( 1.2 );
    				self.maxhealth = 100;
    				self.health = self.maxhealth;
				}
				else
					{
						self iPrintlnbold( "^1The Activator can't have super speed!" );
					}
}
	