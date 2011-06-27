package localManager
{
	import com.sina.microblog.data.MicroBlogComment;
	import com.sina.microblog.data.MicroBlogDirectMessage;
	import com.sina.microblog.data.MicroBlogStatus;
	import com.sina.microblog.data.MicroBlogUnread;
	import com.sina.microblog.data.MicroBlogUser;
	import com.sina.microblog.events.MicroBlogEvent;
	
	import dataCenter.DataCenter;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	
	public class NewMicroBlogChecker extends EventDispatcher
	{
		private var timer:Timer;
		
		private var urlLoader:URLLoader;
		
		public function NewMicroBlogChecker(target:IEventDispatcher=null)
		{
			super(target);
		}
		public function start():void{
			
			timer = new Timer(DataCenter.refreshDelay * 1000);
			timer.addEventListener(TimerEvent.TIMER, checkUnreadData);
			timer.start();
			
		}
		
		private function checkUnreadData(event:TimerEvent):void{
			
			DataCenter.microAPI.addEventListener(MicroBlogEvent.LOAD_STATUS_UNREAD_RESULT, checkoutUnreadData);
			DataCenter.microAPI.loadStatusUnread(1, DataCenter.FriendLastId);
			
		}
		
		private function checkoutUnreadData(event:MicroBlogEvent):void{
			
			DataCenter.microAPI.removeEventListener(MicroBlogEvent.LOAD_STATUS_UNREAD_RESULT, checkoutUnreadData);
			var result:MicroBlogUnread = event.result as MicroBlogUnread;
			if(result.comments > 0){
				
				if(DataCenter.commentNotice){
					
					loadNewComments();
					
				}
				
			}
			if(result.dm > 0){
				
				if(DataCenter.personalNotice){
					
					loadNewDM();
					
				}
				
			}
			if(result.followers > 0){
				
				if(DataCenter.fansNotice){
					
					loadNewFollowers(result.followers);
					
				}
				
			}
			if(result.mentions > 0){
				
				if(DataCenter.atNotice){
					
					loadNewMentions();
					
				}
				
			}
			if(result.new_status > 0){
				
				if(DataCenter.weiboNotice){
					
					loadNewStatus();
					
				}
				
			}
			
		}
		
		private function loadNewComments():void{
			
			DataCenter.microAPI.addEventListener(MicroBlogEvent.LOAD_COMMENTS_TIMELINE_RESULT, loadNewComment_completeHandler);
			DataCenter.microAPI.loadCommentsTimeline(DataCenter.CommentLastId);
			
		}
		
		private function loadNewDM():void{
			
			DataCenter.microAPI.addEventListener(MicroBlogEvent.LOAD_DIRECT_MESSAGES_RECEIVED_RESULT, loadDM_completeHandler);
			DataCenter.microAPI.loadDirectMessagesReceived(DataCenter.PersonalLastId);
			
		}
		
		private function loadNewFollowers(num:uint):void{
			
			if(urlLoader){
				
				urlLoader.removeEventListener(Event.COMPLETE, loadNewFollower_completeHandler);
				urlLoader = null;
				
			}
			urlLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE, loadNewFollower_completeHandler);
			urlLoader.load(new URLRequest("http://api.t.sina.com.cn/statuses/followers/" + DataCenter.user.id + ".xml?source=" + DataCenter.appKey + "&count="  + num));
			
		}
		
		private function loadNewMentions():void{
			
			DataCenter.microAPI.addEventListener(MicroBlogEvent.LOAD_MENSIONS_RESULT, loadNewMentions_completeHandler);
			DataCenter.microAPI.loadMentions(DataCenter.AtLastId);
			
		}
		
		private function loadNewStatus():void{
			
			DataCenter.microAPI.addEventListener(MicroBlogEvent.LOAD_FRIENDS_TIMELINE_RESULT, loadNewStatus_completeHandler);
			DataCenter.microAPI.loadFriendsTimeline(DataCenter.FriendLastId);
			
		}
		
		private function loadNewStatus_completeHandler(event:MicroBlogEvent):void{
			
			DataCenter.microAPI.removeEventListener(MicroBlogEvent.LOAD_FRIENDS_TIMELINE_RESULT, loadNewStatus_completeHandler);
			var data:Array = event.result as Array;
			if(!data || !data.length){
				
				return;
				
			}
			// 过滤重复的微博
			if(!filterWeiBo(data, DataCenter.FriendLastId)){
				
				return;
				
			}
			DataCenter.FriendLastId = (data[0] as MicroBlogStatus).id;
			var selfStatus:Array = [];
			for each(var status:MicroBlogStatus in data){
				
				if(status.user.id == DataCenter.user.id){
					
					selfStatus.push(status);
					
				}
				
			}
			if(selfStatus.length){
				
				if((selfStatus[0] as MicroBlogStatus).id != DataCenter.UserTimeLineLastId){
					
					DataCenter.UserTimeLineLastId = (selfStatus[0] as MicroBlogStatus).id;
					DataCenter.mainPanel.addNewStatusToSelf(selfStatus);
					
				}
				
			}
			DataCenter.mainPanel.addNewStatus(data);
			
		}
		
		private function loadNewComment_completeHandler(event:MicroBlogEvent):void{
			
			DataCenter.microAPI.removeEventListener(MicroBlogEvent.LOAD_COMMENTS_TIMELINE_RESULT, loadNewComment_completeHandler);
			var data:Array = event.result as Array;
			if(!data || !data.length){
				
				return;
				
			}
			// 过滤重复的微博
			if(!filterWeiBo(data, DataCenter.CommentLastId)){
				
				return;
				
			}
			
			DataCenter.CommentLastId = (data[0] as MicroBlogComment).id;
			DataCenter.mainPanel.addNewComment(data);
			DataCenter.microAPI.resetCount(1);
			
		}
		
		private function loadNewMentions_completeHandler(event:MicroBlogEvent):void{
			
			DataCenter.microAPI.removeEventListener(MicroBlogEvent.LOAD_MENSIONS_RESULT, loadNewMentions_completeHandler);
			var data:Array = event.result as Array;
			if(!data || !data.length){
				
				return;
				
			}
			// 过滤重复的微博
			if(!filterWeiBo(data, DataCenter.AtLastId)){
				
				return;
				
			}
			DataCenter.AtLastId = (data[0] as MicroBlogStatus).id;
			DataCenter.mainPanel.addNewMetions(data);
			DataCenter.microAPI.resetCount(2);
			
		}
		
		private function loadDM_completeHandler(event:MicroBlogEvent):void{
			
			DataCenter.microAPI.removeEventListener(MicroBlogEvent.LOAD_DIRECT_MESSAGES_RECEIVED_RESULT, loadDM_completeHandler);
			var data:Array = event.result as Array;
			if(!data || !data.length){
				
				return;
				
			}
			// 过滤重复的微博
			if(!filterWeiBo(data, DataCenter.PersonalLastId)){
				
				return;
				
			}
			DataCenter.PersonalLastId = (data[0] as MicroBlogDirectMessage).id;
			DataCenter.mainPanel.addNewDM(data);
			DataCenter.microAPI.resetCount(3);
			
		}
		
		private function loadNewFollower_completeHandler(event:Event):void{
			
			urlLoader.removeEventListener(Event.COMPLETE, loadNewFollower_completeHandler);
			var xml:XML = XML(event.target.data);
			urlLoader = null;
			var arr:Array = [];
			if(xml.user){
				
				for each(var user:XML in xml.user){
					
					if(user.id){
						
						var mbUser:MicroBlogUser = new MicroBlogUser();
						mbUser.serialization(user);
						arr.push(mbUser);
						
					}
					
				}
				
			}else{
				
				return;
				
			}
			if(!arr || !arr.length){
				
				return;
				
			}
			// 过滤重复的微博
			if(!filterWeiBo(arr, DataCenter.FansLastId)){
				
				return;
				
			}
			DataCenter.FansLastId = (arr[0] as MicroBlogUser).id;
			DataCenter.mainPanel.addNewFollower(arr);
			DataCenter.microAPI.resetCount(4);
			
		}
		
		public function stopAndClear():void{
			
			timer.stop();
			timer.removeEventListener(TimerEvent.TIMER, checkUnreadData);
			timer = null;
			if(urlLoader){
				
				urlLoader.removeEventListener(MicroBlogEvent.LOAD_FOLLOWERS_INFO_RESULT, loadNewFollower_completeHandler);
				urlLoader = null;
				
			}
			
		}
		private function filterWeiBo(arr:Array, nid:String):Boolean{
			
			if(!arr || !arr.length){
				
				return false;
				
			}
			var len:uint = arr.length;
			for(var i:uint = 0; i < len; i++){
				
				if(arr[i].id){
					
					if(arr[i].id == nid){
						
						arr.splice(i, 1);
						
					}
					
				}
				
			}
			return Boolean(arr.length);
			
		}
	}
}