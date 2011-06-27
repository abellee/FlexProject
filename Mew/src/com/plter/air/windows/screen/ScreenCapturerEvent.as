/**
 * 
 * @author xtiqin
 * http://plter.com
 * http://www.apache.org/licenses/LICENSE-2.0 
 */


package com.plter.air.windows.screen
{
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.utils.getQualifiedClassName;
	
	
	/**
	 * 截屏相关事件 
	 */
	public class ScreenCapturerEvent extends Event
	{
		/**
		 * 截屏成功
		 */
		public static const SUCCESS:String="success";
		
		/**
		 * 截屏时发生错误
		 */
		public static const ERROR:String="error";
		
		private var _bitmapData:BitmapData;
		private var _errorCode:int=0;
		
		
		/**
		 * 构造一个ScreenCapturerEvent对象
		 * @param type        事件类型
		 * @param bubbles     
		 * @param cancelable
		 * @param errorCode   错误代码，此值为ScreenCapturerErrorCode类中的常量之一
		 * @param bitmapData  此事件传递的BitmapData对象
		 */
		public function ScreenCapturerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false,errorCode:int=0,bitmapData:BitmapData=null)
		{
			super(type, bubbles, cancelable);
			
			this._errorCode=errorCode;
			this._bitmapData=bitmapData;
		}
		
		
		/**
		 * 取得错误代码
		 * @return int类型，此值为ScreenCapturerErrorCode类中的常量之一
		 */
		public function get errorCode():int
		{
			return _errorCode;
		}

		/**
		 * 取得截取的屏幕位图数据，如果截屏失败，此值为null
		 * @return 
		 */		
		public function get bitmapData():BitmapData
		{
			return _bitmapData;
		}

		override public function clone():Event{
			return new ScreenCapturerEvent(type,bubbles,cancelable);
		}
		
		override public function toString():String{
			return formatToString(getQualifiedClassName(this),"type","bubbles","cancelable","errorCode","bitmapData");
		}
	}
}