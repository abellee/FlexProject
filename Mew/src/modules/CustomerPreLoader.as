package modules
{
	import mx.events.RSLEvent;
	import mx.preloaders.SparkDownloadProgressBar;
	
	public class CustomerPreLoader extends SparkDownloadProgressBar
	{
		public function CustomerPreLoader()
		{
			super();
		}
		override protected function createChildren():void{
			
		}
		override protected function rslProgressHandler(evt:RSLEvent):void {
			
		}
		override protected function setDownloadProgress(completed:Number, total:Number):void {
			
		}
		override protected function setInitProgress(completed:Number, total:Number):void {
			
		}
	}
}