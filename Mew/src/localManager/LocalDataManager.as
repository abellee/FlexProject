package localManager
{
	import com.sina.microblog.MicroBlog;
	
	import dataCenter.DataCenter;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;

	public class LocalDataManager
	{
		private static var file:File;
		private static var fileStream:FileStream = new FileStream();
		public function LocalDataManager()
		{
		}
		public static function writeData(data:*, fileName:String):void{
			
			if((!fileName || fileName == "") || !data){
				
				throw new ArgumentError("fileName or data can not be empty!");
				return;
				
			}
			file = File.applicationStorageDirectory.resolvePath("MewCache/" + DataCenter.user.id + "/" + fileName + ".cache");
			fileStream.open(file, FileMode.WRITE);
			fileStream.position = 0;
			fileStream.writeObject(data);
			fileStream.close();
			
		}
		/**
		 * 文件中数据必需为Array类型的数据
		 */
		public static function spliceData(data:*, fileName:String):Boolean{
			
			if((!fileName || fileName == "") || !data){
				
				throw new ArgumentError("fileName or data can not be empty!");
				return;
				
			}
			
			file = File.applicationStorageDirectory.resolvePath("MewCache/" + DataCenter.user.id + "/" + fileName + ".cache");
			if(!file.exists){
				
				throw new Error("数据出错，请重新启动软件！");
				return;
				
			}
			var arr:Array = LocalDataManager.readData(null, fileName) as Array;
			if(!arr){
				
				throw new Error("数据类型错误，请重启软件!");
				return;
				
			}
			if(data is Array){
				
				if(data[0].id == arr[0].id){
					
					return true;
					
				}
				arr = (data as Array).concat(arr);
				
			}else{
				
				if(data.id == arr[0].id){
					
					return true;
					
				}
				arr.splice(0, 0, data);
				
			}
			var extraLen:int = arr.length - DataCenter.count;
			while(extraLen > 0){
				
				arr.pop();
				--extraLen;
				
			}
			LocalDataManager.writeData(arr, fileName);
			return true;
			
		}
		/**
		 * index: 数据如果为Array, index表示读取条目的索引;
		 *        数据如果无索引， index则为 "0";
		 *        数据如果为Object， index则为此Object的key;
		 * fileName: 所要读取的数据缓存文件的文件名;
		 */
		public static function readData(index:*, fileName:String):*{
			
			if(!fileName || fileName == ""){
				
				throw new ArgumentError("fileName can not be empty!");
				return;
				
			}
			file = File.applicationStorageDirectory.resolvePath("MewCache/" + DataCenter.user.id + "/" + fileName + ".cache");
			if(!file.exists){
				
				return null;
				
			}
			fileStream.open(file, FileMode.READ);
			fileStream.position = 0;
			if(fileStream.bytesAvailable){
				
				var obj:* = fileStream.readObject();
				if(index == null){
					
					return obj;
					
				}
				if(obj is Array){
					
					if(uint(index)){
						
						return (obj as Array)[uint(index)];
						
					}else{
						
						throw new Error("target data is an Array! so index can not be a string!");
						return null;
						
					}
					
				}else if(obj is Object){
					
					if(!uint(index)){
						
						return obj[index];
						
					}else{
						
						throw new Error("target data is an Object! so index can not be a Number!");
						return null;
						
					}
					
				}else{
					
					return null
					
				}
				
			}
			
		}
	}
}