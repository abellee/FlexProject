/**
 * 
 * @author xtiqin
 * http://plter.com
 * http://www.apache.org/licenses/LICENSE-2.0 
 */


package com.plter.air.windows.utils
{
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.NativeProcessExitEvent;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	/**
	 * 此类对本机命令程序进行封装，你可以通过runCmd方法来隐藏执行一条系统命令
	 * @author plter.com
	 */	
	public class NativeCommand extends NativeProcess
	{
		[Embed(source="HideRun.exe",mimeType="application/octet-stream")]
		protected static var HideRunExeFile:Class;
		
		
		public function NativeCommand()
		{
			
		}
		
		
		/**
		 * 启动一个可执行文件，并侦听文件的状态
		 * @param file	可执行文件 
		 * @param args	参数列表
		 */		
		public function exec(file:File,args:Vector.<String>=null):void{
			var info:NativeProcessStartupInfo=new NativeProcessStartupInfo;
			info.executable=file;
			info.arguments=args;
			start(info);
		}
		
		
		/**
		 * 执行一条系统命令
		 * @param args	执行的系统命令参数列表
		 * @param sw    是否显示命令窗体
		 * @param delay 延时执行命令，以毫秒为单位
		 */
		public function runCmd(args:Vector.<String>,sw:String="hide",delay:uint=0):void{
			args.splice(0,0,sw,String(delay));
			exec(hideRunFile,args);
		}
		
		
		/**
		 * 删除调用命令时产生的临时文件 
		 */
		public function deleteTmpFiles():void{
			if(_hideRunFile!=null&&_hideRunFile.exists){
				_hideRunFile.deleteFile();
			}
		}
		
		private var _hideRunFile:File;
		
		private function get hideRunFile():File{
			if(_hideRunFile==null||!_hideRunFile.exists){
				_hideRunFile=createHideRunExeFile("HideRun");
			}
			return _hideRunFile;
		}
		
		private function createHideRunExeFile(fileName:String):File{
			var file:File=File.applicationStorageDirectory.resolvePath(fileName);
			var stream:FileStream=new FileStream;
			stream.open(file,FileMode.WRITE);
			stream.writeBytes(new HideRunExeFile);
			stream.close();
			return file;
		}
	}
}