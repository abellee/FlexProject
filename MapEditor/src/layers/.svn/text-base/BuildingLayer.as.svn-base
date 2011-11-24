package layers
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import globalization.Globals;
	
	import utils.Utils;
	
	public class BuildingLayer extends Sprite
	{
		public function BuildingLayer()
		{
			super();
		}
		
		public function addBuilding(bitmap:Bitmap, tilePoint:Point):void
		{
			var point:Point = Utils.tileToPixel(Globals.tileSize, tilePoint);
			var bp:Bitmap = new Bitmap(bitmap.bitmapData.clone());
			bp.alpha = 1;
			addChild(bp);
			bp.x = point.x;
			bp.y = point.y;
		}
	}
}