package
{
	import air.update.ApplicationUpdaterUI;
	import air.update.events.UpdateEvent;
	
	import flash.desktop.NativeApplication;
	import flash.events.ErrorEvent;

	public class Updator
	{
		private var appUpdater:ApplicationUpdaterUI = new ApplicationUpdaterUI();
		private var serverURL:String = "http://192.168.1.178/componentscodegenerator/update.xml";
		public function Updator()
		{
//			appUpdater.updateURL = serverURL;
//			appUpdater.isCheckForUpdateVisible = true;
//			appUpdater.addEventListener(UpdateEvent.INITIALIZED, onUpdateInit);
//			appUpdater.addEventListener(UpdateEvent.CHECK_FOR_UPDATE, onCheckForUpdate);
//			appUpdater.initialize();
			checkForUpdate();
		}
		
		private function checkForUpdate():void 
		{
			// current version
			var appXml:XML = NativeApplication.nativeApplication.applicationDescriptor;  
			var ns:Namespace = appXml.namespace();
//			txtVersion.text = appXml.ns::version;
			// update
			trace(appXml.ns::versionNumber);
			appUpdater.updateURL = serverURL; 
			appUpdater.isCheckForUpdateVisible = false;
			appUpdater.isFileUpdateVisible = false;
			appUpdater.isInstallUpdateVisible = true;
			appUpdater.addEventListener(UpdateEvent.INITIALIZED, onUpdateHandler);  
			appUpdater.addEventListener(ErrorEvent.ERROR, onErrorHandler);
			appUpdater.initialize();
		}
		
		private function onErrorHandler(evt:ErrorEvent):void 
		{
			var target:ApplicationUpdaterUI = evt.currentTarget as ApplicationUpdaterUI;
			target.removeEventListener(UpdateEvent.INITIALIZED, onUpdateHandler);  
			target.removeEventListener(ErrorEvent.ERROR, onErrorHandler);   
			
			trace(evt.toString());
		}
		
		private function onUpdateHandler(evt:UpdateEvent):void 
		{
			var target:ApplicationUpdaterUI = evt.currentTarget as ApplicationUpdaterUI;
			target.removeEventListener(UpdateEvent.INITIALIZED, onUpdateHandler);  
			target.removeEventListener(ErrorEvent.ERROR, onErrorHandler); 
			
			appUpdater.checkNow(); // Go check for an update now  
		}
	}
}