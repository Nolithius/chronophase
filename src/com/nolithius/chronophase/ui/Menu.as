package com.nolithius.chronophase.ui
{
	import com.nolithius.chronophase.map.Tile;
	import flash.display.BitmapData;
	import flash.geom.ColorTransform;
	
	public class Menu
	{
		// Main menu
		public static function draw():void
		{
			for (var ix:uint = 0; ix < Screen.SCREEN_TILES_X; ix++)
			{
				for (var iy:uint = 0; iy < Screen.SCREEN_TILES_Y; iy++)
				{
					var tile:Tile = new Tile(ix, iy);
					Screen.drawTile(tile.ascii, ix, iy, tile.foregroundColor);
				}
			}
			
			for (ix = 0; ix < Screen.SCREEN_TILES_X; ix++)
			{
				for (iy = 0; iy < Screen.SCREEN_TILES_Y; iy++)
				{
					if (iy == 9 && ix >= 9 && ix <= 31)
					{
						Screen.drawTile(220, ix, iy, Tile.TILE_COLOR_CYAN);
					}
					else if (iy == 11 && ix >= 9 && ix <= 31)
					{
						Screen.drawTile(223, ix, iy, Tile.TILE_COLOR_CYAN);
					}
					else if(ix > 8 && ix < 32 && iy > 14 && iy < 28)
					{
						Screen.drawTile(250, ix, iy, Tile.TILE_COLOR_DARK_GRAY);
					}
				}
			}
			
			Screen.drawString(9, 10, " C H R O N O P H A S E ", Tile.TILE_COLOR_DARK_CYAN, Tile.TILE_COLOR_CYAN);
			
			Screen.drawString(12, 12, "a 4-day roguelike", Tile.TILE_COLOR_CYAN);
			
			Screen.drawTile(24, 11, 16, Tile.TILE_COLOR_GREEN);
			Screen.drawTile(26, 12, 16, Tile.TILE_COLOR_GREEN);
			Screen.drawTile(25, 13, 16, Tile.TILE_COLOR_GREEN);
			Screen.drawTile(27, 14, 16, Tile.TILE_COLOR_GREEN);
			
			Screen.drawString(16, 16, ": Move");
			
			Screen.drawString(10, 18, "SPACE", Tile.TILE_COLOR_GREEN);
			Screen.drawString(16, 18, ": Fire!");
			
			Screen.drawString(10, 20, "1,2,3", Tile.TILE_COLOR_GREEN);
			Screen.drawString(16, 20, ": Weapon select");
			
			Screen.drawString(12, 24, "Take no prisoners!", Tile.TILE_COLOR_RED);
			
			Screen.drawString(12, 26, "<FIRE!> to begin!", Tile.TILE_COLOR_YELLOW);
			
			Screen.drawString(4, Screen.SCREEN_TILES_Y - 3, "Click once within the Flash area", Tile.TILE_COLOR_LIGHT_GRAY);
			Screen.drawString(6, Screen.SCREEN_TILES_Y - 2, "to begin reading keystrokes.", Tile.TILE_COLOR_LIGHT_GRAY);
			
			var bitmapData:BitmapData = new BitmapData(Screen.SCREEN_TILES_X, Screen.SCREEN_TILES_Y);
			bitmapData.perlinNoise(uint(Screen.SCREEN_TILES_X), uint(Screen.SCREEN_TILES_X), 5, uint(Math.random()*10000), true, true, 7, false);
			bitmapData.colorTransform(bitmapData.rect, new ColorTransform(1, 1, 1, 1, -100, -150, -255));
			var menuBackground:Vector.<uint> = bitmapData.getVector(bitmapData.rect);
			
			// Create nebula
			var tileX:uint;
			var tileY:uint;
			var screenTile:ScreenTile;
			for(var i:uint = 0; i < menuBackground.length; i++)
			{
				tileX = i % Screen.SCREEN_TILES_X;
				tileY = uint(i / Screen.SCREEN_TILES_X);
				screenTile = Screen.screenTiles[tileX][tileY];
				
				if (screenTile.backgroundColor == 0)
				{
					Screen.drawTile(screenTile.ascii, tileX, tileY, screenTile.foregroundColor, menuBackground[i]);
				}
			}
		}
	}
}