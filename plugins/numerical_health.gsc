// numerical_health.gsc
// Author: Bear

init( version )
{
    while( 1 )
    {
        level waittill( "connected", player );
        player thread numerical_health();
    }
}

numerical_health()
{
    self endon( "disconnect" );

    while( !isPlayer( self ) || !isAlive( self ) )
        wait( 0.05 );

    self.hp = newClientHudElem( self );
    self.hp.alignX = "left";
    self.hp.alignY = "bottom";
    self.hp.horzAlign = "left";
    self.hp.vertAlign = "bottom";
    self.hp.x = 10;
    self.hp.y = -12;
    self.hp.font = "objective";
    self.hp.fontScale = 1.4;
    self.hp.color = ( 1, 1, 1 );
    self.hp.alpha = 1;
    self.hp.glowColor = level.randomcolour;
    self.hp.glowAlpha = 1;
    self.hp.label     = &"Health: &&1";
    self.hp.hideWhenInMenu = true;

    while( self.health > 0 )
    {
        self.hp setValue( self.health );
        self.hp.glowColor = ( 1 - ( self.health / self.maxhealth ), self.health / self.maxhealth, 0 );
        wait( 0.05 );
    }

    if( isDefined( self.hp ) )
        self.hp destroy();

    self thread numerical_health();
}