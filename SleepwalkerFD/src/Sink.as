package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class Sink extends Sprite
	{
		// Embed the image
		[Embed(source="../images/sink.png")]
		private var SinkImage:Class;
		
		// Public properties
		public var commonName:String = "sink";
		public var collidable:Boolean = true;
		public var usableOnStage:Boolean = true;
		public var carriable:Boolean = false;
		public var approachText:String = "A sink is built into this bathroom cabinet.";
		public var examineText:String = "A fine porcelain sink";
		public var isContainer:Boolean = false;
		
		// Private properties
		private var _sinkImage:DisplayObject = new SinkImage();
		private var _sink:Sprite = new Sprite();
		
		public function Sink()
		{
			// Display the image in this class
			_sink.addChild(_sinkImage);
			//Add the game object to this class
			this.addChild(_sink);	
		}
		
		public function useObjectOnStage():String
		{
			return "You turn on the sink for a while and watch water pour down the drain.";
			// trace("The sink is being used!");
		}
		
	}
}