package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	
	public class KitchenLevel extends Sprite
	{
		// Declare the variables to hold the game objects
		private var _character:Character;
		private var _bathroomBG:BathroomBG;		
		// private var _shower:Shower;
		// private var _toilet:Toilet;
		
		// Timers
		private var _fallAsleepTimer:Timer;
		
		// A variable to store the reference to the stage from the application class
		private var _stage:Object;
		
		public function KitchenLevel(stage:Object)
		{
			_stage = stage;	
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private function addedToStageHandler(event:Event):void
		{
			// startGame();
			this.removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
	}
}