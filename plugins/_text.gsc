init( modVersion )
{
	if( isDefined( self.Website ) )
		self.Website destroy();
		
	if( isDefined( self.Website2 ) )
		self.Website2 destroy();

	self.Website = newHudElem();
	self.Website2 = newHudElem();
    self.Website.foreground = true;
    self.Website2.foreground = true;
	self.Website.alignX = "left";
	self.Website2.alignX = "left";
	self.Website.alignY = "top";
	self.Website2.alignY = "top";
	self.Website.horzAlign = "left";
	self.Website2.horzAlign = "left";
    self.Website.vertAlign = "top";
	self.Website2.vertAlign = "top";
    self.Website.x = 4;
	self.Website2.x = 25;
    self.Website.y = 450;
    self.Website2.y = 0;
    self.Website.sort = 0;
	self.Website2.sort = 0;
  	self.Website.fontScale = 1.5;
	self.Website2.fontScale = 1.6;
	self.Website.color = (0.8, 1.0, 0.8);
	self.Website2.color = (0.9, 1.0, 0.8);
	self.Website.font = "objective";
	self.Website2.font = "objective";
	self.Website.glowColor = (0.2, 0.6, 1.0);
	self.Website2.glowColor = (0.4, 0.8, 1.1);
	self.Website.glowAlpha = 1;
    self.Website2.glowAlpha = 1;
 	self.Website.hidewheninmenu = true;
	self.Website2.hidewheninmenu = true;
	self.Website setText( "" );   // if you put any clor such as this ^3 = yellow. then the color want change 
	self.Website2 setText( "^1Press ^3[^1N^3] ^1to Roll the Dice^3!" );  //you can chnage color by ^3 = yello because its not flashing colors
	wait 1.5;
	self thread color();

}
color()
{
   	self.Website.color = (2, 0.44, 0.342);
	wait 1.5;
    self.Website.color = (1.7, 1.1, 0.234);
	wait 1.5;
    self.Website.color = (1.344, 2.4, 1.0);
	wait 1.5;
    self.Website.color = (1.343, 0.234, 0.1112);
	wait 1.5;
    self.Website.color = (1.53, 0.74, 1.5);
	wait 1.5;
    self.Website.color = (2.5, 1.6, 0.452);
	wait 1.5;
	self.Website.color = (1.034, 1.34, 0.943);
	wait 1.5;
	self.Website.color = (2.3, 0.434, 1.3);
	wait 1.5;
	self.Website.color = (0.8, 1.0, 0.8);
	wait 1.5;
	self thread color();
	wait 1.5;
}