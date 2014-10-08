package com.appsfire.AppsfireANE {
		
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	import flash.system.Capabilities;
	
	public class Appsfire extends EventDispatcher {
		
		// --------------------------------------------------------------------------------------//
		// PUBLIC API																			 //
		// --------------------------------------------------------------------------------------//
		
		// To enable logs, set this variable to `true`.
		public var logEnabled : Boolean = false;
		
		public function Appsfire() {
			
			if (!_instance) {
				_context = ExtensionContext.createExtensionContext(EXTENSION_ID, null);
				if (!_context) {
					log("ERROR - Extension context is null. Please check if extension.xml is setup correctly.");
					return;
				}
				_context.addEventListener(StatusEvent.STATUS, onStatus);
				_instance = this;
			} 
			
			else {
				throw Error("This is a singleton, use getInstance(), do not call the constructor directly.");
			}
		}
		
		public static function getInstance() : Appsfire {
			return _instance ? _instance : new Appsfire();
		}
		
		public static function get isSupported() : Boolean {
			// Appsfire only supports iOS.
			return Capabilities.manufacturer.indexOf("iOS") != -1;
		}
		
		// --------------------------------------------------------------------------------------//
		// Appsfire SDK											                                 //
		// --------------------------------------------------------------------------------------//
		
		public function afsdk_connectWithParameters(sdkToken : String, secretKey : String, isEngageEnabled : Boolean, isMonetizationEnabled : Boolean, isTrackEnabled : Boolean) : Boolean {
			if (!isSupported) return false;
			
			log("afsdk_connectWithParameters");
			
			// Type checking.
			if (!(sdkToken is String)) return false;
			if (!(secretKey is String)) return false;
			if (!(isEngageEnabled is Boolean)) return false;
			if (!(isMonetizationEnabled is Boolean)) return false;
			if (!(isTrackEnabled is Boolean)) return false;
			
			return _context.call(AppsfireMethods.afsdk_connectWithParameters, sdkToken, secretKey, isEngageEnabled, isMonetizationEnabled, isTrackEnabled);
		}
		
		public function afsdk_isInitialized() : Boolean {
			if (!isSupported) return false;
			
			log("afsdk_isInitialized");
			
			return _context.call(AppsfireMethods.afsdk_isInitialized);
		}
		
		public function afsdk_versionDescription() : String {
			if (!isSupported) return null;
			
			log("afsdk_versionDescription");
			
			return _context.call(AppsfireMethods.afsdk_versionDescription) as String;
		}
		
		// --------------------------------------------------------------------------------------//
		// Appsfire Engage SDK																	 //
		// --------------------------------------------------------------------------------------//
		
		public function afesdk_registerPushTokenString(pushToken : String) : void {
			if (!isSupported) return;
			
			log("afesdk_registerPushTokenString");
			
			// Type checking.
			if (!(pushToken is String)) return;
			
			_context.call(AppsfireMethods.afesdk_registerPushTokenString, pushToken);
		}
		
		public function afesdk_handleBadgeCountLocally(shouldHandleLocally : Boolean = true) : void {
			if (!isSupported) return;
			
			log("afesdk_handleBadgeCountLocally");
			
			// Type checking.
			if (!(shouldHandleLocally is Boolean)) return;
			
			_context.call(AppsfireMethods.afesdk_handleBadgeCountLocally, shouldHandleLocally);
			
		}
		
		public function afesdk_handleBadgeCountLocallyAndRemotely(shouldHandleRemotelyAndLocally : Boolean = true) : void {
			if (!isSupported) return;
			
			log("afesdk_handleBadgeCountLocallyAndRemotely");
			
			// Type checking.
			if (!(shouldHandleRemotelyAndLocally is Boolean)) return;
			
			_context.call(AppsfireMethods.afesdk_handleBadgeCountLocallyAndRemotely, shouldHandleRemotelyAndLocally);
		}
		
		public function afesdk_presentPanel(content : String, style : String) : Boolean {
			if (!isSupported) return false;
			
			log("afesdk_presentPanel");
			
			// Type checking.
			if (!(content is String)) return false;
			if (!(style is String)) return false;
			
			return _context.call(AppsfireMethods.afesdk_presentPanel, content, style);
		}
		
		public function afesdk_dismissPanel() : void {
			if (!isSupported) return;
			
			log("afesdk_dismissPanel");
			
			_context.call(AppsfireMethods.afesdk_dismissPanel);
		}
		
		public function afesdk_isDisplayed() : Boolean {
			if (!isSupported) return false;
			
			log("afesdk_isDisplayed");
						
			return _context.call(AppsfireMethods.afesdk_isDisplayed);
		}
		
		public function afesdk_openSDKNotificationID(notificationId : Number) : void {
			if (!isSupported) return;
			
			log("afesdk_openSDKNotificationID");
			
			// Type checking.
			if (!(notificationId is Number)) return;
			
			_context.call(AppsfireMethods.afesdk_openSDKNotificationID, notificationId);
		}
		
		public function afesdk_setColors(backgroundColor : String, textColor : String) : void {
			if (!isSupported) return;
			
			log("afesdk_setColors");
			
			// Type checking.
			if (!(backgroundColor is String)) return;
			if (!(textColor is String)) return;
			
			_context.call(AppsfireMethods.afesdk_setColors, backgroundColor, textColor);
		}
		
		public function afesdk_setUserEmail(email : String, isModifiable : Boolean) : Boolean {
			if (!isSupported) return false;
			
			log("afesdk_setUserEmail");
			
			// Type checking.
			if (!(email is String)) return false;
			if (!(isModifiable is Boolean)) return false;
			
			return _context.call(AppsfireMethods.afesdk_setUserEmail, email, isModifiable);
		}
		
		public function afesdk_setShowFeedbackButton(shouldShowFeedbackButton : Boolean = true) : void {
			if (!isSupported) return;
			
			log("afesdk_setShowFeedbackButton");
			
			// Type checking.
			if (!(shouldShowFeedbackButton is Boolean)) return;
			
			_context.call(AppsfireMethods.afesdk_setShowFeedbackButton, shouldShowFeedbackButton);
		}
		
		public function afesdk_numberOfPendingNotifications() : Number {
			if (!isSupported) return 0;
			
			log("afesdk_numberOfPendingNotifications");
			
			return _context.call(AppsfireMethods.afesdk_numberOfPendingNotifications) as Number;
		}
		
		public function afesdk_setUseDelegate(shouldUseDelegate : Boolean) : void {
			if (!isSupported) return;
			
			log("afesdk_setUseDelegate");
			
			// Type checking.
			if (!(shouldUseDelegate is Boolean)) return;
			
			_context.call(AppsfireMethods.afesdk_setUseDelegate, shouldUseDelegate);
		}

		
		// --------------------------------------------------------------------------------------//
		// Appsfire Ad SDK																		 //
		// --------------------------------------------------------------------------------------//
		
		public function afadsdk_areAdsLoaded() : Boolean {
			if (!isSupported) return false;
			
			log("afadsdk_areAdsLoaded");
			
			return _context.call(AppsfireMethods.afadsdk_areAdsLoaded);
		}
		
		public function afadsdk_setUseInAppDownloadWhenPossible(shouldUseInAppDownload : Boolean = true) : void {
			if (!isSupported) return;
			
			log("afadsdk_setUseInAppDownloadWhenPossible");
			
			_context.call(AppsfireMethods.afadsdk_setUseInAppDownloadWhenPossible, shouldUseInAppDownload);			
		}
		
		public function afadsdk_setDebugModeEnabled(isDebugEnabled : Boolean = false) : void {
			if (!isSupported) return;
			
			log("afadsdk_setDebugModeEnabled");
			
			// Type checking.
			if (!(isDebugEnabled is Boolean)) return;
			_context.call(AppsfireMethods.afadsdk_setDebugModeEnabled, isDebugEnabled);
		}
		
		public function afadsdk_requestModalAd(modalType : String, shouldTriggerDelegateEvents : Boolean = false) : void {
			if (!isSupported) return;
			
			log("afadsdk_requestModalAd");
			
			// Type checking.
			if (!(modalType is String)) return;
			if (!(shouldTriggerDelegateEvents is Boolean)) return;
			_context.call(AppsfireMethods.afadsdk_requestModalAd, modalType, shouldTriggerDelegateEvents);
		}
		
		public function afadsdk_isThereAModalAdAvailable(modalType : String) : Boolean {
			if (!isSupported) return false;
			
			log("afadsdk_isThereAModalAdAvailable");
			
			// Type checking.
			if (!(modalType is String)) return false;
			return _context.call(AppsfireMethods.afadsdk_isThereAModalAdAvailable, modalType);
		}
		
		public function afadsdk_forceDismissalOfModalAd() : Boolean {
			if (!isSupported) return false;
			
			log("afadsdk_forceDismissalOfModalAd");
			
			return _context.call(AppsfireMethods.afadsdk_forceDismissalOfModalAd);
		}
		
		public function afadsdk_cancelPendingAdModalRequest() : Boolean {
			if (!isSupported) return false;
			
			log("afadsdk_cancelPendingAdModalRequest");
			
			return _context.call(AppsfireMethods.afadsdk_cancelPendingAdModalRequest);
		}
		
		public function afadsdk_isModalAdDisplayed() : Boolean {
			if (!isSupported) return false;
			
			log("afadsdk_isModalAdDisplayed");
			
			return _context.call(AppsfireMethods.afadsdk_isModalAdDisplayed);
		}
		
		public function afadsdk_setUseDelegate(shouldUseDelegate : Boolean = false) : void {
			if (!isSupported) return;
			
			log("afadsdk_setUseDelegate");
			
			// Type checking.
			if (!(shouldUseDelegate is Boolean)) return;
			
			_context.call(AppsfireMethods.afadsdk_setUseDelegate, shouldUseDelegate);
		}
		
		// --------------------------------------------------------------------------------------//
		// PRIVATE API										 									 //
		// --------------------------------------------------------------------------------------//
		
		private static const EXTENSION_ID : String = "com.appsfire.AppsfireANE";
		
		private static var _instance : Appsfire;
		
		private var _context : ExtensionContext;
		
		private function onStatus(event : StatusEvent) : void {
			
			// Logging event
			if (event.code == "LOGGING") {
				log(event.level);
			}
			
			// Delegate event
			else if ([AppsfireEvent.AFSDK_OPEN_NOTIFICATION_DID_FINISH,
				AppsfireEvent.AFADSDK_MODAL_ADS_REFRESHED_AND_AVAILABLE,
				AppsfireEvent.AFADSDK_MODAL_ADS_REFRESHED_AND_NOT_AVAILABLE,
				AppsfireEvent.AFADSDK_MODAL_AD_REQUEST_DID_FAIL_WITH_ERROR,
				AppsfireEvent.AFADSDK_MODAL_AD_WILL_APPEAR,
				AppsfireEvent.AFADSDK_MODAL_AD_DID_APPEAR,
				AppsfireEvent.AFADSDK_MODAL_AD_WILL_DISAPPEAR,
				AppsfireEvent.AFADSDK_MODAL_AD_DID_DISAPPEAR].indexOf(event.code) > -1) {
				dispatchEvent(new AppsfireEvent(event.code));
			}
		}
		
		private function log(message : String) : void {
			if (logEnabled) trace("[Appsfire] " + message);
		}
		
	}
}