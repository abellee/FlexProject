package functional
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.filters.BitmapFilter;

	public class ImageGenerator
	{
		public function ImageGenerator()
		{
		}
		public static function generateBitmap(bitmapData:BitmapData):BitmapData{
			
			var sp:Sprite = new Sprite();
			var bitmap:Bitmap = new Bitmap(bitmapData);
			sp.addChild(bitmap);
			sp.width = bitmap.width;
			sp.height = bitmap.height;
			
			var txtFormat:TextFormat = new TextFormat();
			txtFormat.size = 14;
			txtFormat.color = 0xffffff;
			
			var txtField:TextField = new TextField();
			txtField.defaultTextFormat = txtFormat;
			txtField.autoSize = TextFieldAutoSize.LEFT;
			txtField.text = "Mew微博截图";
			
			var filter:BitmapFilter = EffectCenter.getBitmapFilter(0x000000, 0, 1, 2, 2, 1, 1);
			var myFilters:Array = new Array();
			myFilters.push(filter);
			txtField.filters = myFilters;
			
			sp.addChild(txtField);
			txtField.x = 2;
			txtField.y = sp.height - txtField.textHeight - 2;
			
			var newBitmapData:BitmapData = new BitmapData(sp.width, sp.height, true);
			newBitmapData.draw(sp);
			
			return newBitmapData;
			
		}
	}
}