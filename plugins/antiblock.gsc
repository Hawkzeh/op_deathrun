/*===================================================================||
||/|¯¯¯¯¯¯¯\///|¯¯|/////|¯¯|//|¯¯¯¯¯¯¯¯¯|//|¯¯¯¯¯¯¯¯¯|//\  \/////  //||
||/|  |//\  \//|  |/////|  |//|  |/////////|  |//////////\  \///  ///||
||/|  |///\  \/|  |/////|  |//|  |/////////|  |///////////\  \/  ////||
||/|  |///|  |/|  |/////|  |//|   _____|///|   _____|//////\    /////||
||/|  |////  //|  \/////|  |//|  |/////////|  |/////////////|  |/////||
||/|  |///  ////\  \////  ////|  |/////////|  |/////////////|  |/////||
||/|______ //////\_______/////|  |/////////|  |/////////////|  |/////||
||===================================================================*/

init( modVersion )
{
	thread SaveSpots();
	for(;;)
	{
		level waittill("connected", player);
		player thread Blockdetector();
		player thread Blockchooser();
	}
}

SaveSpots()
{
	for(;;)
	{
		players = getentarray("player", "classname");
		for(i=0; i<players.size; i++)
		{
			if(isdefined(players[i]) 
			&& !level.freeRun 
			&& players[i].sessionstate == "playing" 
			&& players[i] isOnGround() 
			&& !isDefined(BulletTrace( players[i].origin+(0,0,10), players[i].origin-(0,0,10), false, self )["entity"]) 
			&& !isDefined(BulletTrace( players[i].origin+(20,0,10), players[i].origin-(-20,0,10), false, self )["entity"]) 
			&& !isDefined(BulletTrace( players[i].origin+(20,20,10), players[i].origin-(-20,-20,10), false, self )["entity"]) 
			&& !isDefined(BulletTrace( players[i].origin+(20,-20,10), players[i].origin-(-20,20,10), false, self )["entity"]) 
			&& !isDefined(BulletTrace( players[i].origin+(-20,20,10), players[i].origin-(20,-20,10), false, self )["entity"]) 
			&& !isDefined(BulletTrace( players[i].origin+(-20,-20,10), players[i].origin-(20,20,10), false, self )["entity"]) 
			&& !isDefined(BulletTrace( players[i].origin+(-20,0,10), players[i].origin-(20,0,10), false, self )["entity"]) 
			&& !isDefined(BulletTrace( players[i].origin+(0,-20,10), players[i].origin-(0,20,10), false, self )["entity"]) 
			&& !isDefined(BulletTrace( players[i].origin+(0,20,10), players[i].origin-(0,-20,10), false, self )["entity"]))
			{
				players[i].safespot["origin"] = players[i].origin;
				players[i].safespot["angles"] = players[i].angles;
			}
		}
		wait .5;
	}
}

Blockdetector()
{
	self endon("disconnect");
	self endon( "joined_spectators" );
	self endon( "stop_respawn" );
	
	self.touchplayer = false;
	wait 5; 
	for(;;)
	{
		players = getentarray("player", "classname");
		for(i=0; i<players.size; i++)
		{
			player = players[i];
			if( self != player && !level.freeRun && isDefined( player ) )
			{
				if( player.sessionstate == "playing" && self.sessionstate == "playing" && self.pers["team"] == "allies" && player.pers["team"] == "allies" )
				{
					oriniedrich = self.origin - (0,0,25);
					orihoch = self.origin + (0,0,25);
					oriniedrich2 = player.origin - (0,0,25);
					orihoch2 = player.origin + (0,0,25);				
					if( distancesquared(oriniedrich,oriniedrich2) < 40*40 || distancesquared(oriniedrich,orihoch2) < 40*40 || distancesquared(orihoch,oriniedrich2) < 40*40 || distancesquared(orihoch,orihoch2) < 40*40)
					{
						self.touchplayer = true;
						self.lasttouched = player;
						wait .1;
					}
					else
					{
						self.touchplayer = false;
					}
				}
				else
				{
					self.touchplayer = false;
				}
			}

		}
		wait 0.05;
	}
}

Blockchooser()
{
	self endon("disconnect");
	self endon( "joined_spectators" );
	self endon( "stop_respawn" );
	
	time = getDvarInt( "dr_blocktime" ) * 20;
	self.touchplayer = false;
	wait 5; 
	for(;;)
	{
		while(!self.touchplayer)
			wait .05;
		for(i=0;i<time;i++)
		{
			if(self.touchplayer)
				i = 0;
			
			if( self.sessionstate != "playing")
			{
				iPrintln( "^3[Anti-Block]: ^2"+self.name+" ^5were blocked by ^1" +self.lasttouched.name );	
				usesafespot = false;
				if(isdefined(self.safespot["origin"]))
				{		
					self.respawntimer = addTextHud( self, 0, 95, 1, "center", "middle", "center", "middle", 1.6, 1 );//help
					self.respawntimer.label = &"^3You ^7were blocked by^3 &&1";
					self.respawntimer SetPlayerNameString(self.lasttouched);
					self.respawntimer.glowColor = level.randomcolour;
					self.respawntimer.glowAlpha = 1;
					self.respawntimer SetPulseFX( 30, 100000, 700 );
					
					self.respawntext = addTextHud( self, 0, 112, 1, "center", "middle", "center", "middle", 1.6, 1 );//help
					self.respawntext.label = &"Area not secure...^3&&1";
					self.respawntext setTenthsTimer(10);
					self.respawntext.glowColor = level.randomcolour;
					self.respawntext.glowAlpha = 1;
					self.respawntext SetPulseFX( 30, 100000, 700 );		

					self.respawnbg = duffman\hud::addTextBackground( self, "^3You ^7were blocked by^3 " + self.lasttouched.name , 0, 103.5, 1, "center", "middle", "center", "middle", 0 );
	
					for(k=0;k<200;k++)
					{
						if(self isOriginSafe(self.safespot["origin"]))
						{
							usesafespot = true;
							k = 201;
						}
						if(self meleebuttonpressed())
							k = 201;
						wait .05;
					}
				}
				self braxi\_mod::SpawnPlayer();	
				if(isDefined(self.respawntimer))
					self.respawntimer destroy();
				if(isDefined(self.respawntext))
					self.respawntext destroy();	
				if(isDefined(self.respawnbg))	
					self.respawnbg destroy();		 
				if(usesafespot)
				{
					self setOrigin(self.safespot["origin"]);
					self setPlayerAngles(self.safespot["angles"]);
				}
				i = 1000; 					
				self.touchplayer = false;
			}
			wait .05;
		}
		wait .05;
	}
}

addTextHud( who, x, y, alpha, alignX, alignY, horiz, vert, fontScale, sort )
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
		hud.vertAlign = vert;
	if(isdefined(horiz))
		hud.horzAlign = horiz;		
	if(fontScale != 0)
		hud.fontScale = fontScale;
	return hud;
}

isOriginSafe(origin)
{
	players = getentarray("player", "classname");
	for(i=0; i<players.size; i++)
		if(isdefined(players[i]) && players[i].sessionstate == "playing" )
			if(distance(players[i].origin,origin) <= 100)
				return false;
	return true;
}