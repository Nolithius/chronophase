package com.nolithius.chronophase.map
{
	import com.nolithius.chronophase.actor.Actor;
	import com.nolithius.chronophase.actor.effect.Effect;
	import com.nolithius.chronophase.actor.projectile.Projectile;
	import com.nolithius.chronophase.ui.ScreenTile;
	
	
	public class Tile
	{
		// Blue
		public static const TILE_COLOR_BLUE:uint = 0x4e83ff;
		public static const TILE_COLOR_DARK_BLUE:uint = 0x36299e;
		
		// Cyan
		public static const TILE_COLOR_CYAN:uint = 0x84cdf1;
		public static const TILE_COLOR_DARK_CYAN:uint = 0x2d618f;
				
		// Green
		public static const TILE_COLOR_GREEN:uint = 0x9be65b;
		public static const TILE_COLOR_DARK_GREEN:uint = 0x2c6d43;
		
		// Magenta
		public static const TILE_COLOR_MAGENTA:uint = 0xdd8cef;
		public static const TILE_COLOR_DARK_MAGENTA:uint = 0x612079;
		
		// Red
		public static const TILE_COLOR_RED:uint = 0xeb2839;
		public static const TILE_COLOR_DARK_RED:uint = 0x810e2c;
		
		// Yellow
		public static const TILE_COLOR_YELLOW:uint = 0xfcec54;
		public static const TILE_COLOR_DARK_YELLOW:uint = 0xa47541;
		
		// White, Grays, Black
		public static const TILE_COLOR_WHITE:uint = 0xFFFFFF;
		public static const TILE_COLOR_LIGHT_GRAY:uint = 0xa19fa9;
		public static const TILE_COLOR_DARK_GRAY:uint = 0x615f73;
		public static const TILE_COLOR_BLACK:uint = 0x000000;
		
		
		public var x:int;
		public var y:int;
		
		public var ascii:uint = 32;
		public var foregroundColor:uint = TILE_COLOR_WHITE;
		public var backgroundColor:uint = TILE_COLOR_BLACK;
		public var projectile:Projectile;
		public var effect:Effect;

		
		public function Tile(p_x:int, p_y:int)
		{
			x = p_x;
			y = p_y;
						
			if (Math.random() < 0.002)
			{
				// Big *
				ascii = 15;
			}
			else if (Math.random() < 0.002)
			{
				// *
				ascii = 42;
			}
			else if (Math.random() < 0.002)
			{
				// +
				ascii = 43;
			}
			else
			{
				// Some of these are gray
				if (Math.random() < 0.5)
				{
					foregroundColor = Tile.TILE_COLOR_LIGHT_GRAY;
				}
				
				if (Math.random() < 0.03)
				{
					// .
					ascii = 46;
				}
				else if (Math.random() < 0.03)
				{
					// Medium .
					ascii = 249;
				}
				else if (Math.random() < 0.03)
				{
					// Little .
					ascii = 250;
				}
			}
		}
			
		
		public function getScreenTile():ScreenTile
		{
			if (projectile)
			{
				return projectile.getScreenTile(backgroundColor);
			}
			else if (effect)
			{
				return effect.getScreenTile(backgroundColor);
			}
			else
			{
				return new ScreenTile(ascii, foregroundColor, backgroundColor);
			}
		}
	}
}