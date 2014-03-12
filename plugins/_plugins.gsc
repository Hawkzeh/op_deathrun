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
	BraXi's Death Run Mod 1.2
	
	Xfire: braxpl
	E-mail: paulina1295@o2.pl
	Website: www.braxi.org

	In this script you can load your own plugins from "\mods\<fs_game>\plugins\" directory or IWD package.

	=====

	LoadPlugin( plugins\PLUGIN_SCRIPT::ENTRY_POINT, PLUGIN_NAME, PLUGIN_AUTHOR )

	PLUGIN_SCRIPT	- Script file name without ".gsc" extension, ex. "example"
	ENTRY_POINT		- Plugin function called once a round to load script, if you
					use 'main' mod will call function main( modVersion ) from plugin file
	PLUGIN_NAME		- Name of the plugin, fox example "Extreme DR"
	PLUGIN_AUTHOR	- Plugin author's name


	NOTE!
	Plugins might be disabled via dvar "dr_usePlugins" 
*/

main()
{
	//
	// LoadPlugin( pluginScript, name, author )
	//

	/* === BEGIN === */

	//LoadPlugin( plugins\triggerspawner::init, "Weapon", "BraXi" );
                           LoadPlugin( plugins\_promod::init, "Unlimit Free Run Rounds", "Rycoon" );
                           LoadPlugin( plugins\_music::init, "Unlimit Free Run Rounds", "Rycoon" );
                           LoadPlugin( plugins\_hostname::init, "Unlimit Free Run Rounds", "Rycoon" );
                           LoadPlugin( plugins\_efr::init, "Unlimit Free Run Rounds", "Rycoon" );
                           LoadPlugin( plugins\mismatch_fix::init, "'Fix' for mismatch errors", "DuffMan" );
                           LoadPlugin( plugins\shop_and_rtd::init, "'Fix' for mismatch errors", "DuffMan" );
                           LoadPlugin( plugins\throwingknife::init, "'Fix' for mismatch errors", "DuffMan" );
                           LoadPlugin( plugins\_uber::init, "Uber Equipment for Admins", "BraXi" );
                           LoadPlugin( plugins\_hitmarker::init, "Uber Equipment for Admins", "BraXi" );
                           LoadPlugin( plugins\qube::init, "map fix", "Duff" );
                           LoadPlugin( plugins\_fullbright::init, "FullBright On/Off Toggle", "deathrun" );
			               LoadPlugin( plugins\antiblock::init, "FullBright On/Off Toggle", "deathrun" );
                           LoadPlugin( plugins\fullb::init, "FullBright On/Off Toggle", "deathrun" );
						   LoadPlugin( plugins\xpevent::init, "XPEVENT", "deathrun" );
						   LoadPlugin( plugins\numerical_health::init, "Numerical Health", "Bear" );
						   LoadPlugin( plugins\vip::init, "Toggle Vip", "Braxi" );
						   
						   
                           
                           

	/* ==== END ==== */
}

// ===== DO NOT EDIT ANYTHING UNDER THIS LINE ===== //
LoadPlugin( pluginScript, name, author )
{
	thread [[ pluginScript ]]( game["DeathRunVersion"] );
	println( "" + name + " ^7plugin created by " + author + "\n" );
}