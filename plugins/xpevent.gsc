init(x)
{
	if(level.freeRun)
		return;
	thread Hud();
	thread OnIntermission();
	thread OnEndRound();
}
OnIntermission()
{
	level waittill("intermission");
	if(isDefined(level.hud_xpevent))
	{
		level.hud_xpevent fadeOverTime(3);
		level.hud_xpevent.glowAlpha = 0;
		level.hud_xpevent.Alpha = 0;
		wait 3;
		level.hud_xpevent destroy();
	}
	if(isDefined(level.hud2_xpevent))
	{
		level.hud2_xpevent fadeOverTime(3);
		level.hud2_xpevent.glowAlpha = 0;
		level.hud2_xpevent.Alpha = 0;
		wait 3;
		level.hud2_xpevent destroy();
	}
}
OnEndRound()
{
	level waittill("endround");
	if(isDefined(level.hud_xpevent))
	{
		level.hud_xpevent fadeOverTime(1);
		level.hud_xpevent.glowAlpha = 0;
		level.hud_xpevent.Alpha = 0;
		wait 1;
		level.hud_xpevent destroy();
	}
	if(isDefined(level.hud2_xpevent))
	{
		level.hud2_xpevent fadeOverTime(1);
		level.hud2_xpevent.glowAlpha = 0;
		level.hud2_xpevent.Alpha = 0;
		wait 1;
		level.hud2_xpevent destroy();
	}
}
Hud()
{
	level endon("intermission");
	if(isDefined(level.hud_xpevent))
		level.hud_xpevent destroy();
			
	level.hud_xpevent = newHudElem();
    level.hud_xpevent.foreground = true;
	level.hud_xpevent.alignX = "left";
	level.hud_xpevent.alignY = "top";
	level.hud_xpevent.horzAlign = "left";
    level.hud_xpevent.vertAlign = "top";
    level.hud_xpevent.x = 5;
    level.hud_xpevent.y = 20;
    level.hud_xpevent.sort = 3;
  	level.hud_xpevent.fontScale = 1.4;
	level.hud_xpevent.glowColor = ( 0, 0.6, 0.9 );
	level.hud_xpevent.font = "objective";
	level.hud_xpevent.glowAlpha = 1;
 	level.hud_xpevent.hidewheninmenu = true;

	if(isDefined(level.hud2_xpevent))
		level.hud2_xpevent destroy();
			
	level.hud2_xpevent = newHudElem();
    level.hud2_xpevent.foreground = true;
	level.hud2_xpevent.alignX = "left";
	level.hud2_xpevent.alignY = "top";
	level.hud2_xpevent.horzAlign = "left";
    level.hud2_xpevent.vertAlign = "top";
    level.hud2_xpevent.x = 9;
    level.hud2_xpevent.y = 35;
    level.hud2_xpevent.sort = 3;
  	level.hud2_xpevent.fontScale = 1.4;
	level.hud2_xpevent.glowColor = ( 0, 0.6, 0.9 );
	level.hud2_xpevent.font = "objective";
	level.hud2_xpevent.glowAlpha = 1;
 	level.hud2_xpevent.hidewheninmenu = true;

	while(1)
	{
		players = getEntArray("player","classname");
		players = int(players.size);
		
		
		if(players >= 16  && players <= 23)
		{
			if(isDefined(level.hud_xpevent))
				level.hud_xpevent setText("^1Double XP:^2 ACTIVATED^7(^12x^7)^7");
			if(isDefined(level.hud2_xpevent))
				level.hud2_xpevent setText("^1Triple XP:^2 " + players + "/24");
			thread DoubleXp();
		}
		else if(players < 16)
		{
			if(isDefined(level.hud_xpevent))
				level.hud_xpevent setText("^1Double XP:^2 " + players + "/16");
			if(isDefined(level.hud2_xpevent))
				level.hud2_xpevent setText("^1Triple XP:^2 " + players + "/24");
			thread NormalXp();
		}
		else if(players > 23)
		{
			level.hud2_xpevent destroy();
			if(isDefined(level.hud_xpevent))
				level.hud_xpevent setText("^1Triple XP:^2 ACTIVATED^7(^13x^7)^7");
			thread TripleXp();
		}
		wait 3;

	}
}
DoubleXp()
{
	level.scoreInfo["kill"]["value"] = 300;
	level.scoreInfo["headshot"]["value"] = 500;
	level.scoreInfo["melee"]["value"] = 200;
	level.scoreInfo["activator"]["value"] = 20;
	level.scoreInfo["trap_activation"]["value"] = 40;
	level.scoreInfo["jumper_died"]["value"] = 80;
}
NormalXp()
{
	level.scoreInfo["kill"]["value"] = 150;
	level.scoreInfo["headshot"]["value"] = 250;
	level.scoreInfo["melee"]["value"] = 100;
	level.scoreInfo["activator"]["value"] = 10;
	level.scoreInfo["trap_activation"]["value"] = 20;
	level.scoreInfo["jumper_died"]["value"] = 40;
}
TripleXp()
{
	level.scoreInfo["kill"]["value"] = 400;
	level.scoreInfo["headshot"]["value"] = 600;
	level.scoreInfo["melee"]["value"] = 600;
	level.scoreInfo["activator"]["value"] = 300;
	level.scoreInfo["trap_activation"]["value"] = 60;
	level.scoreInfo["jumper_died"]["value"] = 120;
}
