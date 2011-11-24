package layers
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	import globalization.Globals;
	
	import lib.Grid;
	
	import utils.Utils;
	
	public class MapLayer extends Sprite
	{
		private var gridList:Vector.<Grid>;
		public function MapLayer()
		{
			super();
		}
		
		public function listGrids():void
		{
			if(!Globals.mapMaterial) return;
			for(var i:int = 0; i < Globals.verticalTiles; i++){
				for(var j:int = 0; j < Globals.horizantolTiles; j++){
					var cell:Bitmap = new Bitmap(Globals.mapMaterial.bitmapData);
					var grid:Grid = new Grid(cell, true, false, new Point(j, i));
					addChild(grid);
					grid.x = (j % Globals.horizantolTiles) * Globals.tileSize.width + (i & 1) * Globals.tileSize.width / 2;
					grid.y = i * Globals.tileSize.height / 2;
				}
			}
		}
		
		public function getGridByTilePoint(tilePoint:Point):Grid
		{
			var index:int = tilePoint.y * Globals.horizantolTiles + tilePoint.x;
			return gridList[index];
		}
		
		public function getGridByPixelPoint(pixelPoint:Point):Grid
		{
			var tilePos:Point = Utils.getTilePoint(Globals.tileSize, pixelPoint);
			return getGridByTilePoint(tilePos);
		}
	}
}