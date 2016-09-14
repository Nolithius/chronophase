package com.nolithius.chronophase.ui
{
	// Represents how tiles actually look on the screen
	public class ScreenTile
	{
		public var ascii:uint;
		public var foregroundColor:uint;
		public var backgroundColor:uint;
		
		public function ScreenTile(p_ascii:uint = 0, p_foregroundColor:uint = 0xFFFFFF, p_backgroundColor:uint = 0x000000)
		{
			ascii = p_ascii;
			foregroundColor = p_foregroundColor;
			backgroundColor = p_backgroundColor;
		}
	}
}