package MewEvent
{
	import flash.events.Event;
	
	public class WindowEvent extends Event
	{
		
		public static const CLOSE:String = "close";
		public static const MINI:String = "mini";
		public static const BACKGROUND_COMPLETE:String = "background_complete";
		public static const LOGIN_SUCCESS:String = "login_success";
		public static const START_RESIZE_WINDOW:String = "start_resize_window";
		public static const STOP_RESIZE_WINDDW:String = "stop_resize_window";
		public static const SWAP_STATE:String = "swap_state";
		public static const REMOVE_OPER:String = "remove_oper";
		public static const DELETE_STATUS:String = "delete_status";
		public static const DELETE_STATUS_SUCCESS:String = "delete_status_success";
		public static const ABOUT_MEW:String = "about_mew";
		public static const CHECK_UPDATE:String = "check_update";
		public static const BUGS_SUBMIT:String = "bugs_submit";
		public static const USER_SUGGESTION:String = "user_suggestion";
		public static const LOG_OUT:String = "log_out";
		public static const EXIT_MEW:String = "exit_mew";
		public static const MIDDLE_IMG:String = "middle_img";
		public static const LOAD_COMPLETE:String = "load_complete";
		public static const TIMER_EVENT:String = "timer_event";
		public static const REPOST_STATUS:String = "repost_status";
		public static const COLLECT_STATUS:String = "collect_status";
		public static const COMMENT_STATUS:String = "comment_status";
		public static const TARGET_USER_DATA:String = "target_user_data";
		public static const COMMENT_SUCCESS:String = "comment_success";
		public static const ADD_COMMENT_TEXT:String = "add_comment_text";
		public static const UPDATE_COMPLETE:String = "update_complete";
		public static const IMAGE_FRAME_LOAD_COMPLETE:String = "image_frame_load_complete";
		public static const IMAGE_FRAME_LOAD_FAILED:String = "image_frame_load_failed";
		
		public static const CONFIRM_YES:String = "confirm_yes";
		public static const CONFIRM_NO:String = "confirm_no";
		
		public static const NO_VIDEO:String = "no_video";
		public static const SHOW_VIDEO:String = "show_video";
		public static const IS_VIDEO:String = "is_video";
		
		public static const PRE_PAGE:String = "pre_page";
		public static const NEXT_PAGE:String = "next_page";
		public static const INDEX_PAGE:String = "index_page";
		
		public static const SEARCH_TOPIC:String = "search_topic";
		public static const SEARCH_USER:String = "search_user";
		
		/**
		 * preload事件
		 */
		public static const FRIEND_TIME_LINE_PRELOAD_COMPLETE:String = "friend_time_line_load_complete";
		public static const FANS_LIST_PRELOAD_COMPLETE:String = "fans_list_load_complete";
		public static const FOLLOW_LIST_PRELOAD_COMPLETE:String = "follow_list_load_complete";
		public static const USER_TIME_LINE_PRELOAD_COMPLETE:String = "user_time_line_load_complete";
		public static const PERSON_RECEIVE_PRELOAD_COMPLETE:String = "person_receive_load_complete";
		public static const PERSON_SEND_PRELOAD_COMPLETE:String = "person_send_load_complete";
		public static const AT_LIST_PRELOAD_COMPLETE:String = "at_list_load_complete";
		public static const COMMENT_LIST_PRELOAD_COMPLETE:String = "comment_list_load_complete";
		public static const COLLECTION_LIST_PRELOAD_COMPLETE:String = "collection_list_load_complete";
		
		public static const NO_UPDATE:String = "no_update";
		
		public var dispatcher:Object = null;
		
		public function WindowEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		override public function clone():Event{
			
			var e:WindowEvent = new WindowEvent(type, bubbles, cancelable);
			e.dispatcher = dispatcher;
			return e;
			
		}
	}
}