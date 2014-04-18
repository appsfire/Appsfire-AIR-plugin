package com.appsfire.AppsfireANE {
	
	import flash.events.Event;
	
	public class AppsfireEvent extends Event {
		
		// Appsfire SDK delegate events.
		public static const AFSDK_OPEN_NOTIFICATION_DID_FINISH : String = "AFSDK_OPEN_NOTIFICATION_DID_FINISH";
		
		// Appsfire Ad SDK delegate events.
		public static const AFADSDK_ADUNIT_DID_INITIALIZE : String = "AFADSDK_ADUNIT_DID_INITIALIZE";
		public static const AFADSDK_MODAL_AD_IS_READY_FOR_REQUEST : String = "AFADSDK_MODAL_AD_IS_READY_FOR_REQUEST";
		public static const AFADSDK_MODAL_AD_REQUEST_DID_FAIL_WITH_ERROR : String = "AFADSDK_MODAL_AD_REQUEST_DID_FAIL_WITH_ERROR";
		public static const AFADSDK_MODAL_AD_WILL_APPEAR : String = "AFADSDK_MODAL_AD_WILL_APPEAR";
		public static const AFADSDK_MODAL_AD_DID_APPEAR : String = "AFADSDK_MODAL_AD_DID_APPEAR";
		public static const AFADSDK_MODAL_AD_WILL_DISAPPEAR : String = "AFADSDK_MODAL_AD_WILL_DISAPPEAR";
		public static const AFADSDK_MODAL_AD_DID_DISAPPEAR : String = "AFADSDK_MODAL_AD_DID_DISAPPEAR";
		
		public function AppsfireEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false) {
			super(type, bubbles, cancelable);
		}
	}
}