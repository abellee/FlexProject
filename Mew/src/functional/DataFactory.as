package functional
{
	import com.sina.microblog.data.MicroBlogStatus;
	import com.sina.microblog.data.MicroBlogUser;

	public class DataFactory
	{
		public function DataFactory()
		{
		}
		public static function serializationStatus(status:XMLList):Array{
			
			var arr:Array = [];
			for each(var xml:XML in status){
				
				var microBlogStatus:MicroBlogStatus = new MicroBlogStatus();
				microBlogStatus.serialization(xml);
				arr.push(microBlogStatus);
				
			}
			return arr;
			
		}
		
		public static function serializationUser(users:XMLList):Array{
			
			var arr:Array = [];
			for each(var user:XML in users){
				
				var microBlogUser:MicroBlogUser = new MicroBlogUser();
				microBlogUser.serialization(user);
				arr.push(microBlogUser);
				
			}
			return arr;
			
		}
	}
}