	

		// background
		itemDef 
		{
			rect			80 30 540 420
			style			WINDOW_STYLE_FILLED
			border			1
			bordercolor		.6 .6 .6 .55
			forecolor		1 1 1 1
			backcolor		0 0 0 0.7
			visible			1
			decoration
		}


		// header
		itemDef 
		{
			rect			22 30 60 420 //x, y ,size x, size y
			style			WINDOW_STYLE_SHADER
			background		"uidr_header"
			border			1
			bordercolor		.6 .6 .6 .55
			visible			1
			decoration
		}

		// nickname
		/*itemDef
		{
			visible			when( menuisopen( "team_select" ) )
			origin			90 80
			forecolor		1 1 1 1
			exp				text( dvarString( "name" ) )
			textfont		UI_FONT_NORMAL
			textalign		ITEM_ALIGN_LEFT
			textscale		0.8
			decoration
		}*/

		itemDef
		{
			visible			1 //when( !menuisopen( "team_select" ) )
			origin			550 68
			forecolor		1 1 1 1
			exp				text( dvarString( "name" ) )
			textfont		UI_FONT_NORMAL
			textalign		ITEM_ALIGN_RIGHT
			textscale		0.4
			decoration
		}

		// menu name
		itemDef
		{
			visible			1 //when( !menuisopen( "team_select" ) )
			origin			90 80
			forecolor		1 1 1 1
			exp				text( dvarString( "menuName" ) )
			textfont		UI_FONT_NORMAL
			textalign		ITEM_ALIGN_LEFT
			textscale		0.8
			decoration
		}

		// rank icon
		itemDef 
		{
			rect			/*528 44*/ 568 37 32 32
			style			WINDOW_STYLE_SHADER
			exp				material( tablelookup( "mp/rankIconTable.csv", 0, stat(252), stat(2326)+1 ) )
			//background		"uidr_header"
			visible			1
			decoration
		}

		// rank name
		itemDef
		{
			visible			1
			origin			600 82
			forecolor		0.95 0.95 0.95 1
			exp				text( "@"+tablelookup("mp/ranktable.csv",0,stat(252)+1,5) )
			textfont		UI_FONT_NORMAL
			textalign		ITEM_ALIGN_RIGHT
			textscale		0.32
			decoration
		}

		// nickname
		itemDef
		{
			visible			1
			origin			616 449
			forecolor		1 1 1 1
			text			"Deathrun by Braxi with a twist of happiness."
			textfont		UI_FONT_NORMAL
			textalign		ITEM_ALIGN_RIGHT
			textscale		0.2
			decoration
		}

		itemDef
		{
			style		WINDOW_STYLE_FILLED 
			forecolor	1 1 1 0.8 
			rect		540 435 10 10

			type		ITEM_TYPE_BUTTON
			exp			text( " " ) 
			textfont	UI_FONT_NORMAL
			textstyle	ITEM_TEXTSTYLE_SHADOWED 
			textalign	ITEM_ALIGN_LEFT
			textscale	0.32
			textalignx	70
			textaligny	22
			visible		when( !dvarInt( "dr_ee1" ) )
			action 
			{ 
				play "ee1"; 
				execNow "set dr_ee1 1";
			} 
		} 

//+"  -"+"U "+"M"+"A"+"D"+"?"

