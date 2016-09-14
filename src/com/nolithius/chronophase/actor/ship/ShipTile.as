package com.nolithius.chronophase.actor.ship
{
	/**
	 * ...
	 * @author Ebyan Alvarez-Buylla
	 */
	public class ShipTile
	{
		public var ascii:uint;
		public var ascii90:uint;
		public var ascii180:uint;
		public var ascii270:uint;
		
		public var foregroundColor:uint; // 0 for show background, 1 for foreground color, and 2 for background color
		public var backgroundColor:uint; // 0 for show background, 1 for foreground color, and 2 for background color
		
		public function ShipTile(p_ascii:uint, p_ascii90:uint, p_ascii180:uint, p_ascii270:uint, p_foregroundColor:uint, p_backgroundColor:uint)
		{
			ascii = p_ascii;
			ascii90 = p_ascii90;
			ascii180 = p_ascii180;
			ascii270 = p_ascii270;
			foregroundColor = p_foregroundColor;
			backgroundColor = p_backgroundColor;
		}
		
		
		public function clone():ShipTile
		{
			return new ShipTile(ascii, ascii90, ascii180, ascii270, foregroundColor, backgroundColor);
		}
	}
}