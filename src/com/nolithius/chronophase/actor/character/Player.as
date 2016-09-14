package com.nolithius.chronophase.actor.character
{
	import com.nolithius.chronophase.actor.ship.Ship;
	import com.nolithius.chronophase.map.Map;
	import com.nolithius.chronophase.ui.Screen;
	

	public class Player extends Character
	{
		public static const PLAYER_OFFSET_X:uint = uint(Screen.SCREEN_TILES_X/2)-1;
		public static const PLAYER_OFFSET_Y:uint = uint(Screen.SCREEN_TILES_Y/2)-5;
		
		
		public function Player(p_ship:Ship)
		{
			super(p_ship);
			
			x = uint(Map.MAP_TILES_X / 2);
			y = uint(Map.MAP_TILES_Y / 2);
		}
	}
}