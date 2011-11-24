package lib
{
	public class Size
	{
		private var _width	:Number	= 0;
		private var _height	:Number	= 0;
		public function Size(wvalue:Number = 0, hvalue:Number = 0)
		{
			_width = wvalue;
			_height = hvalue;
		}
		
		public function set width(value:Number):void
		{
			if(_width != value) _width = value;
		}
		
		public function get width():Number
		{
			return _width;
		}
		
		public function set height(value:Number):void
		{
			if(_height != value) _height = value;
		}
		
		public function get height():Number
		{
			return _height;
		}
		
		public function isEqual(size:Size):Boolean
		{
			return size && size.width == _width && size.height == _height;
		}
		
		public function toString():String
		{
			return "width: " + _width + " ***** height:" + _height;
		}
	}
}