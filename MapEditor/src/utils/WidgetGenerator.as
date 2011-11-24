package utils
{
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;

	public class WidgetGenerator
	{
		public function WidgetGenerator()
		{
		}
		
		/**
		 * 黑色发光滤镜效果
		 */
		public static function getShadowFilter(color:Number = 0x000000, alpha:Number = 0.8, blurX:Number = 10, blurY:Number = 10):BitmapFilter
		{
//			var color:Number = 0x000000;
//			var alpha:Number = 0.8;
//			var blurX:Number = 10;
//			var blurY:Number = 10;
			var strength:Number = 1;
			var inner:Boolean = false;
			var knockout:Boolean = false;
			var quality:Number = BitmapFilterQuality.HIGH;
			
			return new GlowFilter(color,
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