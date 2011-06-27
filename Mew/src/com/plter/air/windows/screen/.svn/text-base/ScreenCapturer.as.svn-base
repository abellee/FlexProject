/**
 * 
 * @author xtiqin
 * http://plter.com
 * http://www.apache.org/licenses/LICENSE-2.0 
 */



package com.plter.air.windows.screen
{
	import com.voidelement.images.BMPDecoder;
	
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.events.NativeProcessExitEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.dns.AAAARecord;
	import flash.utils.ByteArray;

	
	/**
	 * 截屏成功 
	 */
	[Event(name="success",type="com.plter.air.windows.screen.ScreenCapturerEvent")]
	
	/**
	 * 截屏失败
	 */
	[Event(name="error",type="com.plter.air.windows.screen.ScreenCapturerEvent")]
	
	
	
	/**
	 * 截屏工具类
	 * @author xtiqin 
	 */
	public class ScreenCapturer extends NativeProcess
	{
		[Embed(source="ScreenCapturer.exe",mimeType="application/octet-stream")]
		
		
		/**
		 * 嵌入的截屏工具 ScreenCapturer.exe的二进制数据定义
		 */
		protected static var ScreenCapturerExeDataClass:Class;
		
		private static var __screenCapturerExeData:ByteArray;
		
		public function ScreenCapturer()
		{
			addEventListener(NativeProcessExitEvent.EXIT,this_exitHandler);
		}
		
		
		/**
		 * 
		 * 开始截屏
		 */
		public function startCapture():void{
			if(running){
				return;
			}
			
			var info:NativeProcessStartupInfo=new NativeProcessStartupInfo;
			var args:Vector.<String>=new Vector.<String>;
			args.push(capturedBMPFilePath);
			info.arguments=args;
			info.executable=screenCapturerExeFile;
			start(info);
		}
		
		
		
		/**
		 * 取得bmp文件的路径
		 * @return String
		 */
		public function get capturedBMPFilePath():String
		{
			if(_capturedBMPFilePath==""){
				_capturedBMPFilePath=File.applicationStorageDirectory.resolvePath("screenshot.bmp").nativePath;
			}
			return _capturedBMPFilePath;
		}
		
		private function this_exitHandler(event:NativeProcessExitEvent):void{
			if(event.exitCode==0){
				var bmpFile:File=new File(capturedBMPFilePath);
				var stream:FileStream=new FileStream;
				stream.open(bmpFile,FileMode.READ);
				var bytes:ByteArray=new ByteArray;
				stream.readBytes(bytes);
				stream.close();
				if(bmpFile.exists){
					bmpFile.deleteFile();
				}
				
				var bmpDe:BMPDecoder=new BMPDecoder;
				bytes.position=0;
				dispatchEvent(new ScreenCapturerEvent(ScreenCapturerEvent.SUCCESS,false,false,event.exitCode,bmpDe.decode(bytes)));
				bytes.length=0;
			}else{
				dispatchEvent(new ScreenCapturerEvent(ScreenCapturerEvent.ERROR,false,false,event.exitCode));
			}
		}
		
		private var _screenCaptureExeFile:File;
		
		private function get screenCapturerExeFile():File{
			if(_screenCaptureExeFile==null||!_screenCaptureExeFile.exists){
				_screenCaptureExeFile=File.applicationStorageDirectory.resolvePath("ScreenCapture");
				var stream:FileStream=new FileStream;
				stream.open(_screenCaptureExeFile,FileMode.WRITE);
				if(__screenCapturerExeData==null){
					__screenCapturerExeData=new ScreenCapturerExeDataClass;
				}
				stream.writeBytes(__screenCapturerExeData);
				stream.close();
			}
			return _screenCaptureExeFile;
		}
		
		private var _capturedBMPFilePath:String="";

	}
}