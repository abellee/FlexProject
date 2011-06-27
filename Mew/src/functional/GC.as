package functional
{
	import flash.net.LocalConnection;

	public class GC
	{
		public function GC()
		{
		}
		public static function gc():void{
			
			try{
				new LocalConnection().connect("foo");
				new LocalConnection().connect("foo");
			}catch(error:Error)
			{}
			
		}
	}
}