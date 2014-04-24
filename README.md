# Adobe Air Native Extension for Appsfire SDK (iOS)

This documentation is a brief introduction to the Appsfire SDK for Adobe Air. We recommend you to read the Appsfire documentation [SDK](http://docs.appsfire.com) before jumping into its Adobe Air implementation. Most of the iOS Appsfire SDK methods were implemented in the Appsfire ANE. If you have any problem during the integration, don't hesitate to [contact us](mailto:support@appsfire.com).

**Note**: the Appsfire ANE only supports the iOS platform.

### Appsfire SDK
This ANE includes the [**version 2.3.0**](https://github.com/appsfire/Appsfire-iOS-SDK/releases/tag/2.3.0) release of the Appsfire iOS SDK.

### Requirements
Appsfire iOS SDK supports **iOS 5.1.1+**.

### Getting Started

After you have set up your app on the [Appsfire Dashboard](http://dashboard.appsfire.com), you are ready to begin integrating the Appsfire SDK into your AIR project.

First, import the Appsfire ANE in your Adobe Air project. We recommend to create a directory in your project for native extensions, and copy `AppsfireANE.ane` and `AppsfireANE.swc` located in the *bin* folder to that directory. Then, if you are using *Flash Builder*, you can just add that directory as a native extension directory in your project settings.

Second, make sure you add the `<extensionID>` declaration to your AIR application descriptor's root `<application>` element as shown in the following example:

```xml
<extensions>
  <extensionID>com.appsfire.AppsfireANE</extensionID>
</extensions>
```

### How to use the Adobe Air Native Extension

##### Appsfire SDK Setup

First, import the two Appsfire ANE classes into your code.

```actionscript
import com.appsfire.AppsfireANE.Appsfire;
import com.appsfire.AppsfireANE.AppsfireEvent;
```

We recommend to create a variable in your class to store a reference to the global Appsfire instance.

```actionscript
private var appsfire:Appsfire;
appsfire = Appsfire.getInstance();
```

To initialize Appsfire, call the `afsdk_connectWithAPIKey` method with your API token.
This API token can be found in your [Appsfire dashboard](http://dashboard.appsfire.com).

Here is how a typical initialization of the SDK looks like in an application:

```actionscript
// Connects with API Key.
appsfire.afsdk_connectWithAPIKey("YOUR_API_TOKEN");

// Sets the needed features (in this case: Engage + Monetization).
appsfire.afsdk_setFeatures(true, true, false);

// Enable the debug mode. Should be set to false in production environment.
appsfire.afadsdk_setDebugModeEnabled(true);

// Use of the Ad SDK delegate. This will allow you to listen to specific events related to advertisement (events are listed below).
appsfire.afsdk_setUseDelegate(true);

// Tells the SDK to start getting ads.
appsfire.afadsdk_prepare();

```

##### Appsfire methods
**Note**: calling these methods on Android will do nothing.

All the methods listed below are extracted from the `Appsfire.as` class.

```objc
// Appsfire SDK.

/*
 *  @brief Set up the Appsfire SDK with your API key.
 *
 *  @param key Your API key can be found on http://dashboard.appsfire.com
 *
 *  @return `true` if no error was detected, `false` if a problem occurred (likely due to the API key).
 */
public function afsdk_connectWithAPIKey(apiKey : String) : Boolean;

/*
 *  @brief Set up the Appsfire SDK with your API key after a given time interval
 *
 *  @param key Your API key can be found on http://dashboard.appsfire.com/app/manage
 *  @param delay The Delay in seconds before the SDK should initialize.
 *  This is useful if you want to avoid any processes for some period of time.
 *
 *  @return `true` if no error was detected, `false` if a problem occurred (likely due to the key).
 */
public function afsdk_connectWithAPIKeyAndDelay(apiKey : String; delay : Number = 0) : Boolean;

/*
 *  @brief Define the features you want to use in Appsfire SDK.
 *
 *  @note Defining this property will allow us to avoid unnecessary library processes and web-services calls.
 *  For example, if you only use the Monetization SDK (AppsfireAdSDK), then you set `AFSDKFeatureMonetization`.
 *
 *  @warning Don't touch this property if you aren't 100% sure about what you're doing. Check the Appsfire iOS SDK
 *  documentation if you need more information
 *
 *  @param isEngageEnabled if you are Engagement features.
 *  @param isMonetizationEnabled if you are Monetization features.
 *  @param isTrackEnabled if you are Tracking features.
 */
public function afsdk_setFeatures(isEngageEnabled : Boolean, isMonetizationEnabled : Boolean, isTrackEnabled : Boolean) : void;

/*
 *  @brief Tells you if the SDK is initialized.
 *
 *  @note Once the SDK is initialized, you can present the notifications or the feedback.
 *
 *  @return `true` if the sdk is initialized, `false` if not.
 */
public function afsdk_isInitialized() : Boolean;

/*
 *  @brief Pause any refresh timer.
 */
public function afsdk_pause() : void;

/*
 *  @brief Resume any refresh timer.
 */
public function afsdk_resume() : void;

/*
 *  @brief Register the push token for APNS (Apple Push Notification Service).
 *
 *  @param deviceToken NSString representation of the push token.
 */
public function afsdk_registerPushTokenString(pushToken : String) : void;

/*
 *  @brief Handle the badge count for this app locally (only on the device and only while the app is alive).
 *
 *  @note Note that `handleBadgeCountLocally` overrides any settings established by `handleBadgeCountLocallyAndRemotely`, and vice versa.
 *
 *  @param handleLocally A boolean to determine if the badge count should be handled locally.
 */
public function afsdk_handleBadgeCountLocally(shouldHandleLocally : Boolean = true) : void;

/*
 *  @brief Handle the badge count for this app remotely (Appsfire SDK will update the icon at all times, locally and remotely, even when app is closed).
 *
 *  @note Note that `handleBadgeCountLocallyAndRemotely` overrides any settings established by `handleBadgeCountLocally`.
 *  @note IMPORTANT: If you set this option to `true`, you need to provide us with your Push Certificate.
 *  For more information, visit your "Manage Apps" section on http://dashboard.appsfire.com
 *
 *  @param handleLocallyAndRemotely Boolean to determine if badge count should be handled locally and remotely.
 */
public function afsdk_handleBadgeCountLocallyAndRemotely(shouldHandleRemotelyAndLocally : Boolean = true) : void;

/*
 *  @brief Present the panel for notifications / feedback in a specific style
 *
 *  @note Use this method for an easy way to present the Notification Wall. It'll use the window to display, and handle itself so you don't have anything to do except for calling the presentation method.
 *
 *  @param content The default parameter (AFSDKPanelContentDefault) displays the Notification Wall. But if you choose to only display the feedback form (AFSDKPanelContentFeedbackOnly), the Notification Wall will be hidden.
 *  @param style The panel can displayed in a modal fashion over your application (AFSDKPanelStyleDefault) or in full screen (AFSDKPanelStyleFullscreen).
 *
 *  @return A Boolean telling you if a problem occurred.
 */
public function afsdk_presentPanel(content : String, style : String) : Boolean;

/*
 *  @brief Closes the Notification Wall and/or Feedback Form
 */
public function afsdk_dismissPanel() : void;

/*
 *  @brief Tells you if the SDK is displayed.
 *
 *  @return `true` if notifications panel or feedback screen is displayed, `false` if none.
 */
public function afsdk_isDisplayed() : Boolean;

/*
 *  @brief Opens the SDK to a specific notification ID.
 *
 *  @note Fires the "AFSDK_OPEN_NOTIFICATION_DID_FINISH" delegate.
 *
 *  @param notificationID The notification ID you would like to open. Generally this ID is sent via a push to your app.
 */
public function afsdk_openSDKNotificationID(notificationId : Number) : void;

/*
 *  @brief You can customize the colors used in the interface. It'll mainly affect the header and the footer of the panel that you present.
 *
 *  @note You must specify both the background and text colors.
 *
 *  @param backgroundColor The hex string used for the background (ex. "#d7d7d7").
 *  @param textColor The hex string used for the text (over the specific background color, ex. "#a8a8a8").
 */
public function afsdk_setColors(backgroundColor : String, textColor : String) : void;

/*
 *  @brief Set user email.
 *
 *  @note If you know your user's email, call this function so that we avoid asking the user to enter his or her email when sending feedback.
 *
 *  @param email The user's email
 *  @param modifiable If `modifiable` is set to `false`, the user won't be able to modify his/her email in the Feedback form.
 *
 *  @return `true` if no error was detected, `false` if a problem occurred (likely because email was invalid).
 */
public function afsdk_setUserEmail(email : String, isModifiable : Boolean) : Boolean;

/*!
 *  @brief Allow you to display or hide feedback button.
 *
 *  @param show The boolean to tell if feedback button should be displayed or not. Default value is `true`.
 */
public function afsdk_setShowFeedbackButton(shouldShowFeedbackButton : Boolean = true) : void;

/*
 *  @brief Get SDK version and build number (for developer purposes only).
 *
 *  @return Return a string with SDK version and build number.
 */
public function afsdk_getAFSDKVersionInfo() : String;

/*
 *  @brief Returns the number of unread notifications that require attention.
 *
 *  @return Return an integer that represent the number of unread notifications.
 *  If SDK isn't initialized, this number will be 0.
 */
public function afsdk_numberOfPendingNotifications() : Number;

/*
 *  @brief Returns an SDK sessionID.
 *
 *  @return Return a string that represents the session.
 */
public function afsdk_getSessionID() : String;

/*
 *  @brief Resets the SDK's cache completely - all user settings will be erased.
 *
 *  @note This includes messages that have been read, icon images, assets, etc. DO NOT USE LIGHTLY! If you're having an issue that only this seems to solve, please contact us immediately : app-support@appsfire.com
 */
public function afsdk_resetCache();

/*
 *  @brief Activate the firing of events related to the SDK delegate
 *
 *  @note Most of the time Appsfire SDK will alert you for on basic events.
 *  Please refer to the list below of the full list of the events.
 *
 *  @param Boolean if you want to activate the events or not.
 */
public function afsdk_setUseDelegate(shouldUseDelegate : Boolean) : void;

// Appsfire Ad SDK.

/*
 *  @brief Green light so the library can prepare itself.
 *
 *  @note If not already done, this method is automatically called at during a modal ad request.
 */
public function afadsdk_prepare() : void;

/*
 *  @brief Ask if Ad SDK is initialized
 *
 *  @note There are various checks like waiting for the Appsfire SDK initialization, internet connection ...
 *  Usually the library is quickly initialized ( < 1s ).
 *
 *  @return `true` if the library is initialized, `false` if the library isn't yet.
 */
public function afadsdk_isInitialized() : Boolean;

/*
 *  @brief Ask if ads are loaded from the web service
 *
 *  @note This doesn't necessarily means that an ad is available.
 *  But it's always good to know if you want to debug the implementation and check that the web service responded correctly.
 *
 *  @return `true` if ads are loaded from the web service.
 */
public function afadsdk_areAdsLoaded() : Boolean;

/*
 *  @brief Specify if the library should use the in-app overlay when possible.
 *
 *  @note If the client does not have iOS6+, it will be redirected to the App Store app.
 *
 *  @param use A boolean to specify the choice.
 */
public function afadsdk_setUseInAppDownloadWhenPossible(shouldUseInAppDownload : Boolean = true) : void;

/*
 *  @brief Specify if the library should be used in debug mode.
 *
 *  @note Whenever this mode is enabled, the web service will return a fake ad.
 *  By default, this mode is disabled. You must decide if you want to enable the debug mode before any prepare/request.
 *
 *  @param use A boolean to specify if the debug mode should be enabled.
 */
public function afadsdk_setDebugModeEnabled(isDebugEnabled : Boolean = true) : void;

/*
 *  @brief Request a modal ad.
 *
 *  @note If the library isn't initialized, or if the ads aren't loaded yet, then the request will be added to a queue and treated as soon as possible.
 *  You cannot request two ad modals at the same time. In the case where you already have a modal request in the queue, the previous one will be canceled.
 *
 *  @param modalType The kind of modal you want to request (AFAdSDKModalTypeSushi or AFAdSDKModalTypeUraMaki).
 *  @param timerCount the number of seconds used for the timer. if `0` no timer is used.
 */
public function afadsdk_requestModalAd(modalType : String, timerCount : Number = 0) : void;

/*
 *  @brief Ask if ads are loaded and if there is at least one modal ad available.
 *
 *  @note If ads aren't downloaded yet, then the method will return `false`.
 *  To test the library, and then have always have a positive response, please use the "debug" mode (see online documentation for more precisions).
 *
 *  @param modalType The kind of modal you want to check (AFAdSDKModalTypeSushi or AFAdSDKModalTypeUraMaki).
 *  Note that most of ads should be available for both formats.
 *
 *  @return `true` if ads are available, `false` otherwise.
 */
public function afadsdk_isThereAModalAdAvailable(modalType : String) : Boolean;

/*
 *  @brief Force the dismissal of any modal ad currently being displayed on the screen.
 *
 *  @note In the majority of cases, you shouldn't use this method. We highly recommend not to use this method if you aren't sure of the results. Please refer to the documentation or contact us if you have any doubt!
 *
 *  @return `true` if a modal ad was dismissed, `false` otherwise.
 */
public function afadsdk_forceDismissalOfModalAd() : Boolean;

/*
 *  @brief Cancel any pending ad modal request you have made in the past.
 *
 *  @return `true` if a modal ad was canceled, `false` otherwise.
 *  If `true` is returned, you'll get an event via `AFADSDK_MODAL_AD_REQUEST_DID_FAIL_WITH_ERROR:`.
 */
public function afadsdk_cancelPendingAdModalRequest() : Boolean;

/*
 *  @brief Check if there is any modal ad being displayed right now by the library.
 *
 *  @return `true` if a modal ad is being displayed, `false` otherwise
 */
public function afadsdk_isModalAdDisplayed() : Boolean;

/*
 *  @brief Activate the firing of events related to the Ad SDK delegate
 *
 *  @note Most of the time Appsfire SDK will alert you for on basic events.
 *  Please refer to the list below of the full list of the events.
 *
 *  @param Boolean if you want to activate the events or not.
 */
public function afadsdk_setUseDelegate(shouldUseDelegate : Boolean = true) : void;

```

##### Listening to Appsfire Events

Appsfire fires a number of events upon activation of the delegate methods `afsdk_setUseDelegate` and `afadsdk_setUseDelegate`.

Here is an example of how you would listen to them:
```actionscript
appsfire.addEventListener(AppsfireEvent.AFADSDK_MODAL_AD_DID_APPEAR, onModalAdDidAppear);

function onModalAdDidAppear( event:AppsfireEvent ):void {
  trace("Modal Ad Did Appear!");
}
```

Here is the complete list of you can listen to:

```actionscript
// Fired when opening a specific notification.
public static const AFSDK_OPEN_NOTIFICATION_DID_FINISH : String;

// Fired when the Ad Unit did initialize.
public static const AFADSDK_ADUNIT_DID_INITIALIZE : String;

// Fired when the SDK is ready to show modal ads.
public static const AFADSDK_MODAL_AD_IS_READY_FOR_REQUEST : String;

// Fired when an the SDK couldn't show a modal ad.
public static const AFADSDK_MODAL_AD_REQUEST_DID_FAIL_WITH_ERROR : String;

// Fired when a modal ad is about to be displayed.
public static const AFADSDK_MODAL_AD_WILL_APPEAR : String;

// Fired when a modal ad is displayed on the screen.
public static const AFADSDK_MODAL_AD_DID_APPEAR : String;

// Fired when a modal ad is about to be dismissed
public static const AFADSDK_MODAL_AD_WILL_DISAPPEAR : String;

// Fired when a modal as is dismissed.
public static const AFADSDK_MODAL_AD_DID_DISAPPEAR : String;
```

### Build script

Should you need to edit the extension source code and/or recompile it, you will find an ant build script `build.xml` in the *build* folder:

```bash
cd /path/to/the/ane/build
#edit the build.config file to provide your machine-specific paths
ant
```
