package com.nolithius.chronophase.actor.ship
{
	import com.nolithius.chronophase.map.Tile;
	
	/**
	 * ...
	 * @author Ebyan Alvarez-Buylla
	 */
	public class FlyShip extends Ship
	{
		public function FlyShip()
		{
			foregroundColor = Tile.TILE_COLOR_RED;
			backgroundColor = Tile.TILE_COLOR_DARK_RED;
			
			tiles =
			[
				0,	0,	0,
				0,	11,	0,
				12,	6,	13,
				8,	10,	9
			];
						
			replaceTiles();
			
			shipType = Ship.SHIP_TYPE_FLY;
			
			// Variables for enemy AI
			weapon = 2;
			chanceToShoot = 0.2;
			chanceToContinueHeading = 0.7;
		}
	}
}