package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class SleepIcon extends Sprite
	{
		// Embed the image
		[Embed(source="../images/sleepIcon.png")]
		private var SleepIconImage:Class;
		
		// Public properties
		
		// Private properties
		private var _sleepIconImage:DisplayObject = new SleepIconImage();
		private var _sleepIcon:Sprite = new Sprite();
		
		public function SleepIcon()
		{
			// Display the image in this class
			_sleepIcon.addChild(_sleepIconImage);
			//Add the game object to this class
			this.addChild(_sleepIcon);	
		}
		
	}
}