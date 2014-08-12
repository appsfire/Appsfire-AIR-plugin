package com.appsfire.AppsfireANE {
	
	import flash.events.Event;
	
	public class AppsfireEvent extends Event {
		
		// Appsfire Engage delegate events.
		public static const AFSDK_OPEN_NOTIFICATION_DID_FINISH : String = "AFSDK_OPEN_NOTIFICATION_DID_FINISH";
		
		// Appsfire Modal Ad SDK delegate events.
		public static const AFADSDK_MODAL_AD_REQUEST_DID_FAIL_WITH_ERROR : String = "AFADSDK_MODAL_AD_REQUEST_DID_FAIL_WITH_ERROR";
		public static const AFADSDK_MODAL_AD_WILL_APPEAR : String = "AFADSDK_MODAL_AD_WILL_APPEAR";
		public static const AFADSDK_MODAL_AD_DID_APPEAR : String = "AFADSDK_MODAL_AD_DID_APPEAR";
		public static const AFADSDK_MODAL_AD_WILL_DISAPPEAR : String = "AFADSDK_MODAL_AD_WILL_DISAPPEAR";
		public static const AFADSDK_MODAL_AD_DID_DISAPPEAR : String = "AFADSDK_MODAL_AD_DID_DISAPPEAR";
		
		// Appsfire Ad SDK delegate events.
		public static const AFADSDK_MODAL_ADS_REFRESHED_AND_AVAILABLE : String = "AFADSDK_MODAL_ADS_REFRESHED_AND_AVAILABLE";
		public static const AFADSDK_MODAL_ADS_REFRESHED_AND_NOT_AVAILABLE : String = "AFADSDK_MODAL_ADS_REFRESHED_AND_NOT_AVAILABLE";
		
		public function AppsfireEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false) {
			super(type, bubbles, cancelable);
		}
	}
}