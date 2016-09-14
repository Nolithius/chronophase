package com.nolithius.chronophase.actor
{
	import com.nolithius.chronophase.map.Map;
	import com.nolithius.chronophase.map.Tile;


	public class Actor
	{
		public static const ACTOR_TYPE_PLAYER:uint = 0;
		public static const ACTOR_TYPE_ENEMY:uint = 1;
		public static const ACTOR_TYPE_PROJECTILE:uint = 2;
		public static const ACTOR_TYPE_EFFECT:uint = 3;
		
		public var x:int = 0;
		public var y:int = 0;
		public var ascii:uint;
		public var foregroundColor:uint = Tile.TILE_COLOR_WHITE;
		public var backgroundColor:uint = Tile.TILE_COLOR_BLACK;
		public var type:int = ACTOR_TYPE_PLAYER;
		public var id:int = 0; // Used to break energy ties
		public var energy:int = 0;
		public var moveEnergy:int = 1000;
				
		
		public static function compareEnergy(a:Actor, b:Actor):int
		{
			if (a.energy < b.energy)
			{
				return -1;
			}
			else if (a.energy > b.energy)
			{
				return 1;
			}
			else
			{
				if (a.id < b.id)
				{
					return -1;
				}
				else if(a.id > b.id)
				{
					return 1;
				}
				else
				{
					return 0;
				}
			}
		}
		
		
		// Abstract function to be implemented by Monster class
		public function act():void
		{}
		
		
		/**
		 * Move the actor.
		 * @param	xOffset
		 * @param	yOffset
		 */
		public function move(xOffset:int, yOffset:int):void
		{
			spendEnergy(moveEnergy);
			
			x += xOffset;
			y += yOffset;
			
			// Wrap around the positive and negative edges
			x = (x + Map.MAP_TILES_X) % Map.MAP_TILES_X;
			y = (y + Map.MAP_TILES_Y) % Map.MAP_TILES_Y;
		}
		
		
		public function die():void
		{}
				
		
		public function spendEnergy(p_energy:int):void
		{
			Map.turnManager.spendEnergy(this, p_energy);
		}
	}
}