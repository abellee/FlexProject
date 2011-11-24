package globalization
{
	import flash.display.Bitmap;
	import flash.filesystem.File;
	import flash.utils.ByteArray;
	
	import lib.Size;

	public class Globals
	{
		public static var screenWidth			:int;
		public static var screenHeight			:int;
		public static var sceneWidth			:int;
		public static var sceneHeight			:int;
		
		[Bindable]
		public static var sceneName				:String = "";
		
		[Bindable]
		public static var materialPath			:String = File.applicationDirectory.nativePath;
		public static var mapMaterial			:Bitmap;
		public static var horizantolTiles		:int;
		public static var verticalTiles			:int;
		public static var tileSize				:Size;
		
		public function Globals()
		{
		}
	}
}