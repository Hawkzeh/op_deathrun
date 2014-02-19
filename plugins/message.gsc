message()
{
	noti = SpawnStruct();
	noti.notifyText = "^6>>^7JoKe is full of beasts";
	noti.duration = 6;
	noti.glowcolor = (1,0,0);
	players = getEntArray("player", "classname");
	for(i=0;i<players.size;i++)
		players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
}