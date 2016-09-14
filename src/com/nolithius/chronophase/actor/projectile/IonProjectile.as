package com.nolithius.chronophase.actor.projectile
{
	import com.nolithius.chronophase.actor.character.Character;
	import com.nolithius.chronophase.actor.effect.IonTrailEffect;
	import com.nolithius.chronophase.map.Tile;
	import com.nolithius.chronophase.ui.ScreenTile;
	import com.nolithius.chronophase.utils.Coord;
	
	
	/**
	 * ...
	 * @author Ebyan Alvarez-Buylla
	 */
	public class IonProjectile extends Projectile
	{
		public function IonProjectile(p_x:uint, p_y:uint, p_heading:Coord, p_owner:Character)
		{
			super(p_x, p_y, p_heading, p_owner);
			
			// Ion Projectile-specific settings
			foregroundColor = Tile.TILE_COLOR_CYAN;
			life = 10000;
			shootEnergy = 333;
			moveEnergy = 333;
			trail = IonTrailEffect;
			
			projectileType = Projectile.PROJECTILE_TYPE_ION;
		}
		
		
		public override function getScreenTile(mapBackgroundColor:uint):ScreenTile
		{
			// If moving horizontally
			if (heading.x)
			{
				return new ScreenTile(196, foregroundColor, mapBackgroundColor);
			}
			// Vertically
			else
			{
				return new ScreenTile(179, foregroundColor, mapBackgroundColor);
			}
		}
	}
}