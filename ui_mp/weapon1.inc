#undef DRBUTTON_Y
#define DRBUTTON_Y ( 0 )
		itemDef
		{
			text			"Next"
			type			ITEM_TYPE_BUTTON
			rect			DRBUTTON_X DRBUTTON_Y 185 15 HORIZONTAL_ALIGN_FULLSCREEN VERTICAL_ALIGN_CENTER
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


				DR_WEAPON( 0, 0, 11 )
				DR_WEAPON( 1, 0, 12 )
				DR_WEAPON( 2, 0, 13 )
				DR_WEAPON( 3, 0, 14 )
		}