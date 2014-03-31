// Music Menu Options
#include braxi\_dvar;

init( modVersion )
{
	precacheMenu( "musicoptions" );

	level.musicmenu = [];

	//thread onPlayerSpawned(); //Use this If needed

	while( 1 )
	{
		level waittill( "connected", player );
			player thread menunames();
			player thread musicoptions_WatchMenu();
	}
}

menunames()
{
	self setClientDvars( "musicoptions", "1" );
	self setClientDvars( "musicoptions_1", "Random Music ^1OFF" );
	self setClientDvars( "musicoptions_2", "Stop Music" );
//	self setClientDvars( "musicoptions_3", "menu3" );
//	self setClientDvars( "musicoptions_4", "menu4 );
//	self setClientDvars( "musicoptions_5", "menu5" );
//	self setClientDvars( "musicoptions_6", "menu6" );
}

musicoptions_WatchMenu()
{
	self endon( "disconnect" );
	
	while( 1 )
	{
		self waittill("menuresponse", menu, response);

		if( menu != "musicoptions" )
			continue;

		switch( response )
		{
		case "musicoptions_1":
			if( !self.pers["randomer"] )
			{
				self.pers["randomer"] = true;
				self setClientDvar( response, "Random Music ^2ON" );	
				self closeMenu();				
			}
			else
			{
				self.pers["randomer"] = false;
				self setClientDvar( response, "Random Music ^1OFF" );
				self musicstop();	
			}
			break;
		case "musicoptions_2":
			{
			self musicstop();
            self closeMenu();
			}
			break;
		case "musicoptions_3":
			{
            self closeMenu();
			}
			break;
		}
	}
}

musicstop()
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

random()
{
				maptrax = (1+randomInt(20));
				self playLocalSound( "maptrax_" + maptrax );
}