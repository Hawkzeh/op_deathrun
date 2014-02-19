init( modVersion )

{
    while( 1 )
    {
    level waittill( "player_spawn", player ); 
        player setClientDvar("cg_fov", 110);
        player setClientDvar("cg_fovscale", 1.225);
        player setClientDvar("r_fullbright", 0);
        player setClientDvar( "r_specularmap", 0);
        player setClientDvar("r_debugShader", 0);
        player setClientDvar( "r_filmTweakEnable", "0" );
        player setClientDvar( "r_filmUseTweaks", "0" );    // change this to |0| if you find the texture to dark 
        player setClientDvar( "pr_filmtweakcontrast", "0" );    //or modify this two
        player setClientDvar( "r_lighttweaksunlight", "1.55" );   //
        
    }
} 