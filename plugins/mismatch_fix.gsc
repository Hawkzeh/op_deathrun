/*===================================================================||
||/|¯¯¯¯¯¯¯\///|¯¯|/////|¯¯|//|¯¯¯¯¯¯¯¯¯|//|¯¯¯¯¯¯¯¯¯|//\  \/////  //||
||/|  |//\  \//|  |/////|  |//|  |/////////|  |//////////\  \///  ///||
||/|  |///\  \/|  |/////|  |//|  |/////////|  |///////////\  \/  ////||
||/|  |///|  |/|  |/////|  |//|   _____|///|   _____|//////\    /////||
||/|  |////  //|  \/////|  |//|  |/////////|  |/////////////|  |/////||
||/|  |///  ////\  \////  ////|  |/////////|  |/////////////|  |/////||
||/|______ //////\_______/////|  |/////////|  |/////////////|  |/////||
||=====================================================================
	Plugin:	 		Sum/name Mismatch 'fix'
	Version:		1.1
	Requirement:	-
	Date:			20.01.2013
	Author:			DuffMan
	XFire:			mani96x
	Homepage:		3xp-clan.com
*/

init(modver) {
	if(getDvar("mismatch_fix") == "") setDvar("mismatch_fix",0);
	wait .5;
	if(getEntArray("player","classname").size == 0 && getDvarint("mismatch_fix") != 0 && !level.freeRun) {
		setDvar("mismatch_fix",0);
		tok = strTok(getDvar("sv_maprotation")," ");
		while(1) {
			random = randomint(tok.size);
			if(isDefined(tok[random]) && getSubStr(tok[random],0,3) == "mp_") {
				setDvar( "sv_maprotationcurrent", "gametype " + getDvar("g_gametype") + " map " + tok[random] + "" ); 
				exitLevel( false ); 
			}
		}
	}	
	for(;;wait 1) setDvar("mismatch_fix",getEntArray("player","classname").size);
}