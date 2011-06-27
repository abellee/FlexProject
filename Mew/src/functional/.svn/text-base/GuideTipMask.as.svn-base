package functional
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	
	public class GuideTipMask extends Sprite
	{
		private var prePos:Rectangle;
		private var preBA:ByteArray;
		
		private var bitmap:Bitmap;
		
		public function GuideTipMask(w:Number = 1000, h:Number = 600)
		{
			super();
			this.addEventListener(Event.REMOVED_FROM_STAGE, clearSelf);
			init(w, h);
		}
		private function init(w:Number, h:Number):void{
			
			var sp:Sprite = new Sprite();
			sp.graphics.beginFill(0x000000,1.0);
			sp.graphics.drawRect(0, 0, w, h);
			sp.graphics.endFill();
			var bd:BitmapData = new BitmapData(w, h);
			bd.draw(sp);
			bitmap = new Bitmap(bd);
			bitmap.alpha = .5;
			addChild(bitmap);
			this.width = bitmap.width;
			this.height = bitmap.height;
			
		}
		public function masker(rect:Rectangle):void{
			
			if(preBA){
				
				bitmap.bitmapData.setPixels(prePos, preBA)
				
			}
			prePos = rect;
			preBA = bitmap.bitmapData.getPixels(rect);
			preBA.position = 0;
			bitmap.bitmapData.fillRect(rect, 0x00000000);
			
		}
		private function clearSelf(event:Event):void{
			
			this.removeEventListener(Event.REMOVED_FROM_STAGE, clearSelf);
			bitmap.bitmapData.dispose();
			bitmap = null;
			prePos = null;
			preBA = null;
			
		}
	}
}