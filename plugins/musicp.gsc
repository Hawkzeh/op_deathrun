
// Music Menu page 2 
#include braxi\_dvar;

init( modVersion )
{
	precacheMenu( "musicmenup" );

	level.musicmenup = [];

	//thread onPlayerSpawned(); Use this If needed

	while( 1 )
	{
		level waittill( "connected", player );
			player thread menunames();
			player thread musicmenup_WatchMenu();
	}
}

menunames()
{
	self setClientDvars( "musicmenup", "1" );
	self setClientDvars( "musicmenup_1", "Barely Alive - Welcome to the World" );
	self setClientDvars( "musicmenup_2", "Getter & Dastik - Hollow Point" );
	self setClientDvars( "musicmenup_3", "Juston Bieber - Confident" );
	self setClientDvars( "musicmenup_4", "STRFR - While I'm Alive" );
	self setClientDvars( "musicmenup_5", "The Two Friends - Sedated" );
	self setClientDvars( "musicmenup_6", "Virtual Riot - Sugar Rush" );
}

musicmenup_WatchMenu()
{
	self endon( "disconnect" );
	while( 1 )
	{
		self waittill("menuresponse", menu, response);

		switch( response )
		{
		case "musicmenup_1":
			if( !self.pers["song1"] )
			{
				self.pers["song1"] = true;
				self playLocalSound("maptrax_10");
				self closeMenu();
			}
			else
			{
				self.pers["song1"] = false;
				self musicstop();
			}
			break;
		case "musicmenup_2":
			if( !self.pers["song2"] )
			{
				self.pers["song2"] = true;
				self playLocalSound("maptrax_11");
				self closeMenu();
			}
			else
			{
				self.pers["song2"] = false;
				self musicstop();
			}
			break;
		case "musicmenup_3":
			if( !self.pers["song3"] )
			{
				self.pers["song3"] = true;
				self playLocalSound("maptrax_12");
				self closeMenu();
			}
			else
			{
				self.pers["song3"] = false;
				self musicstop();
			}
			break;
		case "musicmenup_4":
			if( !self.pers["song4"] )
			{
				self.pers["song4"] = true;
				self playLocalSound("maptrax_13");
				self closeMenu();
			}
			else
			{
				self.pers["song4"] = false;
				self musicstop();
			}
			break;
		case "musicmenup_5":
			if( !self.pers["song5"] )
			{
				self.pers["song5"] = true;
				self playLocalSound("maptrax_14");
				self closeMenu();
			}
			else
			{
				self.pers["song5"] = false;
				self musicstop();
			}
			break;
		case "musicmenup_6":
			if( !self.pers["song6"] )
			{
				self.pers["song6"] = true;
				self playLocalSound("maptrax_15");
				self closeMenu();
			}
			else
			{
				self.pers["song6"] = false;
				self musicstop();
			}
			break;
		}
	}
}

musicstop()
{	
				self stopLocalSound( "maptrax_1" );
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
				self musicmenup_WatchMenu();
				self closeMenu();
}