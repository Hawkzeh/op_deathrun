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


#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
//#include braxi\_rank;

init()
{
	braxi\_rank::registerScoreInfo( "challenge", 250 );
	precacheString( &"MP_CHALLENGE_COMPLETED" );

	buildChallegeInfo();

	thread playerConnected();
	thread playerSpawned();
	thread playerKilled();
	thread playerDamaged();
}




buildChallegeInfo()
{
	level.challengeInfo = [];
	
	tableName = "mp/challengetable_tier"+i+".csv";

	for( idx = 1; isdefined( tableLookup( tableName, 0, idx, 0 ) ) && tableLookup( tableName, 0, idx, 0 ) != ""; idx++ )
	{
		refString = tableLookup( tableName, 0, idx, 5 );

		// stateid, stat, min val, max val, codename, xp, unlocks, icon, name, description
		// getstat(stateid) is unlock flag, getstat(statid) is current progress
		level.challengeInfo[refString] = [];
		level.challengeInfo[refString]["stateid"] = int( tableLookup( tableName, 0, idx, 1 ) );
		level.challengeInfo[refString]["statid"] = int( tableLookup( tableName, 0, idx, 2 ) );
		level.challengeInfo[refString]["maxval"] = int( tableLookup( tableName, 0, idx, 3 ) );
		level.challengeInfo[refString]["minval"] = int( tableLookup( tableName, 0, idx, 4 ) );
//		level.challengeInfo[refString]["codename"] = tableLookupIString( tableName, 0, idx, 5 ); //name used by code
		level.challengeInfo[refString]["xp"] = int( tableLookup( tableName, 0, idx, 6 ) );
		level.challengeInfo[refString]["unlocks"] = tableLookup( tableName, 0, idx, 7 ) );
		level.challengeInfo[refString]["icon"] = tableLookup( tableName, 0, idx, 8 );
		level.challengeInfo[refString]["name"] = tableLookup( tableName, 0, idx, 9 );
		level.challengeInfo[refString]["desc"] = tableLookup( tableName, 0, idx, 10 );

		precacheString( level.challengeInfo[refString]["name"] );
	}
}


challengeNotify( challengeName, challengeDesc )
{
	notifyData = spawnStruct();
	notifyData.titleText = &"MP_CHALLENGE_COMPLETED";
	notifyData.notifyText = challengeName;
	notifyData.notifyText2 = challengeDesc;
	notifyData.sound = "mp_challenge_complete";
	
	self maps\mp\gametypes\_hud_message::notifyMessage( notifyData );
}



onPlayerConnect()
{
	while( 1 )
	{
		level waittill( "connected", player );
	}
}

onPlayerDisconnect()
{
	self waittill( "disconnect" );
}

playerSpawned()
{
	while( 1 )
	{
		level waittill( "player_spawn", player );
	}
}

playerDamaged()
{
	while( 1 )
	{
		level waittill( "player_damage", who, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon );
	}
}

playerKilled()
{
	while( 1 )
	{
		level waittill( "player_killed", who, eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon );
	}
}