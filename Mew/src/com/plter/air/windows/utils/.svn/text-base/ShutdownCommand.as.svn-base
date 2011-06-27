/**
 * 
 * @author xtiqin
 * http://plter.com
 * http://www.apache.org/licenses/LICENSE-2.0 
 */


package com.plter.air.windows.utils
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.system.Capabilities;

	
	/**
	 * Windows系统的关机命令
	 */
	public class ShutdownCommand extends NativeCommand
	{

		private static const SHUTDOWN:String="shutdown";
		
		public function ShutdownCommand()
		{
			super();
		}
		
		
		
		/**
		 * 关机
		 * @param seconds	倒计时 
		 */
		public function shutdown(seconds:int=0):void{
			var cmd:Vector.<String>=new Vector.<String>;
			cmd.push(SHUTDOWN);
			cmd.push(instr+"s");
			cmd.push(instr+"t");
			cmd.push(seconds);
			runCmd(cmd);
		}
		
		
		/**
		 * 重启
		 * @param seconds	倒计时
		 */
		public function reset(seconds:int=0):void{
			var cmd:Vector.<String>=new Vector.<String>;
			cmd.push(SHUTDOWN);
			cmd.push(instr+"r");
			cmd.push(instr+"t");
			cmd.push(seconds);
			runCmd(cmd);
		}
		
		/**
		 * 取消重启或者关机命令
		 */
		public function abort():void{
			var cmd:Vector.<String>=new Vector.<String>;
			cmd.push(SHUTDOWN);
			cmd.push(instr+"a");
			runCmd(cmd);
		}
		
		private function get instr():String{
			switch(Capabilities.os){
				case "Windows 2000":
				case "Windows XP":
					return "-";
			}
			return "/";
		}
	}
}