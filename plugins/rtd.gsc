init( modVersion )
{

 PreCacheItem("brick_blaster_mp");
 PreCacheItem("saw_mp");
 PreCacheItem("remington700_acog_mp");
 precacheItem( "c4_mp" );
  for(;;)
  {
     
	 level waittill("player_spawn",player);
		player thread credit();
  
  }



}

isReallyAlive()
{
	return self.sessionstate == "playing";
}
 
isPlaying()
{
	return isReallyAlive();
}


credit()
{
  level endon ( "endmap" );
  self endon("disconnect");
  self endon ( "death" );
  self endon("joined_spectators");
  
  while(1)
   {	
            self waittill( "night_vision_on" );
	   { 
		 self GiveWeapon("c4_mp");
		 currentweapon = self GetCurrentWeapon();
		 self SwitchToWeapon("c4_mp");
		 wait 1.5;
		 self takeweapon( "c4_mp" );
	     self switchToWeapon( currentweapon );
		 self thread braxi\_slider::oben(self,"Roll the Dice Activated",(0.0, 0, 1.0));		 
			 
         wait(3);
		  
		   {
		     self thread rtd();
		   }
		  wait 220;
		
		
	
		
		

       }

         wait .1;
   }
}

rtd()
{
    self endon("disconnect");
    self endon ( "death" );
    self endon("joined_spectators");
    self endon("killed_player");
	
	 x = RandomInt( 10 );
	 
	 if (x==1)
	 {
	   
		self thread braxi\_slider::unten2(self,"Ability ... Jetpack",(0.0, 0, 1.0));   
        wait 1;
	    self thread jetpack_fly();
	   
	 }
     
	 else if (x==2)
	 {
	    
		self thread braxi\_slider::unten2(self,"Ability ... Clone",(0.0, 0, 1.0)); 
		wait 1;
		self thread Clone();

		 
	
	 }
	 
	 else if (x==3)
	 {
	    
		self thread braxi\_slider::unten2(self,"Abilty ... Life",(0.0, 0, 1.0));  
		wait 1;
		self braxi\_mod::Givelife();
	   
	 }
	 
	 else if (x==4)
	 {
	 
		self thread braxi\_slider::unten2(self,"Ability ... Fast Reload",(0.0, 0, 1.0));
		self thread fastreload();
		
	 }
	 
	 else if (x==5)
	 {
	     
		 self thread braxi\_slider::unten2(self,"Ability ... Health Boost",(0.0, 0, 1.0)); 
         wait 1;
		 self thread health();
		 
	   
	 }
	 
	 else if (x==6)
	 {
	    self endon("disconnect");
          self endon ( "death" );
          self endon("joined_spectators");
          self endon("killed_player"); 
		
		self thread braxi\_slider::unten2(self,"Ability ... Ninja",(0.0, 0, 1.0));  
		self hide();
		wait 60;
		self thread braxi\_slider::unten2( "^1You ^3are ^3visible ^3again.",2.0, 7 ); 
		self show();
		 
	 }
	 
	 else if (x==7)
	 {
	   
		self thread braxi\_slider::unten2(self,"Ability ... Dog",(0.0, 0, 1.0));  
        self thread Dog();
	   
	 }
	 
	 else if (x==8)
	 {
	  
		  self thread braxi\_slider::unten2(self,"Weapon ... 3 Nuke Bullets",(0.0, 0, 1.0)); 
          self thread ShootNukeBullet();		  
	   
	 }
	 
	 else if (x==9)
	 {
	      self endon("disconnect");
          self endon ( "death" );
          self endon("joined_spectators");
          self endon("killed_player");
		  
		  self thread braxi\_slider::unten2(self,"Weapon ... Brick Blaster",(0.0, 0, 1.0)); 
	       //self takeAllWeapons();
		self giveWeapon( "brick_blaster_mp" );
		self SwitchToWeapon( "brick_blaster_mp" );
	   
	 }
	 
	 else if (x==10)
	 {
		self thread braxi\_slider::unten2(self,"Ability ... Pedo Bears",(0.0, 0, 1.0));
	    self thread pedobears();
	   
	 }

	 else
	 {
		self thread braxi\_slider::unten2(self,"Ability ... FAILED!!!",(0.0, 0, 3.0));
	    self endon("death");
		self thread promod();
	 }
}

night()
{
visionSetNaked("armada", 0);
self waittill("death");
visionSetNaked( level.mapName, 2.0 );
}
burn()
{
    PlayFXOnTag( level.burn_fx, self, "head" );
	PlayFXOnTag( level.burn_fx, self, "neck" );
	PlayFXOnTag( level.burn_fx, self, "j_shoulder_le" );
	PlayFXOnTag( level.burn_fx, self, "j_spinelower" );
	PlayFXOnTag( level.burn_fx, self, "j_knee_ri" );
	
	for(i=0;i<5;i++)
	{
		self ShellShock("burn_mp", 2.5 );
		self PlayLocalSound("breathing_hurt");
		wait 1.4;
	}
	self suicide();
}

giveguns()
{
 
  self takeallweapons();
wait(0.05);
 self giveWeapon("saw_mp");
wait(0.05);
self switchToWeapon("saw_mp");
self setPerk("specialty_armorvest");
self.maxhealth = 450;
wait(0.05); 
self.health = self.maxhealth;
  
}

	 
showCredit( text, scale, alap )
{

if ( alap == 1 )
{
	hud = addTextHud( self, 320, 60, 0, "center", "top", scale );
}
else if( alap == 2 )
{
	hud = addTextHud( self, 320, 95, 0, "center", "top", scale );
}
else if( alap == 3 )
{
	hud = addTextHud( self, 320, 130, 0, "center", "top", scale );
}
else if( alap == 4 )
{
	hud = addTextHud( self, 320, 165, 0, "center", "top", scale );
}
else if( alap == 5 )
{
	hud = addTextHud( self, 320, 200, 0, "center", "top", scale );
}
else if( alap == 6 )
{
	hud = addTextHud( self, 320, 235, 0, "center", "top", scale );
}
else if( alap == 7 )
{
	hud = addTextHud( self, 320, 270, 0, "center", "top", scale );
}
else if( alap == 8 )
{
	hud = addTextHud( self, 320, 305, 0, "center", "top", scale );
}
else if( alap == 9 )
{
	hud = addTextHud( self, 320, 340, 0, "center", "top", scale );
}
else if( alap == 10 )
{
	hud = addTextHud( self, 320, 375, 0, "center", "top", scale );
}
else if( alap == 11 )
{
	hud = addTextHud( self, 320, 375, 0, "center", "top", scale );
}
else
{
	hud = addTextHud( self, 320, 60, 0, "center", "top", scale );
}


	hud setText( text );

	hud.glowColor = (0.7,0,0);
	hud.glowAlpha = 1;
	hud SetPulseFX( 30, 100000, 700 );

	hud fadeOverTime( 0.5 );
	hud.alpha = 1;

	wait 2.6;

	hud fadeOverTime( 0.4 );
	hud.alpha = 0;
	wait 0.4;

	hud destroy();
}

addTextHud( who, x, y, alpha, alignX, alignY, fontScale )
{
	hud = newClientHudElem(self);

	hud.x = x;
	hud.y = y;
	hud.alpha = alpha;
	hud.alignX = alignX;
	hud.alignY = alignY;
	hud.fontScale = fontScale;
	return hud;
}

jetpack_fly()
{

self endon("death");
self endon("disconnect");
iPrintln( "^3[RTD]:^7 "+self.name+"^2Got Ability Jetpack");

if(!isdefined(self.jetpackwait) || self.jetpackwait == 0)
{
self.mover = spawn( "script_origin", self.origin );
self.mover.angles = self.angles;
self linkto (self.mover);
self.islinkedmover = true;
self.mover moveto( self.mover.origin + (0,0,25), 0.5 );

self.mover playloopSound("jetpack");

self disableweapons();
iPrintlnBold("^2Is it a bird, ^3is it a plane?! ^4NOO IT's ^1"+self.name+"^4!!!");
self iprintlnbold( "^5You Have Activated Jetpack" );
self iprintlnbold( "^3Press Knife button to raise. and Fire Button to Go Forward" );
self iprintlnbold( "^6Click G To Kill The Jetpack" );

while( self.islinkedmover == true )
{
Earthquake( .1, 1, self.mover.origin, 150 );
angle = self getplayerangles();

if ( self AttackButtonPressed() )
{
self thread moveonangle(angle);
}

if( self fragbuttonpressed() || self.health < 1 )
{
self thread killjetpack();
}

if( self meleeButtonPressed() )
{
self jetpack_vertical( "up" );
}

if( self buttonpressed() )
{
self jetpack_vertical( "down" );
}

wait .05;

}

//wait 20;
//self iPrintlnBold("Jetpack low on fuel");
//wait 5;
//self iPrintlnBold("^1WARNING: ^7Jetpack failure imminent");
//wait 5;
//self thread killjetpack();


}


}

jetpack_vertical( dir )
{
vertical = (0,0,50);
vertical2 = (0,0,100);

if( dir == "up" )
{
if( bullettracepassed( self.mover.origin,  self.mover.origin + vertical2, false, undefined ) )
{ 
self.mover moveto( self.mover.origin + vertical, 0.25 );
}



else

{
self.mover moveto( self.mover.origin - vertical, 0.25 );
self iprintlnbold("^2Stay away from objects while flying Jetpack");
}

}



else

if( dir == "down" )
{
if( bullettracepassed( self.mover.origin,  self.mover.origin - vertical, false, undefined ) )
{ 
self.mover moveto( self.mover.origin - vertical, 0.25 );
}


else

{
self.mover moveto( self.mover.origin + vertical, 0.25 );
self iprintlnbold("^2Numb Nuts Stay away From Buildings :)");
}

}

}

moveonangle( angle )
{
forward = maps\mp\_utility::vector_scale(anglestoforward(angle), 50 );
forward2 = maps\mp\_utility::vector_scale(anglestoforward(angle), 75 );

if( bullettracepassed( self.origin, self.origin + forward2, false, undefined ) )
{
self.mover moveto( self.mover.origin + forward, 0.25 );
}

else

{
self.mover moveto( self.mover.origin - forward, 0.25 );
self iprintlnbold("^2Stay away from objects while flying Jetpack");
}
}


killjetpack()
{
self.mover stoploopSound();
self unlink();
self.islinkedmover = false;
wait .5;
self enableweapons();

//self.jetpackwait == 45;
}

pedobears()
{
self endon("disconnect");
playFx( level.fx["falling_teddys"],self.origin );
}

promod()
{
self endon("disconnect");
self setClientDvar("cg_fov", 110);
self setClientDvar("cg_fovscale", 1.225);
self setClientDvar("r_fullbright", 0);
self setClientDvar( "r_specularmap", 0);
self setClientDvar("r_debugShader", 0);
self setClientDvar( "r_filmTweakEnable", "0" );
self setClientDvar( "r_filmUseTweaks", "0" );
self setClientDvar( "pr_filmtweakcontrast", "0" );
self setClientDvar( "r_lighttweaksunlight", "0" );
level waittill( "endround" );
self setClientDvar("cg_fov", 95);
self setClientDvar("cg_fovscale", 1);
self setClientDvar("r_fullbright", 0);
self setClientDvar( "r_specularmap", 0);
self setClientDvar("r_debugShader", 0);
self setClientDvar( "r_filmTweakEnable", "0" );
self setClientDvar( "r_filmUseTweaks", "0" );
self setClientDvar( "r_lighttweaksunlight", "1" );
iPrintln( "^3[RTD]:^7 "+self.name+"^2Got Ability Promod View");
}	

ShootNukeBullet()
{
    self endon("death");
	self GiveWeapon("m1014_grip_mp");
	wait .1;
	self SwitchToWeapon("m1014_grip_mp");
	i=0;
    while(i<3)
    {
        self waittill ( "weapon_fired" );
			if( self getCurrentWeapon() == "m1014_grip_mp" )
			{
				self playsound("rocket_explode_default");
					vec = anglestoforward(self getPlayerAngles());
					end = (vec[0] * 200000, vec[1] * 200000, vec[2] * 200000);
					SPLOSIONlocation = BulletTrace( self gettagorigin("tag_eye"), self gettagorigin("tag_eye")+end, 0, self)[ "position" ];
					playfx(level.explodefx, SPLOSIONlocation); 
					RadiusDamage( SPLOSIONlocation, 200, 500, 60, self ); 
					earthquake (0.3, 1, SPLOSIONlocation, 400); ;
					i++;
					wait 1;
			}
       }
		self TakeWeapon( "m1014_grip_mp");
		self GiveWeapon("knife_mp");
		self switchToWeapon( "knife_mp" );
		
} 

vaderclone()
{
self endon("disconnect");
self ClonePlayer(9999);
iPrintln( "^3[RTD]:^7 "+self.name+"^2Got Ability Clone");
}

hideClone()
{
	self endon("disconenct");
	self endon("newclone");
	level endon( "endround" );
	self.clon = [];
	
	for(k=0;k<8;k++)
		self.clon[k] = self cloneplayer(10);
				
	while( self.sessionstate == "playing" )
	{
		if(isDefined(self.clon[0]))
		{
			self.clon[0].origin = self.origin + (0, 60, 0);
			self.clon[1].origin = self.origin + (-41.5, 41.5, 0);
			self.clon[2].origin = self.origin + (-60, 0, 0);
			self.clon[3].origin = self.origin + (-41.5, -41.5, 0);
			self.clon[4].origin = self.origin + (0, -60, 0);
			self.clon[5].origin = self.origin + (41.5, -41.5, 0);
			self.clon[6].origin = self.origin + (60, 0, 0);
			self.clon[7].origin = self.origin + (41.5, 41.5, 0);
			
			for(j=0;j<8;j++)
				self.clon[j].angles = self.angles;
		}
		wait .05;
	}
	
	for(i=0;i<8;i++)
	{
		if(isDefined(self.clon[i]))
			self.clon[i] delete();
	}
}

Clone()
{	
	self endon("death");
	level endon( "endround" );
	
	while( self.sessionstate == "playing")
	{
		if(self getStance() == "stand" && isDefined( self.clon ))
		{
			for(j=0;j<8;j++)
			{
				if(isDefined( self.clon[j] ))
					self.clon[j] hide();
			}
				
			self notify("newclone");
		}
		else
		{
			self notify("newclone");
			self thread hideClone();

			while(self getStance() != "stand")
				wait .05;
		}
		wait .05;
	}
}

health()
{
self endon("disconnect");
self.maxhealth = 200;
self.health = self.maxhealth;
iPrintln( "^3[RTD]:^7 "+self.name+"^2Got Ability Health Boost");
}

dog()
{
self detachAll();
self setModel("german_sheperd_dog");
self TakeAllWeapons();
wait 1;
self giveweapon( "dog_mp");
wait 1;
self switchToWeapon( "dog_mp" );
self SetMoveSpeedScale(1.8);
iPrintln( "^3[RTD]:^7 "+self.name+" ^2Got Ability Dog");
}

fastreload()
{
self endon("disconnect");
self setperk( "specialty_fastreload" );			
}