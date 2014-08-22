package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class Hairdryer extends Sprite
	{
		// Embed the image
		[Embed(source="../images/hairdryer.png")]
		private var HDImage:Class;
		
		// Public properties
		public var commonName:String = "hairdryer";
		public var collidable:Boolean = false;
		public var usableOnStage:Boolean = false;
		public var carriable:Boolean = true;
		public var approachText:String = "A battery operated hairdryer rests here.";
		public var examineText:String = "Battery operated, how convenient.";
		public var isContainer:Boolean = false;
		
		// Private properties
		private var _hdImage:DisplayObject = new HDImage();
		private var _hairdryer:Sprite = new Sprite();
		
		public function Hairdryer()
		{
			// Display the image in this class
			_hairdryer.addChild(_hdImage);
			//Add the game object to this class
			this.addChild(_hairdryer);	
		}
		
		public function useObjectFromInventory(objParamter:Object = null):String
		{
			if (objParamter == null)
			{
				return "You pull the trigger and unleash the warmth of the hair dryer.";
			}
			else
			{
				return "You tried combining the " + this.commonName + " with the " + objParamter.commonName + ".";
			}
		}
		
	}
}