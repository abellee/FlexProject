package functional
{
	import dataCenter.DataCenter;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class Utils
	{
		public function Utils()
		{
		}
		public static function dataTransfer(createTime:Date):String{
			
			var now:Date = new Date();
			var str:String;
			var tt:String = (createTime.getHours() < 10 ? ("0"+createTime.getHours()):createTime.getHours())+":"
				+(createTime.getMinutes() < 10 ? ("0"+createTime.getMinutes()) : createTime.getMinutes());
			if((now.time - createTime.time) / 1000 / 60 < 59){
				
				str = int((now.time - createTime.time) / 1000 / 60 + 1) + "分钟前";
				
			}else{
				
				str = "今天 " + tt;
				
			}
			var timeStr:String = "";
			if(createTime.getFullYear() == now.getFullYear() && createTime.getMonth() == now.getMonth() && createTime.getDate() == now.getDate()){
				
				timeStr = str;
				
			}else{
				
				timeStr = (createTime.getMonth() + 1)+"月"+createTime.getDate()+"日 "+tt;
				
			}
			return timeStr;
			
		}
		public static function sortByCreateTime(a:Object, b:Object):int{
			
			if ((a.createdAt as Date).getTime() > (b.createdAt as Date).getTime()){
				
				return -1;
				
			}
			if ((a.createdAt as Date).getTime() < (b.createdAt as Date).getTime()){
				
				return 1;
				
			}
			return 0;
			
		}
		public static function countWordsNum(str:String):Boolean{
			
			if(!str || str == ""){
				
				return false; 
				
			}
			var len:uint = str.length;
			var num:uint = 0;
			for(var i:uint = 0; i < len; i++){
				
				if(StringDetect.isChinese(str.charAt(i))){
					
					num ++;
					
				}else{
					
					num += .5;
					
				}
				
			}
			if(num > 140){
				
				return false;
				
			}else{
				
				return true;
				
			}
			
		}
		
	}
}