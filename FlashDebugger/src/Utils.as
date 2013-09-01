package
{
	import flash.filesystem.File;

	public class Utils
	{
		public function Utils()
		{
		}
		
		public static function currentOSUser():String {
		    var userDir:String = File.userDirectory.nativePath; 
		    var userName:String = userDir.substr(userDir.lastIndexOf(File.separator) + 1); 
		    return userName; 
		} 
	}
}