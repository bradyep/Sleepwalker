package
{
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class Utilities
	{
		public function Utilities()
		{
		}
		
		public static function pause(interval:int, functionToCall:Function):void {
			var timer:Timer = new Timer(interval);
			timer.addEventListener(TimerEvent.TIMER, callFunction, false, 0, true);
			timer.start();
			function callFunction(event:TimerEvent):void {
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER, callFunction);
				timer = null;
				functionToCall();               
			}
		}
		
	}
}