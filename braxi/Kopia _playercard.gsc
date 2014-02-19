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

init( modVersion )
{
	precacheShader( "black" );

	while( 1 )
	{
		level waittill( "player_killed", who, eInflictor, attacker );
		
		if( !isPlayer( attacker ) )				return;
		if( !isDefined( who.playerCard ) )		who.playerCard = [];
		if( !isDefined( attacker.playerCard ) )	attacker.playerCard = [];

		attacker showPlayerCard( who, who.name, "You're the pro" );
		who showPlayerCard( attacker, attacker.name, "You were own3d by pro" );
	}
}

showPlayerCard( player, text1, text2 )
{
	// one instance at a time
	self notify( "new emblem" );
	self endon( "new emblem" );
	self endon( "disconnect" );

	if( self.playerCard.size )
		self destroyPlayerCard();

	logo1 = ( "spray" + self getStat(979) + "_menu" );
	logo2 = ( "spray" + player getStat(979) + "_menu" );
	rank = ( "rank_" + (player.pers["rank"]-1) ); 

	self.playerCard[0] = newClientHudElem( self );
	self.playerCard[0].x = 160;
	self.playerCard[0].y = 390;
	self.playerCard[0].alpha = 0;
	self.playerCard[0] setShader( "black", 300, 64 );
	
	//logos
	self.playerCard[1] = braxi\_mod::addTextHud( self, 160, 390, 0, "left", "top", 1.8 ); 
	self.playerCard[1] setShader( logo1, 64, 64 );
	self.playerCard[2] = braxi\_mod::addTextHud( self, 160+300-64, 390, 0, "left", "top", 1.8 ); 
	self.playerCard[2] setShader( logo2, 64, 64 );

	// rank icon
	self.playerCard[3] = braxi\_mod::addTextHud( self, 160+300-64-32, 390, 0, "left", "top", 1.8 );
	self.playerCard[3] setShader( rank, 24, 24 );

	//texts
	self.playerCard[4] = braxi\_mod::addTextHud( self, 320, 420, 0, "center", "middle", 1.8 );
	self.playerCard[4].color = ( 0.8, 0.8, 0.8 );
	self.playerCard[4] setText( text1 );

	self.playerCard[5] = braxi\_mod::addTextHud( self, 320, 435, 0, "center", "middle", 1.5 );
	self.playerCard[5].color = ( 0.8, 0.8, 0.8 );
	self.playerCard[5] setText( text2 );	

	for( i = 0; i < self.playerCard.size; i++ )
	{
		self.playerCard[i] fadeOverTime( 0.6 );
		self.playerCard[i].alpha = 1;
	}
	wait 1.9;

	for( i = 0; i < self.playerCard.size; i++ )
	{
		self.playerCard[i] fadeOverTime( 0.8 );
		self.playerCard[i].alpha = 0;
	}
	wait 0.85;
	
	self destroyPlayerCard();
}


destroyPlayerCard()
{
	if( !isDefined( self.playerCard ) || !self.playerCard.size )
		return;

	for( i = 0; i < self.playerCard.size; i++ )
		self.playerCard[i] destroy();
	self.playerCard = [];
}