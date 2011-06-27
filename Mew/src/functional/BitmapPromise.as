package functional
{
	
	import flash.desktop.IFilePromise;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.ErrorEvent;
	import flash.utils.ByteArray;
	import flash.utils.IDataInput;
	
	import mx.graphics.codec.JPEGEncoder;
	
	public class BitmapPromise implements IFilePromise
	{
		public var bmp:BitmapData;
		private var name:String = "";
		
		public function BitmapPromise(_bmp:BitmapData, _name:String)
		{
			bmp = _bmp;
			name = _name;
		}
		
		public function get relativePath():String
		{
			return name + ".jpg";
		}
		
		public function get isAsync():Boolean
		{
			return false;
		}
		
		public function open():IDataInput
		{
			var jpg:JPEGEncoder = new JPEGEncoder(80);
			var ba:ByteArray = jpg.encode(bmp);
			ba.position = 0;
			return ba;
		}
		
		public function close():void
		{
		}
		
		public function reportError(e:ErrorEvent):void
		{
		}
	}
}