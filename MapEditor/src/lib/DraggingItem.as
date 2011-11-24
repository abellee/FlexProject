package lib
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.utils.ByteArray;
	
	public class DraggingItem extends Sprite
	{
		private var _data:Object;
		private var _extension:String;
		public var bitmap:Bitmap;
		private var isImage:Boolean = false;
		public function DraggingItem()
		{
			super();
			
			this.mouseChildren = false;
			this.mouseEnabled = false;
			addEventListener(Event.REMOVED_FROM_STAGE, dealloc);
		}
		
		protected function dealloc(event:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, dealloc);
			_data = null;
			_extension = null;
			bitmap.bitmapData.dispose();
			bitmap = null;
		}
		
		public function get extension():String
		{
			return _extension;
		}

		public function set extension(value:String):void
		{
			_extension = value;
		}

		public function get data():Object
		{
			return _data;
		}

		public function set data(value:Object):void
		{
			_data = value;
			if(_data is File){
				switch((_data as File).extension){
					case "png":
						_extension = Extensions.PNG;
						isImage = true;
						break;
					case "jpg":
						_extension = Extensions.JPG;
						isImage = true;
						break;
					case "gif":
						_extension = Extensions.GIF;
						isImage = true;
						break;
					case "swf":
						_extension = Extensions.SWF;
						isImage = true;
						break;
				}
			}
			if(isImage)
				loadImage();
		}
		
		private function loadImage():void
		{
			var file:File = _data as File;
			var func:Function = function(event:Event):void
			{
				file.removeEventListener(Event.COMPLETE, func);
				var ba:ByteArray = file.data;
				var loader:Loader = new Loader();
				var f:Function = function(evt:Event):void
				{
					loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, f);
					bitmap = evt.target.content as Bitmap;
					addChild(bitmap);
					bitmap.alpha = .5;
				};
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, f);
				loader.loadBytes(ba);
			};
			file.addEventListener(Event.COMPLETE, func);
			file.load();
		}
		
	}
}