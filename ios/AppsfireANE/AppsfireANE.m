//
//  AppsfireANE.m
//  AppsfireANE
//
//  Created by Ali Karagoz on 25/03/14.
//  Copyright (c) 2014 Appsfire. All rights reserved.
//

#import "AppsfireANE.h"
#import "AppsfireSDK.h"
#import "AppsfireAdSDK.h"
#import "AppsfireSDK+Additions.h"
#import "AppsfireAdTimerView.h"
#import "AppsfireSDKDelegate.h"
#import "AppsfireAdSDKDelegate.h"

#pragma mark - C Interface (Appsfire SDK)

static FREContext context;
static AppsfireAdSDKDelegate *appsfireAdSDKDelegate;
static AppsfireSDKDelegate *appsfireSDKDelegate;

DEFINE_ANE_FUNCTION(afsdk_connectWithAPIKey) {
    NSString *apiKey = AFANE_FREObjectToNSString(argv[0]);
    BOOL isSDKInitialized = [AppsfireSDK connectWithAPIKey:apiKey];
    return AFANE_BOOLToFREObject(isSDKInitialized);
}

DEFINE_ANE_FUNCTION(afsdk_connectWithAPIKeyAndDelay) {
    NSString *apiKey = AFANE_FREObjectToNSString(argv[0]);
    
    // Getting the delay value.
    double delay;
    FREGetObjectAsDouble(argv[1], &delay);
    
    // Doing the init.
    BOOL isSDKInitialized = [AppsfireSDK connectWithAPIKey:apiKey afterDelay:delay];
    return AFANE_BOOLToFREObject(isSDKInitialized);
}

DEFINE_ANE_FUNCTION(afsdk_setFeatures) {
    
    BOOL isEngageEnabled = AFANE_FREObjectToBoolean(argv[0]);
    BOOL isMonetizationEnabled = AFANE_FREObjectToBoolean(argv[1]);
    BOOL isTrackEnabled = AFANE_FREObjectToBoolean(argv[2]);
    
    // Building our bitmask.
    AFSDKFeature features;
    if (!isEngageEnabled) {
        features ^= AFSDKFeatureEngage;
    }
    
    if (!isMonetizationEnabled) {
        features ^= AFSDKFeatureMonetization;
    }
    
    if (!isTrackEnabled) {
        features ^= AFSDKFeatureTrack;
    }
    
    [AppsfireSDK setFeatures:features];
    
    return nil;
}

DEFINE_ANE_FUNCTION(afsdk_isInitialized) {
    return AFANE_BOOLToFREObject([AppsfireSDK isInitialized]);
}

DEFINE_ANE_FUNCTION(afsdk_pause) {
    [AppsfireSDK pause];
    return nil;
}

DEFINE_ANE_FUNCTION(afsdk_resume) {
    [AppsfireSDK resume];
    return nil;
}

DEFINE_ANE_FUNCTION(afsdk_registerPushTokenString) {
    NSString *pushToken = AFANE_FREObjectToNSString(argv[0]);
    [AppsfireSDK registerPushTokenString:pushToken];
    return nil;
}

DEFINE_ANE_FUNCTION(afsdk_handleBadgeCountLocally) {
    BOOL shoudHandleLocally = AFANE_FREObjectToBoolean(argv[0]);
    [AppsfireSDK handleBadgeCountLocally:shoudHandleLocally];
    return nil;
}

DEFINE_ANE_FUNCTION(afsdk_handleBadgeCountLocallyAndRemotely) {
    BOOL shouldHandleLocallyAndRemotely = AFANE_FREObjectToBoolean(argv[0]);
    [AppsfireSDK handleBadgeCountLocallyAndRemotely:shouldHandleLocallyAndRemotely];
    return nil;
}

DEFINE_ANE_FUNCTION(afsdk_presentPanel) {
    
    // Content type.
    NSString *contentString = AFANE_FREObjectToNSString(argv[0]);
    AFSDKPanelContent content;
    if (![contentString respondsToSelector:@selector(isEqualToString:)]) {
        return AFANE_BOOLToFREObject(NO);
    }
    
    // Default
    if ([contentString isEqualToString:@"AFSDKPanelContentDefault"]) {
        content = AFSDKPanelContentDefault;
    }
    
    // Feedback
    else if ([contentString isEqualToString:@"AFSDKPanelContentFeedbackOnly"]) {
        content = AFSDKPanelContentFeedbackOnly;
    }
    
    else {
        return AFANE_BOOLToFREObject(NO);
    }
    
    // Style type.
    NSString *styleString = AFANE_FREObjectToNSString(argv[1]);
    AFSDKPanelStyle style;
    if (![styleString respondsToSelector:@selector(isEqualToString:)]) {
        return AFANE_BOOLToFREObject(NO);
    }
    
    // Default
    if ([styleString isEqualToString:@"AFSDKPanelStyleDefault"]) {
        style = AFSDKPanelStyleDefault;
    }
    
    // Fullscreen.
    else if ([styleString isEqualToString:@"AFSDKPanelStyleFullscreen"]) {
        style = AFSDKPanelStyleFullscreen;
    }
    
    else {
        return AFANE_BOOLToFREObject(NO);
    }
    
    NSError *error = [AppsfireSDK presentPanelForContent:content withStyle:style];
    return AFANE_BOOLToFREObject(error == nil);
}

DEFINE_ANE_FUNCTION(afsdk_dismissPanel) {
    [AppsfireSDK dismissPanel];
    return nil;
}

DEFINE_ANE_FUNCTION(afsdk_isDisplayed) {
    BOOL isDisplayed = [AppsfireSDK isDisplayed];
    return AFANE_BOOLToFREObject(isDisplayed);
}

DEFINE_ANE_FUNCTION(afsdk_openSDKNotificationID) {
    // Getting the notification id;
    uint32_t notificationId;
    FREGetObjectAsUint32(argv[0], &notificationId);
    
    [AppsfireSDK openSDKNotificationID:notificationId];
    return nil;
}

DEFINE_ANE_FUNCTION(afsdk_setColors) {
    NSString *backgroundColorString = AFANE_FREObjectToNSString(argv[0]);
    NSString *textColorString = AFANE_FREObjectToNSString(argv[1]);
    
    UIColor *backgroundColor = colorFromHexString(backgroundColorString);
    UIColor *textColor = colorFromHexString(textColorString);
    
    if (!backgroundColor || !textColor) {
        return nil;
    }
    
    [AppsfireSDK setBackgroundColor:backgroundColor textColor:textColor];
    return nil;
}

DEFINE_ANE_FUNCTION(afsdk_setUserEmail) {
    NSString *email = AFANE_FREObjectToNSString(argv[0]);
    BOOL isModifiable = AFANE_FREObjectToBoolean(argv[1]);
    
    if (![email isKindOfClass:NSString.class]) {
        return nil;
    }
    
    BOOL succeeded = [AppsfireSDK setUserEmail:email isModifiable:isModifiable];
    return AFANE_BOOLToFREObject(succeeded);
}

DEFINE_ANE_FUNCTION(afsdk_setShowFeedbackButton) {
    BOOL shouldShowFeedback = AFANE_FREObjectToBoolean(argv[0]);
    [AppsfireSDK setShowFeedbackButton:shouldShowFeedback];
    return nil;
}

DEFINE_ANE_FUNCTION(afsdk_getAFSDKVersionInfo) {
    NSString *versionInfo = [AppsfireSDK getAFSDKVersionInfo];
    return AFANE_NSStringToFREObject(versionInfo);
}

DEFINE_ANE_FUNCTION(afsdk_numberOfPendingNotifications) {
    uint32_t pendingNotificationCount = (uint32_t)[AppsfireSDK numberOfPendingNotifications];
    return AFANE_NSUIntegerToFREObject(pendingNotificationCount);
}

DEFINE_ANE_FUNCTION(afsdk_getSessionID) {
    NSString *sessionId = [AppsfireSDK getSessionID];
    return AFANE_NSStringToFREObject(sessionId);
}

DEFINE_ANE_FUNCTION(afsdk_resetCache) {
    [AppsfireSDK resetCache];
    return nil;
}

DEFINE_ANE_FUNCTION(afsdk_setUseDelegate) {
    BOOL shouldUseDelegate = AFANE_FREObjectToBoolean(argv[0]);
    
    appsfireSDKDelegate = nil;
    
    if (shouldUseDelegate) {
        appsfireSDKDelegate = [[AppsfireSDKDelegate alloc] initWithContext:context];
    }
    
    [AppsfireSDK setDelegate:appsfireSDKDelegate];
    
    return nil;
}

#pragma mark - C Interface (Appsfire Ad SDK)

DEFINE_ANE_FUNCTION(afadsdk_prepare) {
    [AppsfireAdSDK prepare];
    return nil;
}

DEFINE_ANE_FUNCTION(afadsdk_isInitialized) {
    return AFANE_BOOLToFREObject([AppsfireAdSDK isInitialized]);
}

DEFINE_ANE_FUNCTION(afadsdk_areAdsLoaded) {
    return AFANE_BOOLToFREObject([AppsfireAdSDK isInitialized]);
}

DEFINE_ANE_FUNCTION(afadsdk_setUseInAppDownloadWhenPossible) {
    BOOL shouldUseInAppDownload = AFANE_FREObjectToBoolean(argv[0]);
    [AppsfireAdSDK setUseInAppDownloadWhenPossible:shouldUseInAppDownload];
    return nil;
}

DEFINE_ANE_FUNCTION(afadsdk_setDebugModeEnabled) {
    BOOL isDebugEnabled = AFANE_FREObjectToBoolean(argv[0]);
    [AppsfireAdSDK setDebugModeEnabled:isDebugEnabled];
    return nil;
}

DEFINE_ANE_FUNCTION(afadsdk_requestModalAd) {
    
    NSString *modalTypeString = AFANE_FREObjectToNSString(argv[0]);
    if (![modalTypeString respondsToSelector:@selector(isEqualToString:)]) {
        return nil;
    }
    
    AFAdSDKModalType modalType;
    if ([modalTypeString isEqualToString:@"AFAdSDKModalTypeSushi"]) {
        modalType = AFAdSDKModalTypeSushi;
    }
    
    else if ([modalTypeString isEqualToString:@"AFAdSDKModalTypeUraMaki"]) {
        modalType = AFAdSDKModalTypeUraMaki;
    }
    
    else {
        return nil;
    }
    
    if (!([AppsfireAdSDK isThereAModalAdAvailableForType:modalType] == AFAdSDKAdAvailabilityYes)) {
        return nil;
    }
    
    // Getting the timer count value.
    uint32_t timerCount;
    FREGetObjectAsUint32(argv[1], &timerCount);
    
    // Requesting with a timer.
    if (timerCount != 0) {
        [[[AppsfireAdTimerView alloc] initWithCountdownStart:timerCount] presentWithCompletion:^(BOOL accepted) {
            if (accepted) {
                [AppsfireAdSDK requestModalAd:modalType withController:ROOT_VIEW_CONTROLLER];
            }
        }];
    }
    
    // Requesting without timer.
    else {
        [AppsfireAdSDK requestModalAd:modalType withController:ROOT_VIEW_CONTROLLER];
    }
    
    return nil;
}

DEFINE_ANE_FUNCTION(afadsdk_isThereAModalAdAvailable) {
    
    NSString *modalTypeString = AFANE_FREObjectToNSString(argv[0]);
    if (![modalTypeString respondsToSelector:@selector(isEqualToString:)]) {
        return AFANE_BOOLToFREObject(NO);
    }
    
    AFAdSDKModalType modalType;
    if ([modalTypeString isEqualToString:@"AFAdSDKModalTypeSushi"]) {
        modalType = AFAdSDKModalTypeSushi;
    }
    
    else if ([modalTypeString isEqualToString:@"AFAdSDKModalTypeUraMaki"]) {
        modalType = AFAdSDKModalTypeUraMaki;
    }
    
    else {
        return AFANE_BOOLToFREObject(NO);
    }
    
    return AFANE_BOOLToFREObject([AppsfireAdSDK isThereAModalAdAvailableForType:modalType]);
}

DEFINE_ANE_FUNCTION(afadsdk_forceDismissalOfModalAd) {
    BOOL dismissed = [AppsfireAdSDK forceDismissalOfModalAd];
    return AFANE_BOOLToFREObject(dismissed);
}

DEFINE_ANE_FUNCTION(afadsdk_cancelPendingAdModalRequest) {
    BOOL cancelPending = [AppsfireAdSDK cancelPendingAdModalRequest];
    return AFANE_BOOLToFREObject(cancelPending);
}

DEFINE_ANE_FUNCTION(afadsdk_isModalAdDisplayed) {
    Boolean isModalDisplayed = [AppsfireAdSDK isModalAdDisplayed];
    return AFANE_BOOLToFREObject(isModalDisplayed);
}

DEFINE_ANE_FUNCTION(afadsdk_setUseDelegate) {
    BOOL shouldUseDelegate = AFANE_FREObjectToBoolean(argv[0]);
    
    appsfireAdSDKDelegate = nil;
    
    if (shouldUseDelegate) {
        appsfireAdSDKDelegate = [[AppsfireAdSDKDelegate alloc] initWithContext:context];
    }
    
    [AppsfireAdSDK setDelegate:appsfireAdSDKDelegate];
    
    return nil;
}

#pragma mark - ANE setup

void AppsfireANEContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet) {
    NSDictionary *functions = @{
                                @"afsdk_connectWithAPIKey": [NSValue valueWithPointer:&afsdk_connectWithAPIKey],
                                @"afsdk_connectWithAPIKeyAndDelay" : [NSValue valueWithPointer:&afsdk_connectWithAPIKeyAndDelay],
                                @"afsdk_setFeatures" : [NSValue valueWithPointer:&afsdk_setFeatures],
                                @"afsdk_isInitialized" : [NSValue valueWithPointer:&afsdk_isInitialized],
                                @"afsdk_pause" : [NSValue valueWithPointer:&afsdk_pause],
                                @"afsdk_resume" : [NSValue valueWithPointer:&afsdk_resume],
                                @"afsdk_registerPushTokenString" : [NSValue valueWithPointer:&afsdk_registerPushTokenString],
                                @"afsdk_handleBadgeCountLocally" : [NSValue valueWithPointer:&afsdk_handleBadgeCountLocally],
                                @"afsdk_handleBadgeCountLocallyAndRemotely" : [NSValue valueWithPointer:&afsdk_handleBadgeCountLocallyAndRemotely],
                                @"afsdk_presentPanel" : [NSValue valueWithPointer:&afsdk_presentPanel],
                                @"afsdk_dismissPanel" : [NSValue valueWithPointer:&afsdk_dismissPanel],
                                @"afsdk_isDisplayed" : [NSValue valueWithPointer:&afsdk_isDisplayed],
                                @"afsdk_openSDKNotificationID" : [NSValue valueWithPointer:&afsdk_openSDKNotificationID],
                                @"afsdk_setColors" : [NSValue valueWithPointer:&afsdk_setColors],
                                @"afsdk_setUserEmail" : [NSValue valueWithPointer:&afsdk_setUserEmail],
                                @"afsdk_setShowFeedbackButton" : [NSValue valueWithPointer:&afsdk_setShowFeedbackButton],
                                @"afsdk_getAFSDKVersionInfo" : [NSValue valueWithPointer:&afsdk_getAFSDKVersionInfo],
                                @"afsdk_numberOfPendingNotifications" : [NSValue valueWithPointer:&afsdk_numberOfPendingNotifications],
                                @"afsdk_getSessionID" : [NSValue valueWithPointer:&afsdk_getSessionID],
                                @"afsdk_resetCache" : [NSValue valueWithPointer:&afsdk_resetCache],
                                @"afsdk_setUseDelegate" : [NSValue valueWithPointer:&afsdk_setUseDelegate],
                                
                                @"afadsdk_prepare" : [NSValue valueWithPointer:&afadsdk_prepare],
                                @"afadsdk_isInitialized" : [NSValue valueWithPointer:&afadsdk_isInitialized],
                                @"afadsdk_areAdsLoaded" : [NSValue valueWithPointer:&afadsdk_areAdsLoaded],
                                @"afadsdk_setUseInAppDownloadWhenPossible" : [NSValue valueWithPointer:&afadsdk_setUseInAppDownloadWhenPossible],
                                @"afadsdk_setDebugModeEnabled" : [NSValue valueWithPointer:&afadsdk_setDebugModeEnabled],
                                @"afadsdk_requestModalAd" : [NSValue valueWithPointer:&afadsdk_requestModalAd],
                                @"afadsdk_isThereAModalAdAvailable" : [NSValue valueWithPointer:&afadsdk_isThereAModalAdAvailable],
                                @"afadsdk_forceDismissalOfModalAd" : [NSValue valueWithPointer:&afadsdk_forceDismissalOfModalAd],
                                @"afadsdk_cancelPendingAdModalRequest" : [NSValue valueWithPointer:&afadsdk_cancelPendingAdModalRequest],
                                @"afadsdk_isModalAdDisplayed" : [NSValue valueWithPointer:&afadsdk_isModalAdDisplayed],
                                @"afadsdk_setUseDelegate" : [NSValue valueWithPointer:&afadsdk_setUseDelegate],
                                };
    
    *numFunctionsToTest = (uint32_t)[functions count];
    FRENamedFunction *func = (FRENamedFunction *)malloc(sizeof(FRENamedFunction) * (*numFunctionsToTest));
    for (NSInteger i = 0; i < *numFunctionsToTest; i++) {
        func[i].name = (const uint8_t *)[[[functions allKeys] objectAtIndex:i] UTF8String];
        func[i].functionData = NULL;
        func[i].function = [[[functions allValues] objectAtIndex:i] pointerValue];
    }
    
    *functionsToSet = func;
    context = ctx;
}

void AppsfireANEContextFinalizer(FREContext ctx) { }

void AppsfireANEInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet) {
	*extDataToSet = NULL;
	*ctxInitializerToSet = &AppsfireANEContextInitializer;
	*ctxFinalizerToSet = &AppsfireANEContextFinalizer;
}

void AppsfireANEFinalizer(void* extData) {
}