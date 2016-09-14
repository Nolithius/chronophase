package com.nolithius.chronophase.actor.projectile
{
	import com.nolithius.chronophase.actor.Actor;
	import com.nolithius.chronophase.actor.character.Character;
	import com.nolithius.chronophase.actor.effect.Effect;
	import com.nolithius.chronophase.actor.effect.HitEffect;
	import com.nolithius.chronophase.map.Map;
	import com.nolithius.chronophase.ui.ScreenTile;
	import com.nolithius.chronophase.utils.Coord;
	
	
	/**
	 * ...
	 * @author Ebyan Alvarez-Buylla
	 */
	public class Projectile extends Actor
	{
		public static const PROJECTILE_TYPE_ION:uint = 1;
		public static const PROJECTILE_TYPE_MASS:uint = 2;
		public static const PROJECTILE_TYPE_MISSILE:uint = 3;
		
		public var projectileType:uint;
		public var heading:Coord;
		public var life:int = 2000;
		public var speed:int = 1;
		public var shootEnergy:int = 1000;
		public var trail:Class;
		public var damage:int = 1;
		public var hit:Boolean = false;	// Determines the effect when destroying
		public var owner:Character;
		
		
		public function Projectile(p_x:uint, p_y:uint, p_heading:Coord, p_owner:Character = null)
		{
			x = p_x;
			y = p_y;
			heading = p_heading;
			owner = p_owner;
			
			type = Actor.ACTOR_TYPE_PROJECTILE;
			moveEnergy = 1000;
		}
		
		
		public function getScreenTile(mapBackgroundColor:uint):ScreenTile
		{
			return new ScreenTile(140, foregroundColor, backgroundColor ? backgroundColor : mapBackgroundColor);
		}
		
		
		public override function act():void
		{
			move(heading.x, heading.y);
			
			life -= moveEnergy;
			
			if (life <= 0)
			{
				die();
			}
		}
		
		
		public override function move(xOffset:int, yOffset:int):void
		{
			Map.removeProjectileFromTile(this);
			
			super.move(xOffset, yOffset);
			
			Map.addProjectileToTile(this);
		}
		
		
		public override function die():void
		{
			Map.removeProjectile(this);
		}
		
		
		public function getTrail():Effect
		{
			if (hit)
			{
				return new HitEffect(x, y);
			}
			else if (trail)
			{
				return new trail(x, y);
			}
			else
			{
				return null;
			}
		}
	}
}