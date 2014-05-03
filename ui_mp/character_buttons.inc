
// Characters 
		#undef DRBUTTON_X
		#define DRBUTTON_X	175
		#undef DRBUTTON_Y
		#define DRBUTTON_Y	( 20 + 10 )

		itemDef	
		{
			style			WINDOW_STYLE_SHADER
			rect			DRBUTTON_X DRBUTTON_Y 140 20 HORIZONTAL_ALIGN_FULLSCREEN VERTICAL_ALIGN_CENTER

			forecolor		1 1 1 1
			background		"popmenu_bg"
			visible			1
			decoration
		}

		itemDef
		{
			text			"Characters"
			type			ITEM_TYPE_BUTTON
			rect			DRBUTTON_X DRBUTTON_Y 140 20 HORIZONTAL_ALIGN_FULLSCREEN VERTICAL_ALIGN_CENTER
			forecolor		1 1 1 0.85
			textalign		ITEM_ALIGN_MIDDLE_CENTER
			visible			1 
			textfont		6
			textscale		0.3

			onFocus 
			{
				play "mouse_over";
			}
			action 
			{
				play "mouse_click";
				close  self;
				open dr_characters;
			}
		}


// Sprays

		#undef DRBUTTON_X
		#define DRBUTTON_X	(175 + 10 + 140)

		itemDef	
		{
			style			WINDOW_STYLE_SHADER
			rect			DRBUTTON_X DRBUTTON_Y 140 20 HORIZONTAL_ALIGN_FULLSCREEN VERTICAL_ALIGN_CENTER

			forecolor		1 1 1 1
			background		"popmenu_bg"
			visible			1
			decoration
		}

		itemDef
		{
			text			"Sprays"
			type			ITEM_TYPE_BUTTON
			rect			DRBUTTON_X DRBUTTON_Y 140 20 HORIZONTAL_ALIGN_FULLSCREEN VERTICAL_ALIGN_CENTER
			forecolor		1 1 1 0.85
			textalign		ITEM_ALIGN_MIDDLE_CENTER
			visible			1 
			textfont		6
			textscale		0.3

			onFocus 
			{
				play "mouse_over";
			}
			action 
			{
				play "mouse_click";
				close self;
				open dr_sprays;
			}
		}
		
// Weapons
		#undef DRBUTTON_Y
		#define DRBUTTON_Y ( 20 + 45 )

		#undef DRBUTTON_X
		#define DRBUTTON_X	(100 )

		itemDef	
		{
			style			WINDOW_STYLE_SHADER
			rect			DRBUTTON_X DRBUTTON_Y 140 20 HORIZONTAL_ALIGN_FULLSCREEN VERTICAL_ALIGN_CENTER

			forecolor		1 1 1 1
			background		"popmenu_bg"
			visible			1
			decoration
		}

		itemDef
		{
			text			"Weapons"
			type			ITEM_TYPE_BUTTON
			rect			DRBUTTON_X DRBUTTON_Y 140 20 HORIZONTAL_ALIGN_FULLSCREEN VERTICAL_ALIGN_CENTER
			forecolor		1 1 1 0.85
			textalign		ITEM_ALIGN_MIDDLE_CENTER
			visible			1 
			textfont		6
			textscale		0.3

			onFocus 
			{
				play "mouse_over";
			}
			action 
			{
				play "mouse_click";
				close self;
				open dr_weapons;
			}
		}


//Donator
		#undef DRBUTTON_X
		#define DRBUTTON_X	( 100 + 140 + 10 )
		itemDef	
		{
			style			WINDOW_STYLE_SHADER
			rect			DRBUTTON_X DRBUTTON_Y 140 20 HORIZONTAL_ALIGN_FULLSCREEN VERTICAL_ALIGN_CENTER

			forecolor		1 1 1 1
			background		"popmenu_bg"
			visible			1
			decoration
		}

		itemDef
		{
			text			"Donator"
			type			ITEM_TYPE_BUTTON
			rect			DRBUTTON_X DRBUTTON_Y 140 20 HORIZONTAL_ALIGN_FULLSCREEN VERTICAL_ALIGN_CENTER
			forecolor		1 1 1 0.85
			textalign		ITEM_ALIGN_MIDDLE_CENTER
			visible			1 
			textfont		6
			textscale		0.3

			onFocus 
			{
				play "mouse_over";
			}
			action 
			{
				play "mouse_click";
				close self; 
				open vip;
			}
		}

		// Actiweap
		#undef DRBUTTON_X
		#define DRBUTTON_X	( 100 + 140 + 10 + 140 + 10 )

		itemDef	
		{
			style			WINDOW_STYLE_SHADER
			rect			DRBUTTON_X DRBUTTON_Y 140 20 HORIZONTAL_ALIGN_FULLSCREEN VERTICAL_ALIGN_CENTER

			forecolor		1 1 1 1
			background		"popmenu_bg"
			visible			1
			decoration
		}

		itemDef
		{
			text			"Acti Weapons"
			type			ITEM_TYPE_BUTTON
			rect			DRBUTTON_X DRBUTTON_Y 140 20 HORIZONTAL_ALIGN_FULLSCREEN VERTICAL_ALIGN_CENTER
			forecolor		1 1 1 0.85
			textalign		ITEM_ALIGN_MIDDLE_CENTER
			visible			1 
			textfont		6
			textscale		0.3

			onFocus 
			{
				play "mouse_over";
			}
			action 
			{
				play "mouse_click";
				close self; 
				open dr_actiweapon;
			}
		}

		// Return
		#undef DRBUTTON_Y
		#define DRBUTTON_Y	( 20 + 80 )

		#undef DRBUTTON_X
		#define DRBUTTON_X	(250)
		itemDef	
		{
			style			WINDOW_STYLE_SHADER
			rect			DRBUTTON_X DRBUTTON_Y 140 20 HORIZONTAL_ALIGN_FULLSCREEN VERTICAL_ALIGN_CENTER

			forecolor		1 1 1 1
			background		"popmenu_bg"
			visible			1
			decoration
		}

		itemDef
		{
			text			"Return"
			type			ITEM_TYPE_BUTTON
			rect			DRBUTTON_X DRBUTTON_Y 140 20 HORIZONTAL_ALIGN_FULLSCREEN VERTICAL_ALIGN_CENTER
			forecolor		1 1 1 0.85
			textalign		ITEM_ALIGN_MIDDLE_CENTER
			visible			1 
			textfont		6
			textscale		0.3

			onFocus 
			{
				play "mouse_over";
			}
			action 
			{
				play "mouse_click";
				close self;
				open "team_select";
			}
		}
		
		/*
		itemDef
		{
			style			WINDOW_STYLE_SHADER
			rect			FULLSCREEN_WIDE
			background		"overlay_grain"
			visible			1
			forecolor		1 1 1 0.2
			decoration
		}
		*/