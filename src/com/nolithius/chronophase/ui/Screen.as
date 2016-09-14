package com.nolithius.chronophase.ui
{
	import com.nolithius.chronophase.actor.Actor;
	import com.nolithius.chronophase.actor.character.Character;
	import com.nolithius.chronophase.actor.character.Enemy;
	import com.nolithius.chronophase.actor.ship.ShipTile;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import com.nolithius.chronophase.actor.character.Player;
	import com.nolithius.chronophase.actor.ship.Ship;
	import com.nolithius.chronophase.map.Map;
	import com.nolithius.chronophase.map.Tile;
	
	
	public class Screen
	{
        [Embed(source="../../../../../assets/8x8.png")]
        protected static const ASCII:Class;

		// Constants
		public static const TILE_WIDTH:uint = 8;
		public static const TILE_HEIGHT:uint = 8;
		public static const SCREEN_TILES_X:uint = 40;
		public static const SCREEN_TILES_Y:uint = 40;
		public static const SCREEN_WIDTH:uint = TILE_WIDTH*SCREEN_TILES_X;
		public static const SCREEN_HEIGHT:uint = TILE_HEIGHT*SCREEN_TILES_Y;
		
		public static const SCREEN_MENU:uint = 0;
		public static const SCREEN_MAIN:uint = 1;
		public static const SCREEN_WIN:uint = 2;
		public static const SCREEN_LOSE:uint = 3;
		
		// UI
		public static var ascii:BitmapData;
		public static var screen:Bitmap;
		public static var activeScreen:uint = SCREEN_MENU;
		
		// Buffer to avoid redrawing
		public static var screenTiles:Array;
			
		
		public static function init(parent:Sprite)
		{
			screen = new Bitmap(new BitmapData(SCREEN_WIDTH, SCREEN_HEIGHT, false, 0x000000));
			parent.addChild(screen);
			ascii = (new ASCII() as Bitmap).bitmapData;
			
			screenTiles = new Array(SCREEN_TILES_X);
			for(var i = 0; i < SCREEN_TILES_X; i++)
			{
				screenTiles[i] = new Array(SCREEN_TILES_Y);
				
				for(var j = 0; j < SCREEN_TILES_Y; j++)
				{
					screenTiles[i][j] = new ScreenTile();
				}
			}
		}
				
		
		
		// Draw blank tiles to specified rect. If none, clear entire screen.
		public static function clear(rect:Rectangle = null):void
		{
			if(rect)
			{
				for(var i:uint = 0; i < rect.width; i++)
				{
					for(var j: uint = 0; j < rect.height; j++)
					{
						drawTile(0, rect.x + i, rect.y + j);
					}
				}
			}
			else
			{
				for(i = 0; i < SCREEN_TILES_X; i++)
				{
					for(j = 0; j < SCREEN_TILES_Y; j++)
					{
						drawTile(0, i, j);
					}
				}
			}
		}
		
		
		// Draws ship tile. Allows bleedthrough of background if either the foreground or the background are black (0).
		private static function drawShipTile(ascii:uint, x:uint, y:uint, foregroundColor:uint, backgroundColor:uint = 0):void
		{
			// Check bounds
			if (x >= Map.MAP_OFFSET_X && x < Map.MAP_OFFSET_X + Map.MAP_WIDTH && y >= Map.MAP_OFFSET_Y && y < Map.MAP_OFFSET_Y + Map.MAP_HEIGHT)
			{
				drawTile(ascii, x, y, foregroundColor ? foregroundColor : screenTiles[x][y].backgroundColor, backgroundColor ? backgroundColor : screenTiles[x][y].backgroundColor);
			}
		}
		
		
		private static function drawShip(ship:Ship, x:uint, y:uint):void
		{
			if (ship.rotation == 0)
			{
				for (var i:uint = 0; i < 12; i++)
				{
					var tile = ship.tiles[i];
					
					if (tile)
					{
						var tileX:uint = i % 3;
						var tileY:uint = uint(i / 3);
						
						drawShipTile(tile.ascii, x + tileX - 1, y + tileY - 2, tile.foregroundColor, tile.backgroundColor);
					}
				}
				
				drawShipTile(31, x, y+1, Tile.TILE_COLOR_YELLOW);
			}
			else if (ship.rotation == 90)
			{
				for (i = 0; i < 12; i++)
				{
					tile = ship.tiles[i];
					
					if (tile)
					{
						tileX = uint((11 - i) / 3);
						tileY = i % 3;
						
						drawShipTile(tile.ascii90, x + tileX-1, y + tileY-1, tile.foregroundColor, tile.backgroundColor);
					}
				}
				
				drawShipTile(17, x-1, y, Tile.TILE_COLOR_YELLOW);
			}
			else if (ship.rotation == 180)
			{
				for (i = 0; i < 12; i++)
				{
					tile = ship.tiles[i];
					
					if (tile)
					{
						tileX = (11-i) % 3;
						tileY = uint((11-i) / 3);
						
						drawShipTile(tile.ascii180, x + tileX-1, y + tileY-1, tile.foregroundColor, tile.backgroundColor);
					}
				}
				
				drawShipTile(30, x, y-1, Tile.TILE_COLOR_YELLOW);
			}
			else if (ship.rotation == 270)
			{
				for (i = 0; i < 12; i++)
				{
					tile = ship.tiles[i];
					
					if (tile)
					{
						tileX = uint(i / 3);
						tileY = (11-i) % 3;
						
						drawShipTile(tile.ascii270, x + tileX-2, y + tileY-1, tile.foregroundColor, tile.backgroundColor);
					}
				}
				
				drawShipTile(16, x+1, y, Tile.TILE_COLOR_YELLOW);
			}
		}
		
		
		private static function drawPlayer(x:uint, y:uint):void
		{
			drawShip(Map.player.ship, x, y);
		}
		
		
		private static function drawMain():void
		{
			// Draw box
			drawBox(Map.MAP_OFFSET_X - 1, Map.MAP_OFFSET_Y - 1, Map.MAP_WIDTH + 1, Map.MAP_HEIGHT + 1);
			
			// Draw map
			var screenTile:ScreenTile; // Allocate once
			for (var ix:uint = 0; ix < Map.MAP_WIDTH; ix++)
			{
				for (var iy:uint = 0; iy < Map.MAP_HEIGHT; iy++)
				{
					screenTile = Map.getScreenTile(ix, iy);
					drawTile(screenTile.ascii, ix+Map.MAP_OFFSET_X, iy+Map.MAP_OFFSET_Y, screenTile.foregroundColor, screenTile.backgroundColor);
				}
			}
			
			// Draw enemies
			drawEnemies();
			
			// Draw Player
			drawPlayer(Player.PLAYER_OFFSET_X + Map.MAP_OFFSET_X, Player.PLAYER_OFFSET_Y + Map.MAP_OFFSET_Y);
			
			// Draw interface
			drawBar(1, 1, 15, Map.player.currentHull, Map.player.totalHull, "HULL", Tile.TILE_COLOR_RED, Tile.TILE_COLOR_DARK_RED);
			//drawBar(14, 1, 12, Map.player.currentShield, Map.player.totalShield, "SHIELD:", Tile.TILE_COLOR_CYAN, Tile.TILE_COLOR_DARK_CYAN);
			//drawBar(27, 1, 12, Map.player.currentEnergy, Map.player.totalEnergy, "ENERGY:", Tile.TILE_COLOR_YELLOW, Tile.TILE_COLOR_DARK_YELLOW);
			
			drawWeaponSelector(1, Screen.SCREEN_TILES_Y - 5, 1, Map.player.weapon == 1);
			drawWeaponSelector(8, Screen.SCREEN_TILES_Y - 5, 2, Map.player.weapon == 2);
			drawWeaponSelector(15, Screen.SCREEN_TILES_Y - 5, 3, Map.player.weapon == 3);
			
			drawString(18, 0, "SCORE");
			drawString(19, 1, Map.score.toString());
			
			drawString(25, 0, "KILLS", Tile.TILE_COLOR_LIGHT_GRAY);
			drawString(26, 1, Map.kills.toString(), Tile.TILE_COLOR_LIGHT_GRAY);
			
			drawString(32, 0, "ENEMIES", Tile.TILE_COLOR_LIGHT_GRAY);
			drawString(33, 1, (Map.characters.length - 1)+" ", Tile.TILE_COLOR_LIGHT_GRAY);
			
			drawString(23, Screen.SCREEN_TILES_Y -5, "R", Tile.TILE_COLOR_LIGHT_GRAY);
			drawString(23, Screen.SCREEN_TILES_Y -4, "A", Tile.TILE_COLOR_LIGHT_GRAY);
			drawString(23, Screen.SCREEN_TILES_Y -3, "D", Tile.TILE_COLOR_LIGHT_GRAY);
			drawString(23, Screen.SCREEN_TILES_Y -2, "A", Tile.TILE_COLOR_LIGHT_GRAY);
			drawString(23, Screen.SCREEN_TILES_Y -1, "R", Tile.TILE_COLOR_LIGHT_GRAY);
			
			drawMinimap(24, Screen.SCREEN_TILES_Y -5, 15, 5);
		}
		
		
		private static function drawMinimap(x:uint, y:uint, width:uint, height:uint):void
		{
			var xScale:Number = width / Map.MAP_TILES_X;
			var yScale:Number = height / Map.MAP_TILES_Y;
			
			for (var ix:uint = 0; ix < width; ix++)
			{
				for (var iy:uint = 0; iy < height; iy++)
				{
					drawTile(250, x + ix, y + iy, Tile.TILE_COLOR_DARK_GRAY);
				}
			}
			
			// Draw enemies
			for (var i:uint; i < Map.characters.length; i++)
			{
				var character:Character = Map.characters[i];
				
				if (character.type == Actor.ACTOR_TYPE_ENEMY)
				{
					drawTile(character.getHeadingTile(), x + character.x * xScale, y + character.y * yScale, character.ship.foregroundColor);
				}
			}
			
			// Drawplayer
			drawTile(Map.player.getHeadingTile(), x + Map.player.x * xScale, y + Map.player.y * yScale, Map.player.ship.foregroundColor);
		}
		
		
		private static function drawEnemies():void
		{
			for (var i:uint = 0; i < Map.characters.length; i++)
			{
				if (Map.characters[i].type == Actor.ACTOR_TYPE_ENEMY)
				{
					var actor:Enemy = Map.characters[i];
					
					// Added modulo to fix bug where enemies would flicker offscreen if across map boundaries
					drawShip(actor.ship, (actor.x - Map.player.x + Player.PLAYER_OFFSET_X + Map.MAP_TILES_X) % Map.MAP_TILES_X + Map.MAP_OFFSET_X, (actor.y - Map.player.y + Player.PLAYER_OFFSET_Y + Map.MAP_TILES_Y) % Map.MAP_TILES_Y + Map.MAP_OFFSET_Y);
				}
			}
		}
		
		
		private static function drawWeaponSelector(p_x:uint, p_y:uint, p_number:uint, p_selected:Boolean = false):void
		{
			var p_label:String;
			var p_foregroundColor:uint;
			var p_backgroundColor:uint = Tile.TILE_COLOR_DARK_GRAY;
			
			if (p_number == 1)
			{
				p_label = "Ion";
				p_foregroundColor = p_selected ? Tile.TILE_COLOR_CYAN : Tile.TILE_COLOR_LIGHT_GRAY;
				p_backgroundColor = p_selected ? Tile.TILE_COLOR_DARK_CYAN : Tile.TILE_COLOR_DARK_GRAY;
				
				drawTile(196, p_x + 3, p_y + 1, p_foregroundColor);
				drawTile(196, p_x + 4, p_y + 2, p_foregroundColor);
				drawTile(196, p_x + 5, p_y + 3, p_foregroundColor);
				
				drawTile(250, p_x + 1, p_y + 1, p_foregroundColor);
				drawTile(250, p_x + 2, p_y + 1, p_foregroundColor);
				
				drawTile(250, p_x + 1, p_y + 2, p_foregroundColor);
				drawTile(250, p_x + 2, p_y + 2, p_foregroundColor);
				drawTile(250, p_x + 3, p_y + 2, p_foregroundColor);
				
				drawTile(250, p_x + 1, p_y + 3, p_foregroundColor);
				drawTile(250, p_x + 2, p_y + 3, p_foregroundColor);
				drawTile(250, p_x + 3, p_y + 3, p_foregroundColor);
				drawTile(250, p_x + 4, p_y + 3, p_foregroundColor);
			}
			else if (p_number == 2)
			{
				p_label = "Mass";
				p_foregroundColor = p_selected ? Tile.TILE_COLOR_RED : Tile.TILE_COLOR_LIGHT_GRAY;
				p_backgroundColor = p_selected ? Tile.TILE_COLOR_DARK_RED : Tile.TILE_COLOR_DARK_GRAY;
				
				drawTile(111, p_x + 3, p_y + 1, p_foregroundColor);
				drawTile(111, p_x + 5, p_y + 2, p_foregroundColor);
				drawTile(111, p_x + 4, p_y + 3, p_foregroundColor);
				
				drawTile(249, p_x + 1, p_y + 1, p_foregroundColor);
				drawTile(249, p_x + 2, p_y + 1, p_foregroundColor);
				
				drawTile(250, p_x + 1, p_y + 2, p_foregroundColor);
				drawTile(250, p_x + 2, p_y + 2, p_foregroundColor);
				drawTile(249, p_x + 3, p_y + 2, p_foregroundColor);
				drawTile(249, p_x + 4, p_y + 2, p_foregroundColor);
				
				drawTile(250, p_x + 1, p_y + 3, p_foregroundColor);
				drawTile(249, p_x + 2, p_y + 3, p_foregroundColor);
				drawTile(249, p_x + 3, p_y + 3, p_foregroundColor);
			}
			else if (p_number == 3)
			{
				p_label = "Msle";
				p_foregroundColor = p_selected ? Tile.TILE_COLOR_GREEN : Tile.TILE_COLOR_LIGHT_GRAY;
				p_backgroundColor = p_selected ? Tile.TILE_COLOR_DARK_GREEN : Tile.TILE_COLOR_DARK_GRAY;
				
				drawTile(16, p_x + 5, p_y + 1, p_foregroundColor);
				drawTile(16, p_x + 3, p_y + 2, p_foregroundColor);
				drawTile(16, p_x + 5, p_y + 3, p_foregroundColor);
				
				drawTile(249, p_x + 3, p_y + 1, p_foregroundColor);
				drawTile(7, p_x + 4, p_y + 1, p_foregroundColor);
				
				drawTile(249, p_x + 1, p_y + 2, p_foregroundColor);
				drawTile(7, p_x + 2, p_y + 2, p_foregroundColor);
				
				drawTile(249, p_x + 3, p_y + 3, p_foregroundColor);
				drawTile(7, p_x + 4, p_y + 3, p_foregroundColor);
			}
			
			
			var p_width:uint = 6;
			var p_height:uint = 4;
			
			// Draw corners
			drawTile(191, p_x + p_width, p_y, p_backgroundColor);
			drawTile(192, p_x, p_y + p_height, p_backgroundColor);
		
			if (p_label == null) p_label = "";
			var startLabel = p_width - p_label.length + 1;
			var endLabel = startLabel + p_label.length;
			
			// Draw labels
			drawString(p_x, p_y, p_number.toString(), p_selected ? p_foregroundColor : p_backgroundColor, p_selected ? p_backgroundColor : 0);
			drawString(p_x + startLabel, p_y+p_height, p_label, p_selected ? p_foregroundColor : p_backgroundColor, p_selected ? p_backgroundColor : 0);
			
			// Draw top and bottom lines
			for(var i:uint = 1; i < p_width; i++)
			{
				if(i < startLabel || i >= endLabel)
				{
					// Draw bottom tiles
					drawTile(196, p_x + i, p_y + p_height, p_backgroundColor);
				}
				
				// top
				drawTile(196, p_x + i, p_y, p_backgroundColor);
			}
						
			// Draw sides
			for(i = 1; i < p_height; i++)
			{
				drawTile(179, p_x, p_y + i, p_backgroundColor);
				drawTile(179, p_x + p_width, p_y + i, p_backgroundColor);
			}
		}
		
				
		public static function drawTile(index:uint, xPosition:uint, yPosition:uint, p_foregroundColor:uint = 0xFFFFFF, p_backgroundColor:uint = 0x000000):void
		{
			var xSource:uint = index % 16;
			var ySource:uint = uint(index / 16);

			// Check if tile has changed
			var currentMapTile:ScreenTile = screenTiles[xPosition][yPosition];

			if(currentMapTile.ascii != index || currentMapTile.foregroundColor != p_foregroundColor || currentMapTile.backgroundColor != p_backgroundColor)
			{
				screen.bitmapData.lock();
				
				var tile:Vector.<uint> = ascii.getVector(new Rectangle(xSource*TILE_WIDTH, ySource*TILE_HEIGHT, TILE_WIDTH, TILE_HEIGHT));
				var tileLength:uint = tile.length;
				
				if(p_foregroundColor != 0xFFFFFF || p_backgroundColor != 0x000000)
				{
					for(var i:uint = 0; i < tileLength; i++)
					{
						if(tile[i] == 0xFFFFFFFF)
						{
							if(p_foregroundColor != 0xFFFFFF)
							{
								tile[i] = p_foregroundColor;
							}
						}
						else if(p_backgroundColor != 0x000000)
						{
							tile[i] = p_backgroundColor;
						}
					}
		
					screen.bitmapData.setVector(new Rectangle(xPosition*TILE_WIDTH, yPosition*TILE_HEIGHT, TILE_WIDTH, TILE_HEIGHT), tile);
				}
				// Case 4: Neither are colorized
				else
				{
					screen.bitmapData.copyPixels(ascii, new Rectangle(xSource*TILE_WIDTH, ySource*TILE_HEIGHT, TILE_WIDTH, TILE_HEIGHT), new Point(xPosition*TILE_WIDTH, yPosition*TILE_HEIGHT));
				}
				
				screenTiles[xPosition][yPosition].ascii = index;
				screenTiles[xPosition][yPosition].foregroundColor = p_foregroundColor;
				screenTiles[xPosition][yPosition].backgroundColor = p_backgroundColor;
				
				screen.bitmapData.unlock();
			}
		}
		
		
		public static function drawBox(p_x:uint, p_y:uint, p_width:uint, p_height:uint, p_label:String = "", p_foregroundColor:uint = 0xFFFFFF, p_backgroundColor:uint = 0x000000, fill:Boolean = false):void
		{
			if(fill)
			{
				clear(new Rectangle(p_x+1, p_y+1, p_width-1, p_height));
			}
						
			if (p_label == null) p_label = "";
			var startLabel = int((p_width * 0.5) - (p_label.length * 0.5) + 0.5);
			var endLabel = startLabel + p_label.length;
						
			// Draw label
			drawString(p_x + startLabel, p_y, p_label, p_foregroundColor, p_backgroundColor);
						
			// Draw top and bottom lines
			for(var i:uint = 1; i < p_width; i++)
			{
				if(i < startLabel || i >= endLabel)
				{
					// Draw top tiles
					drawTile(196, p_x + i, p_y, p_foregroundColor, p_backgroundColor);
				}
				
				// Bottom
				drawTile(196, p_x + i, p_y + p_height, p_foregroundColor, p_backgroundColor);
			}
						
			// Draw sides
			for(i = 1; i < p_height; i++)
			{
				drawTile(179, p_x, p_y + i, p_foregroundColor, p_backgroundColor);
				drawTile(179, p_x + p_width, p_y + i, p_foregroundColor, p_backgroundColor);
			}
						
			// Draw corners
			drawTile(218, p_x, p_y, p_foregroundColor, p_backgroundColor);
			drawTile(191, p_x + p_width, p_y, p_foregroundColor, p_backgroundColor);
			drawTile(192, p_x, p_y + p_height, p_foregroundColor, p_backgroundColor);
			drawTile(217, p_x + p_width, p_y + p_height, p_foregroundColor, p_backgroundColor);
		}

		
		public static function drawString(p_x:uint, p_y:uint, p_string:String, p_foregroundColor:uint = 0xFFFFFF, p_backgroundColor:uint = 0x000000):void
		{
			var stringLength:uint = p_string.length;
			for(var i:uint = 0; i < stringLength; i++)
			{
				if (p_x + i < SCREEN_TILES_X - 1)
				{
					drawTile(p_string.charCodeAt(i), p_x + i, p_y, p_foregroundColor, p_backgroundColor);
				}
			}
		}
		
		
		// Main draw call
		public static function draw():void
		{
			if(activeScreen == SCREEN_MAIN)
			{
				// Main game map draw
				drawMain();
			}
			else if(activeScreen == SCREEN_MENU)
			{
				Menu.draw();
			}
			else if (activeScreen == SCREEN_WIN)
			{
				drawMain();
				drawWin();
			}
			else if (activeScreen == SCREEN_LOSE)
			{
				drawMain();
				drawLose();
			}
		}
		
		
		public static function drawWin():void
		{
			drawString(1, 12, "                                      ", Tile.TILE_COLOR_BLACK, Tile.TILE_COLOR_YELLOW);
			drawString(1, 13, "            Y O U   W I N !           ", Tile.TILE_COLOR_BLACK, Tile.TILE_COLOR_YELLOW);
			drawString(1, 14, "                                      ", Tile.TILE_COLOR_BLACK, Tile.TILE_COLOR_YELLOW);
		}
		
		
		public static function drawLose():void
		{
			drawString(1, 12, "                                      ", Tile.TILE_COLOR_BLACK, Tile.TILE_COLOR_RED);
			drawString(1, 13, "           Y O U   L O S E !          ", Tile.TILE_COLOR_BLACK, Tile.TILE_COLOR_RED);
			drawString(1, 14, "                                      ", Tile.TILE_COLOR_BLACK, Tile.TILE_COLOR_RED);
		}
		
		
		public static function drawBar(p_x:uint, p_y:uint, width:uint, current:Number, total:Number, p_label:String, p_primaryColor:uint = 0xFf0000, p_secondaryColor:uint = 0xFFFFFF):void
		{
			drawString(p_x, p_y-1, p_label);
			
			var label:String = Math.ceil(current) + "/" + Math.ceil(total);
			
			// Ensure that the width is at least the length of the label (otherwise, calculate normally)
			var percent:int = int((Math.ceil(current) / Math.ceil(total)) * width);
			
			// Measure the starting and ending points for the label (the same as in drawBox)
			var startLabel = 1//int((width * 0.5) - (label.length * 0.5));
			var endLabel = startLabel + label.length;
			
			// Bar
			for(var i = 0; i < width; i++)
			{
				if(i < percent)
				{
					if (i >= startLabel && i < endLabel)
					{
						drawTile(label.charCodeAt(i-startLabel), p_x + i , p_y, p_secondaryColor, p_primaryColor)//p_secondaryColor);
					}
					else
					{
						drawTile(32, p_x + i , p_y, p_secondaryColor, p_primaryColor);
					}
				}
				else
				{
					if (i >= startLabel && i < endLabel)
					{
						drawTile(label.charCodeAt(i-startLabel), p_x + i , p_y, p_primaryColor);
					}
					else
					{
						drawTile(17, p_x + i, p_y, p_secondaryColor);
					}
				}
			}
		}
	}
}