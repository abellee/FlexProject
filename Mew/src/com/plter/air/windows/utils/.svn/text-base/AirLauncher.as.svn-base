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
	 * 用于启动另一个Adobe AIR应用程序
	 * @author xtiqin,plter.com
	 */
	public class AirLauncher extends NativeCommand
	{
		
		
		
		/**
		 * 构造一个AirLauncher
		 * @param adlFile	Air debug launcher file
		 * @param descriptorFile	AIR应用程序描述文件
		 */
		public function AirLauncher(adlFile:File=null,descriptorFile:File=null)
		{
			super();
			
			this.adlFile=adlFile;
			this.descriptorFile=descriptorFile;
		}
		
		private var _adlFile:File;

		/**
		 * 取得adl文件
		 */
		public function get adlFile():File
		{
			return _adlFile;
		}

		/**
		 * 设置adl文件 
		 */
		public function set adlFile(value:File):void
		{
			_adlFile = value;
		}
		
		private var _descriptorFile:File;

		
		/**
		 * 取得应用程序描述文件 
		 */
		public function get descriptorFile():File
		{
			return _descriptorFile;
		}

		/**
		 * 设置应用程序描述文件
		 */
		public function set descriptorFile(value:File):void
		{
			_descriptorFile = value;
		}
		
		/**
		 * 启动并侦听应用程序状态
		 */
		public function connect(...args):void{
			if(adlFile==null||descriptorFile==null){
				throw new Error("Adl file or descriptorFile is null");
			}
			
			var cmdArgs:Vector.<String>=new Vector.<String>;
			cmdArgs.push(descriptorFile.nativePath);
			cmdArgs.push("-nodebug");
			cmdArgs.push("--");
			for (var i:int = 0; i < args.length; i++) 
			{
				cmdArgs.push(String(args[i]));
			}
			
			exec(adlFile,cmdArgs);
		}

		/**
		 * 启动应用程序，但不侦听状态
		 */
		public function launch(...args):void{
			if(adlFile==null||descriptorFile==null){
				throw new Error("Adl file or descriptorFile is null");
			}
			
			var cmd:Vector.<String>=new Vector.<String>;
			cmd.push(adlFile.nativePath);
			cmd.push(descriptorFile.nativePath);
			cmd.push("-nodebug");
			cmd.push("--");
			for (var i:int = 0; i < args.length; i++) 
			{
				cmd.push(String(args[i]));
			}
			runCmd(cmd);
		}

	}
}