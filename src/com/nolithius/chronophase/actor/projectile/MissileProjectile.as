package com.nolithius.chronophase.actor.projectile
{
	import com.nolithius.chronophase.actor.character.Character;
	import com.nolithius.chronophase.actor.effect.MissileTrailEffect;
	import com.nolithius.chronophase.map.Tile;
	import com.nolithius.chronophase.ui.ScreenTile;
	import com.nolithius.chronophase.utils.Coord;
	
	
	/**
	 * ...
	 * @author Ebyan Alvarez-Buylla
	 */
	public class MissileProjectile extends Projectile
	{
		public function MissileProjectile(p_x:uint, p_y:uint, p_heading:Coord, p_owner:Character)
		{
			super(p_x, p_y, p_heading, p_owner);
			
			// Missile Projectile-specific settings
			foregroundColor = Tile.TILE_COLOR_GREEN;
			life = 15000;
			shootEnergy = 1000;
			trail = MissileTrailEffect;
			
			projectileType = Projectile.PROJECTILE_TYPE_MISSILE;
		}
		
		
		public override function getScreenTile(mapBackgroundColor:uint):ScreenTile
		{
			// If moving right
			if (heading.x == 1)
			{
				return new ScreenTile(16, foregroundColor, mapBackgroundColor);
			}
			// Left
			if (heading.x == -1)
			{
				return new ScreenTile(17, foregroundColor, mapBackgroundColor);
			}
			// Down
			if (heading.y == 1)
			{
				return new ScreenTile(31, foregroundColor, mapBackgroundColor);
			}
			// Up
			else
			{
				return new ScreenTile(30, foregroundColor, mapBackgroundColor);
			}
		}
	}
}