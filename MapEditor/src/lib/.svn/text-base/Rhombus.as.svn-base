package lib
{
	import flash.display.Sprite;
	
	public class Rhombus extends Sprite
	{
		private var _width:Number;
		private var _height:Number;
		private var _type:String;
		public function Rhombus(w:Number, h:Number, type:String = "normal")
		{
			super();
			
			_width = w;
			_height = h;
			_type = type;
			
			draw();
		}
		
		public function get type():String
		{
			return _type;
		}

		public function set type(value:String):void
		{
			_type = value;
		}

		private function draw():void
		{
			this.graphics.clear();
			this.graphics.lineStyle(1, 0xFFFFFF);
			switch(_type)
			{
				case RhombusType.NORMAL:
					this.graphics.moveTo(_width / 2, 0);
					this.graphics.lineTo(_width, _height / 2);
					this.graphics.lineTo(_width / 2, _height);
					this.graphics.lineTo(0, _height / 2);
					this.graphics.lineTo(_width / 2, 0);
					break;
				case RhombusType.SHADOWN:
					this.graphics.beginFill(0xFF0000, .5);
					this.graphics.moveTo(_width / 2, 0);
					this.graphics.lineTo(_width, _height / 2);
					this.graphics.lineTo(_width / 2, _height);
					this.graphics.lineTo(0, _height / 2);
					this.graphics.lineTo(_width / 2, 0);
					this.graphics.endFill();
					break;
				case RhombusType.UNWALKABLE:
					this.graphics.moveTo(_width / 2, 0);
					this.graphics.lineTo(_width, _height / 2);
					this.graphics.lineTo(_width / 2, _height);
					this.graphics.lineTo(0, _height / 2);
					this.graphics.lineTo(_width / 2, 0);
					this.graphics.lineTo(_width / 2, _height);
					this.graphics.moveTo(0, _height / 2);
					this.graphics.lineTo(_width, _height / 2);
					break;
			}
		}
		public function clone():Rhombus
		{
			return new Rhombus(_width, _height, _type);
		}
	}
}