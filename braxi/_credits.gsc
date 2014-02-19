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

	showCredit() written by Bipo.
*/

main()
{
	level.creditTime = 6;

	braxi\_common::cleanScreen();

	thread showCredit( "^3Deathrun 1.2 by:", 2.4 );
	wait 0.5;
	thread showCredit( "^7BraXi", 1.8 );
	wait 1.2;
	thread showCredit( "^3Characters by:", 2.4 );
	wait 0.5;
	thread showCredit( "^7|MACOM|Hacker", 1.8 );
	wait 0.5;
	thread showCredit( "^7_INSANE_", 1.8 );
	wait 0.5;
	thread showCredit( "^7Etheross", 1.8 );
	wait 1.2;
	thread showCredit( "^3Modifications by:", 2.4 );
	wait 0.5;
	thread showCredit( "^3[oP]^7Hawkzeh", 1.8 );
	wait 0.5;
	thread showCredit( "^3[oP]^7Bob", 1.8 );
	wait 1.2;
	thread showCredit( "^3Additional Help:", 2.4 );
	wait 0.5;
	thread showCredit( "^7Lossy", 2.4 );
	wait 2.2;
	thread showCredit( "^3Thanks ^7for ^3playing ^7@ ^3[oP] ^7Deathrun!", 1.8 );
	
	if( level.dvar["lastmessage"] != "" )
	{
		wait 0.8;
		thread showCredit( level.dvar["lastmessage"], 2.4 );
	}

	wait level.creditTime + 2;
}


showCredit( text, scale )
{
	level thread braxi\_mod::GlowColors();

	end_text = newHudElem();
	end_text.font = "objective";
	end_text.fontScale = scale;
	end_text SetText(text);
	end_text.alignX = "center";
	end_text.alignY = "top";
	end_text.horzAlign = "center";
	end_text.vertAlign = "top";
	end_text.x = 0;
	end_text.y = 540;
	end_text.sort = -1; //-3
	end_text.alpha = 1;
	end_text.glowColor = level.randomcolour;
	end_text.glowAlpha = 1;
	end_text moveOverTime(level.creditTime);
	end_text.y = -60;
	end_text.foreground = true;
	wait level.creditTime;
	end_text destroy();
}


neon()
{
	neon = addNeon( "^7www.op-clan.info", 1.4 );
	while( 1 )
	{
		neon moveOverTime( 12 );
		neon.x = 800;
		wait 15;
		neon moveOverTime( 12 );
		neon.x = -800;
		wait 15;
	}
}

addNeon( text, scale )
{
	end_text = newHudElem();
	end_text.font = "objective";
	end_text.fontScale = scale;
	end_text SetText(text);
	end_text.alignX = "center";
	end_text.alignY = "top";
	end_text.horzAlign = "center";
	end_text.vertAlign = "top";
	end_text.x = -200;
	end_text.y = 8;
	end_text.sort = -1; //-3
	end_text.alpha = 1;
	//end_text.glowColor = (1,0,0.1);
	//end_text.glowAlpha = 1;
	end_text.foreground = true;
	return end_text;
}