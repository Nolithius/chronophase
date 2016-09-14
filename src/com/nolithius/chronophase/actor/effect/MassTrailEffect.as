package com.nolithius.chronophase.actor.effect
{
	import com.nolithius.chronophase.map.Tile;
		
		
	/**
	 * ...
	 * @author Ebyan Alvarez-Buylla
	 */
	public class MassTrailEffect extends Effect
	{
		public function MassTrailEffect(p_x:uint, p_y:uint)
		{
			super(p_x, p_y);
						
			ascii = 249;
			foregroundColor = Tile.TILE_COLOR_RED;
			life = 3000;
			moveEnergy = 1000;
		}
		
		public override function act():void
		{
			if (life <= 2500 && ascii == 249)
			{
				ascii = 250;
			}
			
			super.act();
		}
	}
}