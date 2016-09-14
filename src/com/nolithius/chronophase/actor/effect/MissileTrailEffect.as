package com.nolithius.chronophase.actor.effect
{
	import com.nolithius.chronophase.map.Tile;
	
	
	/**
	 * ...
	 * @author Ebyan Alvarez-Buylla
	 */
	public class MissileTrailEffect extends Effect
	{
		public function MissileTrailEffect(p_x:uint, p_y:uint)
		{
			super(p_x, p_y);
						
			ascii = 7;
			foregroundColor = Tile.TILE_COLOR_GREEN;
			life = 3000;
			moveEnergy = 1000;
		}
		
		
		public override function act():void
		{
			if (life <= 2500 && ascii == 7)
			{
				ascii = 250;
			}
			
			super.act();
		}
	}

}