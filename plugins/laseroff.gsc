laseroff()
{
if (self.pers["team"] == "allies")
	{
	self iPrintln( "Goodbye Laser" );
	self SetClientDvar ( "cg_laserforceon", "0" );
			}
else if (self.pers["team"] == "axis")
	{
	self iPrintln( "^1Activator can't have a LASER!" );
	}
else
	{
	self iPrintln( "^1Specator can't have a LASER" );
	}
}
