package lib
{
	import delegates.IForListItem;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	public class ListItem extends Sprite
	{
		private var _hasChild:Boolean = false;
		private var _childData:Object;
		private var _label:TextField;
		private var _size:Size;
		private var _background:Shape;
		public var delegate:IForListItem;
		public function ListItem(size:Size, str:String)
		{
			super();
			
			_size = size;
			draw();
			
			_label = new TextField();
			_label.selectable = false;
			_label.mouseEnabled = false;
			_label.autoSize = TextFieldAutoSize.LEFT;
			_label.text = str.length > 10 ? str.substr(0, 8) + "..." : str;
			addChild(_label);
			_label.x = (_size.width - _label.textWidth) / 2;
			_label.y = (_size.height - _label.textHeight) / 2;
			
			if(_hasChild){
				// 添加向右的箭头
			}
			
			this.mouseChildren = false;
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			addEventListener(Event.REMOVED_FROM_STAGE, dealloc);
		}
		
		private function dealloc(event:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, dealloc);
			removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			_background = null;
			_childData = null;
			_label = null;
			_size = null;
		}
		
		protected function onMouseOut(event:MouseEvent):void
		{
			_background.alpha = 0;
		}
		
		protected function onMouseOver(event:MouseEvent):void
		{
			_background.alpha = 1;
			if(delegate) delegate.showChildList();
		}
		
		private function draw():void
		{
			if(!_background) _background = new Shape();
			_background.graphics.beginFill(0x000000, 1.0);
			_background.graphics.drawRect(0, 0, _size.width, _size.height);
			_background.graphics.endFill();
			_background.alpha = 0;
			addChildAt(_background, 0);
		}
		
		public function get childData():Object
		{
			return _childData;
		}

		public function set childData(value:Object):void
		{
			_childData = value;
		}

		public function get hasChild():Boolean
		{
			return _hasChild;
		}

		public function set hasChild(value:Boolean):void
		{
			_hasChild = value;
		}

	}
}