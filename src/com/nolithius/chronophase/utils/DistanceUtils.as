package com.nolithius.chronophase.utils
{
	public class DistanceUtils
	{
		public static const DISTANCE_WIDTH:uint = 120;
		public static const DISTANCE_HEIGHT:uint = 120;
		
		public static var initialized:Boolean = false;
		public static var distanceArray:Array = new Array(DISTANCE_WIDTH);
		
		public static function init()
		{
			initialized = true;
			
			for(var i = 0; i < DISTANCE_WIDTH; i++)
			{
				distanceArray[i] = new Array(DISTANCE_WIDTH);
				
				for(var j = 0; j < DISTANCE_HEIGHT; j++)
				{
					distanceArray[i][j] = rawDistance(0, 0, i, j);
				}
			}
		}
		

		private static function rawDistance(x1:uint, y1:uint, x2:uint, y2:uint):Number
		{
			return Math.sqrt(Math.pow(x1 - x2, 2) + Math.pow(y1 - y2, 2));
		}
				
		
		public static function distance(x1:uint, y1:uint, x2:uint, y2:uint):Number
		{
			var dx:int = x1 - x2;
			if(dx < 0) dx = -dx;
			
			var dy:int = y1 - y2;
			if(dy < 0) dy = -dy;
			
			return distanceArray[dx][dy];
		}
	}
}