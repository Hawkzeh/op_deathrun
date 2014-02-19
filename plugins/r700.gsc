r700()
{
	if(self.pers["team"] == "allies")
	{
		self giveWeapon("r700_mp");
		self switchtoweapon("r700_mp");
		self givemaxammo("r700_mp");
	}
	else
	{
		self iPrintlnbold("^1Activators ^7cannot use the weapons menu.");
	}
}