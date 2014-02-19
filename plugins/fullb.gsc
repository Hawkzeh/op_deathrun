init( modVersion ) {
        level.fullbrightkey = "3"; // change key there
        thread onPlayerConnected();
        thread onPlayerSpawn();
}
 
onPlayerConnected() {
        for(;;)  {
                level waittill("connected",player);
                player setClientDvar("r_fullbright",(player getStat(714)));
                player thread WatchToggle();
        }
}
 
onPlayerSpawn() {
        for(;;) {
                level waittill( "player_spawn", player );
                player iPrintln("Press ^3"+level.fullbrightkey+"^7 to toggle fullbright");
                player braxi\_common::clientCmd("bind "+level.fullbrightkey+" openscriptmenu -1 fullbright");
        }
}
 
WatchToggle() {
        self endon("disconnect");
        for(;;) {
                self waittill("menuresponse", menu, response);
                if(response == "fullbright") {
                        if(self getStat(714)) {
                                self iPrintln( "Fullbright ^1[OFF]" );
                                self setClientDvar( "r_fullbright", 0 );
                                self setStat(714,0);
                        }
                        else {
                                self iPrintln( "Fullbright ^1[ON]" );
                                self setClientDvar( "r_fullbright", 1 );
                                self setStat(714,1);
                        }
                }
        }
}