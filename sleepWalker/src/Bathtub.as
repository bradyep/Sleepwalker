package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class Bathtub extends Sprite
	{
		// Embed the image
		[Embed(source="../images/bathtub.png")]
		private var BathtubImage:Class;
		
		// Public properties
		public var commonName:String = "bathtub";
		public var collidable:Boolean = true;
		public var usableOnStage:Boolean = true;
		public var carriable:Boolean = false;
		public var approachText:String = "It's a bathtub.";
		public var examineText:String = "A fine porcelain bathtub";
		public var isContainer:Boolean = true;
		
		public var hasTraction:Boolean = false;
		
		// The object that this container holds
		public var objectHeld:Object;
		
		// Private properties
		private var _bathtubImage:DisplayObject = new BathtubImage();
		private var _bathtub:Sprite = new Sprite();
		
		private var _drainPlug:DrainPlug;
		
		// Constructor
		public function Bathtub()
		{
			// Display the image in this class
			_bathtub.addChild(_bathtubImage);
			//Add the game object to this class
			this.addChild(_bathtub);
			
			// Create the bathtub drain plug object here and place it in objectHeld
			_drainPlug = new DrainPlug();
			objectHeld = _drainPlug;
			
			// Make the approach string point out that there is a drain plug in there.
			approachText = "A fine porcelain bathtub with a shower head above it. There is a drain plug that could be taken with a little bit of effort (press X while not holding anything).";
		}
		
		// PUBLIC METHODS
		public function useObjectOnStage():String
		{
			return "You mess around with the faucet long enough to see that everything seems to work.";
			// trace("The bathtub is being used!");
		}
		
		// Only run this when we know the characters inventory slot is open
		public function returnObjectHeld():Object
		{
			var tempObject:Object;
			tempObject = objectHeld; 
			objectHeld = null;
			approachText = "A fine porcelain bathtub with a shower head above it. ";
			return tempObject;
		}
		
		// Only run this when we know there is nothing held as storage by this object
		// Consider not allowing this method to do anything, since both placing a tower in it and using a towel with it is weird.
		public function receiveObjectForStorage(objParameter:Object):void
		{
			if (objectHeld == null) {
				objectHeld = objParameter;	
			}
		}
		
	}
}