package
{
	import air.update.ApplicationUpdater;
	import air.update.ApplicationUpdaterUI;
	import air.update.events.UpdateEvent;
	
	import flash.desktop.Updater;
	import flash.events.ErrorEvent;

	public class Updator
	{
		private var update:ApplicationUpdaterUI = new ApplicationUpdaterUI();
		private var serverURL:String = "http://192.168.1.178/componentscodegenerator/update.xml";
		public function Updator()
		{
			update.updateURL = serverURL;
			update.isCheckForUpdateVisible = true;
			update.addEventListener(UpdateEvent.INITIALIZED, onUpdateInit);
			update.addEventListener(UpdateEvent.CHECK_FOR_UPDATE, onCheckForUpdate);
			update.initialize();
		}
		
		protected function onCheckForUpdate(event:UpdateEvent):void
		{
		}
		
		protected function onUpdateInit(event:UpdateEvent):void
		{
			update.checkNow();
		}
		
		public function dealloc():void
		{
			update.removeEventListener(UpdateEvent.INITIALIZED, onUpdateInit);
			update = null;
		}
	}
}