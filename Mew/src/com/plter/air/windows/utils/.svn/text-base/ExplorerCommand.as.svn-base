package com.plter.air.windows.utils
{
	
	/**
	 * 对系统的Explorer命令进行封装
	 * @author xtiqin
	 */
	public class ExplorerCommand extends NativeCommand
	{
		public function ExplorerCommand()
		{
			super();
		}
		
		/**
		 * 浏览文件或者路径
		 */
		public function explore(path:String=null):void{
			var cmd:Vector.<String>=new Vector.<String>;
			cmd.push("explorer");
			if(path!=null&&path!=""){
				cmd.push(path);
			}
			runCmd(cmd,ShowCmdWindow.SHOW);
		}
	}
}