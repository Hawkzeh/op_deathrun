/*

    Plugin:	 		Shop
	Version:		2.0
	Requirement:	Cod4(Deathrun)
	Author:			Sajjad
	XFire:			alisajjad4u

*/

init ( modVersion )
{
	precacheItem("c4_mp");
	precacheShader("black");
	precacheShader("white");
	SetupDvars();
	thread OnConnect();
	thread OnSpawned();
	thread killMoney();
	thread ForActi();
}
SetupDvars()
{
	braxi\_dvar::addDvar( "shop_key", "shop_open_and_close_button", "H", "", "", "string" );
	
	braxi\_dvar::addDvar( "shop_timecoins", "time_coins_ammount", 5, 1, 51, "int" );
	braxi\_dvar::addDvar( "shop_timecoins_time", "time_to_give_timecoins", 5, 1, 101, "int" );
	braxi\_dvar::addDvar( "shop_complete_map", "complete_map_coins", 50, 1, 250, "int" );
	braxi\_dvar::addDvar( "shop_on_death", "death_coins", 5, 1, 250, "int" );
	braxi\_dvar::addDvar( "shop_on_kill", "kill_coins", 100, 1, 250, "int" );
	
	braxi\_dvar::addDvar( "shop_weapon", "weapon_one", "brick_blaster_mp", "", "", "string" );
	braxi\_dvar::addDvar( "shop_weapon1", "weapon_two", "remington700_mp", "", "", "string" );
	braxi\_dvar::addDvar( "shop_weapon2", "weapon_three", "ak74u_mp", "", "", "string" );
	braxi\_dvar::addDvar( "shop_weapon3", "weapon_four", "mp5_reflex_mp", "", "", "string" );
	
	braxi\_dvar::addDvar( "shop_weapon_price", "weapon_one_price", 300, 5, 500, "int" );
	braxi\_dvar::addDvar( "shop_weapon_price1", "weapon_two_price", 225,5, 500, "int" );
	braxi\_dvar::addDvar( "shop_weapon_price2", "weapon_three_price", 250,5,500, "int" );
	braxi\_dvar::addDvar( "shop_weapon_price3", "weapon_four_price", 250,5,500, "int" );
	
	braxi\_dvar::addDvar( "shop_realweapon", "weapon_one_show_name", "brick blaster", "", "", "string" );
	braxi\_dvar::addDvar( "shop_realweapon1", "weapon_two_show_name", "R700", "", "", "string" );
	braxi\_dvar::addDvar( "shop_realweapon2", "weapon_three_show_name", "Ak-74u", "", "", "string" );
	braxi\_dvar::addDvar( "shop_realweapon3", "weapon_four_show_name", "mp5", "", "", "string" );
	
	braxi\_dvar::addDvar( "shop_character", "character_one", "body_50cent", "", "", "string" );
	braxi\_dvar::addDvar( "shop_character1", "character_two", "body_makarov", "", "", "string" );
	braxi\_dvar::addDvar( "shop_character2", "character_three", "body_shepherd", "", "", "string" );
	braxi\_dvar::addDvar( "shop_character3", "character_four", "body_masterchief", "", "", "string" );
	
	braxi\_dvar::addDvar( "shop_character_price", "character_one_price", 100,5, 200, "int" );
	braxi\_dvar::addDvar( "shop_character_price1", "character_two_price", 80, 5,200, "int" );
	braxi\_dvar::addDvar( "shop_character_price2", "character_three_price", 75,5,200, "int" );
	braxi\_dvar::addDvar( "shop_character_price3", "character_four_price", 75,5,200, "int" );
	
	braxi\_dvar::addDvar( "shop_realcharacter", "character_one_show_name", "50 Cent", "", "", "string" );
	braxi\_dvar::addDvar( "shop_realcharacter1", "character_two_show_name", "Makarov", "", "", "string" );
	braxi\_dvar::addDvar( "shop_realcharacter2", "character_three_show_name", "Shepherd", "", "", "string" );
	braxi\_dvar::addDvar( "shop_realcharacter3", "character_four_show_name", "Master Chief", "", "", "string" );
	
	level.rmodels[0] =  level.dvar["shop_character"];
	level.rmodels[1] =  level.dvar["shop_character1"];
	level.rmodels[2] =  level.dvar["shop_character2"];
	level.rmodels[3] =  level.dvar["shop_character3"];
	
	level.rweaps[0] =  level.dvar["shop_weapon"];
	level.rweaps[1] =  level.dvar["shop_weapon1"];
	level.rweaps[2] =  level.dvar["shop_weapon2"];
	level.rweaps[3] =  level.dvar["shop_weapon3"];
	
	level.rothers[0] =  "xp";
	level.rothers[1] =  "life";
	level.rothers[2] =  "jetpack";
	level.rothers[3] =  "ghost";
	
	for(i=0;i<level.rmodels.size;i++)
	{
		precacheModel(level.rmodels[i]);
	}
	for(j=0;j<level.rweaps.size;j++)
	{
		precacheItem(level.rweaps[j]);
	}
}

OnConnect()
{
	self endon("disconnect");
	
	while( 1 )
	{
		level waittill("connected",p);
		p braxi\_common::clientCmd("bind "+level.dvar["shop_key"]+" openscriptmenu -1 openshopmenu");
		p.pers["money"] = 0;
	}
}
OnSpawned()
{
	self endon("disconnect");
	while( 1 )
	{
		level waittill("player_spawn",p);
		p thread SetCoins();
		p thread IncreaseByTime();
		p thread MenuResponse();
		p.canopenshop = true;
		p thread OnCompleteMap();
		p thread OnJoined_spectators();
		p thread SomeFix();
		p thread OnDeath();
		p thread Money();
	}
}
MenuResponse()
{
	self endon("disconnect");
	self endon("joined_spectators");
	self.inshopmenu = false;
	for(;;)
	{
		self waittill("menuresponse", menu, response);
		if(!self.inshopmenu  && response == "openshopmenu")
		{
			if(self.canopenshop )
			{
				self.inshopmenu = true;
				for(;self.sessionstate == "playing" && !self isOnGround();wait .05){}
				self disableWeapons();
				self freezeControls(true);			
				self allowSpectateTeam( "allies", false );
				self allowSpectateTeam( "axis", false );
				self allowSpectateTeam( "none", false );
				self.hud_money destroy();
				self.hud_help destroy();
				self thread Main();
			}
			else
			{
				self iPrintlnBold("^6You Can'^2t ^4Open ^1Shop Menu");
			}
		}else if(self.inshopmenu && response == "openshopmenu" && self.canopenshop) {self closeShopMenu();self thread SetCoins();}
		wait .05;
	}
}
Money()
{	
	self endon("disconnect");
	while(1)
	{
		if(self.pers["money"] < 0)
			self.pers["money"] = 0;
		wait .002;
	}
}
SetCoins()
{
	self endon("disconnect");
	self endon("joined_spectators");
	
	if( isDefined(self.hud_money) && isDefined(self.hud_help)) self.hud_money destroy(); self.hud_help destroy();
	shopkey = level.dvar["shop_key"];
	self.hud_help = newClientHudElem(self);
	self.hud_help.alignX = "right";
	self.hud_help.alignY = "top";
	self.hud_help.horzAlign = "right";
	self.hud_help.vertAlign = "top";
	self.hud_help.x = -90;
	self.hud_help.y = 350; 
	self.hud_help.sort = 500;
	self.hud_help.fontScale = 1.4;
	self.hud_help.color = (1, 1, 1);
	self.hud_help.font = "objective";
	self.hud_help.glowColor = (0,1,1);
	self.hud_help.glowAlpha = 1;
	self.hud_help setText("[" + shopkey + "] Shop");
	
	self.hud_money = newClientHudElem(self);
	self.hud_money.alignX = "left";
	self.hud_money.alignY = "top";
	self.hud_money.horzAlign = "left";
	self.hud_money.vertAlign = "top";
	self.hud_money.sort = 500;
	self.hud_money.fontScale = 1.8;
	self.hud_money.label = &"Money:$";
	self.hud_money.color = (1, 1, 1);
	self.hud_money.font = "objective";
	self.hud_money.glowColor = (0.3,1,0.3);
	self.hud_money.glowAlpha = 1;
	self.hud_money.y = 300;
	self.hud_money setValue(self.pers["money"]);
	self.hud_money moveTimeX(2,740,-80);
	self.hud_money.alignX = "right";
	self.hud_money.alignY = "top";
	self.hud_money.horzAlign = "right";
	self.hud_money.vertAlign = "top";
	self.hud_money.x = 0;
	while( 1 )
	{
		self.hud_money setValue(self.pers["money"]);
		wait 1;
	}
}
moveTimeX(time,movex,oldx)
{
	self.x = oldx;
	self moveOverTime(time);
	self.x = movex;
	
}
ForActi()
{
	level waittill("round_started");
	for(i=0;i<20;i++)
	{
		wait 2;
		level.activ.canopenshop = false;
		if(isDefined(level.activ.hud_help))
		{
			level.activ.hud_help destroy();
		}
	}
}
Main()
{
	self endon("disconnect");
	self endon("joined_spectators");
	self endon("endmenu");
	self.isjetpack = false;
	self disableWeapons();
	
	//main Hud
	self.hud_shader = CreateNewHud(self,600,150,"left","top",501,2,"objective",.3,.3);
	self.hud_shader setShader("black",260,250);
	self.hud_shader moveTimeY(1,168,0);
	
	wait 1.3;
	
	//Shop Title
	self.hud_title = CreateNewHud(self,645,180,"left","top",502,2,"objective",1,1);
	self.hud_title.color = (1, 1, 1);
	self.hud_title.glowColor = (0, 0, 1.0);
	self.hud_title.alpha = 1;
	self.hud_title.glowAlpha = 1;
	self.hud_title setText("Main Menu");
	self.hud_title moveTimeX(1,670,900);
	
	//Cat
	self.hud_cat[0] = CreateNewHud(self,620,240,"left","top",504,1.8,"objective",1,1);
	self.hud_cat[0].color = (1, 1, 1);
	self.hud_cat[0].glowColor = (0.3, 0, 0);
	self.hud_cat[0] setText("Characters");
	self.hud_cat[0] moveTimeX(1,610,900);
	
	self.hud_cat[1] = CreateNewHud(self,620,260,"left","top",505,1.8,"objective",1,1);
	self.hud_cat[1].color = (1, 1, 1);
	self.hud_cat[1].glowColor = (0.5, 0.0, 0.2);
	self.hud_cat[1] setText("Weapons");
	self.hud_cat[1] moveTimeX(1,610,900);
	
	self.hud_cat[2] = CreateNewHud(self,620,280,"left","top",506,1.8,"objective",1,1);
	self.hud_cat[2].color = (1, 1, 1);
	self.hud_cat[2].glowColor = (0.5, 0.0, 0.2);
	self.hud_cat[2] setText("Others");
	self.hud_cat[2] moveTimeX(1,610,900);

	wait 1;
	self.catF = CreateNewHud( self, 604, 240, "left", "top",507,2,"objective",0,.5);
	self.catF setShader("white", 220, 18);
	self.catF moveTimeX(1,608,900);
	
	self.hud_price = CreateNewHud( self, 605, 170, "left", "top",400,1.4,"objective",1,1);
	self.hud_price.color = (1, 1, 1);
	self.hud_price.glowColor = (0, 0, 1.0);
	self.hud_price.label = &"Price:$";
	self.hud_price.alpha = 0;
	self.hud_price.glowAlpha = 0;
	
	self.hud_help_left = CreateNewHud( self, 603, 210, "left", "top",401,1.4,"objective",1,1);
	self.hud_help_left.color = (1, 1, 1);
	self.hud_help_left.glowColor = (0, 0, 1.0);
	self.hud_help_left setText("[G]Back");
	
	self.hud_help_right = CreateNewHud( self, 778, 210, "left", "top",401,1.4,"objective",1,1);
	self.hud_help_right.color = (1, 1, 1);
	self.hud_help_right.glowColor = (0, 0, 1.0);
	self.hud_help_right setText("[F]Select");
	
	self.hud_menu_money = CreateNewHud( self, 670, 210, "left", "top",401,1.4,"objective",1,1);
	self.hud_menu_money.color = (1, 1, 1);
	self.hud_menu_money.glowColor = (0, 0, 1.0);
	self.hud_menu_money.label = &"Money:$";
	self.hud_menu_money setValue(self.pers["money"]);
	
	self.onmain = true;
	self.onmodels = false;
	self.onweaps = false;
	self.onother = false;
	self thread onAttackButtonPressed();
	self thread onUseButtonPressed();
	self thread onGranadeButtonPressed();
	
	while( 1 )
	{
	
		self.hud_menu_money setValue(self.pers["money"]);
		wait 1;
	}
}
OnDeath()
{
	self endon("disconnect");
	self endon("player_spawn");
	while( 1 )
	{
		self waittill("death");
		self.pers["money"] = self.pers["money"] - level.dvar["shop_on_death"];
		self thread closeShopMenu();
	}
}
MainMenu()
{
	if(isDefined(self.hud_cat.size)) self thread clearMain();
	
	self.hud_cat[0] = CreateNewHud(self,620,240,"left","top",504,1.8,"objective",1,1);
	self.hud_cat[0].color = (1, 1, 1);
	self.hud_cat[0].glowColor = (0.3, 0, 0);
	self.hud_cat[0] setText("Characters");
	self.hud_cat[0] moveTimeX(1,610,900);
	
	self.hud_cat[1] = CreateNewHud(self,620,260,"left","top",505,1.8,"objective",1,1);
	self.hud_cat[1].color = (1, 1, 1);
	self.hud_cat[1].glowColor = (0.5, 0.0, 0.2);
	self.hud_cat[1] setText("Weapons");
	self.hud_cat[1] moveTimeX(1,610,900);
	
	self.hud_cat[2] = CreateNewHud(self,620,280,"left","top",506,1.8,"objective",1,1);
	self.hud_cat[2].color = (1, 1, 1);
	self.hud_cat[2].glowColor = (0.5, 0.0, 0.2);
	self.hud_cat[2] setText("Others");
	self.hud_cat[2] moveTimeX(1,610,900);
	
	self.hud_price.alpha = 0;
	self.hud_price.glowAlpha = 0;
	
	self.catF.aplha = 1;
	self.catF.glowAplha = 1;
	
	self.catF moveOverTime(.3);
	self.catF.y = self.hud_cat[self.se].y;

	self.onmain = true;
	self.onmodels = false;
	self.onweaps = false;
	self.onother = false;
	
	
}
onAttackButtonPressed()
{
	self endon("disconnect");
	self endon("endmenu");
	self endon("joined_spectators");
	self.se  = 0;
	self.se1  = 0;
	self.se2  = 0;
	self.se3  = 0;
	level.weapons_p[0] = level.dvar["shop_weapon_price"];
	level.weapons_p[1] = level.dvar["shop_weapon_price1"];
	level.weapons_p[2] = level.dvar["shop_weapon_price2"];
	level.weapons_p[3] = level.dvar["shop_weapon_price3"];
	
	level.models_p[0] = level.dvar["shop_character_price"];
	level.models_p[1] = level.dvar["shop_character_price1"];
	level.models_p[2] = level.dvar["shop_character_price2"];
	level.models_p[3] = level.dvar["shop_character_price3"];
	
	level.others_p[0] = 2; //xp
	level.others_p[1] = 175; //life
	level.others_p[2] = 300; //jetpack
	level.others_p[3] = 275; //ghost
	
	while( 1 )
	{
		if(self attackButtonPressed())
		{
			
			if(self.onmain)
			{
				self playLocalSound("mp_war_objective_lost");
				self.se++;
				if(self.se >= self.hud_cat.size)
					self.se = 0;
				self.catF moveOverTime(.3);
				self.catF.y = self.hud_cat[self.se].y;
			}
			else if(self.onmodels)
			{
				self playLocalSound("mp_war_objective_lost");
				self.se1++;
				if(self.se1 >= self.hud_models.size)
					self.se1 = 0;
				self.catF moveOverTime(.3);
				self.catF.y = self.hud_models[self.se1].y;
				
				self.hud_price.alpha = 1;
				self.hud_price.glowAlpha = 1;
				self.hud_price setValue(level.models_p[self.se1]);
			}
			else if(self.onweaps)
			{
				self playLocalSound("mp_war_objective_lost");
				self.se2++;
				if(self.se2 >= self.hud_weapons.size)
					self.se2 = 0;
				self.catF moveOverTime(.3);
				self.catF.y = self.hud_weapons[self.se2].y;
				
				self.hud_price.alpha = 1;
				self.hud_price.glowAlpha = 1;
				self.hud_price setValue(level.weapons_p[self.se2]);
			}
			else if(self.onother)
			{
				self playLocalSound("mp_war_objective_lost");
				self.se3++;
				if(self.se3 >= self.hud_others.size)
					self.se3 = 0;
				self.catF moveOverTime(.3);
				self.catF.y = self.hud_others[self.se3].y;
				
				self.hud_price.alpha = 1;
				self.hud_price.glowAlpha = 1;
				self.hud_price setValue(level.others_p[self.se3]);
			}
		}
		wait .3;
	}
}
onGranadeButtonPressed()
{
	self endon("disconnect");
	self endon("endmenu");
	self endon("joined_spectators");
	while( 1 )
	{
		if(self fragButtonPressed())
		{
			
			if(self.onmain)
			{
				self closeShopMenu();
			}
			else if(self.onmodels)
			{
				self playLocalSound("mp_war_objective_taken");
				if(isDefined(int(self.hud_models.size)))
				{
					for(j=0;j<self.hud_models.size;j++)
					{
						self.hud_models[j] thread moveendinghud();
					}
				}
				self thread MainMenu();
			}
			else if(self.onweaps)
			{
				self playLocalSound("mp_war_objective_taken");
				if(isDefined(int(self.hud_weapons.size)))
				{
					for(j=0;j<self.hud_weapons.size;j++)
					{
						self.hud_weapons[j] thread moveendinghud();
					}
				}
				self thread MainMenu();
			}
			else if(self.onother)
			{
				self playLocalSound("mp_war_objective_taken");
				
				if(isDefined(int(self.hud_others.size)))
				{
					for(f=0;f<self.hud_others.size;f++)
					{
						self.hud_others[f] thread moveendinghud();
					}
				}
				self thread MainMenu();
			}
		}
		wait .1;
	}
}
killMoney()
{
	while( 1 )
	{
		level waittill( "player_killed", who ,attacker , sMeansOfDeath );
		if(isDefined( who ) && isDefined( attacker ))
		{
			attacker.pers["money"] = attacker.pers["money"] + int(level.dvar["shop_on_kill"]);
		}
	}
}
OnJoined_spectators()
{
	self endon("disconnect");
	
	while( 1 )
	{
		self waittill("joined_spectators");
		self thread closeShopMenu();
	}
}
onUseButtonPressed()
{
	self endon("disconnect");
	self endon("endmenu");
	self endon("joined_spectators");
	while( 1 )
	{
		if(self useButtonPressed())
		{
			
			if(self.onmain)
			{
				self playLocalSound("mp_war_objective_taken");
				if(self.se == 0){self clearMain();wait 1;self.hud_title setText("Characters");self plugins\models::Hud_Models();}
				else if(self.se == 1){self clearMain();wait 1;self.hud_title setText("Weapons");self plugins\weapons::Hud_Weapons();}
				else if(self.se == 2){self clearMain();wait 1;self.hud_title setText("0thers");self plugins\others::Hud_Others();}
			}
			else if(self.onmodels)
			{
				self playLocalSound("mp_war_objective_taken");
				self thread plugins\models::setPlayerModel(level.rmodels[self.se1],self.se1);	
				self thread closeShopMenu();
			}
			else if(self.onweaps)
			{
				self playLocalSound("mp_war_objective_taken");
				self thread plugins\weapons::setWeapon(level.rweaps[self.se2],self.se2);	
				self thread closeShopMenu();
			}
			else if(self.onother)
			{
				self playLocalSound("mp_war_objective_taken");
				
				self thread plugins\others::Other(level.rothers[self.se3],self.se3);	
				if(level.rothers[self.se3] != "xp")
				{
					self thread closeShopMenu();
				}
				
			}
		}
		wait .1;
	}
}
clearMain()
{
	for(i=0; i < self.hud_cat.size;i++)
	{
		self.hud_cat[i] thread moveendinghud();
	}
	self.catF.aplha = 0;
	self.catF.glowAplha = 0;
}
closeShopMenu()
{
	
	if(isDefined(int(self.hud_models.size)))
	{
		for(j=0;j<self.hud_models.size;j++)
		{
			//self.hud_models[j] moveTimeX(1,900,self.hud_models[j].x);
		//	self.hud_models[j]   destroy();
			self.hud_models[j] thread moveendinghud();
		}
	}
	if(isDefined(int(self.hud_weapons.size)))
	{
		for(j=0;j<self.hud_weapons.size;j++)
		{
			//self.hud_weapons[j] moveTimeX(1,900,self.hud_weapons[j].x);
			//self.hud_weapons[j] destroy();
			self.hud_weapons[j] thread moveendinghud();
		}
	}
	if(isDefined(int(self.hud_others.size)))
	{
		for(f=0;f<self.hud_others.size;f++)
		{
			//self.hud_others[f] moveTimeX(1,900,self.hud_others[f].x);
			//self.hud_others[f] destroy();
			self.hud_others[f] thread moveendinghud();
		}
	}
	if(isDefined(int(self.hud_cat.size)))
	{
		for(k=0;k<self.hud_cat.size;k++)
		{
		//	self.hud_cat[k] moveTimeX(1,900,self.hud_cat[k].x);
		//	self.hud_cat[k] destroy();
			self.hud_cat[k] thread moveendinghud();
		}
	}
	if(isDefined(int(self.hud_title.size)))
		self.hud_title thread moveendinghud();
		//self.hud_title moveTimeX(1,-20,650);self.hud_title  destroy();
	
	//	self.hud_shader moveTimey(1,-700,0);self.hud_shader destroy();
	if(isDefined(int(self.catF.size)))
		self.catF thread moveendinghud();
	//	self.catF destroy();
	if(isDefined(int(self.hud_price.size)))
		self.hud_price thread moveendinghud();
	//	self.hud_price destroy();
	if(isDefined(int(self.hud_help_left.size)))
		self.hud_help_left thread moveendinghud();
	//	self.hud_help_left destroy();
	if(isDefined(int(self.hud_help_right.size)))
		self.hud_help_right thread moveendinghud();
	//	self.hud_help_right destroy();
	if(isDefined(int(self.hud_menu_money.size)))
		self.hud_menu_money thread moveendinghud();
	if(isDefined(int(self.hud_shader.size)))	
		self.hud_shader destroy();
	//	self.hud_menu_money destroy();
		
	if(self.inshopmenu)
	{
		self playLocalSound("mp_war_objective_taken");
		if(!self.isjetpack)
		{
			self enableWeapons();
		}
		self freezeControls(false);			
		self allowSpectateTeam( "allies", true );
		self allowSpectateTeam( "axis", true );
		self allowSpectateTeam( "none", true );
		self.inshopmenu = false;
		self.onmain = false;
		self.onmodels = false;
		self.onweaps = false;
		self.onother = false;
		self thread SetCoins();
		self notify("endmenu");
	}
}
moveendinghud()
{
	self moveTimeX(1,900,self.x);
	wait 1.2;
	self destroy();
}
OnCompleteMap()
{
	trig = getEntArray("endmap_trig","targetname");
	if( !trig.size || trig.size > 1 )
		return;
	trig = trig[0];
	trig waittill("trigger",nub);
	nub.pers["money"] = nub.pers["money"] + level.dvar["shop_complete_map"];
	nub.canopenshop = false;
}
moveTimeY(time,movey,oldy)
{
	self.y = oldy;
	self moveOverTime(time);
	self.y = movey;
}
CreateNewHud(who,x,y,alignx,aligny,sort,scale,font,glowalpha,alpha)
{
	hud = newClientHudElem(who);
	hud.y = y;
	hud.x = x;
	hud.alignX = alignx;
	hud.alignY = alignY;
	hud.horzAlign = alignx;
	hud.vertAlign = alignY;
	hud.sort = sort;
	hud.fontScale = scale;
	hud.alpha = 0;
	hud fadeOverTime(2);
	hud.alpha = alpha;
	hud.font = font;
	hud.glowAlpha = glowalpha;
	return hud;
}
SomeFix()
{
	self endon("disconnect");
	
	while(1)
	{
		if(!self.inshopmenu)
		{
			self thread closeShopMenu();
		}
		wait 1;
	}
}
IncreaseByTime()
{
	self endon( "disconnect" );
	self endon( "joined_spectators" );
	while( 1 )
	{
		self.pers["money"] = self.pers["money"] + int(level.dvar["shop_timecoins"]);
		wait int(level.dvar["shop_timecoins_time"]);
	}
	
}