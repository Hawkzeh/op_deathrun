
// VIP
#include braxi\_dvar;

init( modVersion )
{
	addDvar( "vipWeapon", "bx_vip_weapon", "knife_mp", "", "", "string" );
	
	precacheItem( level.dvar["vipWeapon"] );
	precacheMenu( "vip" );

	level.vips = [];

	for( i = 0; i < 10; i++ )
	{
		parms = strTok( getDvar("bx_vip_pass_"+i), ":" );
		
		if( parms.size < 3 )
		{
			//print( dvar + " - must have 3 params" );
			continue;
		}

		vip = spawnStruct();
		vip.guid = parms[0];
		vip.login = parms[1];
		vip.pw = parms[2];
		level.vips[level.vips.size] = vip;
	}

	thread onPlayerSpawned();

	while( 1 )
	{
		level waittill( "connected", player );
	
		if( !isDefined( player.pers["vip"] ) )
			player.pers["vip"] = false;

		if( !player.pers["vip"] ) 
			player thread verifyVIP();

		player thread VIP_WatchMenu();
	}
}

verifyVIP()
{
	for( i = 0; i < level.vips.size; i++ )
	{
		if( self getGuid() == level.vips[i].guid )
		{
			self.pers["vip"] = true; //we have two types of VIP - real VIPs and test accounts which can be used only once
self setClientDvars( "vip", "1", "vip_1", "Special Spray ^1OFF", "vip_2", "Explode", "vip_3", "^5Characters", "vip_4", "Dog Character ^1OFF", "vip_5", "Joker Character ^1OFF", "vip_6", "Duke Nukem Character ^1OFF", "vip_7", "Novak Heavy Character ^1OFF", "vip_8", "Rosco Heavy Character ^1OFF" );
			return;
		}
	}
}

onPlayerSpawned()
{
	while( 1 )
	{
		level waittill( "jumper", player );

		if( !player.pers["vip"] )
			continue;

		if( !isDefined( player.pers["vipOnce"] ) )
		{
			player.pers["vipOnce"] = true;
			//player iPrintlnBold( "You can gib yourself by pressing ^2USE+KNIFE^7 (F+V by default)" );
		}

			
		if( !player.pers["isDog"] && !level.freeRun || !player.pers["isDog"] && level.freeRun && game["roundsplayed"] == 1 )
		{
			player giveWeapon( level.dvar["vipWeapon"] );
			player giveMaxAmmo( level.dvar["vipWeapon"] );
			player switchToWeapon( level.dvar["vipWeapon"]);
		}

	}
}

VIP_WatchShortcuts()
{
	self endon( "disconnect" );
	self endon( "death" );

	self setClientDvar( "cg_laserForceOn", 1 );

	wait 0.2;
	while( 1 )
	{
		iprintln("t");
		if( self useButtonPressed() && self meleeButtonPressed() )
		{
			self playSound( "gib_splat" );
			playFx( level.fx["gib_splat"], self.origin + (0,0,20) );
			wait 0.8;
		}
		wait 0.1;
	}
}

VIP_WatchMenu()
{
	self endon( "disconnect" );

	if( !self.pers["vip"] )
		return;

	//self thread VIP_WatchShortcuts();

	while( 1 )
	{
		self waittill("menuresponse", menu, response);

		if( menu != "vip" )
			continue;

		switch( response )
		{
		case "vip_1":
			if( !isDefined( self.pers["customSpray"] ) )
			{
				self.pers["customSpray"] = true;
				self setClientDvar( response, "Special Spray ^2ON" );
			}
			else
			{
				self.pers["customSpray"] = undefined;
				self setClientDvar( response, "Special Spray ^1OFF" );
			}
			break;

		case "vip_2":
			if( self.sessionstate == "playing" )
			{
				command = [];
				command[0] = "wtf";
				command[1] = self getEntityNumber();

				braxi\_admin::adminCommands( command, "number" );
			}
			break;

		case "vip_3":
			{
				self setClientDvar( response, "^5Characters" );
			}
			break;
			
		case "vip_4":
			if( !self.pers["isDog"] )
			{
				self.pers["isDog"] = true;
				self setClientDvar( response, "Dog Character ^2ON" );
			}
			else
			{
				self.pers["isDog"] = false;
				self setClientDvar( response, "Dog Character ^1OFF" );
			}
			break;
			
		case "vip_5":
			if( !self.pers["isJoker"] )
			{
				self.pers["isJoker"] = true;
				self setClientDvar( response, "Joker Character ^2ON" );
			}
			else
			{
				self.pers["isJoker"] = false;
				self setClientDvar( response, "Joker Character ^1OFF" );
			}
			break;
			
		case "vip_6":
			if( !self.pers["isDuke"] )
			{
				self.pers["isDuke"] = true;
				self setClientDvar( response, "Duke Nukem Character ^2ON" );
			}
			else
			{
				self.pers["isDuke"] = false;
				self setClientDvar( response, "Duke Nukem Character ^1OFF" );
			}
			break;
			
		case "vip_7":
			if( !self.pers["isArmyh"] )
			{
				self.pers["isArmyh"] = true;
				self setClientDvar( response, "Novak Heavy Character ^2ON" );
			}
			else
			{
				self.pers["isArmyh"] = false;
				self setClientDvar( response, "Novak Heavy Character ^1OFF" );
			}
			break;	
			
		case "vip_8":
			if( !self.pers["isRoskoh"] )
			{
				self.pers["isRoskoh"] = true;
				self setClientDvar( response, "Rosko Heavy Character ^2ON" );
			}
			else
			{
				self.pers["isRoskoh"] = false;
				self setClientDvar( response, "Rosko Heavy Character ^1OFF" );
			}
			break;	
		}
	}
}

