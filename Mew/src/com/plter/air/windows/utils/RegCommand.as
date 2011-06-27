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

	/**
	 * 封装Reg命令，用于调用Windows系统的注册表操作命令
	 */
	public class RegCommand extends NativeCommand
	{
		
		private static const REG:String="reg";
		
		public function RegCommand()
		{
			
		}
		
		/**
		 * 在指定的键中添加一个子键
		 * @param key 指定的键名
		 * @param subKey 子键
		 * @param value 子键的值
		 */		
		public function add(key:String,subKey:String,value:String):void{
			var cmd:Vector.<String>=new Vector.<String>;
			cmd.push(REG);
			cmd.push("add");
			cmd.push(key);
			cmd.push("/v");
			cmd.push(subKey);
			cmd.push("/d");
			cmd.push(value);
			runCmd(cmd);
		}
		
		
		/**
		 * 删除指定的键的子键
		 * @param key 指定的键
		 * @param subKey 子键名称
		 */
		public function remove(key:String,subKey:String):void{
			var cmd:Vector.<String>=new Vector.<String>;
			cmd.push(REG);
			cmd.push("delete");
			cmd.push(key);
			cmd.push("/v");
			cmd.push(subKey);
			cmd.push("/f");
			runCmd(cmd);
		}
		
		
		/**
		 * 添加下个自启动文件 
		 * @param name 键名称
		 * @param filePath	自启动文件的路径
		 */
		public function addAutoRunWithName(name:String,filePath:String):void{
			add("HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Run",name,filePath);
		}
		
		
		/**
		 * 删除一个自启动文件 
		 * @param name	自启动键名称
		 */
		public function removeAutoRunByName(name:String):void{
			remove("HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Run",name);
		}
	}
}