package assets.components
{
	
	import flash.events.MouseEvent;
	
	import mx.flash.UIMovieClip;
	
	public class ListUI extends UIMovieClip
	{
		
		public var obj:Object;	
		public function ListUI():void
		{	
			
		}
		public function setBtnLabel(arr:Array):void
		{
			
			for(var i:uint=0;i<5;i++){
				
				this["btn"+i].mouseChildren = false;
				this["btn"+i].visible = false;
				this["btn"+i].redText.visible = false;
				
			}
			for(var j:uint=0;j<arr.length;j++){
				
				this["btn"+j].visible = true;
				this["btn"+j].buttonMode = true;
				this["btn"+j].btnText.text = arr[j];
				this["btn"+j].redText.text = arr[j];
				this["btn"+j].addEventListener(MouseEvent.MOUSE_OVER,turnRed);
				this["btn"+j].addEventListener(MouseEvent.MOUSE_OUT,turnBlack);
				this["btn"+j].addEventListener(MouseEvent.CLICK,extractWord);
				
			}
			
		}
		private function turnRed(e:MouseEvent):void
		{
			
			e.target.redText.visible = true;
			e.target.btnText.visible = false;
			
		}
		private function turnBlack(e:MouseEvent):void
		{
			
			e.target.redText.visible = false;
			e.target.btnText.visible = true;
			
		}
		private function extractWord(e:MouseEvent):void{
			
			obj.extractWordList(e.target.btnText.text);
			
		}
		
	}
	
}