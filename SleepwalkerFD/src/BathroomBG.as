package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class BathroomBG extends Sprite
	{
		//Embed the gameObject image
		[Embed(source="../images/bathroomBG.png")]
		private var BackgroundImage:Class;
		private var _backgroundImage:DisplayObject = new BackgroundImage();
		private var _background:Sprite = new Sprite();
		
		public function BathroomBG()
		{
			_background.addChild(_backgroundImage);
			this.addChild(_background);
		}
	}
}
