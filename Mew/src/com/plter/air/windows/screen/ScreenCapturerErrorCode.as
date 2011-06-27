/**
 * 
 * @author xtiqin
 * http://plter.com
 * http://www.apache.org/licenses/LICENSE-2.0 
 */



package com.plter.air.windows.screen
{
	
	/**
	 * 截屏时错误代码 
	 */
	public class ScreenCapturerErrorCode
	{
		
		/**
		 * 内存错误，无法为屏幕截图分配内存 
		 */
		public static const MEMORY_ERROR:int=		1;
		
		
		/**
		 * 路径错误，可能是所指定的图片路径不合法 
		 */
		public static const PATH_ERROR:int=		2;
		
		
		/**
		 * 参数错误，在调用ScreenCapturer.exe时必须指定保存的图片的路径 
		 */
		public static const ARGUMENT_ERROR:int=	3;
	}
}