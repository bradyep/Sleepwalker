package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.text.*;
	import flash.ui.Keyboard;
	
	public class Instructions extends Sprite
	{
		// VARIABLES
		// A variable to store the reference to the stage from the application class
		private var _stage:Object;
		
		//Create the text objects
		public var format:TextFormat = new TextFormat();
		public var output:TextField = new TextField();
		
		// CONSTRUCTOR
		public function Instructions(stage:Object)
		{
			_stage = stage;	
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private function addedToStageHandler(event:Event):void
		{
			startInstructions(); // We don't want to start the game until this class (a sprite) has been added to the stage.
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, instKeyDownHandler);
		}
		
		private function startInstructions():void
		{
			//Set the text format object
			format.font = "Helvetica";
			format.size = 12;
			format.color = 0xFFFFFF;
			format.align = TextFormatAlign.LEFT;
			
			//Configure the output text field	
			output.defaultTextFormat = format;
			output.width = 500;
			output.height = 400;
			output.autoSize = TextFieldAutoSize.LEFT;
			output.border = true;
			output.borderColor = 0xFF0000;
			output.wordWrap = true;
			output.text = "You are the RED SQUARE. When the timer runs out you will lose control and your character will begin sleepwalking and engaging in risky behavior. It's your job to create a safe environment" +
				" while you are still awake." +
				"\n\nMove around with arrow keys. Use things on the stage with SPACE BAR. Pick things up with X and then use them with Y." +
				" The UI is generally helpful and will let you know when buttons can do something or not, so pay attention to them! " +
				"\n\nIf you get stuck the key is probably combining the use of two objects. That means pick an item up with X, move to an object on the stage you can interact with" +
				"and press Z to use those two items together." +
				"\n\nIf you think the environment is safe, you can press R to go directly to sleep no matter where the timer is." +
				"\n\nPRESS ANY KEY TO BEGIN";
			
			//Display and position the output text field
			this.addChild(output);
			output.x = 25;
			output.y = 105;
		}
		
		// EVENT HANDLERS
		private function instKeyDownHandler(event:KeyboardEvent):void
		{
			trace(event.keyCode);
			dispatchEvent(new Event("startLevelOne", true));
			_stage.removeEventListener(KeyboardEvent.KEY_DOWN, instKeyDownHandler);
		}
	}
}