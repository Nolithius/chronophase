package com.nolithius.chronophase.actor.ship
{
	/**
	 * ...
	 * @author Ebyan Alvarez-Buylla
	 */
	public class ShipTiles
	{
		public static const SHIP_TILES:Array =
		[
			null,
			/*1*/	new ShipTile(127, 256, 257, 258, 1, 0),
					new ShipTile(219, 219, 219, 219, 1, 0),
					new ShipTile(17, 30, 16, 31, 1, 0),
					new ShipTile(30, 16, 31, 17, 2, 1),		// Triangle up, background color main, foreground color in background
			/*5*/	new ShipTile(16, 31, 17, 30, 1, 0),
					new ShipTile(24, 26, 25, 27, 2, 1), 	//Arrow, background color main, foreground color in background
					new ShipTile(180, 180, 195, 180, 1, 0),	//< Not used (7) replace
					new ShipTile(195, 194, 180, 193, 1, 0),
					new ShipTile(180, 193, 195, 194, 1, 0),
			/*10*/	new ShipTile(32, 32, 32, 32, 0, 0),		// Blank tile, to be used in place of thrusters for accurate collision
					new ShipTile(30, 16, 31, 17, 1, 0),		// Triangle up, regular
					new ShipTile(92, 47, 92, 47, 1, 0),		// '\', regular
					new ShipTile(47, 92, 47, 92, 1, 0),		// '/', regular
			/*14*/	new ShipTile(206, 206, 206, 206, 1, 0)	// Doubleline crossroads, regular
		];
	}
}