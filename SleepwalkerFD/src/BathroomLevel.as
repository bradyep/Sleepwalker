package
{
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import fl.transitions.easing.*;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.geom.ColorTransform;
	import flash.text.*;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	
	public class BathroomLevel extends Sprite
	{
		// --VARIABLES--
		
		// Gameplay variables
		public var walkspeed:Number = 2;
		public var sleepWalkspeed:Number = 1;
		public var sleepTimerStartValue:int = 45;
		public var nightFilter:Shape = new Shape();
		public var closeObject:Object;
		public var charHasRecentlyMoved:Boolean = false;
		public var gameObjectHeld:Object; 
		
		//Create the text objects
		public var format:TextFormat = new TextFormat();
		public var output:TextField = new TextField();
		public var zExplanation:TextField = new TextField();
		public var xExplanation:TextField = new TextField();
		public var rExplanation:TextField = new TextField();
		public var sleepExplanation:TextField = new TextField();
		public var sleepCountdown:TextField = new TextField();
		public var spaceExplanation:TextField = new TextField();
		public var restartExplanation:TextField = new TextField();
		
		// Declare the variables to hold the game objects
		private var _character:Character;
		private var _bathroomBG:BathroomBG;
		private var _allGameObjects:Array = new Array();
		private var _sink:Sink;
		private var _hairdryer:Hairdryer; 
		private var _towel:Towel;
		private var _toilet:Toilet;
		private var _bathtub:Bathtub;
		private var _medicineCabinet:MedicineCabinet;
		private var _door:Door;
		private var _sleepIcon:SleepIcon;
		
		// Timers
		private var _fallAsleepTimer:Timer;
		
		// A variable to store the reference to the stage from the application class
		private var _stage:Object;
		
		
		// --CONSTRUCTOR--
		public function BathroomLevel(stage:Object)
		{
			_stage = stage;	
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private function addedToStageHandler(event:Event):void
		{
			startGame(); // We don't want to start the game until this class (a sprite) has been added to the stage.
			this.removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		
		// --GAME INIT FUNCTIONS--
		private function startGame():void
		{
			createGameObjects();
			setupTextfields();
			setupEventListeners();
		}
		
		private function createGameObjects():void
		{
			// Create the game objects
			_character = new Character();
			_bathroomBG = new BathroomBG();
			_sink = new Sink();
			_allGameObjects.push(_sink);
			_hairdryer = new Hairdryer();
			_allGameObjects.push(_hairdryer);
			_towel = new Towel();
			_allGameObjects.push(_towel);
			_toilet = new Toilet();
			_allGameObjects.push(_toilet);
			_bathtub = new Bathtub();
			_allGameObjects.push(_bathtub);
			_medicineCabinet = new  MedicineCabinet();
			_allGameObjects.push(_medicineCabinet);
			_door = new  Door();
			_allGameObjects.push(_door);
			_sleepIcon = new  SleepIcon();
			// _allGameObjects.push(_sleepIcon); // We will never need to find this in the array
			
			// Add the game objects to the stage
			addGameObjectToLevel(_bathroomBG, 0, 0);
			addGameObjectToLevel(_character, 250, 300);
			addGameObjectToLevel(_sink, 250, 50);
			addGameObjectToLevel(_hairdryer, 340, 75);
			addGameObjectToLevel(_towel, 250, 350);
			addGameObjectToLevel(_toilet, 90, 50);
			addGameObjectToLevel(_bathtub, 425, 50);
			addGameObjectToLevel(_medicineCabinet, 180, 50);
			addGameObjectToLevel(_door, 0, 165);
			addGameObjectToLevel(_sleepIcon, 310, 410);
			
			// Create the "night filter"
			nightFilter.graphics.beginFill(0x0000FF);
			nightFilter.graphics.drawRect(0, 0, 550, 400);
			nightFilter.graphics.endFill();
			_stage.addChild(nightFilter);
			nightFilter.x = 0;
			nightFilter.y = 0;
			nightFilter.alpha = .4;
			nightFilter.visible = false;
			
			// Initialize the timers
			_fallAsleepTimer = new Timer(1000);
			_fallAsleepTimer.addEventListener(TimerEvent.TIMER, sleepCountdownHandler);
			_fallAsleepTimer.start();
		}
		
		private function setupTextfields():void
		{
			//Set the text format object
			format.font = "Helvetica";
			format.size = 12;
			format.color = 0xFFFFFF;
			format.align = TextFormatAlign.LEFT;
			
			//Configure the output text field	
			output.defaultTextFormat = format;
			output.width = 240;
			output.height = 140;
			output.autoSize = TextFieldAutoSize.LEFT;
			output.border = true;
			output.borderColor = 0xFF0000;
			output.wordWrap = true;
			output.text = "Day 1. You wake up in a bathroom.";

			//Display and position the output text field
			this.addChild(output);
			output.x = 5;
			output.y = 405;
			
			// Configure and display the zExplanation text field
			zExplanation.defaultTextFormat = format;
			zExplanation.text = "Z";
			this.addChild(zExplanation);
			zExplanation.x = 270;
			zExplanation.y = 405;
			
			// Configure and display the xExplanation text field
			xExplanation.defaultTextFormat = format;
			xExplanation.text = "X";
			this.addChild(xExplanation);
			xExplanation.x = 270;
			xExplanation.y = 465;
			
			
			// Configure and display the rExplanation text field
			rExplanation.defaultTextFormat = format;
			rExplanation.text = "R";
			this.addChild(rExplanation);
			rExplanation.x = 330;
			rExplanation.y = 405;
			
			// Configure and display the spaceExplanation text field
			spaceExplanation.defaultTextFormat = format;
			spaceExplanation.text = "Space:";
			this.addChild(spaceExplanation);
			spaceExplanation.x = 258;
			spaceExplanation.y = 480;
			
			// Configure and display the sleepExplanation text field
			sleepExplanation.defaultTextFormat = format;
			sleepExplanation.text = "Time Until Sleep: ";
			this.addChild(sleepExplanation);
			sleepExplanation.x = 380;
			sleepExplanation.y = 475;
			
			// Configure and display the sleepTimer text field
			sleepCountdown.defaultTextFormat = format;
			sleepCountdown.text = String(sleepTimerStartValue);
			this.addChild(sleepCountdown);
			sleepCountdown.x = 490;
			sleepCountdown.y = 475;
			
			// Configure and display the restartExplanation text field
			restartExplanation.defaultTextFormat = format;
			restartExplanation.text = "PRESS R TO RESTART";
			this.addChild(restartExplanation);
			restartExplanation.x = 5;
			restartExplanation.y = 482;
			restartExplanation.width = 240;
			restartExplanation.visible = false;
			
			// Draw a shape for the heart monitor
			/*
			var square:Shape = new Shape();
			square.graphics.beginFill(0xFF0000);
			square.graphics.drawRect(0, 0, 150, 50);
			square.graphics.endFill();
			this.addChild(square);
			square.x = 380;
			square.y = 410;
			*/
		}
		
		private function setupEventListeners():void
		{
			//Event listeners
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			_stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler); 
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);	
		}
		
		
		// --MISC GAME FUNCTIONS--
		
		private function addGameObjectToLevel(gameObject:Sprite, xPos:int, yPos:int):void
		{
			this.addChild(gameObject);
			gameObject.x = xPos;
			gameObject.y = yPos;
		}
		
		private function checkStageBoundaries(gameObject:Sprite):void
		{
			if (gameObject.x < 50)
			{
				gameObject.x = 50;
			}
			if (gameObject.y < 50)
			{
				gameObject.y = 50;
			}
			if (gameObject.x + gameObject.width > _stage.stageWidth - 50)
			{
				gameObject.x = _stage.stageWidth - gameObject.width - 50;
			}
			if (gameObject.y + gameObject.height > _stage.stageHeight - 150)
			{
				gameObject.y = _stage.stageHeight - gameObject.height - 150;
			}
		}
		
		private function fallAsleep():void
		{
			// Stop the sleep countdown timer
			_fallAsleepTimer.reset();
			_fallAsleepTimer.stop();
			sleepCountdown.text = "";
			// Hide all UI elements that denote interactivity
			spaceExplanation.visible = false;
			zExplanation.visible = false;
			xExplanation.visible = false;
			rExplanation.visible = false;
			_sleepIcon.visible = false;
			// Disable player input by killing off the keyboard event listeners and stop player movement
			_stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			_stage.removeEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			_character.vx = 0;
			_character.vy = 0;
			
			output.text = "You begin to feel very sleepy ... ";
			// Make a cool tween
			var ct2:ColorTransform = new ColorTransform();
			ct2.color = 0x000000; // black
			nightFilter.transform.colorTransform = ct2;
			nightFilter.visible = true;
			var nightTween:Tween = new Tween(nightFilter, "alpha", None.easeInOut, 0, 1, 180, false);
			nightTween.addEventListener(TweenEvent.MOTION_FINISH, onNightFinish);
		}
			
		private function onNightFinish(e:TweenEvent):void 
		{
			var ct3:ColorTransform = new ColorTransform();
			ct3.color = 0x0000FF; // blue
			nightFilter.transform.colorTransform = ct3;
			nightFilter.alpha = .3;
			sleepExplanation.text = "SLEEPWALKING";
			// Make the "night filter" covering the gameplay area of the stage visible
			nightFilter.visible = true;
			// Move the character slowly in some direction
			// _character.vx = -1.3;
			// _character.vy = -.8;
			
			// -SLEEPING PILLS-
			// First check your inventory for the pills
			output.text = "You suddenly have a craving for pills! You check your hands for them.";
			Utilities.pause(4000, checkHandsForPills);					
		}		
		
		private function checkHandsForPills():void 
		{
			// Check to see if the user has pills in their inventory
			if (gameObjectHeld != null) 
			{
				if (gameObjectHeld.commonName == "sleeping pills")
				{
					output.text = "You stuff all the pills in the bottle into your face. You died.";
					_character.isDead = true;
					endGame();
				}
				else
				{
					output.text = "You do not seem to have the sleeping pills in your hands.";
				}
			}
			else
			{
				output.text = "Your hands are empty.";
			}
			if (!_character.isDead)
			{
				Utilities.pause(3000, checkFieldForPills);	
			}
			
		}
		
		private function checkFieldForPills():void {
			output.text = "You look for pills in the room.";
			Utilities.pause(3000, checkFieldForPills2);
		}
		
		private function checkFieldForPills2():void {
			// Look for pills in _allGameObjects 
			for (var i:int=1;i < _allGameObjects.length;i++)
			{
				if (_allGameObjects[i].commonName == "sleeping pills") {
					// trace("We found pills in the _allGameObjects array."); 
					// Check to see if its y value is between 0 and 400, if it is then it is in the field of gameplay
					if (_allGameObjects[i].y >= 0 && _allGameObjects[i].y <= 400) {
						// Move character to pills with the sleepWalkspeed variable 
						_character.x = _allGameObjects[i].x;
						_character.y = _allGameObjects[i].y;
						output.text = "You found the pills in the room! You stuff all the pills in the bottle into your face. You died.";
						_character.isDead = true;
						endGame();
					}
				}
			} // End of for loop
			if (!_character.isDead)
			{
				output.text =  "You could not find any pills in the room.";
				Utilities.pause(3000, checkCabinetForPills);
			}
			
		}
		
		private function checkCabinetForPills():void {
			output.text = "You check the cabinet for the sleeping pills.";
			// _medicineCabinet, 180, 50);
			_character.x = 180;
			_character.y = 90;
			Utilities.pause(3000, checkCabinetForPills2);
		}
		
		private function checkCabinetForPills2():void {
			if (!_medicineCabinet.isOpen)
			{
				output.text = _medicineCabinet.useObjectOnStage();
				Utilities.pause(3000, checkCabinetForPills3);
			}
			else
			{
				checkCabinetForPills3();	
			}
		}
		
		private function checkCabinetForPills3():void {
			if (_medicineCabinet.objectHeld != null)
			{
				if (_medicineCabinet.objectHeld.commonName == "sleeping pills") {
					output.text = "You found the pills! You stuff all the pills from the bottle into your face at once. You died.";
					_character.isDead = true;
					endGame();
				}
				else
				{
					output.text = "You didn't find any pills in the cabinet. Now you feel like taking a shower";
				}
			}
			else {
				output.text = "You didn't find anything in the cabinet. Now you feel like taking a shower";
			}
			// Go to next function that handles the shower if we haven't died yet
			if (!_character.isDead) {
				Utilities.pause(5000, gotoShower);	
			}
			
		}
		
		private function gotoShower():void {
			output.text = "You turn on the shower and step in.";
			_character.x = 432;
			_character.y = 100;
			swapChildren(_character, _bathtub);
			swapChildren(_character, _towel);
			Utilities.pause(3000, checkShower);
		}
		
		private function checkShower():void {
			if (!_bathtub.hasTraction) {
				output.text = "Just as you start to get into the shower you slip, fall and crack your head open. You died.";
				_character.isDead = true;
				endGame();
			}
			else
			{
				output.text = "You step onto the towel in the bathtub and start to lather up. You then realize what you really want is a nice, relaxing bath.";
			}
			if (!_character.isDead)
			{
				Utilities.pause(5000, checkBath);
			}
		}
		
		private function checkBath():void {
			// Check to see if there is still a drain in the bathtub
			// output.text = "You start to lather up and then realize what you really want is a nice, relaxing bath.";
			// objectHeld
			output.text = "You turn the shower off and let the water pour from the faucet. All the while slipping into a peaceful slumber at the bottom of the tub.";
			Utilities.pause(7000, checkBath2);
		}
		
		private function checkBath2():void {
			// Need to check if this object even exists before we try and find out what it is
			if (_bathtub.objectHeld != null) {
				if (_bathtub.objectHeld.commonName == "bathtub drain plug")
				{
					output.text = "Even as the bathtub begins to completely overflow, you remain submerged at the bottom of the bathtub. Deprived of any oxygen, you drown to death.";
					_character.isDead = true;
				}
				else
				{
					output.text = "There is something in the tub, but it's not a drain plug. Without the drain plug, all of the water from the faucet eventually ends up in the drain, and you are free to continue to nod out lying at the bottom of a bath tub.";
				}
			}
			else
			{
				output.text = "Without the drain plug, all of the water from the faucet eventually ends up in the drain, and you are free to continue to nod out lying at the bottom of a bath tub.";
			}
			Utilities.pause(7000, endGame); // The game is over whether the player lived or died here.
		}
		
		private function endGame():void
		{
			if (_character.isDead) {
				// Make the screen red or something
				var ct1:ColorTransform = new ColorTransform();
				ct1.color = 0xFF0000; //red
				// nightFilter.transform.colorTransform(0xFF0000);
				nightFilter.transform.colorTransform = ct1;
				nightFilter.alpha = .3;
				restartExplanation.visible = true;
				// Allow restart
				_stage.addEventListener(KeyboardEvent.KEY_DOWN, endGameKeyDownHandler);
			}
			else
			{
				// The player won the game, wake them back up, and open the door
				nightFilter.visible = false;
				output.text = "You are once again awake.";
				sleepExplanation.text = "Awake";
				setupEventListeners();
				// Show the UI elements once again
				spaceExplanation.visible = true;
				zExplanation.visible = true;
				xExplanation.visible = true;
				rExplanation.visible = true;
				// Change the door
				_door.isGateway = true;
			}
		}
		
		private function onEndingFinish(e:TweenEvent):void
		{
			restartExplanation.text = "CONGRATULATIONS, YOU'VE WON";
			restartExplanation.visible = true;
			output.text = "The End";
		}
		
		// --EVENT HANDLERS--
		
		private function sleepCountdownHandler(event:TimerEvent):void
		{
			// Count down the timer and check to see if its time to fall asleep yet
			sleepCountdown.text = (int(sleepCountdown.text) - 1).toString();
			if (int(sleepCountdown.text) == 0)
			{
				// Call a function that does all the "sleep" stuff
				fallAsleep()
			}
		}
		
		private function enterFrameHandler(event:Event):void
		{	
			// Move the game character and check its stage boundaries
			_character.x += _character.vx; 
			_character.y += _character.vy;
			
			if (_character.vx != 0  || _character.vy != 0)
			{
				charHasRecentlyMoved = true;
			}
			else 
			{
				charHasRecentlyMoved = false;
			}
			
			if (charHasRecentlyMoved)
			{
				// If the character is moving, there is no closeObject, and nothing to interact with
				closeObject = null;
				spaceExplanation.text = "Space:";
				// If we are empty-handed we should not see 'use' set to the Z key
				if (gameObjectHeld == null)
				{
					zExplanation.text = "Z";
					xExplanation.text = "X";	
				}
			}
			
			if (charHasRecentlyMoved)
			{
				// Collision code - we should only have to run this if we have recently moved
				for (var i:int = 0; i < _allGameObjects.length; i++)
				{
					if (_allGameObjects[i].collidable)
					{
						Collision.block(_character, _allGameObjects[i]);
						// trace("collisionSide: " + Collision.collisionSide);
						if (Collision.collisionSide != "" && Collision.collisionSide != "No collision")
						{
							// The character must be colliding with some object
							closeObject = _allGameObjects[i];
						}
					}
					else if(_character.hitTestObject(_allGameObjects[i]))
					{
						closeObject = _allGameObjects[i];
					}
					if (closeObject != null)
					{
						// trace("closeObject: " + closeObject.toString());
						output.text = closeObject.approachText;
						// We only want to give the option to interact with a gameObject on the stage if it is (usableOnStage)
						if (closeObject.usableOnStage)
						{
							spaceExplanation.text = "Space: Interact";	
						}
						// Check to see if our close object is 'usableOnStage', if so display as so for the Z key
						/*
						if (closeObject.usableOnStage)
						{
							zExplanation.text = "Z - Use";
						}
						*/
						if (closeObject.carriable && gameObjectHeld == null)
						{
							xExplanation.text = "X - Pick Up";
						}
						if (closeObject.isContainer)
						{
							// Check to see if there is anything in the container and make sure our hands are empty
							if (closeObject.objectHeld != null && gameObjectHeld == null)
							{
								xExplanation.text = "X - Pick Up";	
							}
							
						}
					}
				} // End of for loop for collision code
			} // End of if charHasRecentlyMoved
			
			// Check stage boundaries
			checkStageBoundaries(_character);
		}
		
		private function keyDownHandler(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.LEFT)
			{
				_character.vx = -walkspeed;
			}
			else if (event.keyCode == Keyboard.RIGHT)
			{
				_character.vx = walkspeed;
			}
			else if (event.keyCode == Keyboard.UP)
			{
				_character.vy = -walkspeed;
			}
			else if (event.keyCode == Keyboard.DOWN)
			{
				_character.vy = walkspeed;
			}
			else if (event.keyCode == Keyboard.SPACE)
			{
				// If next to a gameObject and you can use that game object on the stage ... use it
				if (closeObject != null && closeObject.usableOnStage)
				{
					// trace("closeObject was not null and we pressed the space bar. The closeObject is: " + closeObject.toString());
					// Should probably have an interface called gameObject that has all the properties and methods my game objects will have
					var tempReturn:String = closeObject.useObjectOnStage();
					output.text = tempReturn;
					// Check for the end of the level
					if (tempReturn == "The door opens up.")
					{
						// Kill keyboard control, hide the character and tween us out of here with a game over
						_stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
						_stage.removeEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
						_character.visible = false;
						// Make a cool tween
						var ct3:ColorTransform = new ColorTransform();
						ct3.color = 0xFFFFFF; // white
						nightFilter.transform.colorTransform = ct3;
						nightFilter.visible = true;
						var endingTween:Tween = new Tween(nightFilter, "alpha", None.easeInOut, 0, 1, 180, false);
						endingTween.addEventListener(TweenEvent.MOTION_FINISH, onEndingFinish);
					}
				}
				else
				{
					output.text = "There is nothing here to interact with.";
				}
				 
			}
			
			else if (event.keyCode == Keyboard.R) {
				fallAsleep();
			}
			
			else if (event.keyCode == Keyboard.Z)
			{
				if (gameObjectHeld == null)
				{
					output.text = "You aren't holding anything.";
				}
				else
				{
					// We ARE holding something
					if (closeObject == null)
					{
						// No objects close by so just call the method without a parameter
						var anotherReturnMessage:String;
						anotherReturnMessage = gameObjectHeld.useObjectFromInventory();
						output.text = anotherReturnMessage
						// HACK
						if (anotherReturnMessage == "You take a couple of sleeping pills. Suddenly you feel very drozy.") {
							fallAsleep();
						}
					}
					else
					{
						// Combine the object on the stage next to us with what we are holding
						var returnMessage:String;
						returnMessage = gameObjectHeld.useObjectFromInventory(closeObject);
						output.text = returnMessage;
						// HACK: This is a hack for placing the towel into the bathtub
						if (returnMessage == "You place the towel inside of the bathtub. It fits neatly and may even provide some traction while showering.")
						{
							_bathtub.hasTraction = true;
							_towel.x = 432;
							_towel.y = 120;
							gameObjectHeld = null;
							// Need to run swapChildren on towel and bathtub
							swapChildren(_towel, _bathtub);
						}
						// HACK: This is a hack for making sure we kill off the sleeping pills object as needed.
						if (returnMessage == "You flush the sleeping pills down the toilet. They are gone for good now." || returnMessage == "You pour all of the sleeping pills into the sink. They are gone for good now." || returnMessage == "You pour all of the sleeping pills into the bathtub drain. They are gone for good now.")
						{
							// Find the stupid pills object so we can remove it from the screen
							for (var i:int=1;i < _allGameObjects.length;i++)
							{
								if (_allGameObjects[i].commonName == "sleeping pills")
								{
									this.removeChild(_allGameObjects[i]);
									_allGameObjects.splice(i,1);
								}
							}
							gameObjectHeld = null;
							// Need to remove the pills from the gamObject array as well as from our inventory screen
							
						}
					}
				}
			}
			
			else if (event.keyCode == Keyboard.X)
			{
				// Handle using X to pick things up
				if (closeObject != null && closeObject.carriable == true)
				{
					if (gameObjectHeld == null)
					{
						// trace("closeObject was not null, is carriable, we are not carrying anything, and we pressed the x key. The closeObject is: " + closeObject.toString());
						// Should probably have an interface called gameObject that has all the properties and methods my game objects will have
						// output.text = closeObject.examineText;
						// Move the object from the gameplay field into the players single inventory slot
						output.text = "You pick up the " + closeObject.commonName + ".";
						gameObjectHeld = closeObject;
						Sprite(closeObject).x = 270;
						Sprite(closeObject).y = 430;
						xExplanation.text = "X - Drop";
						zExplanation.text = "Z - Use";
					}
					else
					{
						output.text = "You cannot carry more than one object at a time. If you want to pick this item up then drop your current " +
							"item (preferably somewhere away from this object to keep things neat)."; 
					}
				}
				// Handle the player trying to pick up nothing or trying to pick up an uncarriable item
				else if ((closeObject == null && gameObjectHeld == null) || (closeObject != null && closeObject.carriable == false && gameObjectHeld == null && !closeObject.isContainer))
				{
					output.text = "There is nothing to pick up here.";
				}
				// Handle the player trying to grab an item from a container
				else if (closeObject != null && closeObject.carriable == false && gameObjectHeld == null && closeObject.isContainer)
				{
					// Try to GET the object from the container and add it to our inventory
					// trace("Attempting to grab an object from a container");
					// First check that there is anything inside the container
					if (closeObject.objectHeld != null)
					{
						gameObjectHeld = closeObject.returnObjectHeld();
						output.text = "You pick up the " + gameObjectHeld.commonName + ".";
						
						// Have to add this sprite to this class
						addGameObjectToLevel(Sprite(gameObjectHeld), 270, 430);
						_allGameObjects.push(gameObjectHeld);
						xExplanation.text = "X - Drop";
						zExplanation.text = "Z - Use";						
					}
					else
					{
						output.text = "There is nothing in this container to take.";
					}

				}
				// Handle using X to drop items
				else if (closeObject == null && gameObjectHeld != null)
				{
					output.text = "You dropped the " + gameObjectHeld.commonName + ".";
					Sprite(gameObjectHeld).x = _character.x;
					Sprite(gameObjectHeld).y = _character.y;
					gameObjectHeld = null;
					xExplanation.text = "X";
				}
				// Handle the player trying to drop an item while colliding with another object
				else if (closeObject != null && gameObjectHeld != null)
				{
					output.text = "You cannot drop an item so close to another item.";
				}
				
				
			} // End of else if the X key is pressed
		} // End of function keyDownHandler
		
		private function keyUpHandler(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.LEFT 
				|| event.keyCode == Keyboard.RIGHT)
			{
				_character.vx = 0;
			} 
			else if (event.keyCode == Keyboard.DOWN 
				|| event.keyCode == Keyboard.UP)
			{
				_character.vy = 0;
			}
		}
		
		// endGameKeyDownHandler
		private function endGameKeyDownHandler(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.R)
			{
				dispatchEvent(new Event("restartLevelOne", true));
			}
		}
		
	}
}
