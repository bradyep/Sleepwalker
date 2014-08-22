package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class DrainPlug extends Sprite
	{
		// Embed the image
		[Embed(source="../images/drainPlug.png")]
		private var DrainPlugImage:Class;
		
		// Public properties
		public var commonName:String = "bathtub drain plug";
		public var collidable:Boolean = false;
		public var usableOnStage:Boolean = false;
		public var carriable:Boolean = true;
		public var approachText:String = "A bathrub drain plug lies here inconspicuously.";
		// public var examineText:String = "It's a drainPlug.";
		public var isContainer:Boolean = false;
		
		// Private properties
		private var _drainPlugImage:DisplayObject = new DrainPlugImage();
		private var _drainPlug:Sprite = new Sprite();
		
		public function DrainPlug()
		{
			// Display the image in this class
			_drainPlug.addChild(_drainPlugImage);
			//Add the game object to this class
			this.addChild(_drainPlug);	
		}
		
		public function useObjectFromInventory(objParamter:Object = null):String
		{
			if (objParamter == null)
			{
				return "You fiddle around with the drain plug in your hands for a short while.";
			}
			else
			{
				return "You tried combining the " + this.commonName + " with the " + objParamter.commonName + ".";
			}
		}
		
	}
}