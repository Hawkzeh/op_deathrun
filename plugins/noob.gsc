partymode()
{
	self endon("disconnect");
	iPrintlnBold("^2PARTY ^6TIME");
	SetExpFog(1024, 2048, 1, 0, 0, 0);  
	wait .5;  
	SetExpFog(1024, 2048, 0, 1, 0, 0);  
	wait .5;  
	SetExpFog(1024, 2048, 0, 0, 1, 0);  
	wait .5;  
	SetExpFog(1024, 2048, 0.4, 1, 0.8, 0);  
	wait .5;  
	SetExpFog(1024, 2048, 0.8, 0, 0.6, 0);  
	wait .5;  
	SetExpFog(1024, 2048, 1, 1, 0.6, 0);  
	wait .5;  
	SetExpFog(1024, 2048, 1, 1, 1, 0);  
	wait .5;  
	SetExpFog(1024, 2048, 0, 0, 0.8, 0); 
	wait .5;  
	SetExpFog(1024, 2048, 0.2, 1, 0.8, 0);  
	wait .5;  
	SetExpFog(1024, 2048, 0.4, 0.4, 1, 0);  
	wait .5;  
	SetExpFog(1024, 2048, 0, 0, 0, 0);  
	wait .5;  
	SetExpFog(1024, 2048, 0.4, 0.2, 0.2, 0);  
	wait .5;  
	SetExpFog(1024, 2048, 0.4, 1, 1, 0);  
	wait .5;  
	SetExpFog(1024, 2048, 0.6, 0, 0.4, 0);  
	wait .5;  
	SetExpFog(1024, 2048, 1, 0, 0.8, 0);  
	wait .5;  
	SetExpFog(1024, 2048, 1, 1, 0, 0);  
	wait .5;   
	SetExpFog(1024, 2048, 0.6, 1, 0.6, 0);  
	wait .5;  
	SetExpFog(1024, 2048, 1, 0, 0, 0);  
	wait .5;  
	SetExpFog(1024, 2048, 0, 1, 0, 0);  
	wait .5;  
	SetExpFog(1024, 2048, 0, 0, 1, 0);  
	wait .5;  
	SetExpFog(1024, 2048, 0.4, 1, 0.8, 0);  
	wait .5;  
	SetExpFog(1024, 2048, 0.8, 0, 0.6, 0);  
	wait .5;  
	SetExpFog(1024, 2048, 1, 1, 0.6, 0);  
	wait .5;  
	SetExpFog(1024, 2048, 1, 1, 1, 0);  
	wait .5;  
	SetExpFog(1024, 2048, 0, 0, 0.8, 0);  
	wait .5;  
	SetExpFog(1024, 2048, 0.2, 1, 0.8, 0);  
	wait .5;  
	SetExpFog(1024, 2048, 0.4, 0.4, 1, 0);  
	wait .5;  
	SetExpFog(1024, 2048, 0, 0, 0, 0);  
	wait .5;  
	SetExpFog(1024, 2048, 0.4, 0.2, 0.2, 0);  
	wait .5;  
	SetExpFog(1024, 2048, 0.4, 1, 1, 0);  
	wait .5;  
	SetExpFog(1024, 2048, 0.6, 0, 0.4, 0);  
	wait .5;  
	SetExpFog(1024, 2048, 1, 0, 0.8, 0); 
	wait .5;  
	SetExpFog(1024, 2048, 1, 1, 0, 0);  
	wait .5;  
	SetExpFog(2048, 4096, 0, 0, 0, 0);
} 
ninja()
{
	self iprintlnbold ("^1You Are Now On Fire!!"); 
    while(isAlive(self))
	{
		playFx( level.dist , self.origin );
		wait .1;
	}
}