package lib
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	import globalization.Globals;
	
	import utils.Utils;
	
	public class Grid extends Sprite
	{
		private var _background:DisplayObject;
		private var _walkable:Boolean = true;
		private var _shadow:Boolean = false;
		private var tilePos:Point;
		public function Grid(displayObject:DisplayObject, walkable:Boolean, shadow:Boolean, tp:Point)
		{
			super();
			
			_background = displayObject;
			_walkable = walkable;
			_shadow = shadow;
			tilePos = tp;
			addChild(_background);
			
			addEventListener(Event.REMOVED_FROM_STAGE, dealloc);
		}
		
		protected function dealloc(event:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, dealloc);
			if(_background is Bitmap){
				if((_background as Bitmap).bitmapData != Globals.mapMaterial.bitmapData)
					(_background as Bitmap).bitmapData.dispose();
			}
			_background = null;
			tilePos = null;
		}
		
		public function setWalkable(bool:Boolean):void
		{
			if(_walkable == bool) return;
			_walkable = bool;
			var rhombus:Rhombus;
			if(!bool){
				this.removeChild(_background);
				_background = null;
				rhombus = new Rhombus(Globals.tileSize.width, Globals.tileSize.height, RhombusType.UNWALKABLE);
			}else{
				rhombus = new Rhombus(Globals.tileSize.width, Globals.tileSize.height, RhombusType.NORMAL);
			}
			addChild(rhombus);
			_background = rhombus;
		}
		
		public function setShadow(bool:Boolean):void
		{
			if(bool == _shadow) return;
			_shadow = bool;
			var rhombus:Rhombus;
			if(!bool){
				if(_walkable){
					rhombus = new Rhombus(Globals.tileSize.width, Globals.tileSize.height, RhombusType.NORMAL);
				}else{
					rhombus = new Rhombus(Globals.tileSize.width, Globals.tileSize.height, RhombusType.UNWALKABLE);
				}
			}else{
				rhombus = new Rhombus(Globals.tileSize.width, Globals.tileSize.height, RhombusType.SHADOWN);
			}
			if(rhombus){
				this.removeChild(_background);
				_background = null;
				addChild(rhombus);
				_background = rhombus;
			}
		}
		
		public function getPixelPos():Point
		{
			return Utils.tileToPixel(Globals.tileSize, tilePos);
		}
		
		public function getTilePos():Point
		{
			return tilePos;
		}
	}
}