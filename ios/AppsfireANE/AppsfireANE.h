//
//  AppsfireANE.h
//  AppsfireANE
//
//  Created by Ali Karagoz on 25/03/14.
//  Copyright (c) 2014 Appsfire. All rights reserved.
//

#import "FlashRuntimeExtensions.h"
#import "AFANEUtils.h"

#pragma mark - C Interface (Appsfire SDK)
DEFINE_ANE_FUNCTION(afsdk_connectWithParameters);
DEFINE_ANE_FUNCTION(afsdk_isInitialized);
DEFINE_ANE_FUNCTION(afsdk_versionDescription);

#pragma mark - C Interface (Appsfire Engage SDK)
DEFINE_ANE_FUNCTION(afesdk_registerPushTokenString);
DEFINE_ANE_FUNCTION(afesdk_handleBadgeCountLocally);
DEFINE_ANE_FUNCTION(afesdk_handleBadgeCountLocallyAndRemotely);
DEFINE_ANE_FUNCTION(afesdk_presentPanel);
DEFINE_ANE_FUNCTION(afesdk_dismissPanel);
DEFINE_ANE_FUNCTION(afesdk_isDisplayed);
DEFINE_ANE_FUNCTION(afesdk_openSDKNotificationID);
DEFINE_ANE_FUNCTION(afesdk_setColors);
DEFINE_ANE_FUNCTION(afesdk_setUserEmail);
DEFINE_ANE_FUNCTION(afesdk_setShowFeedbackButton);
DEFINE_ANE_FUNCTION(afesdk_numberOfPendingNotifications);
DEFINE_ANE_FUNCTION(afesdk_setUseDelegate);

#pragma mark - C Interface (Appsfire Ad SDK)
DEFINE_ANE_FUNCTION(afadsdk_areAdsLoaded);
DEFINE_ANE_FUNCTION(afadsdk_setUseInAppDownloadWhenPossible);
DEFINE_ANE_FUNCTION(afadsdk_setDebugModeEnabled);
DEFINE_ANE_FUNCTION(afadsdk_requestModalAd);
DEFINE_ANE_FUNCTION(afadsdk_isThereAModalAdAvailable);
DEFINE_ANE_FUNCTION(afadsdk_forceDismissalOfModalAd);
DEFINE_ANE_FUNCTION(afadsdk_cancelPendingAdModalRequest);
DEFINE_ANE_FUNCTION(afadsdk_isModalAdDisplayed);
DEFINE_ANE_FUNCTION(afadsdk_setUseDelegate);

#pragma mark - ANE setup
void AppsfireANEContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet);
void AppsfireANEContextFinalizer(FREContext ctx);
void AppsfireANEInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet);
void AppsfireANEFinalizer(void* extData);


