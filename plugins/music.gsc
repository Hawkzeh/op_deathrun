
// Music Menu
#include braxi\_dvar;

init( modVersion )
{
	precacheMenu( "musicmenu" );

	level.musicmenu = [];

	//thread onPlayerSpawned(); Use this If needed

	while( 1 )
	{
		level waittill( "connected", player );
			player thread menunames();
			player thread musicmenu_WatchMenu();
	}
}

menunames()
{
	self setClientDvars( "musicmenu", "1" );
	self setClientDvars( "musicmenu_1", "Hellberg & Deutgen - Collide" );
	self setClientDvars( "musicmenu_2", "Astronaut" );
	self setClientDvars( "musicmenu_3", "Barely Alive - Chasing Ghosts" );
	self setClientDvars( "musicmenu_4", "Barely Alive - Chasing Ghosts VR Remix" );
	self setClientDvars( "musicmenu_5", "Barely Alive - Dial Up" );
	self setClientDvars( "musicmenu_6", "Barely Alive - Keyboard Killer" );
}

musicmenu_WatchMenu()
{
	self endon( "disconnect" );
	while( 1 )
	{
		self waittill("menuresponse", menu, response);

		switch( response )
		{
		case "musicmenu_1":
			if( !self.pers["song1"] )
			{
				self.pers["song1"] = true;
				self playLocalSound("maptrax_1");
				self closeMenu();
			}
			else
			{
				self.pers["song1"] = false;
				self musicstop();
			}
			break;
		case "musicmenu_2":
			if( !self.pers["song2"] )
			{
				self.pers["song2"] = true;
				self playLocalSound("maptrax_2");
				self closeMenu();
			}
			else
			{
				self.pers["song2"] = false;
				self musicstop();
			}
			break;
		case "musicmenu_3":
			if( !self.pers["song3"] )
			{
				self.pers["song3"] = true;
				self playLocalSound("maptrax_3");
				self closeMenu();
			}
			else
			{
				self.pers["song3"] = false;
				self musicstop();
			}
			break;
		case "musicmenu_4":
			if( !self.pers["song4"] )
			{
				self.pers["song4"] = true;
				self playLocalSound("maptrax_4");
				self closeMenu();
			}
			else
			{
				self.pers["song4"] = false;
				self musicstop();
			}
			break;
		case "musicmenu_5":
			if( !self.pers["song5"] )
			{
				self.pers["song5"] = true;
				self playLocalSound("maptrax_5");
				self closeMenu();
			}
			else
			{
				self.pers["song5"] = false;
				self musicstop();
			}
			break;
		case "musicmenu_6":
			if( !self.pers["song6"] )
			{
				self.pers["song6"] = true;
				self playLocalSound("maptrax_6");
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
				self musicmenu_WatchMenu();
				self closeMenu();
}