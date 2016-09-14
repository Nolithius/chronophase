package com.nolithius.chronophase.actor.effect
{
	import com.nolithius.chronophase.map.Tile;
	
	
	/**
	 * ...
	 * @author Ebyan Alvarez-Buylla
	 */
	public class ThrusterEffect extends Effect
	{
		public function ThrusterEffect(p_x:uint, p_y:uint)
		{
			super(p_x, p_y);
						
			ascii = 249;
			foregroundColor = Tile.TILE_COLOR_YELLOW;
			life = 4001;
		}
		
		
		public override function act():void
		{
			if (life <= 3000 && ascii == 249)
			{
				ascii = 250;
			}
			
			super.act();
		}
	}
}