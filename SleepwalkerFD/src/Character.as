package
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	
	public class Character extends Sprite
	{
		// Embed the image
		// [Embed(source="../images/character.png")]
		// private var CharacterImage:Class;
		
		// Private properties
		// private var _characterImage:DisplayObject = new CharacterImage();
		private var _character:Sprite = new Sprite();
		private var square:Shape = new Shape();
		
		// Public properties
		public var vx:Number = 0;
		public var vy:Number = 0;
		
		public var isDead:Boolean = false;
		
		public function Character()
		{
			// Display the image in this class
			// _character.addChild(_characterImage);
			this.addChild(_character);
			drawSquare();
		}
		
		private function drawSquare():void
		{
			square.graphics.beginFill(0xFF0000);
			square.graphics.drawRect(0, 0, 50, 50);
			square.graphics.endFill();
			_character.addChild(square);
		}
	}
}
