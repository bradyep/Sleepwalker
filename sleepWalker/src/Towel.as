package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class Towel extends Sprite
	{
		// Embed the image
		[Embed(source="../images/towel.png")]
		private var TowelImage:Class;
		
		// Public properties
		public var commonName:String = "towel";
		public var collidable:Boolean = false;
		public var usableOnStage:Boolean = true;
		public var carriable:Boolean = true;
		public var approachText:String = "A towel is resting here.";
		public var examineText:String = "It's a towel.";
		public var isContainer:Boolean = false;
		
		// Private properties
		private var _towelImage:DisplayObject = new TowelImage();
		private var _towel:Sprite = new Sprite();
		
		public function Towel()
		{
			// Display the image in this class
			_towel.addChild(_towelImage);
			//Add the game object to this class
			this.addChild(_towel);	
		}
		
		public function useObjectOnStage():String
		{
			return "You dry yourself off a bit.";
			// trace("The sink is being used!");
		}
		
		public function useObjectFromInventory(objParamter:Object = null):String
		{
			var returnString:String;
			if (objParamter == null)
			{
				returnString = "You dry yourself off a bit with the towel you are holding.";
			}
			else
			{
				if (objParamter.commonName == "bathtub")
				{
					returnString = "You place the towel inside of the bathtub. It fits neatly and may even provide some traction while showering.";
				}
				else
				{
					returnString = "You tried combining the " + this.commonName + " with the " + objParamter.commonName + ".";	
				}
				
			}
			return returnString;
		}
		
	}
}