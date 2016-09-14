package com.nolithius.chronophase.actor.ship
{
	import com.nolithius.chronophase.map.Tile;
	
	/**
	 * ...
	 * @author Ebyan Alvarez-Buylla
	 */
	public class XwingShip extends Ship
	{
		public function XwingShip()
		{
			foregroundColor = Tile.TILE_COLOR_GREEN;
			backgroundColor = Tile.TILE_COLOR_LIGHT_GRAY;
			
			tiles =
			[
				0,	0,	0,
				13,	14,	12,
				12,	1,	13,
				0,	10,	0
			];
						
			replaceTiles();
			
			shipType = Ship.SHIP_TYPE_XWING;
			
			// Variables for enemy AI
			weapon = 3;
			chanceToShoot = 0.1;
			chanceToContinueHeading = 0.5;
		}
	}
}