package com.nolithius.chronophase.actor.effect
{
	import com.nolithius.chronophase.map.Tile;
	
	
	/**
	 * ...
	 * @author Ebyan Alvarez-Buylla
	 */
	public class IonTrailEffect extends Effect
	{
		public function IonTrailEffect(p_x:uint, p_y:uint)
		{
			super(p_x, p_y);
						
			ascii = 250;
			foregroundColor = Tile.TILE_COLOR_CYAN;
			life = 2000;
			moveEnergy = 1000;
		}
	}
}