package remoteManager
{
	import MewEvent.WindowEvent;
	
	import dataCenter.DataCenter;
	
	import flash.net.NetConnection;
	import flash.net.Responder;
	import flash.system.System;
	
	import modules.ConfirmPanel;

	public class RemoteConnecting
	{
		private var nc:NetConnection = new NetConnection();
		public function RemoteConnecting()
		{
			nc.connect("http://mew.iabel.com/amfphp/gateway.php");
		}
		public function submitBugs(str:String):void{
			
			nc.call("MewCustom.postBugs", new Responder(showConfirmPanel, showConfirmPanel), str, DataCenter.user.name);
			
		}
		public function submitSuggestion(str:String):void{
			
			nc.call("MewCustom.postSuggestion", new Responder(showConfirmPanel, showConfirmPanel), str, DataCenter.user.name);
			
		}
		private function showConfirmPanel(e:String):void{
			
			if(!DataCenter.confirmPanel){
				
				DataCenter.confirmPanel = new ConfirmPanel();
				
			}
			DataCenter.confirmPanel.noLabel = "";
			DataCenter.confirmPanel.addEventListener(WindowEvent.CONFIRM_YES,
				function(event:WindowEvent):void{
					
					DataCenter.confirmPanel.hide();
					
				});
			if(e == "[object Object]"){
				
				e = "服务器出错!请通知开发者!\n http://weibo.com/abellee";
				
			}
			DataCenter.confirmPanel.txt = e;
			DataCenter.confirmPanel.show(DataCenter.mainPanel, false);
			
		}
	}
}