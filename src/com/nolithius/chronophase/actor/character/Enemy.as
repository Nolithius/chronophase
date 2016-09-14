package com.nolithius.chronophase.actor.character
{
	import com.nolithius.chronophase.actor.Actor;
	import com.nolithius.chronophase.actor.ship.Ship;
	import com.nolithius.chronophase.map.Map;
	import com.nolithius.chronophase.utils.Coord;
	import com.nolithius.chronophase.utils.DistanceUtils;
	
	
	public class Enemy extends Character
	{
		public var chanceToShoot:Number = 0.1;
		public var chanceToContinueHeading:Number = 0.7;
		
		
		public override function Enemy(p_ship:Ship)
		{
			super(p_ship);
			
			type = Actor.ACTOR_TYPE_ENEMY;
			
			// Random starting rotation
			var rotationChance:Number = Math.random();
			if (rotationChance < 0.25) ship.rotation = 90;
			else if (rotationChance < 0.5) ship.rotation = 180;
			else if (rotationChance < 0.75) ship.rotation = 270;
			// Else do nothing, stay at 0
		}
		
		
		public override function act():void
		{
			var distanceToPlayer:Number = DistanceUtils.distance(x, y, Map.player.x, Map.player.y);
			
			if (Math.random() < chanceToShoot && distanceToPlayer < 20)
			{
				shoot();
			}
			else
			{
				var randomHeading:Coord = getRandomHeading();
				
				move(randomHeading.x, randomHeading.y);
			}
		}
		
		
		private function getRandomHeading():Coord
		{
			// High chance that they will continue moving in the same direction
			if (Math.random() < chanceToContinueHeading)
			{
				// return current heading
				return getHeadingByRotation();
			}
			else
			{
				var chance:Number = Math.random();
				
				if (chance < 0.25) return new Coord(0, -1);
				else if (chance < 0.5) return new Coord(1, 0);
				else if (chance < 0.75) return new Coord(0, 1);
				else return new Coord(-1, 0);
			}
		}
	}
}