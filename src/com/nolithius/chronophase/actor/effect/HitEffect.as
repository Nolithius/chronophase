package com.nolithius.chronophase.actor.effect
{
	import com.nolithius.chronophase.map.Tile;
	
	
	/**
	 * ...
	 * @author Ebyan Alvarez-Buylla
	 */
	public class HitEffect extends Effect
	{
		public function HitEffect(p_x:uint, p_y:uint)
		{
			super(p_x, p_y);
						
			ascii = 15;
			foregroundColor = Tile.TILE_COLOR_RED;
			life = 3000;
			moveEnergy = 1000;
		}
		
		
		public override function act():void
		{
			if (life <= 2500 && ascii == 15)
			{
				ascii = 42;
			}
			
			super.act();
		}
	}

}