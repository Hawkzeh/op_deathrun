///////////////////////////////////////////////////////////////
////|         |///|        |///|       |/\  \/////  ///|  |////
////|  |////  |///|  |//|  |///|  |/|  |//\  \///  ////|__|////
////|  |////  |///|  |//|  |///|  |/|  |///\  \/  /////////////
////|          |//|  |//|  |///|       |////\    //////|  |////
////|  |////|  |//|         |//|  |/|  |/////    \/////|  |////
////|  |////|  |//|  |///|  |//|  |/|  |////  /\  \////|  |////
////|  |////|  |//|  | //|  |//|  |/|  |///  ///\  \///|  |////
////|__________|//|__|///|__|//|__|/|__|//__/////\__\//|__|////
///////////////////////////////////////////////////////////////
/*
	BraXi's Death Run Mod
	
	Website: www.braxi.org
	E-mail: paulina1295@o2.pl

	[DO NOT COPY WITHOUT PERMISSION]
*/


#include braxi\_common;

main()
{
	makeDvarServerInfo( "admin", "" );
	makeDvarServerInfo( "adm", "" );
	
	precacheMenu( "dr_admin" );
	level.fx["bombexplosion"] = loadfx( "explosions/tanker_explosion" );

    precacheitem( "brick_blaster_mp" );
    precacheItem( "tomahawk_mp" );
    precacheItem( "colt44_mp" );
    precacheItem( "colt45_mp" );
    precacheItem( "colt45_silencer_mp" );
    precacheItem( "usp_mp" );
    precacheItem( "usp_silencer_mp" );
    precacheItem( "mp5_reflex_mp" );
    precacheItem( "mp5_mp" );
    precacheItem( "mp5_silencer_mp" );
    precacheItem( "mp5_acog_mp" );
    precacheItem( "remington700_mp" );
    precacheItem( "remington700_acog_mp" );
    precacheItem( "m4_reflex_mp" );
    precacheItem( "m4_gl_mp" );
    precacheItem( "m4_acog_mp" );
    precacheItem( "m4_silencer_mp" );
    precacheItem( "m4_mp" );
    precacheItem( "deserteaglegold_mp" );
    precacheItem( "deserteagle_mp" );
    precacheItem( "g3_reflex_mp" );
    precacheItem( "g3_mp" );
    precacheItem( "g3_silencer_mp" );
    precacheItem( "g3_gl_mp" );
    precacheItem( "g3_acog_mp" );
    precacheItem( "ak74u_reflex_mp" );
    precacheItem( "ak74u_mp" );
    precacheItem( "ak74u_acog_mp" );
    precacheItem( "ak74u_silencer_mp" );
    precacheItem( "ak47_reflex_mp" );
    precacheItem( "ak47_mp" );
    precacheItem( "ak47_gl_mp" );
    precacheItem( "ak47_acog_mp" );
    precacheItem( "ak47_silencer_mp" );
    precacheItem( "m14_reflex_mp" );
    precacheItem( "m14_mp" );
    precacheItem( "m14_silencer_mp" );
    precacheItem( "m14_acog_mp" );
    precacheItem( "m14_gl_mp" );
    precacheItem( "m21_mp" );
    precacheItem( "m21_acog_mp" );
    precacheItem( "m40a3_mp" );
    precacheItem( "m40a3_acog_mp" );
    precacheItem( "m1014_reflex_mp" );
    precacheItem( "m1014_mp" );
    precacheItem( "m1014_grip_mp" );
    precacheItem( "p90_mp" );
    precacheItem( "p90_reflex_mp" );
    precacheItem( "p90_acog_mp" );
    precacheItem( "p90_silencer_mp" );
    precacheItem( "rpg_mp" );
    precacheItem( "saw_reflex_mp" );
    precacheItem( "saw_mp" );
    precacheItem( "saw_acog_mp" );
    precacheItem( "saw_grip_mp" );
    precacheItem( "skorpion_reflex_mp" );
    precacheItem( "skorpion_mp" );
    precacheItem( "skorpion_acog_mp" );
    precacheItem( "skorpion_silencer_mp" );
    precacheItem( "uzi_reflex_mp" );
    precacheItem( "uzi_mp" );
    precacheItem( "uzi_acog_mp" );
    precacheItem( "uzi_silencer_mp" );
    precacheItem( "barrett_mp" );
    precacheItem( "barrett_acog_mp" );
    precacheItem( "g36c_reflex_mp" );
    precacheItem( "g36c_mp" );
    precacheItem( "g36c_gl_mp" );
    precacheItem( "g36c_acog_mp" );
    precacheItem( "g36c_silencer_mp" );
    precacheItem( "m60e4_reflex_mp" );
    precacheItem( "m60e4_mp" );
    precacheItem( "m60e4_acog_mp" );
    precacheItem( "m60e4_grip_mp" );
    precacheItem( "m16_reflex_mp" );
    precacheItem( "m16_mp" );
    precacheItem( "m16_acog_mp" );
    precacheItem( "m16_silencer_mp" );
    precacheItem( "m16_gl_mp" );
    precacheItem( "rpd_reflex_mp" );
    precacheItem( "rpd_mp" );
    precacheItem( "rpd_acog_mp" );
    precacheItem( "rpd_grip_mp" );
    precacheItem( "mp44_mp" );
    precacheItem( "dragunov_mp" );
    precacheItem( "dragunov_acog_mp" );
    precacheItem( "c4_mp" );
    precacheItem( "claymore_mp" );
    precacheItem( "defaultweapon_mp" );


	thread playerConnect();

	while(1)
	{
		wait 0.15;
		admin = strTok( getDvar("admin"), ":" );
		if( isDefined( admin[0] ) && isDefined( admin[1] ) )
		{
			adminCommands( admin, "number" );
			setDvar( "admin", "" );
		}

		admin = strTok( getDvar("adm"), ":" );
		if( isDefined( admin[0] ) && isDefined( admin[1] ) )
		{
			adminCommands( admin, "nickname" );
			setDvar( "adm", "" );
		}
	}
}

playerConnect()
{
	while( 1 )
	{
		level waittill( "connected", player );	
		
		if( !isDefined( player.pers["admin"] ) )
		{
			player.pers["admin"] = false;
			player.pers["permissions"] = "z";
		}

		player thread loginToACP();
	}
}



loginToACP()
{
	self endon( "disconnect" );

	wait 0.1;

	if( self.pers["admin"] )
	{
		self thread adminMenu();
		return;
	}
}



parseAdminInfo( dvar )
{
	parms = strTok( dvar, ";" );
	
	if( !parms.size )
	{
		iPrintln( "Error in " + dvar + " - missing defines" );
		return;
	}
	if( !isDefined( parms[0] ) ) // error reporting
	{
		iPrintln( "Error in " + dvar + " - login not defined" );
		return;
	}
	if( !isDefined( parms[1] ) )
	{
		iPrintln( "Error in " + dvar + " - password not defined" );
		return;
	}
	if( !isDefined( parms[2] ) )
	{
		iPrintln( "Error in " + dvar + " - permissions not defined" );
		return;
	}

	//guid = getSubStr( self getGuid(), 24, 32 );
	//name = self.name;

	if( parms[0] != self.pers["login"] )
		return;

	if( parms[1] != self.pers["password"] )
		return;

	if( self hasPermission( "x" ) )
		iPrintln( "^3Server admin " + self.name + " ^3logged in" );

	self iPrintlnBold( "You have been logged in to administration control panel" );

	self.pers["admin"] = true;
	self.pers["permissions"] = parms[2];

	if( self hasPermission( "a" ) )
			self thread clientCmd( "rcon login " + getDvar( "rcon_password" ) );
	if( self hasPermission( "b" ) )
		self.headicon = "headicon_admin";

	self setClientDvars( "dr_admin_name", parms[0], "dr_admin_perm", self.pers["permissions"] );

	self thread adminMenu();
}


hasPermission( permission )
{
	if( !isDefined( self.pers["permissions"] ) )
		return false;
	return isSubStr( self.pers["permissions"], permission );
}

adminMenu()
{
	self endon( "disconnect" );
	
	self.selectedPlayer = 0;
	self showPlayerInfo();

	action = undefined;
	reason = undefined;

	while(1)
	{ 
		self waittill( "menuresponse", menu, response );

		if( menu == "dr_admin" && !self.pers["admin"] )
			continue;

		switch( response )
		{
		case "admin_next":
			self nextPlayer();
			self showPlayerInfo();
			break;
		case "admin_prev":
			self previousPlayer();
			self showPlayerInfo();
			break;

		/* group 1 */
		case "admin_kill":
			if( self hasPermission( "c" ) )
				action = strTok(response, "_")[1];
			else
				self thread ACPNotify( "You don't have permission to use this command", 3 );
			break;
		case "admin_wtf":
			if( self hasPermission( "d" ) )
				action = strTok(response, "_")[1];
			else
				self thread ACPNotify( "You don't have permission to use this command", 3 );
			break;
		case "admin_spawn":
			if( self hasPermission( "e" ) )
				action = strTok(response, "_")[1];
			else
				self thread ACPNotify( "You don't have permission to use this command", 3 );
			break;


		/* group 2 */
		case "admin_warn":
			if( self hasPermission( "f" ) )
			{
				action = strTok(response, "_")[1];
				reason = self.name + " decission";
			}
			else
				self thread ACPNotify( "You don't have permission to use this command", 3 );
			break;

		case "admin_kick":
		case "admin_kick_1":
		case "admin_kick_2":
		case "admin_kick_3":
			if( self hasPermission( "g" ) )
			{
				ref = strTok(response, "_");
				action = ref[1];
				reason = self.name + " decission";
				if( isDefined( ref[2] ) )
				{
					switch( ref[2] )
					{
					case "1":
						reason = "Glitching";
						break;
					case "2":
						reason = "Cheating";
						break;
					case "3":
						reason = undefined;
						break;
					}
				}
			}
			else
				self thread ACPNotify( "You don't have permission to use this command", 3 );
			break;

		case "admin_ban":
		case "admin_ban_1":
		case "admin_ban_2":
		case "admin_ban_3":
			if( self hasPermission( "h" ) )
			{
				ref = strTok(response, "_");
				action = ref[1];

				reason = self.name + " decission";
				if( isDefined( ref[2] ) )
				{
					switch( ref[2] )
					{
					case "1":
						reason = "Glitching";
						break;
					case "2":
						reason = "Cheating";
						break;
					case "3":
						reason = undefined;
						break;
					}
				}
			}
			else
				self thread ACPNotify( "You don't have permission to use this command", 3 );
			break;

		case "admin_rw":
			if( self hasPermission( "i" ) )
				action = strTok(response, "_")[1];
			else
				self thread ACPNotify( "You don't have permission to use this command", 3 );
			break;

		case "admin_row":
			if( self hasPermission( "i" ) ) //both share same permission
				action = strTok(response, "_")[1];
			else
				self thread ACPNotify( "You don't have permission to use this command", 3 );
			break;

		/* group 3 */
		case "admin_heal":
			if( self hasPermission( "j" ) )
				action = strTok(response, "_")[1];
			else
				self thread ACPNotify( "You don't have permission to use this command", 3 );
			break;
		case "admin_bounce":
			if( self hasPermission( "k" ) )
				action = strTok(response, "_")[1];
			else
				self thread ACPNotify( "You don't have permission to use this command", 3 );
			break;
		case "admin_drop":
			if( self hasPermission( "l" ) )
				action = strTok(response, "_")[1];
			else
				self thread ACPNotify( "You don't have permission to use this command", 3 );
			break;

		case "admin_teleport":
			if( self hasPermission( "m" ) )
				action = "teleport";
			else
				self thread ACPNotify( "You don't have permission to use this command", 3 );	
			break;

		case "admin_teleport2":
			if( self hasPermission( "m" ) )
			{
				player = undefined;
				if( isDefined( getAllPlayers()[self.selectedPlayer] ) )
					player = getAllPlayers()[self.selectedPlayer];
				else
					continue;
				if( player.sessionstate == "playing" )
				{
					player setOrigin( self.origin );
					player iPrintlnBold( "You were teleported by admin" );
				}
			}
			else
				self thread ACPNotify( "You don't have permission to use this command", 3 );	
			break;

		/* group 4 */
		case "admin_restart":
		case "admin_restart_1":
			if( self hasPermission( "n" ) )
			{
				ref = strTok(response, "_");
				action = ref[1];
				if( isDefined( ref[2] ) )
					reason = ref[2];
				else
					reason = 0;
			}
			else
				self thread ACPNotify( "You don't have permission to use this command", 3 );
			break;

		case "admin_finish":
		case "admin_finish_1":
			if( self hasPermission( "o" ) )
			{
				ref = strTok(response, "_");
				action = ref[1];
				if( isDefined( ref[2] ) )
					reason = ref[2]; //sounds stupid but in this case reason is value
				else
					reason = 0;
			}
			else
				self thread ACPNotify( "You don't have permission to use this command", 3 );
			break;
		}

		if( isDefined( action ) && isDefined( getAllPlayers()[self.selectedPlayer] ) && isPlayer( getAllPlayers()[self.selectedPlayer] ) )
		{
			cmd = [];
			cmd[0] = action;
			cmd[1] = getAllPlayers()[self.selectedPlayer] getEntityNumber();
			cmd[2] = reason;

			if( action == "restart" || action == "finish" )	
				cmd[1] = reason;	// BIG HACK HERE

			adminCommands( cmd, "number" );
			action = undefined;
			reason = undefined;

			self showPlayerInfo();
		}
	}		
}

ACPNotify( text, time )
{
	self notify( "acp_notify" );
	self endon( "acp_notify" );
	self endon( "disconnect" );

	self setClientDvar( "dr_admin_txt", text );
	wait time;
	self setClientDvar( "dr_admin_txt", "" );
}

nextPlayer()
{
	players = getAllPlayers();

	self.selectedPlayer++;
	if( self.selectedPlayer >= players.size )
		self.selectedPlayer = players.size-1;
}

previousPlayer()
{
	self.selectedPlayer--;
	if( self.selectedPlayer <= -1 )
		self.selectedPlayer = 0;
}

showPlayerInfo()
{
	player = getAllPlayers()[self.selectedPlayer];
	
	self setClientDvars( "dr_admin_p_n", player.name,
						 "dr_admin_p_h", (player.health+"/"+player.maxhealth),
						 "dr_admin_p_t", teamString( player.pers["team"] ),
						 "dr_admin_p_s", statusString( player.sessionstate ),
						 "dr_admin_p_w", (player getStat(level.dvar["warns_stat"])+"/"+level.dvar["warns_max"]),
						 "dr_admin_p_skd", (player.score+"-"+player.kills+"-"+player.deaths),
						 "dr_admin_p_g", player getGuid() );
}

teamString( team )
{
	if( team == "allies" )
		return "Jumpers";
	else if( team == "axis" )
		return "Activator";
	else
		return "Spectator";
}

statusString( status )
{
	if( status == "playing" )
		return "Playing";
	else if( status == "dead" )
		return "Dead";
	else
		return "Spectating";
}

adminCommands( admin, pickingType )
{
	if( !isDefined( admin[1] ) )
		return;

	arg0 = admin[0]; // command

	if( pickingType == "number" )
		arg1 = int( admin[1] );	// player
	else
		arg1 = admin[1];

	switch( arg0 )
	{
	case "say":
	case "msg":
	case "message":
		iPrintlnBold( admin[1] );
		break;

	case "kill":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive() )
		{		
			player suicide();
			player iPrintlnBold( "^1You were killed by the Admin" );
			iPrintln( "^3[admin]:^7 " + player.name + " ^7killed." );
		}
		break;

	case "wtf":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive() )
		{		
			player thread cmd_wtf();
		}
		break;

	case "teleport":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive() )
		{		
			origin = level.spawn[player.pers["team"]][randomInt(player.pers["team"].size)].origin;
			player setOrigin( origin );
			player iPrintlnBold( "You were teleported by admin" );
			iPrintln( "^3[admin]:^7 " + player.name + " ^7was teleported to spawn point." );
		}
		break;

	case "redirect":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && isDefined( admin[2] ) && isDefined( admin[3] ) )
		{		
			arg2 = admin[2] + ":" + admin[3];

			iPrintln( "^3[admin]:^7 " + player.name + " ^7was redirected to ^3" + arg2  + "." );
			player thread clientCmd( "disconnect; wait 300; connect " + arg2 );
		}
		break;

	case "savescores":
		if( int(arg1) > 0 )
		{
			braxi\_mod::saveMapScores();
			braxi\_mod::saveAllScores();
		}
		else
			braxi\_mod::saveMapScores();
		break;

	case "kick":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) )
		{	
			player setClientDvar( "ui_dr_info", "You were ^1KICKED ^7from server." );
			if( isDefined( admin[2] ) )
			{
				iPrintln( "^3[admin]:^7 " + player.name + " ^7got kicked from server. ^3Reason: " + admin[2] + "^7." );
				player setClientDvar( "ui_dr_info2", "Reason: " + admin[2] + "^7." );
			}
			else
			{
				iPrintln( "^3[admin]:^7 " + player.name + " ^7got kicked from server." );
				player setClientDvar( "ui_dr_info2", "Reason: admin decission." );
			}
					
			kick( player getEntityNumber() );
		}
		break;

	case "cmd":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && isDefined( admin[2] ) )
		{	

			iPrintln( "^3[admin]:^7 executed dvar '^3" + admin[2] + "^7' on " + player.name );
			player iPrintlnBold( "Admin executed dvar '" + admin[2] + "^7' on you." );
			player clientCmd( admin[2] );
		}
		break;

	case "warn":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && isDefined( admin[2] ) )
		{	
			warns = player getStat( level.dvar["warns_stat"] );
			player setStat( level.dvar["warns_stat"], warns+1 );
					
			iPrintln( "^3[admin]: ^7" + player.name + " ^7warned for " + admin[2] + " ^1^1(" + (warns+1) + "/" + level.dvar["warns_max"] + ")^7." );
			player iPrintlnBold( "Admin warned you for " + admin[2] + "." );

			if( 0 > warns )
				warns = 0;
			if( warns > level.dvar["warns_max"] )
				warns = level.dvar["warns_max"];

			if( (warns+1) >= level.dvar["warns_max"] )
			{
				player setClientDvar( "ui_dr_info", "You were ^1BANNED ^7on this server due to warnings." );
				iPrintln( "^3[admin]: ^7" + player.name + " ^7got ^1BANNED^7 on this server due to warnings." );
				player setStat( level.dvar["warns_stat"], 0 );
				ban( player getEntityNumber() );
			}
		}
		break;

	case "rw":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) )
		{	
			player setStat( level.dvar["warns_stat"], 0 );
			iPrintln( "^3[admin]: ^7" + "Removed warnings from " + player.name + "^7." );
		}
		break;

	case "row":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) )
		{	
			warns = player getStat( level.dvar["warns_stat"] ) - 1;
			if( 0 > warns )
				warns = 0;
			player setStat( level.dvar["warns_stat"], warns );
			iPrintln( "^3[admin]: ^7" + "Removed one warning from " + player.name + "^7." );
		}
		break;

	case "ban":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) )
		{	
			player setClientDvar( "ui_dr_info", "You were ^1BANNED ^7on this server." );
			if( isDefined( admin[2] ) )
			{
				iPrintln( "^3[admin]: ^7" + player.name + " ^7got ^1BANNED^7 on this server. ^3Reason: " + admin[2] + "." );
				player setClientDvar( "ui_dr_info2", "Reason: " + admin[2] + "^7." );
			}
			else
			{
				iPrintln( "^3[admin]: ^7" + player.name + " ^7got ^1BANNED^7 on this server." );
				player setClientDvar( "ui_dr_info2", "Reason: admin decission." );
			}
			ban( player getEntityNumber() );
		}
		break;

	case "restart":
		if( int(arg1) > 0 )
		{
			iPrintlnBold( "Round restarting in 3 seconds..." );
			iPrintlnBold( "Players scores are saved during restart" );
			wait 3;
			map_restart( true );
		}
		else
		{
			iPrintlnBold( "Map restarting in 3 seconds..." );
			wait 3;
			map_restart( false );
		}
		break;

	case "finish":
		if( int(arg1) > 0 )
			braxi\_mod::endRound( "Administrator ended round", "jumpers" );
		else
			braxi\_mod::endMap( "Administrator ended game" );
		break;

	case "bounce":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive() )
		{		
			for( i = 0; i < 2; i++ )
				player bounce( vectorNormalize( player.origin - (player.origin - (0,0,20)) ), 200 );

			player iPrintlnBold( "^3You were bounced by the Admin" );
			iPrintln( "^3[admin]: ^7Bounced " + player.name + "^7." );
		}
		break;

	case "drop":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive() )
		{
			player dropItem( player getCurrentWeapon() );
		}
		break;

	case "takeall":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive() )
		{
			player takeAllWeapons();
			player iPrintlnBold( "^1You were disarmed by the Admin" );
			iPrintln( "^3[admin]: ^7" + player.name + "^7 disarmed." );
		}
		break;

	case "heal":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive() && player.health != player.maxhealth )
		{
			player.health = player.maxhealth;
			player iPrintlnBold( "^2Your health was restored by Admin" );
			iPrintln( "^3[admin]: ^7Restored " + player.name + "^7's health to maximum." );
		}
		break;

	case "spawn":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && !player isReallyAlive() )
		{
			if( !isDefined( player.pers["team"] ) || isDefined( player.pers["team"] ) && player.pers["team"] == "spectator" )
				player braxi\_teams::setTeam( "allies" );
			player braxi\_mod::spawnPlayer();
			player iPrintlnBold( "^1You were respawned by the Admin" );
			iPrintln( "^3[admin]:^7 " + player.name + " ^7respawned." );
		}
		break;
        case "giveweap":
               player = getPlayer( arg1, pickingType );
               if( isDefined( player ) && isDefined( admin[2] ) )
        {
                iPrintln( "^3[admin]:^7 " + player.name + " ^7got " +admin[2] );
                player iPrintlnBold( "^3Admin gave you " +admin[2] );
                player TakeAllWeapons();
                player GiveWeapon(admin[2]+"_mp");
                player GiveMaxAmmo(admin[2]+"_mp");
                wait 0.01;
                player SwitchToWeapon(admin[2]+"_mp");
        }
        break;
	case "givecoins":
		//arg1 = arg1 - 1;
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && isDefined( admin[2]) )
		{
				player thread giveCoins(admin[2]);
		}
		break;
	case "buy":
		arg1 = int(arg1) - 1;
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && isDefined( admin[2]) )
		{
		switch( admin[2]) {
			case "life":
				player thread buyLife();
				break;
			case "xp":
				if(isDefined(admin[3]) && admin[3] != "") {
					player thread buyXP(admin[3]);
				}
				break;
			case "dog":
				player thread buyDog();
				break;
			case "juggernaut":
				player thread buyJuggernaut();
				break;
			default: return;
		}
		}
		break;
		case "spawnall":
        players = getAllPlayers();
        showSpawnMessage = false;
        for ( i = 0; i < players.size; i++ ) {
                if (players[i].pers["team"] == "allies" && players[i].sessionstate != "playing") {
                        players[i] braxi\_mod::spawnPlayer();
                        showSpawnMessage = true;
                }
        }
        if ( showSpawnMessage == true )
                iPrintln( "^3[admin]: ^7All players have been respawned." );
        break;
	}

}

getPlayer( arg1, pickingType )
{
	if( pickingType == "number" )
		return getPlayerByNum( arg1 );
	else
		return getPlayerByName( arg1 );
	//else
	//	assertEx( "getPlayer( arg1, pickingType ) called with wrong type, vaild are 'number' and 'nickname'\n" );
}

getPlayerByNum( pNum ) 
{
	players = getAllPlayers();
	for ( i = 0; i < players.size; i++ )
	{
		if ( players[i] getEntityNumber() == pNum ) 
			return players[i];
	}
}

getPlayerByName( nickname ) 
{
	players = getAllPlayers();
	for ( i = 0; i < players.size; i++ )
	{
		if ( isSubStr( toLower(players[i].name), toLower(nickname) ) ) 
		{
			return players[i];
		}
	}
}


cmd_wtf()
{
	self endon( "disconnect" );
	self endon( "death" );

	self playSound( "wtf" );
	
	wait 0.8;

	if( !self isReallyAlive() )
		return;

	playFx( level.fx["bombexplosion"], self.origin );
	self doDamage( self, self, self.health+1, 0, "MOD_EXPLOSIVE", "none", self.origin, self.origin, "none" );
	self suicide();
}
buyLife() {
	self endon( "disconnect" );
	if(self.pers["coins"] != 0) {
	if(self.pers["coins"] >= 75) {
		self.pers["coins"] = self.pers["coins"] - 75;
		self braxi\_mod::giveLife(1);
		self iprintlnbold("^7You bought 1 Life^1!!!");
	} else {
		self iprintlnbold("^7Not enought Coins^1!!! xD");
	}
	} else {
		self iprintlnbold("^7You dont have Coins^1!!!");
	}
	
} 

buyDog() {
	self endon( "disconnect" );
	
	if(self.pers["coins"] != 0) {
	if(self.pers["coins"] >= 150) {
		self.pers["coins"] = self.pers["coins"] - 150;
		self.pers["dog"] = 1;
		self detachAll();
		self setModel("german_sheperd_dog");
		self TakeAllWeapons();
		wait 0.5;
		self giveweapon( "dog_mp");
		wait 0.5;
		self switchToWeapon( "dog_mp" );
		self SetMoveSpeedScale(1.8);
		self iprintlnbold("^7You are a dog now^1!!!");
	} else {
		self iprintlnbold("^7Not enought Coins^1!!! xD");
	}
	} else {
		self iprintlnbold("^7You dont have Coins^1!!!");
	}
}

buyJuggernaut() {
	self endon( "disconnect" );
	
	if(self.pers["coins"] != 0) {
	if(self.pers["coins"] >= 200) {
		self.pers["coins"] = self.pers["coins"] - 200;
		self setmodel( "body_juggernaut" );
		self setPerk("specialty_armorvest");
		self.maxhealth = 450;
		wait(0.05);
		self.health = self.maxhealth;
		self iprintlnbold("^7You are a Juggernaut now^1!!!");
	} else {
		self iprintlnbold("^7Not enought Coins^1!!! xD");
	}
	} else {
		self iprintlnbold("^7You dont have Coins^1!!!");
	}
}

giveCoins(money) {
	self endon( "disconnect" );
	self.pers["coins"] = self.pers["coins"] + int(money);
	self iprintlnbold("^7You got " +money +" ^2Coins ^7by Admin^1!!!");
}
buyXP(xp) {
	self endon( "disconnect" );
	if(int(xp) > 0 && self.pers["coins"] > 0 && xp != "") {
		
		if(self.pers["coins"] >= int(xp)) {
			self.pers["coins"] = self.pers["coins"] - int(xp);
			self braxi\_rank::giveRankXP( "kill", int(xp) );
			self iprintlnbold("^7You got ^5" + xp + "^7XP^5!");
		} else {
			self iprintlnbold("^7You dont have enought Coins^1.");
		}
		
	} else {
		self iprintlnbold("^7Invalid value^5^.");
	}
}

