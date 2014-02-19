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

advancedJumping()
{
	self endon( "death" );
	self endon( "spawned" );
	self endon( "disconnect" );

	if( !isDefined( self.bh ) )
		self.bh = false;

	while( self.sessionstate == "playing" ) // self isReallyAlive() in DRMod
	{
		while( self isOnGround() || self.bh ) // don't do that if we're not on ground or bunny hooping
			wait 0.1;

		while( self.sessionstate == "playing" && !self isOnGround() && !self.bh )
		{	
			end = ( self.origin + (0,0,-3) + vector_scale( anglesToForward( self.angles ), 3 ) );
			endPos = playerPhysicsTrace( self.origin, end );

			self setOrigin( (endPos[0], endPos[1], self.orign[2] ) );
			wait 0.05;
		}

		wait 0.1; // delay before another advanced jump
	}
}