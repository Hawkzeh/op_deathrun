colt44()
{
	if(self.pers["team"] == "allies")
	{
		self giveWeapon("colt44_mp");
		self switchtoweapon("colt44_mp");
		self givemaxammo("colt44_mp");
	}
	else
	{
		self iPrintlnBold("^1Activators ^7cannot use the weapons menu.");
	}
}