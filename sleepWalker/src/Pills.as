package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class Pills extends Sprite
	{
		// Embed the image
		[Embed(source="../images/pills.png")]
		private var PillsImage:Class;
		
		// Public properties
		public var commonName:String = "sleeping pills";
		public var collidable:Boolean = false;
		public var usableOnStage:Boolean = false;
		public var carriable:Boolean = true;
		public var approachText:String = "You spot some sleeping pills.";
		// public var examineText:String = "It's a pills.";
		public var isContainer:Boolean = false;
		
		// Private properties
		private var _pillsImage:DisplayObject = new PillsImage();
		private var _pills:Sprite = new Sprite();
		
		public function Pills()
		{
			// Display the image in this class
			_pills.addChild(_pillsImage);
			//Add the game object to this class
			this.addChild(_pills);	
		}
		
		public function useObjectFromInventory(objParamter:Object = null):String
		{
			var returnString:String;
			if (objParamter == null)
			{
				return "You take a couple of sleeping pills. Suddenly you feel very drozy.";
				// Run the fallAsleep() method ... which we can't do with this architecture ... 
				
			}
			else
			{
				// Check to see if the parameter was the toilet, sink or bathtub
				if (objParamter.commonName == "toilet") {
					returnString = "You flush the sleeping pills down the toilet. They are gone for good now.";
				}
				else if (objParamter.commonName == "sink") {
					returnString = "You pour all of the sleeping pills into the sink. They are gone for good now.";
				}
				else if (objParamter.commonName == "bathtub") {
					returnString = "You pour all of the sleeping pills into the bathtub drain. They are gone for good now.";
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