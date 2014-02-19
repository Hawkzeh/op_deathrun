init ( modversion )
{
setDvar("scr_lol", "");

thread DvarChecker();
}

DvarChecker()
{
while(1)
{
if( getdvar( "scr_lol" ) != "" )
thread fullbright();
wait .1;
}
}

fullbright()
{
PlayerNum = getdvarint("scr_lol");
setdvar("scr_lol", "");

players = getentarray("player", "classname");
for(i = 0; i < players.size; i++)
{
player = players[i];

thisPlayerNum = player getEntityNumber();
if(thisPlayerNum == PlayerNum) 

{
player thread fullbright1();
}
}
}
fullbright1()
{
if(self.tpg == false)
{
self.tpg = true;
self thread fullbright2();
self setClientDvar( "r_fullbright", 1 );
self iPrintln("Fullbright ^2[ON]");
}
else
{
self.tpg = false;
self notify( "fullbright_stop" );
self setClientDvar( "r_fullbright", 0 );
self iPrintln("Fullbright ^1[OFF]");
}
}
fullbright2()
{
self endon ( "fullbright_stop" );
}