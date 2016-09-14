package com.nolithius.chronophase.actor.ship
{
	/**
	 * ...
	 * @author Ebyan Alvarez-Buylla
	 */
	public class Ship
	{
		public static const SHIP_TYPE_PLAYER:uint = 0;
		public static const SHIP_TYPE_INTERCEPTOR:uint = 1;
		public static const SHIP_TYPE_FLY:uint = 2;
		public static const SHIP_TYPE_XWING:uint = 3;
		
		
		public var rotation:uint = 0;
		public var foregroundColor:uint;
		public var backgroundColor:uint;
		public var tiles:Array = new Array();
		public var shipType:uint;
		
		// For enemies
		public var weapon:uint = 1;
		public var chanceToShoot:Number = 0.5;
		public var chanceToContinueHeading:Number = 0.5;
		
		
		public function replaceTiles()
		{
			// Replace tile indexes with tile objects
			for (var i:uint = 0; i < tiles.length; i++)
			{
				if (tiles[i])
				{
					var shipTile:ShipTile = ShipTiles.SHIP_TILES[tiles[i]].clone();
					
					// Replace foreground and background
					if (shipTile.foregroundColor == 1) shipTile.foregroundColor = foregroundColor;
					if (shipTile.foregroundColor == 2) shipTile.foregroundColor = backgroundColor;
					
					if (shipTile.backgroundColor == 1) shipTile.backgroundColor = foregroundColor;
					if (shipTile.backgroundColor == 2) shipTile.backgroundColor = backgroundColor;
										
					tiles[i] = shipTile;
				}
			}
		}
		
		
		public function coordinateInShip(x:int, y:int):Boolean
		{
			if (Math.abs(x) <= 2 && Math.abs(y) <= 2)
			{
				// Heading up, easy case, plain tiles
				if (rotation == 0)
				{
					// Offset
					x += 1;
					y += 2;
					
					// If in bounds
					if (x >= 0 && x <= 2 && y >= 0 && y <= 3)
					{
						var index:int = y * 3 + x;
						
						// Check if there is a tile definition for this tile
						if (tiles[index])
						{
							tiles[index] = null
							return true;
						}
						else
						{
							return false;
						}
					}
					else
					{
						return false;
					}
				}
				else if (rotation == 90)
				{
					// Offset
					x += 1;
					y += 1;
					
					// If in bounds
					if (x >= 0 && x <= 3 && y >= 0 && y <= 2)
					{
						index = (3-x)*3+y;
												
						// Check if there is a tile definition for this tile
						if (tiles[index])
						{
							tiles[index] = null
							return true;
						}
						else
						{
							return false;
						}
					}
					else
					{
						return false;
					}
				}
				else if (rotation == 180)
				{
					// Offset
					x += 1;
					y += 1;
					
					// If in bounds
					if (x >= 0 && x <= 2 && y >= 0 && y <= 3)
					{
						index = (3-y)*3 + (2-x);
												
						// Check if there is a tile definition for this tile
						if (tiles[index])
						{
							tiles[index] = null
							return true;
						}
						else
						{
							return false;
						}
					}
					else
					{
						return false;
					}
				}
				if (rotation == 270)
				{
					// Offset
					x += 2;
					y += 1;
					
					// If in bounds
					if (x >= 0 && x <= 3 && y >= 0 && y <= 2)
					{
						index = (x*3)+(2-y);
						
						// Check if there is a tile definition for this tile
						if (tiles[index])
						{
							tiles[index] = null
							return true;
						}
						else
						{
							return false;
						}
					}
					else
					{
						return false;
					}
				}
				else
				{
					return true;
				}
			}
			else
			{
				return false;
			}
		}
	}
}