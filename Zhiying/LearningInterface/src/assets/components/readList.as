package assets.components
{
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.text.TextField;
	
	import mx.flash.UIMovieClip;
	
	public class readList extends UIMovieClip{
		
		private var url:URLRequest;
		private var loader:Loader;
		private var txt:TextField = new TextField();
		private var tempID:String = "";
		public var myObject:Object;
		
		public function readList(){
			
		}
		public function loadTitles(arr:Array):void{
			
			for(var i:uint=0; i<arr.length;i++){
				
				loader = new Loader();
				loadSWFs(loader.contentLoaderInfo);
				url = new URLRequest(arr[i][0]);
				loader.load(url);
				this["mc"+i].addChild(loader);
				this["mc"+i].id = arr[i][1];
				
			}
			
		}
		private function loadSWFs(dispatcher:IEventDispatcher):void{
			
			dispatcher.addEventListener(Event.COMPLETE,loadSuccess);
			
		}
		private function loadSuccess(e:Event):void{
			
			(e.target.content as MovieClip)["parent"]["parent"].mouseChildren = false;
			(e.target.content as MovieClip)["parent"]["parent"].buttonMode = true;
			(e.target.content as MovieClip)["parent"]["parent"].addEventListener(MouseEvent.MOUSE_OVER,turnRed);
			(e.target.content as MovieClip)["parent"]["parent"].addEventListener(MouseEvent.MOUSE_OUT,turnBlack);
			(e.target.content as MovieClip)["parent"]["parent"].addEventListener(MouseEvent.CLICK,btnClick);
			e.target.removeEventListener(Event.COMPLETE,loadSuccess);
			
		}
		public function get currentID():String{
			
			return tempID;
			
		}
		private function turnRed(e:MouseEvent):void{
			
			(e.target.getChildAt(1).content as MovieClip).gotoAndStop(2);
			
		}
		private function turnBlack(e:MouseEvent):void{
			
			(e.target.getChildAt(1).content as MovieClip).gotoAndStop(1);
			
		}
		private function btnClick(e:MouseEvent):void{
			
			tempID = String(e.target.id);
			myObject.extractXML(tempID);
			
		}
		
	}
	
}