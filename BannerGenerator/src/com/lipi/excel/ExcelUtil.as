package com.lipi.excel
{
	import flash.geom.Point;

	public class ExcelUtil
	{
		public function ExcelUtil()
		{
		}
		
		
		/**
		 * excel列标题对应的索引（A1，A2）
		 * @param colName
		 * @return 
		 */
		public static function getColIndex(colName:String):int
		{
			var abc:String = colName.replace(/(\d)/g,"");
			return textToInt(abc);
		}
		
		
		public static function colNameToPosition(colName:String):Array
		{
			var colText:String = colName.replace(/(\d)/g,"");
			var col:int = textToInt(colText);
			var row:int = int(colName.replace(colText,"")) - 1;
			return [row,col];
		}
		
		public static function textToInt(abc:String):int
		{
			var returnValue:int = 0;
			for(var i:int = abc.length-1;i>=0;i--)
			{
				var cValue:int = abc.charCodeAt(0) - 65;
				returnValue = returnValue + cValue + (i*26);
			}
			return returnValue;
		}
		
	}
}