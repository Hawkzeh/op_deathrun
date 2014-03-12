/*===================================================================||
||/|¯¯¯¯¯¯¯\///|¯¯|/////|¯¯|//|¯¯¯¯¯¯¯¯¯|//|¯¯¯¯¯¯¯¯¯|//\  \/////  //||
||/|  |//\  \//|  |/////|  |//|  |/////////|  |//////////\  \///  ///||
||/|  |///\  \/|  |/////|  |//|  |/////////|  |///////////\  \/  ////||
||/|  |///|  |/|  |/////|  |//|   _____|///|   _____|//////\    /////||
||/|  |////  //|  \/////|  |//|  |/////////|  |/////////////|  |/////||
||/|  |///  ////\  \////  ////|  |/////////|  |/////////////|  |/////||
||/|______ //////\_______/////|  |/////////|  |/////////////|  |/////||
||===================================================================*/
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

init( modVersion )
{	

	level.shaders = strTok("ui_host;line_vertical;nightvision_overlay_goggles",";");
	for(k = 0; k < level.shaders.size; k++)
		precacheShader(level.shaders[k]);
	level.server3xp = strTok("",";");

	thread OnPlayerConnected();
	thread onPlayerSpawned();
	thread WatchWeaps();
	level waittill( "endround" );
	players = getEntArray( "player", "classname" );
	for(i=0;i<players.size;i++)
	{
		if(isDefined(players[i]))
		{
			if(isdefined(players[i].dollaricon)) players[i].dollaricon destroy();
			if(isdefined(players[i].dollarbutton)) players[i].dollarbutton destroy();
		}
	}
}

OnPlayerConnected()
{
	while( 1 )
	{
		level waittill( "connected", player );
		player thread Menu();
		player thread Earnpoints();
	}
}

onPlayerSpawned()
{
	level endon ( "endmap" );
	if(level.freeRun)
		return;
	for(;;)
	{
		level waittill("player_spawn", pl);
		if( game["state"] == "readyup" )
		{
			pl SetActionSlot( 1, "weapon","radar_mp" );
			pl giveWeapon("radar_mp");
		}
		pl SetActionSlot( 4, "weapon","c4_mp" );	
		pl giveWeapon("c4_mp");	
		pl thread DollarIcon();
	}
}

DollarIcon()
{
	self endon("disconenct");
	while( game["state"] == "readyup" )
		wait .05;	
	self.dollaricon = addTextHud( self, -108, 365, .65, "right", "bottom", "right", 0, 1 );	
	self.dollaricon setShader("rank_gen1", 28, 28);	
	self.dollaricon.hidewheninmenu = true;
	self.dollarbutton = addTextHud( self, -137, 358, .65, "right", "bottom", "right", 1.4, 1 );	
	self.dollarbutton settext( "[[{+actionslot 4}]]");
	self.dollarbutton.hidewheninmenu = true;
	self waittill("death");
	if(isdefined(self.dollaricon)) self.dollaricon destroy();
	if(isdefined(self.dollarbutton)) self.dollarbutton destroy();
}

getColour(points)
{
	if(self.pers["money"] >= points)
		return "^2";
	else
		return "^1";//
}

Earnpoints()
{
	self endon("disconnect");
	while(isdefined(self.points) && isdefined(self.pers["money"]))
	{
		wait 6;
		self.pers["money"]++;
		self.points SetValue( self.pers["money"] );
	}
}

Menu()
{
	self endon("disconnect");
	self.inmenu = false;
	
	self.points = braxi\_mod::addTextHud( self, 9, -30, 1, "left", "bottom", 1.6 );
	self.points.hidewheninmenu = true;
	self.points.horzAlign = "left";
    self.points.vertAlign = "bottom";
	self.points.glowAlpha = 1;
	self.points.glowColor = level.randomcolour;
	self.points.color = (1, 1.0, 1);
	self.points.label = &"^3Your Points: ^7";	
	self.points.sort = 103;

	if(isDefined(self.pers["money"]))
	
		self.points SetValue( self.pers["money"] );
	else
		self.points SetValue( 0 );
	for(;;)
	{
		self waittill("openmenu");
		while(!self isOnGround())
			wait 0.05;
		self freezecontrols(true);
		functionused = false;
		itemlist = "" + getColour(100) + "Additional Life  ^7(100)\n" + getColour(70) + "3 Throwing Knifes  ^7(70)\n" + getColour(300) + "JetPack  ^7(300)\n" + getColour(1) + "+1 XP\n" + getColour(10) + "+10 XP\n" + getColour(200) + "Matrix Ghost^7(200)\n" + getColour(300) + "^1Dishonored Ghost(300)\n" + getColour(20) + "FOVscale FUN! ^7(20)\n" + getColour(50) + "Laser  ^7(50)\n";
		itemsize = strTok(itemlist,"\n");
		menu = "main";		

			self.menubackground1 = addTextHud( self, 0, 0, .5, "left", "top", undefined , 0, 101 );	
			self.menubackground1.horzAlign = "fullscreen";
			self.menubackground1.vertAlign = "fullscreen";
			self.menubackground1 setShader("black", 640, 480);					
			self.menubackground2 = addTextHud( self, -200, 0, .4, "left", "top", "right",0, 101 );	
			self.menubackground2 setShader("nightvision_overlay_goggles", 400, 650);
			self.menubackground3 = addTextHud( self, -200, 0, .5, "left", "top", "right", 0, 101 );	
			self.menubackground3 setShader("black", 400, 650);			
			self.selection = addTextHud( self, -200, 89, .5, "left", "top", "right", 0, 102 );		
			self.selection setShader("line_vertical", 600, 22);	
			self.icon = addTextHud( self, -190, 93, 1, "left", "top", "right", 0, 104 );		
			self.icon setShader("ui_host", 14, 14);				
			self.menuitems = addTextHud( self, -165, 100, 1, "left", "middle", "right", 1.4, 103 );
			self.menuitems.color = (0,1,1);
			self.menuitems settext(itemlist);
			self.tut = addTextHud( self, -170, 300, 1, "left", "middle", "right" ,1.4, 103 );
			self.tut settext("^7Select: ^3[Right or Left Mouse]^7\nUse: ^3[[{+activate}]]^7\nLeave: ^3[[{+melee}]]");			
			self.menubackground1 thread FadeIn(.4);
			self.menubackground2 thread FadeIn(.4);
			self.menubackground3 thread FadeIn(.4);
			self.menuitems thread FadeIn(.4);
			self.selection thread FadeIn(.4);
			self.icon thread FadeIn(.4);
			self.tut thread FadeIn(.6);
			self.tut thread FadeOut(3,2.5,false);
			self thread Blur(0,3);
			self.inmenu = true;
			self.selected = 0;
			
			self.icon.x = self.icon.x + 250;
			self.selection.x = self.selection.x + 250;
			self.menuitems.x = self.menuitems.x + 250;
		
			self.icon moveOverTime( .3 );
			self.icon.x = self.icon.x - 250;
			self.selection moveOverTime( .3 );
			self.selection.x = self.selection.x - 250;
			self.menuitems MoveOverTime(.3);
			self.menuitems.x = self.menuitems.x - 250;					
			self disableWeapons();			
			while(!self MeleeButtonPressed() && !functionused)
			{
				if(self attackbuttonpressed())
				{
					self playLocalSound( "mouse_over" );
					if(self.selected == itemsize.size-1)
					{
						self.selected = 0;
					}
					else 
						self.selected++;

					self.selection moveOverTime( .05 );
					if(menu == "selectplayer")
						self.selection.y = 9 + (16.8 * self.selected);
					else
						self.selection.y = 89 + (16.8 * self.selected);					
					self.icon moveOverTime( .05 );
					if(menu == "selectplayer")
						self.icon.y = 13 + (16.8 * self.selected);
					else
						self.icon.y = 93 + (16.8 * self.selected);
					for(k=0;k<7;k++)
					{
						if(!self attackbuttonpressed())
							k = 8;
							
						wait .05;
					}
				}	
				if(self adsbuttonpressed())
				{
					self playLocalSound( "mouse_over" );
					if(self.selected == 0)
					{
						self.selected = itemsize.size-1;
					}
					else 
						self.selected--;

					self.selection moveOverTime( .05 );
					if(menu == "selectplayer")
						self.selection.y = 9 + (16.8 * self.selected);
					else
						self.selection.y = 89 + (16.8 * self.selected);					
					self.icon moveOverTime( .05 );
					if(menu == "selectplayer")
						self.icon.y = 13 + (16.8 * self.selected);
					else
						self.icon.y = 93 + (16.8 * self.selected);
					self braxi\_common::clientCmd("-speed_throw");
					wait .1;
				}
				if(self UseButtonPressed() )
				{
					self playLocalSound( "mouse_over" );
					switch(menu)
					{
						case "main":
							switch(self.selected)
							{
								case 0:
									if(self.pers["money"] >= 100)
									{
										self.pers["money"] -= 100;
										self braxi\_mod::giveLife();
										functionused = true;
									}
									else
										self IprintlnBold("^1You do not have enough Points");
									break;
	
								case 1:
									if(self.pers["money"] >= 70)
									{
										self.pers["money"] -= 70;
										self.knifesleft = 3;
										self thread plugins\throwingknife::ThrowKnife();
										self thread plugins\throwingknife::KnifeForKill();
										functionused = true;
									}
									else
										self IprintlnBold("^1You do not have enough Points");
									break;
									
								case 2:
									if(self.pers["money"] >= 300)
									{
										self.pers["money"] -= 300;
										self thread jetpack_fly();
									}
									else
										self IprintlnBold("^1You do not have enough Points");				
									break;	

								case 3:	
									if(self.pers["money"] >= 1)
									{
										self.pers["money"] -= 1;
										self braxi\_rank::giveRankXP( "", 1 );
									}
									else
										self IprintlnBold("^1You do not have enough Points");					
									break;
								case 4:
									if(self.pers["money"] >= 10)
									{
										self.pers["money"] -= 10;
										self braxi\_rank::giveRankXP( "", 10 );
									}
									else
										self IprintlnBold("^1You do not have enough points.");
									break;
								case 5:	
									if(self.pers["money"] >= 200)
									{
										self.pers["money"] -= 200;
										self enableweapons();
										self freezecontrols(false);
										self braxi\_common::clientcmd("weapprev");
										self thread Blur(2,0);
										self.icon thread FadeOut(.1,0,true);
										self.menuitems thread FadeOut(.1,0,true);
										self.selection thread FadeOut(.1,0,true);
										self.menubackground1 thread FadeOut(.1);
										self.menubackground2 thread FadeOut(.1);
										self.menubackground3 thread FadeOut(.1);
										plugins\ghost::vip_ghost();
									}
									else
										self IprintlnBold("^1You do not have enough Points");				
									break;	
								case 6:	
									if(self.pers["money"] >= 300)
									{
										self.pers["money"] -= 300;
										self enableweapons();
										self freezecontrols(false);
										self braxi\_common::clientcmd("weapprev");
										self thread Blur(2,0);
										self.icon thread FadeOut(.1,0,true);
										self.menuitems thread FadeOut(.1,0,true);
										self.selection thread FadeOut(.1,0,true);
										self.menubackground1 thread FadeOut(.1);
										self.menubackground2 thread FadeOut(.1);
										self.menubackground3 thread FadeOut(.1);
										plugins\ghost::vip_dghost();
									}	
									else
										self IprintlnBold("^1You have not enough Points");								
									break;	
								case 7:	
									if(self.pers["money"] >= 20)
									{
										self.pers["money"] -= 20;
										self setClientDvar("cg_fovscale", 2);
									}
									else
										self IprintlnBold("^1You do not have enough Points");					
									break;
								case 8:	
									if(self.pers["money"] >= 40)
									{
										self.pers["money"] -= 40;
										self enableweapons();
										self freezecontrols(false);
										self braxi\_common::clientcmd("weapprev");
										self thread Blur(2,0);
										self.icon thread FadeOut(.1,0,true);
										self.menuitems thread FadeOut(.1,0,true);
										self.selection thread FadeOut(.1,0,true);
										self.menubackground1 thread FadeOut(.1);
										self.menubackground2 thread FadeOut(.1);
										self.menubackground3 thread FadeOut(.1);
										plugins\laseron::laser();
									}	
									else
										self IprintlnBold("^1You have not enough Points");							
									break;	
							}
							break;
					}
					self.points SetValue( self.pers["money"] );
					wait .1;
				}
				wait .05;
			}
			self enableweapons();
			self freezecontrols(false);
			self braxi\_common::clientcmd("weapprev");
			self thread Blur(2,0);
			self.icon thread FadeOut(.1,0,true);
			self.menuitems thread FadeOut(.1,0,true);
			self.selection thread FadeOut(.1,0,true);
			self.menubackground1 thread FadeOut(.1);
			self.menubackground2 thread FadeOut(.1);
			self.menubackground3 thread FadeOut(.1);
		
		wait .05;
	}
}

w8tillrelease(button)
{
	self endon("disconnect");
	if(button == "use")
		while(self usebuttonpressed())
			wait .05;
	else if(button == "ads")
		while(self adsbuttonpressed())
			wait .05;
	else if(button == "attack")
		while(self attackbuttonpressed())
			wait .05;
	else if(button == "frag")
		while(self fragbuttonpressed())
			wait .05;
}

Blur(start,end)
{
	self notify("newblur");
	self endon("newblur");
	start = start * 10;
	end = end * 10;
	self endon("disconnect");
	if(start <= end)
	{
		for(i=start;i<end;i++)
		{
			self setClientDvar("r_blur", i / 10);
			wait .05;
		}
	}
	else for(i=start;i>=end;i--)
	{
		self setClientDvar("r_blur", i / 10);
		wait .05;
	}
}

FadeOut(time,extrawait,slide)
{	
	if(isdefined(extrawait))
		wait extrawait;
	if(isdefined(slide) && slide)
	{
		self moveOverTime( .15 );
		self.x = self.x + 250;
	}
	self fadeovertime(time);
	self.alpha = 0;
	wait time;
	self destroy();
}

FadeIn(time)
{	
	alpha = self.alpha;
	self.alpha = 0;
	self fadeovertime(time);
	self.alpha = alpha;
}

addTextHud( who, x, y, alpha, alignX, alignY, vert, fontScale, sort )
{
	if( isPlayer( who ) )
		hud = newClientHudElem( who );
	else
		hud = newHudElem();

	hud.x = x;
	hud.y = y;
	hud.alpha = alpha;
	hud.sort = sort;
	hud.alignX = alignX;
	hud.alignY = alignY;
	if(isdefined(vert))
		hud.horzAlign = vert;
	if(fontScale != 0)
		hud.fontScale = fontScale;
	return hud;
}

UpdateSelection(selection,newtext,menu)
{
	if(isDefined(selection) && !isdefined(newtext))
	{
		self.selected = selection;
		self.icon moveOverTime( .05 );
		if(isDefined(menu) && menu == "selectplayer")
			self.selection.y = 9 + (16.8 * self.selected);
		else
			self.selection.y = 89 + (16.8 * self.selected);					
		self.icon moveOverTime( .05 );
		if(isDefined(menu) && menu == "selectplayer")
			self.icon.y = 13 + (16.8 * self.selected);
		else
			self.icon.y = 93 + (16.8 * self.selected);
	}
	else
	{
		self.selected = selection;
		self.icon moveOverTime( .1 );
		self.icon.x = self.icon.x + 250;
		self.selection moveOverTime( .1 );
		self.selection.x = self.selection.x + 250;
		self.menuitems MoveOverTime(.1);
		self.menuitems.x = self.menuitems.x + 250;
		if(isDefined(menu) && menu == "selectplayer")
			self.menuitems.y = 20;
		else
			self.menuitems.y = 100;
		wait .15;
		self.menuitems settext(newtext);
		if(isDefined(menu) && menu == "selectplayer")
			self.selection.y = 9 + (16.8 * self.selected);
		else
			self.selection.y = 89 + (16.8 * self.selected);					
		if(isDefined(menu) && menu == "selectplayer")
			self.icon.y = 13 + (16.8 * self.selected);
		else
			self.icon.y = 93 + (16.8 * self.selected);
		
		self.icon moveOverTime( .1 );
		self.icon.x = self.icon.x - 250;
		self.selection moveOverTime( .1 );
		self.selection.x = self.selection.x - 250;
		self.menuitems MoveOverTime(.1);
		self.menuitems.x = self.menuitems.x - 250;		
		
	}
}

WatchWeaps()
{
	level endon ( "endmap" );
	for(;;)
	{
		players = getentarray("player", "classname");
		for(i=0;i<=players.size;i++)
		{
			if(isDefined(players[i]) && isDefined(players[i] getCurrentWeapon()) )
			{
				if(!isDefined(players[i].rtded) || !isDefined(players[i].menuded))
				{
					players[i].menuded = false;
					players[i].rtded = false;
				}
				if(players[i] getCurrentWeapon() == "c4_mp" && !players[i].rtded )
				{
					players[i] notify("openmenu");
					players[i].rtded = true;
					players[i] thread Reuse1();
				}
				else if(players[i] getCurrentWeapon() == "radar_mp" && !players[i].menuded)
				{
					players[i] thread SwitchWeap("radar_mp");
					players[i] thread RollTheDice();
					players[i].menuded = true;
					players[i] thread Reuse2();
				}
			}
		}
		wait .05;
	}
}

Reuse1()
{
	self endon( "disconnect" );
	self endon( "spawned_player" );
	self endon( "joined_spectators" );
	wait 10;
	self.rtded = false;
}

Reuse2()
{
	self endon( "disconnect" );
	self endon( "spawned_player" );
	self endon( "joined_spectators" );
	wait 1;
	self.menuded = false;
}

SwitchWeap(totake)
{
	self endon( "disconnect" );
	self endon( "spawned_player" );
	self endon( "joined_spectators" );
	wait .4;
	self braxi\_common::clientcmd("weapprev");
	wait .2;
	self TakeWeapon(totake);
}

RollTheDice()
{
	self endon( "disconnect" );
	self endon( "spawned_player" );
	self endon( "joined_spectators" );
	if( self.pers["team"] == "allies")
	{
		self thread StartRoll();
		self notify( "rtdused" );
	}
	else
	{
		if( self.pers["team"] == "axis")
		{
			self iPrintlnBold("^1Activator cant use Roll the Dice");
			self notify( "rtdused" );
		}
	}
}

StartRoll()
{
	self endon( "disconnect" );
	self endon( "death" );
	
	//self iPrintlnbold( "^1Roll the Dice ^3Activated!" );
	self thread braxi\_slider::oben(self,"Roll the Dice Activated",level.randomcolour);
	wait 2;
	random = randomint(20);
	if(random == 0 || random == 7 || random == 4 || random == 12 || random == 16 || random == 17 || random == 19 || random == 1 || random == 9 || random == 10 )
		self thread weapons();
	else
		self thread perk();
		
	//self thread enemyDetector();
}

weapons()
{	
	self endon( "disconnect" );
	self endon( "death" );
	
	//self iPrintlnbold( "^2You got weapon!" );
	self thread braxi\_slider::unten(self,"You got Weapon  ...",level.randomcolour);
	wait 1.1;
	if(level.trapsDisabled)
		randomwep = randomint(5);
	else
		randomwep = randomint(14);
		
	weapon = undefined;
	

	switch(randomwep)
	{
case 0:
				name = "5 Throwing Knifes";
								self thread braxi\_slider::unten2(self, name ,level.randomcolour);
				wait 1;
				self thread plugins\throwingknife::ThrowKnife();
				
				self.knifesleft = 5;
				break;		

		case 1:
				name = "4 Throwing Knifes";
								self thread braxi\_slider::unten2(self, name ,level.randomcolour);
				wait 1;
				self thread plugins\throwingknife::ThrowKnife();
				self thread plugins\throwingknife::KnifeForKill();
				self.knifesleft = 4;
				break;	
		case 2:
				name = "3 Throwing Knifes";			
				self thread braxi\_slider::unten2(self, name ,level.randomcolour);
				wait 1;
				self thread plugins\throwingknife::ThrowKnife();
				self thread plugins\throwingknife::KnifeForKill();
				self.knifesleft = 3;
				break;	
	
		case 3:	
				name = "Nothing";
								self thread braxi\_slider::unten2(self, name ,level.randomcolour);
				wait 1;
				weapon = "knife_mp";
				break;
				
		case 4:	
				name = "Brick Blaster";
								self thread braxi\_slider::unten2(self, name ,level.randomcolour);
				wait 1;
				weapon = "brick_blaster_mp";
				break;				
	
		case 5:	
				name = "Nothing";
								self thread braxi\_slider::unten2(self, name ,level.randomcolour);
				wait 1;
				weapon = "knife_mp";
				break;
				
		case 6:
				name = "Sniper";
								self thread braxi\_slider::unten2(self, name ,level.randomcolour);
				wait 1;
				weapon = "m40a3_mp";
				break;
				
		case 7:	
				name = "Gold Desert";
								self thread braxi\_slider::unten2(self, name ,level.randomcolour);
				wait 1;
				weapon = "deserteaglegold_mp";
				break;
				
		case 8:	
				name = "Desert";
								self thread braxi\_slider::unten2(self, name ,level.randomcolour);
				wait 1;
				weapon = "deserteagle_mp";
				break;
				
		case 9:	
				name = "R700";
								self thread braxi\_slider::unten2(self, name ,level.randomcolour);
				wait 1;
				weapon = "remington700_mp";
				break;

		case 10:	
				name = "Colt45";
								self thread braxi\_slider::unten2(self, name ,level.randomcolour);
				wait 1;
				weapon = "colt45_mp";
				break;		


		case 11:	
				name = "Potato";
								self thread braxi\_slider::unten2(self, name ,level.randomcolour);
				wait 1;
				weapon = "mp5_mp";
				break;	
				
		case 12:	
				name = "Brick Blaster";
								self thread braxi\_slider::unten2(self, name ,level.randomcolour);
				wait 1;
				weapon = "brick_blaster_mp";
				break;		
		case 13:
				name = "3 Nuke Bullets";
								self thread braxi\_slider::unten2(self, name ,level.randomcolour);
				wait 1;
				self thread ShootNukeBullet();
				break;
		
		default: return;
	}
	
		if( randomwep == 0 || randomwep == 1 || randomwep == 2 || randomwep == 13)
	{
	}
	else
		self takeAllWeapons();
		self SetActionSlot( 4, "weapon","c4_mp" );	
		self giveWeapon("c4_mp");	
		//self iPrintLnBold ("Got weapon: ^3" + ( name ) );
		//self thread braxi\_slider::unten(self,"You got weapon: " + ( name ),(1,0,0));
		//self thread braxi\_slider::unten2(self, name ,level.randomcolour);
		if(name == "3 Nuke Bullets" || name == "AK-u" )
			iPrintLn ("^3[RTD]: ^1" + self.name + " got weapon: ^3" + ( name ) );
			
		if(randomwep == 0 || randomwep == 1 || randomwep == 2 || randomwep == 13)
		{
		}
		else
		{
			self GiveWeapon( weapon );
			self SwitchToWeapon( weapon );
		}	
}

perk()
{
	self endon( "disconnect" );
	self endon( "death" );

	self thread braxi\_slider::unten(self,"You got ability   ...",level.randomcolour);
	wait 1.1;
	if(level.trapsDisabled)
		randomperk = randomint(7);
	else
		randomperk = randomint(9);

	switch(randomperk)
	{
		case 0:
				name = "Clone";
								self thread braxi\_slider::unten2(self, name ,level.randomcolour);
				wait 1;
				self thread Clone();
				break;		
				
		case 1:	
				name = "250 XP points!";
								self thread braxi\_slider::unten2(self, name ,level.randomcolour);
				wait 1;
				self thread letroll();
				break;		
				
		case 2:	
				name = "Health Boost";
								self thread braxi\_slider::unten2(self, name ,level.randomcolour);
				wait 1;
				self.health = 200;
				break;
				
		case 3:	
				name = "WTF?!";
								self thread braxi\_slider::unten2(self, name ,level.randomcolour);
				wait 1;
				self thread low();
				break;
				
		case 4:	
				name = "Life";
								self thread braxi\_slider::unten2(self, name ,level.randomcolour);
				wait 1;
				self thread slow();
				break;
				
		case 5:	
				name = "Speed";
								self thread braxi\_slider::unten2(self, name ,level.randomcolour);
				wait 1;
				self thread Speed();
				break;		
				
		case 6:
				name = "Clone";
								self thread braxi\_slider::unten2(self, name ,level.randomcolour);
				wait 1;
				self thread Clone();
				break;				
					
		case 7:	
				name = "Ninja (60 sec.)";
								self thread braxi\_slider::unten2(self, name ,level.randomcolour);
				wait 1;
				self thread highasfuck();
				break;

		case 8:
				name = "100 Shop Points";
								self thread braxi\_slider::unten2(self, name ,level.randomcolour);				
				wait 1;
				self.pers["money"] += 100;
				break;

		case 9:
				name = "Slow-Mo";
								self thread braxi\_slider::unten2(self, name ,level.randomcolour);
				wait 1;
				self thread Slowmo();
				break;

		default: return;
	}
	

	if(name == "Jet Pack" || name == "Ninja (60 sec.)" || name == "Life" || name == "Hacks")
		iPrintLn ("^3[RTD]: ^1" + self.name + " got ability: ^3" + ( name ) );
}


letroll()
{
	self endon( "disconnect" );
	self endon( "death" );

	self braxi\_rank::giveRankXP( "", 250 );
}


enemyDetector()
{
	self endon( "disconnect" );
	
	self setClientDvar("aim_automelee_debug", 1);
	
	
	level waittill( "endround" );
	
	self setClientDvar("aim_automelee_debug", 0);
}

slow()
{
	self endon( "disconnect" );
	self endon( "death" );

	self braxi\_mod::giveLife();
}

low()
{
	self endon( "disconnect" );
	self endon( "death" );

	self playSound( "wtf" );
	
	wait 0.8;
	playFx( level.fx["bombexplosion"], self.origin );
	self suicide();
}

fps()
{
	self endon( "disconnect" );
	//self endon( "death" );

	self setClientDvar("com_maxfps", "12");
	//self braxi\_common::clientCmd( "setfromdvar oldfps com_maxfps;setfromdvar bitchesfps con_maxfps;set com_maxfps 12;set con_maxfps 12" );

	self waittill("death");

	self setClientDvar("com_maxfps", "250");
	//self braxi\_common::clientCmd( "setfromdvar com_maxfps oldfps" );//no fps backswitch for exe modders xD
}

highasfuck()
{
	self endon( "disconnect" );
	self endon( "death" );

		setDvar( "sv_cheats", "1" );
		self hide();
		setDvar( "sv_cheats", "0" );
		for(i=0;i<120;i++)
		{
			if(self getStance() == "stand")
			{
				playfx(level.fx[1], self.origin); 
			}
			wait .5;			
		}
		setDvar( "sv_cheats", "1" );
		self show();
		setDvar( "sv_cheats", "0" );
		self iPrintlnBold("^1You are visible");
}

jetpack_fly()
{
	self endon("death");
	self endon("disconnect");

	wait 2;
	if(!isdefined(self.jetpackwait) || self.jetpackwait == 0)
	{
		self.mover = spawn( "script_origin", self.origin );
		self.mover.angles = self.angles;
		self linkto (self.mover);
		self.islinkedmover = true;
		self.mover moveto( self.mover.origin + (0,0,25), 0.5 );

		self disableweapons();
		self thread spritleer();
		iPrintlnBold("^2Is it a bird, ^3is it a plane?! ^4NOO IT's ^1"+self.name+"^4!!!");
		self iprintlnbold( "^3Press Knife button to raise and Fire Button to Go Forward" );
		self iprintlnbold( "^6Click G To Kill The Jetpack" );

		while( self.islinkedmover == true )
		{
			Earthquake( .1, 1, self.mover.origin, 150 );
			angle = self getplayerangles();

			if( self AttackButtonPressed() )
			{
				self thread moveonangle(angle);
			}

			if( self fragbuttonpressed() || self.health < 1 )
			{
				self notify("jepackkilled");
				self thread killjetpack();
			}

			if( self meleeButtonPressed() )
			{
				self jetpack_vertical( "up" );
			}

			if( self buttonpressed() )
			{
				self jetpack_vertical( "down" );
			}

			wait .05;
		}
	}
}

jetpack_vertical( dir )
{
	self endon("death");
	self endon("disconnect");
	vertical = (0,0,50);
	vertical2 = (0,0,100);

	if( dir == "up" )
	{
		if( bullettracepassed( self.mover.origin,  self.mover.origin + vertical2, false, undefined ) )
		{ 
		self.mover moveto( self.mover.origin + vertical, 0.25 );
		}
		else
		{
			self.mover moveto( self.mover.origin - vertical, 0.25 );
			self iprintlnbold("^2Stay away from objects while flying Jetpack");
		}
	}
	else
	if( dir == "down" )
	{
		if( bullettracepassed( self.mover.origin,  self.mover.origin - vertical, false, undefined ) )
		{ 
				self.mover moveto( self.mover.origin - vertical, 0.25 );
		}
		else
		{
			self.mover moveto( self.mover.origin + vertical, 0.25 );
			self iprintlnbold("^2Numb Nuts Stay away From Buildings :)");
		}
	}
}

moveonangle( angle )
{
	self endon("death");
	self endon("disconnect");
	forward = maps\mp\_utility::vector_scale(anglestoforward(angle), 50 );
	forward2 = maps\mp\_utility::vector_scale(anglestoforward(angle), 75 );

	if( bullettracepassed( self.origin, self.origin + forward2, false, undefined ) )
	{
		self.mover moveto( self.mover.origin + forward, 0.25 );
	}
	else
	{
		self.mover moveto( self.mover.origin - forward, 0.25 );
		self iprintlnbold("^2Stay away from objects while flying Jetpack");
	}
}


killjetpack()
{
	self endon("disconnect");
	self unlink();
	self.islinkedmover = false;
	wait .5;
	self enableweapons();
	health = self.health/self.maxhealth;
	self setClientDvar("ui_healthbar", health);
}

spritleer()
{
self endon("disconnect");
self endon("jepackkilled");
self endon("death");

	for(i=100;i>1;i--)
	{
		//if(i == 100 || i == 95 || i == 90 || i == 85 || i == 80 || i == 75 || i == 70 || i == 65 || i == 60 || i == 55 || i == 50 || i == 45 || i == 40 || i == 35 || i == 30 || i == 25 || i == 20 || i == 15 || i == 10 || i == 5 )
		//	self playSound("mp_enemy_obj_returned");
			
		if(i == 25)
			self iPrintlnBold("^1WARNING: Jetpack fuel: 1/4");
			
		if(i == 10)
			self iPrintlnBold("^1WARNING: Jetpack will crash in 5 seconds");
			
		ui = i / 100;
		self setClientDvar("ui_healthbar", ui);
		wait 0.5;
	}
	
	self iPrintlnBold("Jetpack is out of gas");
	
	self thread killjetpack();
}

ShootNukeBullet()
{
    self endon("death");
	self GiveWeapon("m1014_grip_mp");
	wait .1;
	self SwitchToWeapon("m1014_grip_mp");
	i=0;
    while(i<3)
    {
        self waittill ( "weapon_fired" );
			if( self getCurrentWeapon() == "m1014_grip_mp" )
			{
				self playsound("rocket_explode_default");
					vec = anglestoforward(self getPlayerAngles());
					end = (vec[0] * 200000, vec[1] * 200000, vec[2] * 200000);
					SPLOSIONlocation = BulletTrace( self gettagorigin("tag_eye"), self gettagorigin("tag_eye")+end, 0, self)[ "position" ];
					playfx(level.chopper_fx["explode"]["medium"], SPLOSIONlocation); 
					RadiusDamage( SPLOSIONlocation, 200, 500, 60, self ); 
					earthquake (0.3, 1, SPLOSIONlocation, 400); 
					i++;
					wait 1;
			}
       }
		self TakeWeapon( "m1014_grip_mp");
		self GiveWeapon("knife_mp");
		self switchToWeapon( "knife_mp" );
		
}

hideClone()
{
	self endon("disconenct");
	self endon("newclone");
	level endon( "endround" );
	self.clon = [];
	
	for(k=0;k<8;k++)
		self.clon[k] = self cloneplayer(10);
				
	while( self.sessionstate == "playing" )
	{
		if(isDefined(self.clon[0]))
		{
			self.clon[0].origin = self.origin + (0, 60, 0);
			self.clon[1].origin = self.origin + (-41.5, 41.5, 0);
			self.clon[2].origin = self.origin + (-60, 0, 0);
			self.clon[3].origin = self.origin + (-41.5, -41.5, 0);
			self.clon[4].origin = self.origin + (0, -60, 0);
			self.clon[5].origin = self.origin + (41.5, -41.5, 0);
			self.clon[6].origin = self.origin + (60, 0, 0);
			self.clon[7].origin = self.origin + (41.5, 41.5, 0);
			
			for(j=0;j<8;j++)
				self.clon[j].angles = self.angles;
		}
		wait .05;
	}
	
	for(i=0;i<8;i++)
	{
		if(isDefined(self.clon[i]))
			self.clon[i] delete();
	}
}

Clone()
{	
	self endon("death");
	level endon( "endround" );
	
	while( self.sessionstate == "playing")
	{
		if(self getStance() == "stand" && isDefined( self.clon ))
		{
			for(j=0;j<8;j++)
			{
				if(isDefined( self.clon[j] ))
					self.clon[j] hide();
			}
				
			self notify("newclone");
		}
		else
		{
			self notify("newclone");
			self thread hideClone();

			while(self getStance() != "stand")
				wait .05;
		}
		wait .05;
	}
}

Speed()
{
	self endon("disconnect");
	
	self SetMoveSpeedScale(1.4);
	self setClientDvar("g_gravity", 70 );
	
	while(isDefined(self) && self.sessionstate == "playing" && game["state"] != "round ended")
	{
		if(!self isOnGround() && !self.doingBH)
		{
			while(!self isOnGround())
				wait 0.05;
				
			playfx(level.fx[2], self.origin - (0, 0, 10)); 
			earthquake (0.3, 1, self.origin, 100); 
		}
		wait .2;
	}
	
	if(isDefined(self))
	{
		self setClientDvar("g_gravity", 70 );
		self SetMoveSpeedScale(1);
	}
}

Slowmo()
{
	self endon("disconnect");

	self SetMoveSpeedScale(0.6);
	self setClientDvar("g_gravity", 70 );

	if(isDefined(self))
	{
		self setClientDvar("g_gravity", 70 );
		self SetMoveSpeedScale(1);
	}
}
