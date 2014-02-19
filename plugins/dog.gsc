dog()
{
	if(self.pers["team"] == "allies")
	{
		if(self.dogmode == 0)
		{
			self takeallweapons();
			self giveweapon("dog_mp");
			self switchtoweapon("dog_mp");
			self setModel("german_sheperd_dog");
			self setClientDvar("cg_thirdperson","1");
			self iPrintln("^3Dog Mode: ^2[ON]");
			self.dogmode = 1;
		}
		else if(self.dogmode == 1)
		{	
			self braxi\_teams::setPlayerModel();
			self setViewModel( "viewmodel_hands_zombie" );
			self takeAllWeapons();
			self giveWeapon(self.pers["weapon"]);
			self setSpawnWeapon(self.pers["weapon"]);
			self giveMaxAmmo(self.pers["weapon"]);
			self switchToWeapon(self.pers["weapon"]);
			self iPrintln("^3Dog Mode: ^1[OFF]");
			self.dogmode = 0;
		}
	}
	else
	{
		self iPrintlnBold("^1Activators ^7cannot turn into dogs.");
	}
}
