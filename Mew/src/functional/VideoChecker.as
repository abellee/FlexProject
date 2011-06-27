package functional
{
	import MewEvent.WindowEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class VideoChecker extends EventDispatcher implements IEventDispatcher
	{
		
		private var urlLoader:URLLoader;
		
		private var tempArr:Array;
		
		public function VideoChecker(target:IEventDispatcher=null)
		{
			super(target);
		}
		public function checkVideo(char:String):void{
			
			var pattern:RegExp = /((http|https):\/\/)+?[A-Za-z0-9\.]+[A-Za-z0-9]+[\/=\?%\-&_~`@[\]\':+!]+[A-Za-z0-9\/]*/g;
			tempArr = char.match(pattern);
			if(tempArr && tempArr.length){
				
				pingTarget(tempArr[0]);
				tempArr.shift();
				
			}else{
				
				this.dispatchEvent(new WindowEvent(WindowEvent.NO_VIDEO));
				
			}
			
			
		}
		private function pingTarget(str:String):void{
			
			urlLoader = new URLLoader();
			urlLoader.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, checkWhetherVideo);
			urlLoader.load(new URLRequest(str));
			
		}
		private function checkWhetherVideo(event:HTTPStatusEvent):void{
			
			urlLoader.removeEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, checkWhetherVideo);
			
			var youku:RegExp = /v.youku.com/g;
			var ku6:RegExp = /v.ku6.com/g;
			var cn6:RegExp = /6.cn/g;
			var tudou:RegExp = /www.tudou.com/g;
			var sina:RegExp = /video.sina.com/g;
			var wuliu:RegExp = /56.com/g;
			//joy.cn
			if(youku.test(event.responseURL)){
				
				this.dispatchEvent(new WindowEvent(WindowEvent.IS_VIDEO));
				urlLoader.addEventListener(Event.COMPLETE, youku_loadComplete_handler);
				urlLoader.load(new URLRequest(event.responseURL));
				
			}
			if(tudou.test(event.responseURL)){
				
				this.dispatchEvent(new WindowEvent(WindowEvent.IS_VIDEO));
				urlLoader.addEventListener(Event.COMPLETE, tudou_loadComplete_handler);
				urlLoader.load(new URLRequest(event.responseURL));
				
			}
			
		}
		private function youku_loadComplete_handler(event:Event):void{
			
			urlLoader.removeEventListener(Event.COMPLETE, youku_loadComplete_handler);
			var tempStr:String = event.target.data;
			var videoPattern:RegExp = /<embed src=\"[\w\W]+\" quality=\"high\" width=\"480\" height=\"400\" align=\"middle\" allowScriptAccess=\"sameDomain\" type=\"application\/x-shockwave-flash\"><\/embed>/;
			var thumbnailPattern:RegExp = /dd/;
			
			var thumbnailArr:Array = tempStr.match(thumbnailPattern);
			if(!thumbnailArr || !thumbnailArr.length){
				
				this.dispatchEvent(new WindowEvent(WindowEvent.NO_VIDEO));
				return;
				
			}
			var videoArr:Array = tempStr.match(videoPattern);
			if(!videoArr || !videoArr.length){
				
				this.dispatchEvent(new WindowEvent(WindowEvent.NO_VIDEO));
				return;
				
			}
			
			var thumbnailPath:String = thumbnailArr[0];
			var videoPath:String = videoArr[0];
			
			var videoEvent:WindowEvent = new WindowEvent(WindowEvent.SHOW_VIDEO);
			videoEvent.dispatcher = {};
			videoEvent.dispatcher.thumbnail = thumbnailPath;
			videoEvent.dispatcher.video = videoPath;
			this.dispatchEvent(videoEvent);
			
		}
		private function tudou_loadComplete_handler(event:Event):void{
			
			urlLoader.removeEventListener(Event.COMPLETE, tudou_loadComplete_handler);
			var tempStr:String = event.target.data;
			var videoPattern:RegExp = /<embed src=\"[\w\W]+\" type=\"application\/x-shockwave-flash\" allowscriptaccess=\"always\" allowfullscreen=\"true\" wmode=\"opaque\" width=\"520\" height=\"450\"><\/embed>/;
			var thumbnailPattern:RegExp = /dd/;
			
			var thumbnailArr:Array = tempStr.match(thumbnailPattern);
			if(!thumbnailArr || !thumbnailArr.length){
				
				this.dispatchEvent(new WindowEvent(WindowEvent.NO_VIDEO));
				return;
				
			}
			var videoArr:Array = tempStr.match(videoPattern);
			if(!videoArr || !videoArr.length){
				
				this.dispatchEvent(new WindowEvent(WindowEvent.NO_VIDEO));
				return;
				
			}
			
			var thumbnailPath:String = thumbnailArr[0];
			var videoPath:String = videoArr[0];
			
			var videoEvent:WindowEvent = new WindowEvent(WindowEvent.SHOW_VIDEO);
			videoEvent.dispatcher = {};
			videoEvent.dispatcher.thumbnail = thumbnailPath;
			videoEvent.dispatcher.video = videoPath;
			this.dispatchEvent(videoEvent);
			
		}
	}
}