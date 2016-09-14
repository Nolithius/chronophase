package com.nolithius.chronophase
{
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import com.nolithius.chronophase.actor.character.Player;
	import com.nolithius.chronophase.actor.ship.MagentaShip;
	import com.nolithius.chronophase.map.Map;
	import com.nolithius.chronophase.turns.TurnManager;
	import com.nolithius.chronophase.ui.Screen;
	import com.nolithius.chronophase.utils.DistanceUtils;


    [SWF(frameRate="60", width="320", height="320", backgroundColor="#000000")]
	public class Chronophase extends Sprite
	{
		// Focuses for keystroke processing
		public static const FOCUS_MAIN:uint = 0;				// Main game screen
		public static const FOCUS_MENU:uint = 1;				// Main menu
		public static const FOCUS_WIN:uint = 2;					// Win
		public static const FOCUS_LOSE:uint = 3;				// Lose

		public var turnManager:TurnManager;
		public var player:Player;
		public var focus:uint = FOCUS_MENU;


		public function Chronophase()
		{
			// Initialize distance shortcuts
			DistanceUtils.init();
			
			// Draw the screen
			Screen.init(this);
			
			Screen.draw();
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
		}
		
		
		private function handleKeyDown(event:KeyboardEvent):void
		{
			if (focus == FOCUS_MAIN)
			{
				if (event.keyCode == Keyboard.UP) player.move(0, -1);
				else if (event.keyCode == Keyboard.RIGHT) player.move(1, 0);
				else if (event.keyCode == Keyboard.DOWN) player.move(0, 1);
				else if (event.keyCode == Keyboard.LEFT) player.move( -1, 0);
				else if (event.keyCode == Keyboard.SPACE) player.shoot();
				else if (event.charCode == String('1').charCodeAt(0)) player.weapon = 1;
				else if (event.charCode == String('2').charCodeAt(0)) player.weapon = 2;
				else if (event.charCode == String('3').charCodeAt(0)) player.weapon = 3;
				else
				{
					return;
				}
				
				turnManager.resolveTurns();
				
				Screen.draw();
			}
			else if (focus == FOCUS_MENU)
			{
				if (event.keyCode == Keyboard.SPACE)
				{
					Screen.clear();
					startGame();
				}
				else
				{
					return;
				}
				
				Screen.draw();
			}
		}
		
		
		private function startGame():void
		{
			player = new Player(new MagentaShip());
			turnManager = new TurnManager();
			
			Map.init(this, player, turnManager);
			
			focus = FOCUS_MAIN;
			Screen.activeScreen = Screen.SCREEN_MAIN;
		}
	}
}