package com.nolithius.chronophase.actor.projectile
{
	import com.nolithius.chronophase.actor.character.Character;
	import com.nolithius.chronophase.actor.effect.MassTrailEffect;
	import com.nolithius.chronophase.map.Tile;
	import com.nolithius.chronophase.ui.ScreenTile;
	import com.nolithius.chronophase.utils.Coord;
	
	
	/**
	 * ...
	 * @author Ebyan Alvarez-Buylla
	 */
	public class MassProjectile extends Projectile
	{
		public function MassProjectile(p_x:uint, p_y:uint, p_heading:Coord, p_owner:Character)
		{
			super(p_x, p_y, p_heading, p_owner);
			
			// Mass Projectile-specific settings
			foregroundColor = Tile.TILE_COLOR_RED;
			life = 12000;
			shootEnergy = 500;
			moveEnergy = 500;
			trail = MassTrailEffect;
			
			projectileType = Projectile.PROJECTILE_TYPE_MASS;
		}
		
		
		public override function getScreenTile(mapBackgroundColor:uint):ScreenTile
		{
			return new ScreenTile(111, foregroundColor, mapBackgroundColor);
		}
	}
}