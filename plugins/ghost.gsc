//Made by Wingzor
//Edited by Dunciboy

vip_ghost()
{
self endon ( "disconnect" );
self endon ( "death" );
if(!isdefined(self.ghost))
	self.ghost=false;
if(self.ghost==false)
{
	iprintln("^3" +self.name +" has enabled: ^1Matrix Ghost");
	self.ghost=true;
	while(1)
	{
	self hide();
	wait 0.01;
	self show();
	wait 0.01;
	}
}
else
{
self iprintln("^3You already used ^1Ghost ^3this round");
}
}

vip_dghost()
{
self endon ( "disconnect" );
self endon ( "death" );
if(!isdefined(self.ghost))
	self.ghost=false;
if(self.ghost==false)
{
	iprintln("^3" +self.name +" has enabled: ^1Dishonored Ghost");
	self.ghost=true;
	while(1)
	{
	self show();
	playFx( level.fx["dust"] , self.origin );
	wait 1.5;
	self hide();
	wait 0.5;
	}
}
else
{
self iprintln("^3You already used ^1Ghost ^3this round");
}
}