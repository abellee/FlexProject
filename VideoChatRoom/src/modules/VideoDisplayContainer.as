package modules
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.media.Camera;
	import flash.media.Sound;
	import flash.media.Video;
	import flash.net.NetStream;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import resource.Resource;
	
	public class VideoDisplayContainer extends Sprite
	{
		
		private var _label:TextField = new TextField();
		private var video:Video = new Video();
		private var ns:NetStream;
		private var noVideo:DisplayObject = new (Resource.NoVideo)();
		private var sound:Sound = new Sound();
		private var _volumn:MovieClip = new (Resource.Volumn)();
		
		public function VideoDisplayContainer()
		{
			super();
			init();
		}
		private function init():void{
			
			this.addChild(noVideo);
			video.width = 80;
			video.height = 60;
			video.smoothing = true;
			this.addChild(video);
			
			addChild(_volumn);
			_volumn.gotoAndStop(1);
			
			_label.text = "";
			_label.selectable = false;
			_label.defaultTextFormat = new TextFormat(null, 13, 0x000000, true);
			_label.autoSize = TextFieldAutoSize.CENTER;
			
			this.width = video.width;
			this.height = video.height + _label.textHeight + 5;
			this.addEventListener(Event.REMOVED_FROM_STAGE, clearSelf);
			
		}
		
		private function clearSelf(event:Event):void{
			
			this.removeEventListener(Event.REMOVED_FROM_STAGE, clearSelf);
			ns.removeEventListener(NetStatusEvent.NET_STATUS, nsReady);
			_label = null;
			video = null;
			ns = null;
			
		}
		
		public function addStreamAndPlay(stream:NetStream, sname:String):void{
			
			ns = stream;
			stream.addEventListener(NetStatusEvent.NET_STATUS, nsReady);
			stream.play(sname);
			
		}
		private function nsReady(event:NetStatusEvent):void{
			
			if(event.info.code == "NetStream.Play.Start"){
				
				video.attachNetStream(ns);
				
			}
			
		}
		public function set camera(cam:Camera):void{
			
			video.attachCamera(cam);
			
		}
		public function set cname(str:String):void{
			
			this.addChild(_label);
			_label.text = str;
			_label.y = video.height + 5;
			_label.x = (video.width - _label.textWidth) / 2;
			this.height = video.height + _label.textHeight + 5;
			
		}
		public function get cname():String{
			
			return _label.text;
			
		}
		public function setVideoSize(w:Number, h:Number):void{
			
			video.width = w;
			video.height = h;
			_label.x = (video.width - _label.textWidth) / 2;
			_label.y = video.height + 5;
			this.width = video.width;
			this.height = video.height + _label.textHeight + 5;
			
			
		}
		public function set showNoVideo(bool:Boolean):void{
			
			noVideo.visible = bool;
			
		}
		public function showNoVideoBig():void{
			
			this.removeChild(noVideo);
			noVideo = null;
			noVideo = new (Resource.NoVideoBig)();
			this.addChildAt(noVideo, 0);
			
		}
		public function volumn(index:uint):void{
			
			_volumn.gotoAndStop(index);
			
		}
	}
}