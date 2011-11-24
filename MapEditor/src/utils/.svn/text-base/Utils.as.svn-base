package utils
{
	import flash.geom.Point;
	
	import lib.Size;

	public class Utils
	{
		public function Utils()
		{
		}
		/**
		 * 根据屏幕象素坐标取得网格的坐标
		 * px 象素坐标x
		 * py 象素坐标x
		 * return 网格坐标的点
		 */
		public static function getTilePoint(tileSize:Size, pixelPoint:Point):Point
		{
			var px:int = pixelPoint.x;
			var py:int = pixelPoint.y;
			var tileWidth:Number = tileSize.width;
			var tileHeight:Number = tileSize.height;
			var xtile:int = 0;	//网格的x坐标
			var ytile:int = 0;	//网格的y坐标
			
			var cx:int, cy:int, rx:int, ry:int;
			cx = int(px / tileWidth) * tileWidth + tileWidth / 2;	//计算出当前X所在的以tileWidth为宽的矩形的中心的X坐标
			cy = int(py / tileHeight) * tileHeight + tileHeight / 2;//计算出当前Y所在的以tileHeight为高的矩形的中心的Y坐标
			
			rx = (px - cx) * tileHeight/2;
			ry = (py - cy) * tileWidth/2;
			
			if (Math.abs(rx) + Math.abs(ry) <= tileWidth * tileHeight / 4)
			{
				xtile = int(px / tileWidth);
				ytile = int(py / tileHeight) * 2;
			}
			else
			{
				px = px - tileWidth / 2;
				xtile = int(px / tileWidth) + 1;
				
				py = py - tileHeight / 2;
				ytile = int(py / tileHeight) * 2 + 1;
			}
			
			return new Point(xtile - (ytile & 1), ytile);
		}
		
		/**
		 * 格子坐标 转 像素坐标
		 * 返回 像素坐标
		 */
		public static function tileToPixel(tileSize:Size, tilePoint:Point):Point
		{
			var tpx:Number = tilePoint.x;
			var tpy:Number = tilePoint.y;
			var xp:int = tpx * tileSize.width + ((tpy & 1) + 1) * tileSize.width / 2;
			var yp:int = (tpy + 1) * tileSize.height / 2;
			
			return new Point(xp, yp);
		}
	}
}