package dataCenter
{
	import MewEvent.WindowEvent;
	
	import com.sina.microblog.data.MicroBlogComment;
	import com.sina.microblog.data.MicroBlogCount;
	import com.sina.microblog.data.MicroBlogDirectMessage;
	import com.sina.microblog.data.MicroBlogRelationshipDescriptor;
	import com.sina.microblog.data.MicroBlogStatus;
	import com.sina.microblog.data.MicroBlogUser;
	import com.sina.microblog.data.MicroBlogUsersRelationship;
	import com.sina.microblog.events.MicroBlogEvent;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.registerClassAlias;
	
	import localManager.LocalDataManager;
	import localManager.LocalizationPhase;
	
	public class DataPreloader extends EventDispatcher
	{
		private var byPage:Boolean = false;
		public function DataPreloader(target:IEventDispatcher=null)
		{
			super(target);
			registerClassAlias("microblogstatus", MicroBlogStatus);
			registerClassAlias("microbloguser", MicroBlogUser);
			registerClassAlias("microblogcomment", MicroBlogComment);
			registerClassAlias("microblogrelationshipdescriptor", MicroBlogRelationshipDescriptor);
			registerClassAlias("microblogdirectmessage", MicroBlogDirectMessage);
			registerClassAlias("microblogrelationship", MicroBlogUsersRelationship);
			registerClassAlias("microblogcount", MicroBlogCount);
		}
		public function preloadFriendTimeLine(page:uint = 1):void{
			
			if(page != 1){
				
				byPage = true;
				
			}else{
				
				byPage = false;
				
			}
			DataCenter.FriendTimelinePhase = LocalizationPhase.IS_LOADING;
			DataCenter.microAPI.addEventListener(MicroBlogEvent.LOAD_FRIENDS_TIMELINE_RESULT,loadFriends_timeLine_handler);
			DataCenter.microAPI.loadFriendsTimeline("0", "0", DataCenter.count, page);
			
		}
		public function preloadUserTimeLine(page:uint = 1):void{
			
			if(page != 1){
				
				byPage = true;
				
			}else{
				
				byPage = false;
				
			}
			DataCenter.UserTimelinePhase = LocalizationPhase.IS_LOADING;
			DataCenter.microAPI.addEventListener(MicroBlogEvent.LOAD_USER_TIMELINE_RESULT, loaderUserTimeLine);
			DataCenter.microAPI.loadUserTimeline(DataCenter.curUserId, "0", null, "0", "0", DataCenter.count, page);
			
		}
		public function preloadAtList(page:uint = 1):void{
			
			if(page != 1){
				
				byPage = true;
				
			}else{
				
				byPage = false;
				
			}
			DataCenter.AtDataPhase = LocalizationPhase.IS_LOADING;
			DataCenter.microAPI.addEventListener(MicroBlogEvent.LOAD_MENSIONS_RESULT, loadMensionsTimeline);
			DataCenter.microAPI.loadMentions("0", "0", DataCenter.count, page);
			
		}
		public function preloadCommentList(page:uint = 1):void{
			
			if(page != 1){
				
				byPage = true;
				
			}else{
				
				byPage = false;
				
			}
			DataCenter.CommentDataPhase = LocalizationPhase.IS_LOADING;
			DataCenter.microAPI.addEventListener(MicroBlogEvent.LOAD_COMMENTS_TIMELINE_RESULT, loadCommentsTimeline);
			DataCenter.microAPI.loadCommentsTimeline("0", "0", DataCenter.count, page);
			
		}
		public function preloadPersonReceiveList(page:uint = 1):void{
			
			if(page != 1){
				
				byPage = true;
				
			}else{
				
				byPage = false;
				
			}
			DataCenter.PersonalReceiveDataPhase = LocalizationPhase.IS_LOADING;
			DataCenter.microAPI.addEventListener(MicroBlogEvent.LOAD_DIRECT_MESSAGES_RECEIVED_RESULT, loadDirectMessage);
			DataCenter.microAPI.loadDirectMessagesReceived("0", "0", DataCenter.count, page);
			
		}
		public function preloadFansList(page:uint = 1):void{
			
			if(page != 1){
				
				byPage = true;
				
			}else{
				
				byPage = false;
				
			}
			DataCenter.FansDataPhase = LocalizationPhase.IS_LOADING;
			DataCenter.microAPI.addEventListener(MicroBlogEvent.LOAD_FOLLOWERS_INFO_RESULT, loadFollowers_info_result);
			DataCenter.microAPI.loadFollowersInfo(DataCenter.user.name, DataCenter.user.id, null, DataCenter.fansNum * (page - 1));
			
		}
		public function preloadFollowList(page:uint = 1):void{
			
			if(page != 1){
				
				byPage = true;
				
			}else{
				
				byPage = false;
				
			}
			DataCenter.FollowDataPhase = LocalizationPhase.IS_LOADING;
			DataCenter.microAPI.addEventListener(MicroBlogEvent.LOAD_FRIENDS_INFO_RESULT, loadFriend_info_result);
			DataCenter.microAPI.loadFriendsInfo(DataCenter.user.name, DataCenter.user.id, null, DataCenter.fansNum * (page - 1));
			
		}
		public function preloadPersonSendList(page:uint = 1):void{
			
			if(page != 1){
				
				byPage = true;
				
			}else{
				
				byPage = false;
				
			}
			DataCenter.PersonalSendDataPhase = LocalizationPhase.IS_LOADING;
			DataCenter.microAPI.addEventListener(MicroBlogEvent.LOAD_DIRECT_MESSAGES_SENT_RESULT, loadDirectMessageSend);
			DataCenter.microAPI.loadDirectMessagesSent("0", "0", DataCenter.count, page);
			
		}
		public function preloadCollectionList(page:uint = 1):void{
			
			if(page != 1){
				
				byPage = true;
				
			}else{
				
				byPage = false;
				
			}
			DataCenter.CollectionDataPhase = LocalizationPhase.IS_LOADING;
			DataCenter.microAPI.addEventListener(MicroBlogEvent.LOAD_FAVORITE_LIST_RESULT, loadFavoriteList);
			DataCenter.microAPI.loadFavoriteList(page);
			
		}
		
		private function loadFriends_timeLine_handler(event:MicroBlogEvent):void{
			
			var data:Array = event.result as Array;
			DataCenter.microAPI.removeEventListener(MicroBlogEvent.LOAD_FRIENDS_TIMELINE_RESULT,loadFriends_timeLine_handler);
			
			var e:WindowEvent = new WindowEvent(WindowEvent.FRIEND_TIME_LINE_PRELOAD_COMPLETE);
			e.dispatcher = {};
			if(byPage){
				
				e.dispatcher.data = data;
				this.dispatchEvent(e);
				DataCenter.FriendTimelinePhase = LocalizationPhase.LOADING_COMPLETE;
				return;
				
			}
			if(data && data.length){
				
				if(DataCenter.FriendLastId != (data[0] as MicroBlogStatus).id){
					
					DataCenter.FriendLastId = (data[0] as MicroBlogStatus).id;
					
				}
				e.dispatcher.data = data;
				
			}
			this.dispatchEvent(e);
			
			LocalDataManager.writeData(data, DataCenter.FriendTimeLineFileName);
			DataCenter.FriendTimelinePhase = LocalizationPhase.LOADING_COMPLETE;
			
		}
		
		private function loaderUserTimeLine(event:MicroBlogEvent):void{
			
			var data:Array = event.result as Array;
			DataCenter.microAPI.removeEventListener(MicroBlogEvent.LOAD_USER_TIMELINE_RESULT, loaderUserTimeLine);
			
			var e:WindowEvent = new WindowEvent(WindowEvent.USER_TIME_LINE_PRELOAD_COMPLETE);
			e.dispatcher = {};
			if(byPage){
				
				e.dispatcher.data = data;
				this.dispatchEvent(e);
				DataCenter.UserTimelinePhase = LocalizationPhase.LOADING_COMPLETE;
				return;
				
			}
			if(data && data.length){
				
				if(DataCenter.UserTimeLineLastId != (data[0] as MicroBlogStatus).id){
					
					DataCenter.UserTimeLineLastId = (data[0] as MicroBlogStatus).id;
					
				}
				e.dispatcher.data = data;
				
			}
			this.dispatchEvent(e);
			
			LocalDataManager.writeData(data, DataCenter.UserTimeLineFileName);
			DataCenter.UserTimelinePhase = LocalizationPhase.LOADING_COMPLETE;
			
		}
		
		private function loadMensionsTimeline(event:MicroBlogEvent):void{
			
			var data:Array = event.result as Array;
			DataCenter.microAPI.removeEventListener(MicroBlogEvent.LOAD_MENSIONS_RESULT, loadMensionsTimeline);
			
			var e:WindowEvent = new WindowEvent(WindowEvent.AT_LIST_PRELOAD_COMPLETE);
			e.dispatcher = {};
			if(byPage){
				
				e.dispatcher.data = data;
				this.dispatchEvent(e);
				DataCenter.AtDataPhase = LocalizationPhase.LOADING_COMPLETE;
				return;
				
			}
			if(data && data.length){
				
				if(DataCenter.AtLastId != (data[0] as MicroBlogStatus).id){
					
					DataCenter.AtLastId = (data[0] as MicroBlogStatus).id;
					
				}
				e.dispatcher.data = data;
				
			}
			this.dispatchEvent(e);
			
			LocalDataManager.writeData(data, DataCenter.AtDataFileName);
			DataCenter.AtDataPhase = LocalizationPhase.LOADING_COMPLETE;
			
		}
		
		private function loadCommentsTimeline(event:MicroBlogEvent):void{
			
			var data:Array = event.result as Array;
			DataCenter.microAPI.removeEventListener(MicroBlogEvent.LOAD_COMMENTS_TIMELINE_RESULT, loadCommentsTimeline);
			
			var e:WindowEvent = new WindowEvent(WindowEvent.COMMENT_LIST_PRELOAD_COMPLETE);
			e.dispatcher = {};
			if(byPage){
				
				e.dispatcher.data = data;
				this.dispatchEvent(e);
				DataCenter.CommentDataPhase = LocalizationPhase.LOADING_COMPLETE;
				return;
				
			}
			if(data && data.length){
				
				if(DataCenter.CommentLastId != (data[0] as MicroBlogComment).id){
					
					DataCenter.CommentLastId = (data[0] as MicroBlogComment).id;
					
				}
				e.dispatcher.data = data;
				
			}
			this.dispatchEvent(e);
			
			LocalDataManager.writeData(data, DataCenter.CommentFileName);
			DataCenter.CommentDataPhase = LocalizationPhase.LOADING_COMPLETE;
			
		}
		
		private function loadDirectMessage(event:MicroBlogEvent):void{
			
			var data:Array = event.result as Array;
			DataCenter.microAPI.removeEventListener(MicroBlogEvent.LOAD_DIRECT_MESSAGES_RECEIVED_RESULT, loadDirectMessage);
			
			var e:WindowEvent = new WindowEvent(WindowEvent.PERSON_RECEIVE_PRELOAD_COMPLETE);
			e.dispatcher = {};
			if(byPage){
				
				e.dispatcher.data = data;
				this.dispatchEvent(e);
				DataCenter.PersonalReceiveDataPhase = LocalizationPhase.LOADING_COMPLETE;
				return;
				
			}
			if(data && data.length){
				
				if(DataCenter.PersonalLastId != (data[0] as MicroBlogDirectMessage).id){
					
					DataCenter.PersonalLastId = (data[0] as MicroBlogDirectMessage).id;
					
				}
				e.dispatcher.data = data;
				
			}
			this.dispatchEvent(e);
			
			LocalDataManager.writeData(data, DataCenter.PersonalReceiveFileName);
			DataCenter.PersonalReceiveDataPhase = LocalizationPhase.LOADING_COMPLETE;
			
		}
		
		private function loadFollowers_info_result(event:MicroBlogEvent):void{
			
			var data:Array = event.result as Array;
			DataCenter.microAPI.removeEventListener(MicroBlogEvent.LOAD_FOLLOWERS_INFO_RESULT, loadFollowers_info_result);
			
			var e:WindowEvent = new WindowEvent(WindowEvent.FANS_LIST_PRELOAD_COMPLETE);
			e.dispatcher = {};
			if(byPage){
				
				e.dispatcher.data = data;
				this.dispatchEvent(e);
				DataCenter.FansDataPhase = LocalizationPhase.LOADING_COMPLETE;
				return;
				
			}
			if(data && data.length){
				
				if(DataCenter.FansLastId != (data[0] as MicroBlogUser).id){
					
					DataCenter.FansLastId = (data[0] as MicroBlogUser).id;
					
				}
				e.dispatcher.data = data;
				
			}
			this.dispatchEvent(e);
			
			LocalDataManager.writeData(data, DataCenter.FansListFileName);
			DataCenter.FansDataPhase = LocalizationPhase.LOADING_COMPLETE;
			
		}
		
		private function loadFriend_info_result(event:MicroBlogEvent):void{
			
			var data:Array = event.result as Array;
			DataCenter.microAPI.removeEventListener(MicroBlogEvent.LOAD_FRIENDS_INFO_RESULT, loadFriend_info_result);
			
			var e:WindowEvent = new WindowEvent(WindowEvent.FOLLOW_LIST_PRELOAD_COMPLETE);
			e.dispatcher = {};
			if(byPage){
				
				e.dispatcher.data = data;
				this.dispatchEvent(e);
				DataCenter.FollowDataPhase = LocalizationPhase.LOADING_COMPLETE;
				return;
				
			}
			if(data && data.length){
				
				if(DataCenter.FollowInfoLastId != (data[0] as MicroBlogUser).id){
					
					DataCenter.FollowInfoLastId = (data[0] as MicroBlogUser).id;
					
				}
				e.dispatcher.data = data;
				
			}
			this.dispatchEvent(e);
			
			LocalDataManager.writeData(data, DataCenter.FollowListFileName);
			DataCenter.FollowDataPhase = LocalizationPhase.LOADING_COMPLETE;
			
		}
		
		private function loadDirectMessageSend(event:MicroBlogEvent):void{
			
			var data:Array = event.result as Array;
			DataCenter.microAPI.removeEventListener(MicroBlogEvent.LOAD_DIRECT_MESSAGES_RECEIVED_RESULT, loadDirectMessageSend);
			
			var e:WindowEvent = new WindowEvent(WindowEvent.PERSON_SEND_PRELOAD_COMPLETE);
			e.dispatcher = {};
			if(byPage){
				
				e.dispatcher.data = data;
				this.dispatchEvent(e);
				DataCenter.PersonalSendDataPhase = LocalizationPhase.LOADING_COMPLETE;
				return;
				
			}
			if(data && data.length){
				
				if(DataCenter.PersonalSendLastId != (data[0] as MicroBlogDirectMessage).id){
					
					DataCenter.PersonalSendLastId = (data[0] as MicroBlogDirectMessage).id;
					
				}
				e.dispatcher.data = data;
				
			}
			this.dispatchEvent(e);
			
			LocalDataManager.writeData(data, DataCenter.PersonalSendFileName);
			DataCenter.PersonalSendDataPhase = LocalizationPhase.LOADING_COMPLETE;
			
		}
		
		private function loadFavoriteList(event:MicroBlogEvent):void{
			
			var data:Array = event.result as Array;
			DataCenter.microAPI.removeEventListener(MicroBlogEvent.LOAD_FAVORITE_LIST_RESULT, loadFavoriteList);
			
			var e:WindowEvent = new WindowEvent(WindowEvent.COLLECTION_LIST_PRELOAD_COMPLETE);
			e.dispatcher = {};
			if(byPage){
				
				e.dispatcher.data = data;
				this.dispatchEvent(e);
				DataCenter.CollectionDataPhase = LocalizationPhase.LOADING_COMPLETE;
				return;
				
			}
			if(data && data.length){
				
				if(DataCenter.CollectionLastId != (data[0] as MicroBlogStatus).id){
					
					DataCenter.CollectionLastId = (data[0] as MicroBlogStatus).id;
					
				}
				e.dispatcher.data = data;
				
			}
			this.dispatchEvent(e);
			
			LocalDataManager.writeData(data, DataCenter.CollectionFileName);
			DataCenter.CollectionDataPhase = LocalizationPhase.LOADING_COMPLETE;
			
		}
		
	}
}