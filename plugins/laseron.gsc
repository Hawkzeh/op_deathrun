laser()
{
if (self.pers["team"] == "allies")
	{
	self iPrintln( "Nice Laser!" );
	self SetClientDvar ( "cg_laserforceon", "1" );
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
