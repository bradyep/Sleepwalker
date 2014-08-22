package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class Door extends Sprite
	{
		// Embed the image
		[Embed(source="../images/doorClosed.png")]
		private var DoorImage:Class;
		[Embed(source="../images/doorOpen.png")]
		private var DoorOpenImage:Class;
		
		// Public properties
		public var commonName:String = "door";
		public var collidable:Boolean = true;
		public var usableOnStage:Boolean = true;
		public var carriable:Boolean = false;
		public var approachText:String = "This door leads to another room in the house.";
		// public var examineText:String = "It's a door.";
		public var isContainer:Boolean = false;
		public var isGateway:Boolean = false;
		
		// Private properties
		private var _doorImage:DisplayObject = new DoorImage();
		private var _door:Sprite = new Sprite();
		
		private var _doorOpenImage:DisplayObject = new DoorOpenImage();
		private var _doorOpen:Sprite = new Sprite();
		
		public function Door()
		{
			// Display the image in this class
			_door.addChild(_doorImage);
			//Add the game object to this class
			this.addChild(_door);	
			
			_doorOpen.addChild(_doorOpenImage);
			this.addChild(_doorOpen);
			_doorOpen.visible = false;
		}
		
		/*
		public function changeToGateway():void
		{
			isGateway = true;
			
		}
		*/
		
		public function useObjectOnStage():String
		{
			var returnString:String;
			if (isGateway)
			{
				_doorOpen.visible = true;
				_door.visible = false;
				returnString = "The door opens up.";
			}
			else
			{
				returnString = "You attempt to turn the handle with all your might, but this door won't budge. If you can survive through the night, this door may no longer be an obstacle.";	
			}
			return returnString;
		}
		
	}
}