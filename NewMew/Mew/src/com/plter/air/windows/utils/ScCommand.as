/**
 * 
 * @author xtiqin
 * http://plter.com
 * http://www.apache.org/licenses/LICENSE-2.0 
 */


package com.plter.air.windows.utils
{
	import flash.filesystem.File;

	/**
	 * 
	 * 用于调用Windows系统的服务命令
	 */
	public class ScCommand extends NativeCommand
	{
		
		public function ScCommand()
		{
			super();
		}
		
		/**
		 * 创建一个本机服务
		 * @param name 服务的名称
		 * @param binPath 可执行文件的路径
		 * @param type 服务的类型，此值为ScCommandCreateServiceType类中的常量 
		 * @param start 服务的启动方式，此值为ScCommandCreateServiceStartOptions类中的常量
		 * @param error 错误类型，此值为ScCommandCreateServiceError类中的常量
		 */
		public function createServiceWithName(name:String,binPath:String,type:String="own",start:String="demand",error:String="normal"):void{
			var cmd:Vector.<String>=new Vector.<String>;
			cmd.push("sc");
			cmd.push("create");
			cmd.push(name);
			cmd.push("binPath=");
			cmd.push(binPath);
			cmd.push("type=");
			cmd.push(type);
			cmd.push("start=");
			cmd.push(start);
			cmd.push("error=");
			cmd.push(error);
			runCmd(cmd);
		}
		
		
		/**
		 * 删除一个本机服务 
		 * @param name 服务的名字
		 */
		public function removeServiceByName(name:String):void{
			var cmd:Vector.<String>=new Vector.<String>;
			cmd.push("sc");
			cmd.push("delete");
			cmd.push(name);
			runCmd(cmd);
		}
		
		/**
		 * 启动一个服务
		 */
		public function startService(name:String,...args):void{
			var cmd:Vector.<String>=new Vector.<String>;
			cmd.push("sc");
			cmd.push("start");
			cmd.push(name);
			while(args.length){
				cmd.push(String(args.shift()));
			}
			runCmd(cmd);
		}
		
		/**
		 * 发送一个停止服务的请求
		 */
		public function stopService(name:String):void{
			var cmd:Vector.<String>=new Vector.<String>;
			cmd.push("sc");
			cmd.push("stop");
			cmd.push(name);
			runCmd(cmd);
		}
	}
}