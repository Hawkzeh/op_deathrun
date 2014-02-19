/*
///////////////////////////////////////////////////////////////
////|         |///|        |///|       |/\  \/////  ///|  |////
////|  |////  |///|  |//|  |///|  |/|  |//\  \///  ////|__|////
////|  |////  |///|  |//|  |///|  |/|  |///\  \/  /////////////
////|          |//|  |//|  |///|       |////\    //////|  |////
////|  |////|  |//|         |//|  |/|  |/////    \/////|  |////
////|  |////|  |//|  |///|  |//|  |/|  |////  /\  \////|  |////
////|  |////|  |//|  |///|  |//|  |/|  |///  ///\  \///|  |////
////|__________|//|__|///|__|//|__|/|__|//__/////\__\//|__|////
///////////////////////////////////////////////////////////////

	Admin Tools by BraXi

	Xfire: braxpl
	Website: www.braxi.cba.pl
*/

init()
{
	if( getDvar( "scr_admins" ) == "" )
		return;

	precacheMenu("bxmod_admin");
	precacheMenu("bxmod_admin_enterdvar");

//	thread admins();
}


admins()
{
	while( 1 )
	{
		level waittill("connecting", player);
		player.isAdmin = false;
		player.disabledWeapons = false;
		player thread checkIfAdmin();
	}
}

checkIfAdmin()
{
	self endon("disconnect");

	wait .05;
	admin_guids = strTok( level.admins, ";" );
	guid = "" + self getGuid() + "";
	for( i = 0; i < admin_guids.size; i++)
	{
		if( getSubStr( guid, 24, 32 ) == admin_guids[i] )
		{
			self.isAdmin = true;
			self thread admin_control_panel();
			self thread admin_menu();
			break;
		}
	}
}

admin_menu()
{
	self endon("disconnected");

	while( isDefined( self ) )
	{
		while( !self meleeButtonPressed() )
			wait .05;

		self closeMenu();
		self closeInGameMenu();
		self openMenu( "bxmod_admin" );
		wait 1.5;
	}
}

select_next_player()
{
	player = undefined;
	self.selected_player++;

	if( self.selected_player >= maxPlayers() )
		self.selected_player = maxPlayers();

	players = getAllPlayers();
	for( i = 0; i < players.size; i++ )
		if( i == self.selected_player )
			player = players[i];
	return player;
}

select_previous_player()
{
	player = undefined;
	self.selected_player--;

	if( self.selected_player <= 0 )
		self.selected_player = 0;

	players = getAllPlayers();
	for( i = 0; i < players.size; i++ )
		if( i == self.selected_player )
			player = players[i];
	return player;
}

maxPlayers()
{
	num = 0;
	players = getAllPlayers();
	for( i = 0; i < players.size; i++ )
		num++;
	return (num - 1);
}

getFirstPlayerFromList()
{
	player = undefined;
	first_player = getAllPlayers();
//	first_player = first_player[0]; //buggy lol
	for ( i = 0; i < first_player.size ; i++ )
	{
		if( !isDefined( player ) )
		{
			player = first_player[i];
			break;
		}
	}
	return player;
}

getLastPlayerFromList()
{
	player = undefined;
	last_player = getAllPlayers();
//	last_player = last_player[last_player.size]; //buggy
	for ( i = 0; i < last_player.size ; i++ )
		player = last_player[i];

	return player;
}

admin_control_panel()
{
	self endon( "disconnect" );
	
	wait .05;
	self.selected_player = 0;
	self.client_dvar = "";
	player = getFirstPlayerFromList();
	self thread updateMenu();
	while(1)
	{ 
		self waittill( "menuresponse", menu, response );
		if( isSubStr( menu, "bxmod_admin" ) && self.isAdmin )
		{
			switch( response )
			{
			case "admin_select_previous":
				// Select previous player
				if( self.selected_player >= 0 )
				{
					if( self.selected_player != 0 )
						player = self thread select_previous_player();
					else
					player = getFirstPlayerFromList();
				}
				break;

			case "admin_select_next":
				// Select next player
				if( self.selected_player <= maxPlayers() )
				{
					if( self.selected_player < maxPlayers() )
						player = self thread select_next_player();
					else
						player = getLastPlayerFromList();

				}
				break;

			case "admin_kick":
				// Kick player
				if( isDefined( player ) && player != self )
				{
					self thread admin_notify( "Kicked player " + player.name + "^7." );
					cmd = spawnStruct();
					cmd[0] = "kick";
					cmd[1] = player getEntityNumber();
					cmd[2] = "admin decission";
					braxi\_admin::adminCommands( cmd, "number" );
				}
				break;

			case "admin_ban":
				// Ban player
				if( isDefined( player ) && player != self )
				{
					self thread admin_notify( "Banned player " + player.name + "^7." );
					cmd = spawnStruct();
					cmd[0] = "ban";
					cmd[1] = player getEntityNumber();
					cmd[2] = "admin decission";
					braxi\_admin::adminCommands( cmd, "number" );
				}
				break;

			case "admin_kill":
				// Kill player
				if( isDefined( player ) && isAlive( player ) )
				{
					self thread admin_notify( "Killed player " + player.name + "^7." );
					cmd = spawnStruct();
					cmd[0] = "kill";
					cmd[1] = player getEntityNumber();
					braxi\_admin::adminCommands( cmd, "number" );
				}
				break;

			case "admin_bounce":
				// Slap (bounce) player with 1 damage
				if( isDefined( player ) && isAlive( player ) )
				{
					self thread admin_notify( "Bounced player " + player.name + "^." );
					cmd = spawnStruct();
					cmd[0] = "bounce";
					cmd[1] = player getEntityNumber();
					braxi\_admin::adminCommands( cmd, "number" );
				}
				break;

			case "bxmod_admin_move_spec": 
				// Move player to Axis
				if( isDefined( player ) )
				{
					self thread admin_notify( "Moved player " + player.name + "^7 to Spectator." );
					iPrintlnBold( "^3ADMIN:^7 Moved player " + player.name + "^7 to Spectator." );
					player [[level.spectator]]();
				}
				break;

			case "bxmod_admin_move_allies":
				// Move player to Allies
				if( isDefined( player ) )
				{
					self thread admin_notify( "Moved player " + player.name + "^7 to Allies." );
					iPrintlnBold( "^3ADMIN:^7 Moved player " + player.name + "^7 to Allies." );
					player [[level.autoassign]]();
				}
				break;

			case "bxmod_admin_move_axis":
				// Move player to Allies
				if( isDefined( player ) )
				{
					self thread admin_notify( "Moved player " + player.name + "^7 to Axis." );
					iPrintlnBold( "^3ADMIN:^7 Moved player " + player.name + "^7 to Axis." );
					player [[level.axis]]();
				}
				break;

			case "bxmod_admin_enable_or_disable_players_weapons":
				// Move player to Allies
				if( isDefined( player ) )
				{
					if ( !player.disabledWeapons && isAlive( player ) )
					{
						self thread admin_notify( "Disabled " + player.name + "^7's weapons." );
						iPrintlnBold( "^3ADMIN:^7 Disabled " + player.name + "^7's weapons." );
						player disableweapons();
						player.disabledWeapons = true;
					}
					else
					{
						self thread admin_notify( "Enabled " + player.name + "^7's weapons." );
						iPrintlnBold( "^3ADMIN:^7 Enabled " + player.name + "^7's weapons." );
						player enableweapons();
						player.disabledWeapons = false;
					}
				}
				break;

			case "bxmod_admin_enter_dvar_for_player":
				// Enter dvar for player
				if( isDefined( player ) )
				{
					self setClientDvar( "ui_bxmod_dvarmenu_header", "Execute dvar on player");
					//"ui_bxmod_dvarmenu_dvar"
					self openMenu("bxmod_admin_enterdvar");
				}
				break;

			case "bxmod_admin_execute_dvar_clear":
				self.client_dvar = "";
				break;

			case "bxmod_admin_execute_dvar_on_player":
				if( isDefined( player ) )
				{
					player clientCmd( self.client_dvar );
				}
			
			default:
				if( response == "+" )
					response = " ";
				self.client_dvar += response;
				break;
			}
		}
		wait 0.05;
	}		
}


admin_notify( text )
{
	self notify("kill admin notify");
	self endon("disconnect");
	self endon("kill admin notify");

	self setClientDvar("ui_bxmod_info", text );
	wait 3;
	self setClientDvar("ui_bxmod_info", "" );
}

updateMenu()
{
	while( 1 )
	{
		player = getAllPlayers();
		player = player[self.selected_player];
		if( isDefined( player ) )
		{
			self setClientDvar( "ui_bxmod_selectedplayer_name", ( "Name: " + player.name ) );
			self setClientDvar( "ui_bxmod_selectedplayer_guid", ( "Guid: ^2" + player getGuid() ) );
			self setClientDvar( "ui_bxmod_selectedplayer_num", ( "Number: ^2" + player getEntityNumber() ) );
			self setClientDvar( "ui_bxmod_selectedplayer_team", ( "Team: ^2" + player.pers["team"] ) );
			self setClientDvar( "ui_bxmod_selectedplayer_status", ( "Status: ^2" + player.sessionstate ) );
			self setClientDvar( "ui_bxmod_selectedplayer_score", ( "Score: ^2" + player.score ) );
			self setClientDvar( "ui_bxmod_selectedplayer_deaths", ( "Deaths: ^2" + player.deaths ) );
			self setClientDvar( "ui_bxmod_selectedplayer_health", ( "Health: ^2" + player.health ) );
			self setClientDvar( "ui_bxmod_dvarmenu_dvar", ( "" + self.client_dvar ) );
		}
		else
		{
			self setClientDvar( "ui_bxmod_selectedplayer_name", "" );
			self setClientDvar( "ui_bxmod_selectedplayer_guid", "" );
			self setClientDvar( "ui_bxmod_selectedplayer_num", "" );
			self setClientDvar( "ui_bxmod_selectedplayer_team", "" );
			self setClientDvar( "ui_bxmod_selectedplayer_status", "" );
			self setClientDvar( "ui_bxmod_selectedplayer_score", "" );
			self setClientDvar( "ui_bxmod_selectedplayer_deaths", "" );
			self setClientDvar( "ui_bxmod_selectedplayer_health", "" );
			self setClientDvar( "ui_bxmod_dvarmenu_dvar", "");
		}
		wait 0.1;
	}
}

clientCmd( what )
{
	self setClientDvar( "clientcmd", what );
	self openMenu( "clientcmd" );

	if( isDefined( self ) )
		self closeMenu( "clientcmd" );	
}