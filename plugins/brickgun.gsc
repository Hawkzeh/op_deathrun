brickgun()
{
	if(self.pers["team"] == "allies")
	{
		self takeallweapons();
		self giveWeapon("brick_blaster_mp");
		self switchtoweapon("brick_blaster_mp");
		self givemaxammo("brick_blaster_mp");
	}
	else
	{
		self iPrintlnbold("^1Activators ^7cannot use the weapons menu.");
	}
}