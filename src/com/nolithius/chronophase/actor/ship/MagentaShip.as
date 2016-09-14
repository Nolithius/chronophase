package com.nolithius.chronophase.actor.ship
{
	import com.nolithius.chronophase.map.Tile;
	
	/**
	 * ...
	 * @author Ebyan Alvarez-Buylla
	 */
	public class MagentaShip extends Ship
	{
		public function MagentaShip()
		{
			foregroundColor = Tile.TILE_COLOR_MAGENTA;
			backgroundColor = Tile.TILE_COLOR_DARK_MAGENTA;
			
			tiles =
			[
				0,	1,	0,
				8,	2,	9,
				3,	4,	5,
				0,	10,	0
			];
						
			replaceTiles();
			
			shipType = Ship.SHIP_TYPE_PLAYER;
		}
	}
}