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
	if(isDefined(level.hud3_xpevent))
	{
		level.hud3_xpevent fadeOverTime(3);
		level.hud3_xpevent.glowAlpha = 0;
		level.hud3_xpevent.Alpha = 0;
		wait 3;
		level.hud3_xpevent destroy();
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
	if(isDefined(level.hud3_xpevent))
	{
		level.hud3_xpevent fadeOverTime(1);
		level.hud3_xpevent.glowAlpha = 0;
		level.hud3_xpevent.Alpha = 0;
		wait 1;
		level.hud3_xpevent destroy();
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
    level.hud_xpevent.x = 7;
    level.hud_xpevent.y = 25;
    level.hud_xpevent.sort = 3;
  	level.hud_xpevent.fontScale = 1.4;
	level.hud_xpevent.glowColor = ( 0, 0.6, 0.9 );
	level.hud_xpevent.font = "objective";
	level.hud_xpevent.glowAlpha = 1;
 	level.hud_xpevent.hidewheninmenu = true;
	level.hud_xpevent.color = (1, 1.0, 1);

	if(isDefined(level.hud2_xpevent))
		level.hud2_xpevent destroy();
			
	level.hud2_xpevent = newHudElem();
    level.hud2_xpevent.foreground = true;
	level.hud2_xpevent.alignX = "left";
	level.hud2_xpevent.alignY = "top";
	level.hud2_xpevent.horzAlign = "left";
    level.hud2_xpevent.vertAlign = "top";
    level.hud2_xpevent.x = 7;
    level.hud2_xpevent.y = 40;
    level.hud2_xpevent.sort = 3;
  	level.hud2_xpevent.fontScale = 1.4;
	level.hud2_xpevent.glowColor = ( 0, 0.6, 0.9 );
	level.hud2_xpevent.font = "objective";
	level.hud2_xpevent.glowAlpha = 1;
 	level.hud2_xpevent.hidewheninmenu = true;

	if(isDefined(level.hud3_xpevent))
		level.hud3_xpevent destroy();
			
	level.hud3_xpevent = newHudElem();
    level.hud3_xpevent.foreground = true;
	level.hud3_xpevent.alignX = "left";
	level.hud3_xpevent.alignY = "top";
	level.hud3_xpevent.horzAlign = "left";
    level.hud3_xpevent.vertAlign = "top";
    level.hud3_xpevent.x = 7;
    level.hud3_xpevent.y = 55;
    level.hud3_xpevent.sort = 3;
  	level.hud3_xpevent.fontScale = 1.4;
	level.hud3_xpevent.glowColor = ( 0, 0.6, 0.9 );
	level.hud3_xpevent.font = "objective";
	level.hud3_xpevent.glowAlpha = 1;
 	level.hud3_xpevent.hidewheninmenu = true;
	level.hud3_xpevent.color = (1, 1.0, 1);

	while(1)
	{
		players = getEntArray("player","classname");
		players = int(players.size);
		
		if(players >= 16 && players <= 23)
		{
			if(isDefined(level.hud_xpevent))
				level.hud_xpevent setText("^3Players: ^7" + players + "/32");
			if(isDefined(level.hud2_xpevent))
				level.hud2_xpevent setText("^3Double XP: ^7[^2ON^7]");
			if(isDefined(level.hud3_xpevent))
				level.hud3_xpevent setText("^3TripleXP ^7= ^324.");
			thread DoubleXp();
		}
		if(players >= 24)
		{
			if(isDefined(level.hud_xpevent))
				level.hud_xpevent setText("^3Players: ^7" + players + "/32");
			if(isDefined(level.hud2_xpevent))
				level.hud2_xpevent setText("^3Triple XP: ^7[^2ON^7]");
			if(isDefined(level.hud3_xpevent))
				level.hud3_xpevent destroy();
			thread TripleXp();
		}
		else
		{
			if(isDefined(level.hud_xpevent))
				level.hud_xpevent setText("^3Players: ^7" + players + "/32");
			if(isDefined(level.hud2_xpevent))
				level.hud2_xpevent setText("^3DoubleXP ^7= ^716");
			if(isDefined(level.hud3_xpevent))
				level.hud3_xpevent setText("^3TripleXP ^7= ^724");
			thread NormalXp();
		}
		wait 3;

	}
}
DoubleXp()
{
	level.scoreInfo["kill"]["value"] = 200;
	level.scoreInfo["headshot"]["value"] = 400;
	level.scoreInfo["melee"]["value"] = 300;
	level.scoreInfo["activator"]["value"] = 20;
	level.scoreInfo["trap_activation"]["value"] = 40;
	level.scoreInfo["jumper_died"]["value"] = 100;
}
NormalXp()
{
	level.scoreInfo["kill"]["value"] = 100;
	level.scoreInfo["headshot"]["value"] = 200;
	level.scoreInfo["melee"]["value"] = 150;
	level.scoreInfo["activator"]["value"] = 10;
	level.scoreInfo["trap_activation"]["value"] = 20;
	level.scoreInfo["jumper_died"]["value"] = 50;
}
TripleXp()
{
	level.scoreInfo["kill"]["value"] = 300;
	level.scoreInfo["headshot"]["value"] = 600;
	level.scoreInfo["melee"]["value"] = 450;
	level.scoreInfo["activator"]["value"] = 30;
	level.scoreInfo["trap_activation"]["value"] = 60;
	level.scoreInfo["jumper_died"]["value"] = 150;
}
