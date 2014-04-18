package com.appsfire.AppsfireANE {
		
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	import flash.system.Capabilities;
	
	public class Appsfire extends EventDispatcher {
		
		// --------------------------------------------------------------------------------------//
		// 									   PUBLIC API										 //
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
		// 									   Appsfire SDK										 //
		// --------------------------------------------------------------------------------------//
		
		public function afsdk_connectWithAPIKey(apiKey : String) : Boolean {
			if (!isSupported) return false;
			
			log("afsdk_connectWithAPIKey");
			
			// Type checking.
			if (!(apiKey is String)) return false;
			
			return _context.call(AppsfireMethods.afsdk_connectWithAPIKey, apiKey);
		}
		
		public function afsdk_connectWithAPIKeyAndDelay(apiKey : String, delay : Number = 0) : Boolean {
			if (!isSupported) return false;
			
			log("afsdk_connectiWithAPIKeyAndDelay");
			
			// Type checking.
			if (!(apiKey is String)) return false;
			if (!(delay is Number)) return false;
			
			return _context.call(AppsfireMethods.afsdk_connectWithAPIKeyAndDelay, apiKey, delay);
		}
	
		public function afsdk_setFeatures(isEngageEnabled : Boolean, isMonetizationEnabled : Boolean, isTrackEnabled : Boolean) : void {
			if (!isSupported) return;
			
			log("afsdk_setFeatures");
			
			// Type checking.
			if (!(isEngageEnabled is Boolean)) return;
			if (!(isMonetizationEnabled is Boolean)) return;
			if (!(isTrackEnabled is Boolean)) return;
			
			_context.call(AppsfireMethods.afsdk_setFeatures, isEngageEnabled, isEngageEnabled, isTrackEnabled);
		}
		
		public function afsdk_isInitialized() : Boolean {
			if (!isSupported) return false;
			
			log("afsdk_isInitialized");
			
			return _context.call(AppsfireMethods.afsdk_isInitialized);
		}
		
		public function afsdk_pause() : void {
			if (!isSupported) return;
			
			log("afsdk_pause");
			
			_context.call(AppsfireMethods.afsdk_pause);
		}
		
		public function afsdk_resume() : void {
			if (!isSupported) return;
			
			log("afsdk_resume");
			
			_context.call(AppsfireMethods.afsdk_resume);
		}
		
		public function afsdk_registerPushTokenString(pushToken : String) : void {
			if (!isSupported) return;
			
			log("afsdk_registerPushTokenString");
			
			// Type checking.
			if (!(pushToken is String)) return;
			
			_context.call(AppsfireMethods.afsdk_registerPushTokenString, pushToken);
		}
		
		public function afsdk_handleBadgeCountLocally(shouldHandleLocally : Boolean = true) : void {
			if (!isSupported) return;
			
			log("afsdk_handleBadgeCountLocally");
			
			// Type checking.
			if (!(shouldHandleLocally is Boolean)) return;
			
			_context.call(AppsfireMethods.afsdk_handleBadgeCountLocally, shouldHandleLocally);
			
		}
		
		public function afsdk_handleBadgeCountLocallyAndRemotely(shouldHandleRemotelyAndLocally : Boolean = true) : void {
			if (!isSupported) return;
			
			log("afsdk_handleBadgeCountLocallyAndRemotely");
			
			// Type checking.
			if (!(shouldHandleRemotelyAndLocally is Boolean)) return;
			
			_context.call(AppsfireMethods.afsdk_handleBadgeCountLocallyAndRemotely, shouldHandleRemotelyAndLocally);
		}
		
		public function afsdk_presentPanel(content : String, style : String) : Boolean {
			if (!isSupported) return false;
			
			log("afsdk_presentPanel");
			
			// Type checking.
			if (!(content is String)) return false;
			if (!(style is String)) return false;
			
			return _context.call(AppsfireMethods.afsdk_presentPanel, content, style);
		}
		
		public function afsdk_dismissPanel() : void {
			if (!isSupported) return;
			
			log("afsdk_dismissPanel");
			
			_context.call(AppsfireMethods.afsdk_dismissPanel);
		}
		
		public function afsdk_isDisplayed() : Boolean {
			if (!isSupported) return false;
			
			log("afsdk_isDisplayed");
						
			return _context.call(AppsfireMethods.afsdk_isDisplayed);
		}
		
		public function afsdk_openSDKNotificationID(notificationId : Number) : void {
			if (!isSupported) return;
			
			log("afsdk_openSDKNotificationID");
			
			// Type checking.
			if (!(notificationId is Number)) return;
			
			_context.call(AppsfireMethods.afsdk_openSDKNotificationID, notificationId);
		}
		
		public function afsdk_setColors(backgroundColor : String, textColor : String) : void {
			if (!isSupported) return;
			
			log("afsdk_setColors");
			
			// Type checking.
			if (!(backgroundColor is String)) return;
			if (!(textColor is String)) return;
			
			_context.call(AppsfireMethods.afsdk_setColors, backgroundColor, textColor);
		}
		
		public function afsdk_setUserEmail(email : String, isModifiable : Boolean) : Boolean {
			if (!isSupported) return false;
			
			log("afsdk_setUserEmail");
			
			// Type checking.
			if (!(email is String)) return false;
			if (!(isModifiable is Boolean)) return false;
			
			return _context.call(AppsfireMethods.afsdk_setUserEmail, email, isModifiable);
		}
		
		public function afsdk_setShowFeedbackButton(shouldShowFeedbackButton : Boolean = true) : void {
			if (!isSupported) return;
			
			log("afsdk_setShowFeedbackButton");
			
			// Type checking.
			if (!(shouldShowFeedbackButton is Boolean)) return;
			
			_context.call(AppsfireMethods.afsdk_setShowFeedbackButton, shouldShowFeedbackButton);
		}
		
		public function afsdk_getAFSDKVersionInfo() : String {
			if (!isSupported) return null;
			
			log("afsdk_getAFSDKVersionInfo");
			
			return _context.call(AppsfireMethods.afsdk_getAFSDKVersionInfo) as String;
		}
		
		public function afsdk_numberOfPendingNotifications() : Number {
			if (!isSupported) return 0;
			
			log("afsdk_numberOfPendingNotifications");
			
			return _context.call(AppsfireMethods.afsdk_numberOfPendingNotifications) as Number;
		}
		
		public function afsdk_getSessionID() : String {
			if (!isSupported) return null;
			
			log("afsdk_getSessionID");
			
			return _context.call(AppsfireMethods.afsdk_getSessionID) as String;
		}
		
		public function afsdk_resetCache() : void {
			if (!isSupported) return;
			
			log("afsdk_resetCache");
			
			_context.call(AppsfireMethods.afsdk_resetCache);
		}
		
		public function afsdk_setUseDelegate(shouldUseDelegate : Boolean) : void {
			if (!isSupported) return;
			
			log("afsdk_setUseDelegate");
			
			// Type checking.
			if (!(shouldUseDelegate is Boolean)) return;
			
			_context.call(AppsfireMethods.afsdk_setUseDelegate, shouldUseDelegate);
		}

		
		// --------------------------------------------------------------------------------------//
		// 									 Appsfire Ad SDK    								 //
		// --------------------------------------------------------------------------------------//
		
		public function afadsdk_prepare() : void {
			if (!isSupported) return;
			
			log("afadsdk_prepare");
			
			_context.call(AppsfireMethods.afadsdk_prepare);
		}
		
		public function afadsdk_isInitialized() : Boolean {
			if (!isSupported) return false;
			
			log("afadsdk_isInitialized");
			
			return _context.call(AppsfireMethods.afadsdk_isInitialized);
		}
		
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
		
		public function afadsdk_setDebugModeEnabled(isDebugEnabled : Boolean = true) : void {
			if (!isSupported) return;
			
			log("afadsdk_setDebugModeEnabled");
			
			// Type checking.
			if (!(isDebugEnabled is Boolean)) return;
			_context.call(AppsfireMethods.afadsdk_setDebugModeEnabled, isDebugEnabled);
		}
		
		public function afadsdk_requestModalAd(modalType : String, timerCount : Number = 0) : void {
			if (!isSupported) return;
			
			log("afadsdk_requestModalAd");
			
			// Type checking.
			if (!(modalType is String)) return;
			if (!(timerCount is Number)) return;
			_context.call(AppsfireMethods.afadsdk_requestModalAd, modalType, timerCount);
		}
		
		public function afadsdk_isThereAModalAdAvailable(modalType : String) : Boolean {
			if (!isSupported) return false;
			
			log("afadsdk_requestModalAd");
			
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
		
		public function afadsdk_setUseDelegate(shouldUseDelegate : Boolean = true) : void {
			if (!isSupported) return;
			
			log("afadsdk_setUseDelegate");
			
			// Type checking.
			if (!(shouldUseDelegate is Boolean)) return;
			
			_context.call(AppsfireMethods.afadsdk_setUseDelegate, shouldUseDelegate);
		}
		
		// --------------------------------------------------------------------------------------//
		// 									 	PRIVATE API										 //
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
				AppsfireEvent.AFADSDK_ADUNIT_DID_INITIALIZE,
				AppsfireEvent.AFADSDK_MODAL_AD_IS_READY_FOR_REQUEST,
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