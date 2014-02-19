laser()
{
	if(self.laser == 0)
	{
		self SetClientDvar("cg_laserforceon","1");
		self iPrintln("^3Laser: ^2[ON]");
		self.laser = 1;
	}
	else if(self.laser == 1)
	{
		self SetClientDvar("cg_laserforceon","0");
		self iPrintln("^3Laser: ^1[OFF]");
		self.laser = 0;
	}
}