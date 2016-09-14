package com.nolithius.chronophase.utils
{
	public class Coord
	{
		public var x:int;
		public var y:int;
		
		public function Coord(p_x:int, p_y:int)
		{
			x = p_x;
			y = p_y;
		}
		
		
		public function toString():String
		{
			return "(" + x + ", " + y + ")";
		}
		
		
		public static function comparator(a:Coord, b:Coord):Boolean
		{
			return a.x == b.x && a.y == b.y;
		}
	}
}