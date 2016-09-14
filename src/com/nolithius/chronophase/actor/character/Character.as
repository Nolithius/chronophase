package com.nolithius.chronophase.actor.character
{
	import com.nolithius.chronophase.actor.Actor;
	import com.nolithius.chronophase.actor.effect.ThrusterEffect;
	import com.nolithius.chronophase.actor.projectile.IonProjectile;
	import com.nolithius.chronophase.actor.projectile.MassProjectile;
	import com.nolithius.chronophase.actor.projectile.MissileProjectile;
	import com.nolithius.chronophase.actor.projectile.Projectile;
	import com.nolithius.chronophase.actor.ship.Ship;
	import com.nolithius.chronophase.map.Map;
	import com.nolithius.chronophase.utils.Coord;
	
	
	/**
	 * ...
	 * @author Ebyan Alvarez-Buylla
	 */
	public class Character extends Actor
	{
		public static const PROJECTILE_SHOOT_SEPARATION:uint = 3;
		
		
		public var ship:Ship;
		
		public var currentHull:Number = 5;
		public var totalHull:Number = 5;
		public var alive:Boolean = true;
		public var score:uint = 1000;
		public var weapon:uint = 1;
		
		
		public function Character(p_ship:Ship)
		{
			ship = p_ship;
		}
		
		
		public function shoot():void
		{
			var heading:Coord = getHeadingByRotation();
			
			var projectile:Projectile;
			
			if (weapon == 1) projectile = new IonProjectile((x + heading.x * PROJECTILE_SHOOT_SEPARATION + Map.MAP_TILES_X) % Map.MAP_TILES_X, (y + heading.y * PROJECTILE_SHOOT_SEPARATION + Map.MAP_TILES_Y) % Map.MAP_TILES_Y, heading, this);
			if (weapon == 2) projectile = new MassProjectile((x + heading.x * PROJECTILE_SHOOT_SEPARATION + Map.MAP_TILES_X) % Map.MAP_TILES_X, (y + heading.y * PROJECTILE_SHOOT_SEPARATION + Map.MAP_TILES_Y) % Map.MAP_TILES_Y, heading, this);
			if (weapon == 3) projectile = new MissileProjectile((x + heading.x * PROJECTILE_SHOOT_SEPARATION + Map.MAP_TILES_X) % Map.MAP_TILES_X, (y + heading.y * PROJECTILE_SHOOT_SEPARATION + Map.MAP_TILES_Y) % Map.MAP_TILES_Y, heading, this);
			
			Map.addProjectile(projectile);
						
			spendEnergy(projectile.shootEnergy);
		}
		
		
		public function getThrusterHeadingByRotation():Coord
		{
			if (ship.rotation == 90) return new Coord(-1, 0);
			else if (ship.rotation == 180) return new Coord(0, -1);
			else if (ship.rotation == 270) return new Coord(1, 0);
			// 0
			else return new Coord(0, 1);
		}
		
		
		public function getHeadingByRotation():Coord
		{
			if (ship.rotation == 90) return new Coord(1, 0);
			else if (ship.rotation == 180) return new Coord(0, 1);
			else if (ship.rotation == 270) return new Coord( -1, 0);
			// 0
			else return new Coord(0, -1);
		}
		
		
		public override function move(xOffset:int, yOffset:int):void
		{
			if (xOffset == 1) ship.rotation = 90;
			if (xOffset == -1) ship.rotation = 270;
			if (yOffset == 1) ship.rotation = 180;
			if (yOffset == -1) ship.rotation = 0;
			
			// Add engine thruster effect
			Map.addEffect(new ThrusterEffect(x, y));
			
			super.move(xOffset, yOffset);
		}
		
		
		public function takeDamage(damage:int):void
		{
			currentHull -= damage;

			if (currentHull <= 0)
			{
				die();
			}
		}
		
		
		public override function die():void
		{
			alive = false;
			Map.removeCharacter(this);
		}
		
				
		public function projectileCollision(projectile:Projectile):Boolean
		{
			if (ship.coordinateInShip(projectile.x-x, projectile.y-y))
			{
				takeDamage(projectile.damage);

				projectile.hit = true;
				
				return true;
			}
			else
			{
				return false;
			}
		}
		
		
		public function getHeadingTile():uint
		{
			if (ship.rotation == 90) return 16;
			else if (ship.rotation == 180) return 31;
			else if (ship.rotation == 270) return 17;
			// 0
			else return 30;
		}
	}
}