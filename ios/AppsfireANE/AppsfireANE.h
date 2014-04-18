//
//  AppsfireANE.h
//  AppsfireANE
//
//  Created by Ali Karagoz on 25/03/14.
//  Copyright (c) 2014 Appsfire. All rights reserved.
//

#import "FlashRuntimeExtensions.h"
#import "AFANEUtils.h"

// C Interface

// Appsfire SDK
DEFINE_ANE_FUNCTION(afsdk_connectWithAPIKey);
DEFINE_ANE_FUNCTION(afsdk_connectWithAPIKeyAndDelay);
DEFINE_ANE_FUNCTION(afsdk_setFeatures);
DEFINE_ANE_FUNCTION(afsdk_isInitialized);
DEFINE_ANE_FUNCTION(afsdk_pause);
DEFINE_ANE_FUNCTION(afsdk_resume);
DEFINE_ANE_FUNCTION(afsdk_registerPushTokenString);
DEFINE_ANE_FUNCTION(afsdk_handleBadgeCountLocally);
DEFINE_ANE_FUNCTION(afsdk_handleBadgeCountLocallyAndRemotely);
DEFINE_ANE_FUNCTION(afsdk_presentPanel);
DEFINE_ANE_FUNCTION(afsdk_dismissPanel);
DEFINE_ANE_FUNCTION(afsdk_isDisplayed);
DEFINE_ANE_FUNCTION(afsdk_openSDKNotificationID);
DEFINE_ANE_FUNCTION(afsdk_setColors);
DEFINE_ANE_FUNCTION(afsdk_setUserEmail);
DEFINE_ANE_FUNCTION(afsdk_setShowFeedbackButton);
DEFINE_ANE_FUNCTION(afsdk_getAFSDKVersionInfo);
DEFINE_ANE_FUNCTION(afsdk_numberOfPendingNotifications);
DEFINE_ANE_FUNCTION(afsdk_getSessionID);
DEFINE_ANE_FUNCTION(afsdk_resetCache);
DEFINE_ANE_FUNCTION(afsdk_setUseDelegate);

// Appsfire Ad SDK
DEFINE_ANE_FUNCTION(afadsdk_prepare);
DEFINE_ANE_FUNCTION(afadsdk_isInitialized);
DEFINE_ANE_FUNCTION(afadsdk_areAdsLoaded);
DEFINE_ANE_FUNCTION(afadsdk_setUseInAppDownloadWhenPossible);
DEFINE_ANE_FUNCTION(afadsdk_setDebugModeEnabled);
DEFINE_ANE_FUNCTION(afadsdk_requestModalAd);
DEFINE_ANE_FUNCTION(afadsdk_isThereAModalAdAvailable);
DEFINE_ANE_FUNCTION(afadsdk_forceDismissalOfModalAd);
DEFINE_ANE_FUNCTION(afadsdk_cancelPendingAdModalRequest);
DEFINE_ANE_FUNCTION(afadsdk_isModalAdDisplayed);
DEFINE_ANE_FUNCTION(afadsdk_setUseDelegate);

// ANE setup
void AppsfireANEContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet);
void AppsfireANEContextFinalizer(FREContext ctx);
void AppsfireANEInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet);
void AppsfireANEFinalizer(void* extData);


