package functional
{
	import com.greensock.TweenLite;
	
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	
	import mx.core.UIComponent;

	public class EffectCenter
	{
		public function EffectCenter()
		{
		}
		public static function fadeIn(obj:UIComponent, dur:Number=.5, completeFunc:Function = null, params:Array = null):void{
			
			obj.alpha = 0;
			TweenLite.to(obj, dur, {alpha:1, onComplete:completeFunc, onCompleteParams:params});
			
		}
		public static function fadeOut(obj:UIComponent, dur:Number=.5, delayTime:int=0, completeFunc:Function = null, params:Array = null):void{
			
			obj.alpha = 1;
			TweenLite.to(obj, dur, {alpha:0, onComplete:completeFunc, delay:delayTime, onCompleteParams:params});
			
		}
		public static function getBitmapFilter(co:Number = 0x000000, an:Number = 0, al:Number = 0.8, bx:Number = 8, by:Number = 8, dis:Number = 1, str:Number = 0.65):BitmapFilter {
			var color:Number = co;
			var angle:Number = an;
			var alpha:Number = al;
			var blurX:Number = bx;
			var blurY:Number = by;
			var distance:Number = dis;
			var strength:Number = str;
			var inner:Boolean = false;
			var knockout:Boolean = false;
			var quality:Number = BitmapFilterQuality.HIGH;
			return new DropShadowFilter(distance,
				angle,
				color,
				alpha,
				blurX,
				blurY,
				strength,
				quality,
				inner,
				knockout);
		}
	}
}