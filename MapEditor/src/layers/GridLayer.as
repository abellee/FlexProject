package layers
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import globalization.Globals;
	
	import lib.Grid;
	import lib.Rhombus;
	import lib.RhombusType;
	
	public class GridLayer extends Sprite
	{
		private var gridList:Vector.<Grid> = new Vector.<Grid>();
		public function GridLayer()
		{
			super();
		}
		
		public function listGrids():void
		{
			for(var i:int = 0; i < Globals.verticalTiles; i++){
				for(var j:int = 0; j < Globals.horizantolTiles; j++){
					var rhombus:Rhombus = new Rhombus(Globals.tileSize.width, Globals.tileSize.height, RhombusType.NORMAL);
					var grid:Grid = new Grid(rhombus, true, false, new Point(j, i));
					addChild(grid);
					grid.x = (j % Globals.horizantolTiles) * Globals.tileSize.width + (i & 1) * Globals.tileSize.width / 2;
					grid.y = i * Globals.tileSize.height / 2;
					gridList.push(grid);
				}
			}
		}
		
		public function getGridByTilePoint(tilePoint:Point):Grid
		{
			if(tilePoint.x < 0 || tilePoint.y < 0 || tilePoint.x >= Globals.horizantolTiles || tilePoint.y >= Globals.verticalTiles) return null;
			var index:int = Globals.horizantolTiles * tilePoint.y + tilePoint.x;
			return gridList[index];
		}
	}
}