package lib
{
	import flash.display.Shape;
	import flash.display.Sprite;
	
	public class List extends Sprite
	{
		private var _width:Number = 0;
		private var _height:Number = 0;
		private var background:Shape;
		private var data:Object;
		private var items:Vector.<ListItem>;
		private var itemContainer:Sprite = new Sprite();
		private var itemHeight:Number = 30;
		public function List(w:Number, h:Number)
		{
			super();
			
			_width = w;
			_height = h;
			draw();
		}
		
		private function draw():void
		{
			if(!background) background = new Shape();
			background.graphics.clear();
			background.graphics.beginFill(0xaaaaaa);
			background.graphics.drawRoundRectComplex(0, 0, _width, _height, 0, 0, 5, 5);
			background.graphics.endFill();
			addChildAt(background, 0);
		}
		
		public function listItem(obj:Object):void
		{
			if(obj != data){
				data = obj;
				addChild(itemContainer);
				for(var key:String in data){
					var listItem:ListItem = new ListItem(new Size(_width, itemHeight), key);
					if(data[key]){
						listItem.hasChild = true;
						listItem.childData = data[key];
					}
					itemContainer.addChild(listItem);
					var num:Number = itemContainer.numChildren;
					listItem.x = 0;
					listItem.y = (num - 1) * itemHeight;
				}
			}
		}
	}
}