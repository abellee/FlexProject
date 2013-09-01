package
{
	import flash.events.Event;
	
	public class CustomEvent extends Event
	{
		public static const CLOSE_PANEL:String = "close_panel";
		public function CustomEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}