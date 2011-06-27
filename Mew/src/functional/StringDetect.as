package functional
{
	public class StringDetect
	{
		public function StringDetect()
		{
		}
		public static function trim(str:String):String{
			
			var start:int = 0;
			var end:int = str.length;
			for(var i:int=0; i<str.length; i++){
				
				if(String.fromCharCode(12288) == str.charAt(i) || String.fromCharCode(32) == str.charAt(i) || String.fromCharCode(13) == str.charAt(i)){
					
					start ++;
					
				}else{
					
					break;
					
				}
				
			}
			for(var j:int=str.length-1; j>=0; j--){
				
				if(String.fromCharCode(12288) == str.charAt(j) || String.fromCharCode(32) == str.charAt(j) || String.fromCharCode(13) == str.charAt(j)){
					
					end --;
					
				}else{
					
					break;
					
				}
				
			}
			if(start == str.length && end == 0){
				
				return "";
				
			}
			return str.substring(start, end);
			
		}
		public static function replaceEnter(str:String):String{
			
			var pattern:RegExp = /\n*/g;
			return str.replace(pattern, "");
			
		}
		public static function isChinese(char:String):Boolean{ 
			if(char == null){ 
				return false; 
			} 
			char = trim(char); 
			var pattern:RegExp = /^[\u0391-\uFFE5]+$/;  
			var result:Object = pattern.exec(char); 
			if(result == null) { 
				return false; 
			} 
			return true; 
		}
		public static function isDoubleChar(char:String):Boolean{ 
			if(char == null){ 
				return false; 
			} 
			char = trim(char); 
			var pattern:RegExp = /^[^\x00-\xff]+$/;  
			var result:Object = pattern.exec(char); 
			if(result == null) { 
				return false; 
			} 
			return true; 
		}
		public static function isURL(char:String):Boolean{ 
			if(char == null){ 
				return false; 
			} 
			char = trim(char).toLowerCase(); 
			var pattern:RegExp = /^http:\/\/[A-Za-z0-9]+\.[A-Za-z0-9]+[\/=\?%\-&_~`@[\]\':+!]*([^<>\"\"])*$/;  
			var result:Object = pattern.exec(char); 
			if(result == null) { 
				return false; 
			} 
			return true;
		}
		public static function setURL(char:String):String{
			
			char = char + " ";
			char = char.replace(/</g, "&lt;");
			char = char.replace(/>/g, "&gt;");
			char = char.replace(/"/g, "&quot;");
			var topicPat:RegExp = /#[\w\W]+?#/g;
			var res:Array = char.match(topicPat);
			if(res){
				
				var tpArr:Array = [];
				for each(var ooo:String in res){
					
					var isReplaced:Boolean = false;
					for each(var mm:String in tpArr){
						
						if(mm == ooo){
							
							isReplaced = true;
							break;
							
						}
						
					}
					if(isReplaced){
						
						continue;
						
					}
					char = char.replace(new RegExp(ooo, "g"),"<font color=\"#2d6a9c\"><a href='event:topic" + ooo + "'>"+ooo+"</a></font>");
					tpArr.push(ooo);
				}
				
			}
			var pattern:RegExp = /((http|https):\/\/)+?[A-Za-z0-9\.]+[A-Za-z0-9]+[\/=\?%\-&_~`@[\]\':+!]+[A-Za-z0-9\/]*/g;
			var result:Array = char.match(pattern);
			if(result){
				
				var tempURLs:Array = [];
				for each(var o:String in result){
					var link:String = o;
					var isTrans:Boolean = false;
					for each(var stt:String in tempURLs){
						
						if(stt == o){
							
							isTrans = true;
							break;
							
						}
						
					}
					if(isTrans){
						
						continue;
						
					}
					char = char.replace(new RegExp(o, "g"),"<font color=\"#2d6a9c\"><u><a href=\""+link+"\">"+o+"</a></u></font>");
					tempURLs.push(o);
					
				}
				tempURLs = null;
				
			}
			var atPat:RegExp = /@([0-9A-Za-z\u4e00-\u9fa5_-]+)/g;
			res = char.match(atPat);
			if(res){
				
				var tempArr:Array = [];
				for each(var oo:String in res){
					
					var isReged:Boolean = false;
					for each(var ss:String in tempArr){
						
						if(oo == ss){
							
							isReged = true;
							break;
							
						}
						
					}
					if(isReged){
						
						continue;
						
					}
					var herfStr:String = oo.substr(1, oo.length-1);
					char = char.replace(new RegExp(oo, "g"), "<font color=\"#2d6a9c\"><a href='event:"+herfStr+"'>"+oo+"</a></font>");
					tempArr.push(oo);
					
				}
				
			}
			return char;
			
		}
		public static function isEmail(char:String):Boolean{ 
			if(char == null){ 
				return false; 
			} 
			char = trim(char); 
			var pattern:RegExp = /(\w|[_.\-])+@((\w|-)+\.)+\w{2,4}+/;  
			var result:Object = pattern.exec(char); 
			if(result == null) { 
				return false; 
			} 
			return true; 
		}
	}
}