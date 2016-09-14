package com.nolithius.chronophase.actor.effect
{
	import com.nolithius.chronophase.actor.Actor;
	import com.nolithius.chronophase.map.Map;
	import com.nolithius.chronophase.ui.ScreenTile;
	
	
	/**
	 * ...
	 * @author Ebyan Alvarez-Buylla
	 */
	public class Effect extends Actor
	{
		public var life:int = 2000;
		
		
		public function Effect(p_x:uint, p_y:uint)
		{
			x = p_x;
			y = p_y;
			type = Actor.ACTOR_TYPE_EFFECT;
		}
		
		
		public function getScreenTile(mapBackgroundColor:uint):ScreenTile
		{
			return new ScreenTile(ascii, foregroundColor, backgroundColor ? backgroundColor : mapBackgroundColor);
		}
		
		
		public override function act():void
		{
			spendEnergy(moveEnergy);
			
			life -= moveEnergy;
			
			if (life <= 0)
			{
				die();
			}
		}
		
		
		public override function die():void
		{
			Map.removeEffect(this);
		}
	}
}