package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class MedicineCabinet extends Sprite
	{
		// Embed the images
		[Embed(source="../images/medicineCabinetClosed.png")]
		private var MedicineCabinetClosedImage:Class;
		[Embed(source="../images/medicineCabinetOpen.png")]
		private var MedicineCabinetOpenImage:Class;
		
		// Public properties
		public var isOpen:Boolean = false;
		
		public var commonName:String = "medicineCabinet";
		public var collidable:Boolean = true;
		public var usableOnStage:Boolean = true;
		public var carriable:Boolean = false;
		public var approachText:String = "It's a medicine cabinet. It is currently closed.";
		// public var examineText:String = "A fine porcelain medicine cabinet";
		public var isContainer:Boolean = false;
		
		// The object that this container holds
		public var objectHeld:Object;
		
		// Private properties
		private var _medicineCabinetClosedImage:DisplayObject = new MedicineCabinetClosedImage();
		private var _medicineCabinetClosed:Sprite = new Sprite();
		private var _medicineCabinetOpenImage:DisplayObject = new MedicineCabinetOpenImage();
		private var _medicineCabinetOpen:Sprite = new Sprite();
		
		private var _pills:Pills;
		
		// CONSTRUCTOR
		public function MedicineCabinet()
		{
			// Display the image in this class
			_medicineCabinetClosed.addChild(_medicineCabinetClosedImage);
			//Add the game object to this class
			this.addChild(_medicineCabinetClosed);
			
			_medicineCabinetOpen.addChild(_medicineCabinetOpenImage);
			this.addChild(_medicineCabinetOpen);
			_medicineCabinetOpen.visible = false;
			
			// Create the sleeping pills object here and place it in objectHeld
			_pills = new Pills();
			objectHeld = _pills; 
		}
		
		// Public methods
		public function useObjectOnStage():String
		{
			if (!isOpen)
			{
				var returnString:String;
				_medicineCabinetOpen.visible = true;
				_medicineCabinetClosed.visible = false;
				isOpen = true;
				isContainer = true; // The medicine cabinet works as a container, but only when it is open
				returnString = "You opened the medicine cabinet. "
				if (objectHeld == null)
				{
					approachText = "An empty medicine cabinet.";
				}
				else
				{
					approachText = "An open medicine cabinet. Inside you can find " + objectHeld.commonName + ".";	
				}
				// Check to see if there are any items in this container
				if (objectHeld != null)
				{
					returnString += "There is an item in the cabinet: " + objectHeld.commonName + ". If your inventory is empty you can pick them up by pressing X."; 
				}
				
				return returnString;
			}
			else
			{
				_medicineCabinetOpen.visible = false;
				_medicineCabinetClosed.visible = true;
				isOpen = false;
				isContainer = false; // A closed cabinet cannot be used as a container
				approachText = "It's a medicine cabinet. It is currently closed."
				return "You closed the medicine cabinet.";
			}
		} // End of function useObjectOnStage()
		
		// Only run this when we know the characters inventory slot is open
		public function returnObjectHeld():Object
		{
			var tempObject:Object;
			tempObject = objectHeld; 
			objectHeld = null;
			return tempObject;
		}
		
		// Only run this when we know there is nothing held as storage by this object
		public function receiveObjectForStorage(objParameter:Object):void
		{
			if (objectHeld == null) {
				objectHeld = objParameter;	
			}
		}
		
	}
}