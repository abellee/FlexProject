package
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.filesystem.File;

	public class ResData
	{
		public var className:String = "";
		public var annotation:String = "";
		public var packageName:String = "";
		public var imageType:int = 0;
		public var name:String = "";
		public var file:File;
		[Bindable]
		public var bp:Bitmap = null;
		[Bindable]
		public var skinIndex:int = 0;
		public function ResData()
		{
		}
		
		public function loadBitmap():void
		{
			file.addEventListener(Event.COMPLETE, fileLoad_completeHandler);
			file.load();
		}
		
		protected function fileLoad_completeHandler(event:Event):void
		{
			file.removeEventListener(Event.COMPLETE, fileLoad_completeHandler);
			var loader:Loader = new Loader();
			var func:Function = function(event:Event):void
			{
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, func);
				bp = event.target.content as Bitmap;
				EmbedResourceGenerator.instance.addBitmap();
			};
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, func);
			loader.loadBytes(file.data);
		}
	}
}