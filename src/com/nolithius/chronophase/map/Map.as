package com.nolithius.chronophase.map
{
	import flash.display.BitmapData;
	import flash.geom.ColorTransform;
	
	import com.nolithius.chronophase.actor.Actor;
	import com.nolithius.chronophase.actor.character.Character;
	import com.nolithius.chronophase.actor.character.Enemy;
	import com.nolithius.chronophase.actor.character.Player;
	import com.nolithius.chronophase.actor.effect.Effect;
	import com.nolithius.chronophase.actor.projectile.Projectile;
	import com.nolithius.chronophase.actor.ship.FlyShip;
	import com.nolithius.chronophase.actor.ship.InterceptorShip;
	import com.nolithius.chronophase.actor.ship.Ship;
	import com.nolithius.chronophase.actor.ship.XwingShip;
	import com.nolithius.chronophase.Chronophase;
	import com.nolithius.chronophase.map.Map;
	import com.nolithius.chronophase.map.Tile;
	import com.nolithius.chronophase.turns.TurnManager;
	import com.nolithius.chronophase.ui.Screen;
	import com.nolithius.chronophase.ui.ScreenTile;
	
	
	public class Map
	{
		// Constants
		public static const MAP_OFFSET_X:uint = 1;
		public static const MAP_OFFSET_Y:uint = 3;
		public static const MAP_TILES_X:uint = Screen.SCREEN_TILES_X*3;
		public static const MAP_TILES_Y:uint = Screen.SCREEN_TILES_Y*2;
		public static const MAP_WIDTH:uint = Screen.SCREEN_TILES_X-2;
		public static const MAP_HEIGHT:uint = Screen.SCREEN_TILES_Y - 9;
		public static const ENEMY_COUNT:uint = 7;
		public static const ENEMY_SHIPS:Array = [InterceptorShip, FlyShip, XwingShip];
		
		public static var player:Player;
		public static var main:Chronophase;	// Pointer back to main
		public static var turnManager:TurnManager;
		public static var tiles:Array;
		public static var characters:Array = new Array();
		public static var projectiles:Array = new Array();
		public static var effects:Array = new Array();
		public static var idCounter:int = 0; // Increment this to line up projectiles nicely
		public static var score:int = 0;
		public static var kills:int = 0;
		
		
		public static function init(p_main:Chronophase, p_player:Player, p_turnManager:TurnManager)
		{
			main = p_main;
			player = p_player;
			
			turnManager = p_turnManager
			turnManager.registerActor(player, 0);

			characters.push(player);
			
			// Init area
			tiles = new Array(Map.MAP_TILES_X);
			for(var i = 0; i < Map.MAP_TILES_X; i++)
			{
				tiles[i] = new Array(Map.MAP_TILES_Y);
			}
			
			generate();
		}
		
				
		public static function getScreenTile(x:uint, y:uint):ScreenTile
		{
			return tiles[(x+player.x-Player.PLAYER_OFFSET_X+Map.MAP_TILES_X)%Map.MAP_TILES_X][(y+player.y-Player.PLAYER_OFFSET_Y+Map.MAP_TILES_Y)%Map.MAP_TILES_Y].getScreenTile();
		}
		
		
		public static function addCharacter(character:Character):void
		{
			characters.push(character);
			
			turnManager.registerActor(character, idCounter++);
		}
		
		
		public static function removeCharacter(character:Character):void
		{
			if (character.type == Actor.ACTOR_TYPE_ENEMY)
			{
				characters.splice(characters.indexOf(character), 1);
				turnManager.removeActor(character);
				
				score += character.score;
				kills++;
				
				if (characters.length == 1)
				{
					main.focus = Chronophase.FOCUS_WIN;
					Screen.activeScreen = Screen.SCREEN_WIN;
				}
			}
			// Player death
			else if (character.type == Actor.ACTOR_TYPE_PLAYER)
			{
				main.focus = Chronophase.FOCUS_LOSE;
				Screen.activeScreen = Screen.SCREEN_LOSE;
			}
		}
						
		
		public static function addProjectile(projectile:Projectile):void
		{
			projectiles.push(projectile);
			
			turnManager.registerActor(projectile, idCounter++);
			
			addProjectileToTile(projectile);
		}
		
		
		public static function removeProjectile(projectile:Projectile):void
		{
			projectiles.splice(projectiles.indexOf(projectile), 1);
			
			removeProjectileFromTile(projectile);
			
			turnManager.removeActor(projectile);
		}
		
		
		private static function projectileShipCollision(projectile:Projectile):Boolean
		{
			for (var i:uint = 0; i < characters.length; i++)
			{
				if (characters[i].projectileCollision(projectile))
				{
					return true;
				}
			}
			
			return false;
		}
		
		
		public static function addProjectileToTile(projectile:Projectile):void
		{
			// Projectile-ship collision
			if (projectileShipCollision(projectile))
			{
				removeProjectile(projectile);
			}
			// Projectile-projectile collision (both projectiles destroyed)
			else
			{
				var existingProjectile:Projectile = tiles[projectile.x][projectile.y].projectile;
				
				if (existingProjectile && existingProjectile.owner != projectile.owner && existingProjectile.projectileType != projectile.projectileType)
				{
					projectile.hit = true;
					removeProjectile(tiles[projectile.x][projectile.y].projectile);
					removeProjectile(projectile);
				}
				// No collision, move normally
				else
				{
					tiles[projectile.x][projectile.y].projectile = projectile;
				}
			}
		}
		
		
		public static function removeProjectileFromTile(projectile:Projectile):void
		{
			// Set the tile's projectile to null
			tiles[projectile.x][projectile.y].projectile = null;
			
			// Set the projectile trail effect
			addEffect(projectile.getTrail());
		}
		
		
		public static function addEffect(effect:Effect):void
		{
			effects.push(effect);

			turnManager.registerActor(effect, idCounter++);
			
			addEffectToTile(effect);
		}
		
		
		public static function addEffectToTile(effect:Effect):void
		{
			// Remove previous effect if it exists
			if (tiles[effect.x][effect.y].effect)
			{
				removeEffect(tiles[effect.x][effect.y].effect);
			}
			
			tiles[effect.x][effect.y].effect = effect;
		}
		
		
		public static function removeEffect(effect:Effect):void
		{
			effects.splice(effects.indexOf(effect), 1);
			
			removeEffectFromTile(effect);
			
			turnManager.removeActor(effect);
		}
		
		
		public static function removeEffectFromTile(effect:Effect):void
		{
			tiles[effect.x][effect.y].effect = null;
		}
		
		
		/**
		 * Generate area and add enemies.
		 */
		public static function generate():void
		{
			for (var ix:uint = 0; ix < Map.MAP_TILES_X; ix++)
			{
				for (var iy:uint = 0; iy < Map.MAP_TILES_Y; iy++)
				{
					tiles[ix][iy] = new Tile(ix, iy);
				}
			}
			
			var bitmapData:BitmapData = new BitmapData(Map.MAP_TILES_X, Map.MAP_TILES_Y);
			bitmapData.perlinNoise(uint(Map.MAP_TILES_X/2), uint(Map.MAP_TILES_Y/2), 5, uint(Math.random()*10000), true, true, 7, false);
			bitmapData.colorTransform(bitmapData.rect, new ColorTransform(1, 1, 1, 1, -100, -150, -255));
			var menuBackground:Vector.<uint> = bitmapData.getVector(bitmapData.rect);
			
			// Create nebula
			var tileX:uint;
			var tileY:uint;
			for(var i:uint = 0; i < menuBackground.length; i++)
			{
				tileX = i % Map.MAP_TILES_X;
				tileY = uint(i / Map.MAP_TILES_X);
				
				tiles[tileX][tileY].backgroundColor = menuBackground[i];
			}
			
			// Add enemies
			for (i = 0; i < ENEMY_COUNT; i++)
			{
				var enemyShipIndex:uint = uint(Math.ceil(Math.random() * (ENEMY_SHIPS.length))-1);
				var enemyShipClass:Class = ENEMY_SHIPS[enemyShipIndex];
				var ship:Ship = new enemyShipClass();
				var enemy:Enemy = new Enemy(ship);
				
				// Populate enemy AI properties from ship settings
				enemy.weapon = ship.weapon;
				enemy.chanceToShoot = ship.chanceToShoot;
				enemy.chanceToContinueHeading = ship.chanceToContinueHeading;
				
				enemy.x = uint(Math.random()*Map.MAP_TILES_X);
				enemy.y = uint(Math.random() * Map.MAP_TILES_Y);
				
				addCharacter(enemy);
			}
		}
	}
}