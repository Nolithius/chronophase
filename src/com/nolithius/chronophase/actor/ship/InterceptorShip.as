package com.nolithius.chronophase.actor.ship
{
	import com.nolithius.chronophase.map.Tile;
	
	/**
	 * ...
	 * @author Ebyan Alvarez-Buylla
	 */
	public class InterceptorShip extends Ship
	{
		public function InterceptorShip()
		{
			foregroundColor = Tile.TILE_COLOR_CYAN;
			backgroundColor = Tile.TILE_COLOR_DARK_CYAN;
			
			tiles =
			[
				0,	11,	0,
				0,	6,	0,
				3,	4,	5,
				8,	10,	9
			];
						
			replaceTiles();
			
			shipType = Ship.SHIP_TYPE_INTERCEPTOR;
			
			// Variables for enemy AI
			weapon = 1;
			chanceToShoot = 0.5;
			chanceToContinueHeading = 0.9;
		}
	}
}