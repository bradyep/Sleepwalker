package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	[SWF(width="550", height="500", 
    backgroundColor="#000000", frameRate="60")]
	
	public class sleepWalker extends Sprite
	{
		private var _instructions:Instructions;
		private var _bathroomLevel:BathroomLevel;
		private var _kitchenLevel:KitchenLevel;
		
		public function sleepWalker()
		{
			trace("Game has started up!!");
			_instructions = new Instructions(stage);
			_bathroomLevel = new BathroomLevel(stage);
			// _kitchenLevel = new KitchenLevel(stage);
			//stage.addChild(_bathroomLevel);
			stage.addChild(_instructions);
			stage.addEventListener("startLevelOne", startLevelHandler);
			
			stage.addEventListener("restartLevelOne", resetLevelHandler);
		}

		private function startLevelHandler(event:Event):void	
		{
			trace("Application class: Start stage!");
			stage.removeChild(_instructions);
			_instructions = null;
			
			_bathroomLevel = new BathroomLevel(stage);
			stage.addChild(_bathroomLevel);
			
			if(_instructions == null)
			{
			trace("Instructions is null");
			}
			
		}
		
		private function resetLevelHandler(event:Event):void	
		{
			trace("Application class: Reset stage!");
			stage.removeChild(_bathroomLevel);
			_bathroomLevel = null;
			
			_bathroomLevel = new BathroomLevel(stage);
			stage.addChild(_bathroomLevel);
			
			/*
			if(_bathroomLevel == null)
			{
				trace("Bathroom Level is null");
			}
			*/
			
		}
		
	}
}