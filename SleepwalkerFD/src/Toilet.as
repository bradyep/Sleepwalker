package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class Toilet extends Sprite
	{
		// Embed the image
		[Embed(source="../images/toilet.png")]
		private var ToiletImage:Class;
		
		// Public properties
		public var commonName:String = "toilet";
		public var collidable:Boolean = true;
		public var usableOnStage:Boolean = true;
		public var carriable:Boolean = false;
		public var approachText:String = "It's a toilet.";
		public var examineText:String = "A fine porcelain toilet";
		public var isContainer:Boolean = false;
		
		// Private properties
		private var _toiletImage:DisplayObject = new ToiletImage();
		private var _toilet:Sprite = new Sprite();
		
		public function Toilet()
		{
			// Display the image in this class
			_toilet.addChild(_toiletImage);
			//Add the game object to this class
			this.addChild(_toilet);	
		}
		
		public function useObjectOnStage():String
		{
			return "You pull the handle and flush the toilet. Everything seems to be in working order here.";
			// trace("The toilet is being used!");
		}
		
	}
}