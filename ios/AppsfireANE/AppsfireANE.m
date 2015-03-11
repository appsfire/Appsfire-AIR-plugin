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
#import "AppsfireEngageSDK.h"
#import "AppsfireSDK+Additions.h"

// Delegates
#import "AppsfireAdSDKDelegate.h"
#import "AppsfireEngageSDKDelegate.h"
#import "AppsfireAdSDKModalDelegate.h"

#pragma mark - C Interface (Appsfire SDK)

static FREContext context;
static AppsfireAdSDKDelegate *appsfireAdSDKDelegate;
static AppsfireEngageSDKDelegate *appsfireEngageSDKDelegate;
static AppsfireAdSDKModalDelegate *appsfireAdSDKModalDelegate;

DEFINE_ANE_FUNCTION(afsdk_connectWithParameters) {
    
    // Getting the SDK Token.
    NSString *sdkToken = AFANE_FREObjectToNSString(argv[0]);
    
    // Getting the Secret Key.
    NSString *secretKey = AFANE_FREObjectToNSString(argv[1]);
    
    // Getting the features.
    BOOL isEngageEnabled = AFANE_FREObjectToBoolean(argv[2]);
    BOOL isMonetizationEnabled = AFANE_FREObjectToBoolean(argv[3]);
    
    // Building our feature bitmask.
    AFSDKFeature features = (AFSDKFeatureEngage|AFSDKFeatureMonetization);
    
    if (!isEngageEnabled) {
        features ^= AFSDKFeatureEngage;
    }
    
    if (!isMonetizationEnabled) {
        features ^= AFSDKFeatureMonetization;
    }
    
    NSError *error = [AppsfireSDK connectWithSDKToken:sdkToken secretKey:secretKey features:features parameters:nil];
    
    // Return a boolean value if there are no error.
    return AFANE_BOOLToFREObject(!error);
}

DEFINE_ANE_FUNCTION(afsdk_isInitialized) {
    return AFANE_BOOLToFREObject([AppsfireSDK isInitialized]);
}

DEFINE_ANE_FUNCTION(afsdk_versionDescription) {
    NSString *versionDescription = [AppsfireSDK versionDescription];
    return AFANE_NSStringToFREObject(versionDescription);
}

#pragma mark - C Interface (Appsfire Engage SDK)

DEFINE_ANE_FUNCTION(afesdk_registerPushTokenString) {
    NSString *pushToken = AFANE_FREObjectToNSString(argv[0]);
    [AppsfireSDK registerPushTokenString:pushToken];
    return nil;
}

DEFINE_ANE_FUNCTION(afesdk_handleBadgeCountLocally) {
    BOOL shoudHandleLocally = AFANE_FREObjectToBoolean(argv[0]);
    [AppsfireEngageSDK handleBadgeCountLocally:shoudHandleLocally];
    return nil;
}

DEFINE_ANE_FUNCTION(afesdk_handleBadgeCountLocallyAndRemotely) {
    BOOL shouldHandleLocallyAndRemotely = AFANE_FREObjectToBoolean(argv[0]);
    [AppsfireEngageSDK handleBadgeCountLocallyAndRemotely:shouldHandleLocallyAndRemotely];
    return nil;
}

DEFINE_ANE_FUNCTION(afesdk_presentPanel) {
    
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
    
    NSError *error = [AppsfireEngageSDK presentPanelForContent:content withStyle:style];
    return AFANE_BOOLToFREObject(error == nil);
}

DEFINE_ANE_FUNCTION(afesdk_dismissPanel) {
    [AppsfireEngageSDK dismissPanel];
    return nil;
}

DEFINE_ANE_FUNCTION(afesdk_isDisplayed) {
    BOOL isDisplayed = [AppsfireEngageSDK isDisplayed];
    return AFANE_BOOLToFREObject(isDisplayed);
}

DEFINE_ANE_FUNCTION(afesdk_openSDKNotificationID) {
    // Getting the notification id;
    uint32_t notificationId;
    FREGetObjectAsUint32(argv[0], &notificationId);
    
    [AppsfireEngageSDK openSDKNotificationID:notificationId];
    return nil;
}

DEFINE_ANE_FUNCTION(afesdk_setColors) {
    NSString *backgroundColorString = AFANE_FREObjectToNSString(argv[0]);
    NSString *textColorString = AFANE_FREObjectToNSString(argv[1]);
    
    UIColor *backgroundColor = colorFromHexString(backgroundColorString);
    UIColor *textColor = colorFromHexString(textColorString);
    
    if (!backgroundColor || !textColor) {
        return nil;
    }
    
    [AppsfireEngageSDK setBackgroundColor:backgroundColor textColor:textColor];
    return nil;
}

DEFINE_ANE_FUNCTION(afesdk_setUserEmail) {
    NSString *email = AFANE_FREObjectToNSString(argv[0]);
    BOOL isModifiable = AFANE_FREObjectToBoolean(argv[1]);
    
    if (![email isKindOfClass:NSString.class]) {
        return nil;
    }
    
    BOOL succeeded = [AppsfireEngageSDK setUserEmail:email isModifiable:isModifiable];
    return AFANE_BOOLToFREObject(succeeded);
}

DEFINE_ANE_FUNCTION(afesdk_setShowFeedbackButton) {
    BOOL shouldShowFeedback = AFANE_FREObjectToBoolean(argv[0]);
    [AppsfireEngageSDK setShowFeedbackButton:shouldShowFeedback];
    return nil;
}

DEFINE_ANE_FUNCTION(afesdk_numberOfPendingNotifications) {
    uint32_t pendingNotificationCount = (uint32_t)[AppsfireEngageSDK numberOfPendingNotifications];
    return AFANE_NSUIntegerToFREObject(pendingNotificationCount);
}

DEFINE_ANE_FUNCTION(afesdk_setUseDelegate) {
    
    appsfireEngageSDKDelegate = nil;
    BOOL shouldUseDelegate = AFANE_FREObjectToBoolean(argv[0]);
    
    if (shouldUseDelegate) {
        appsfireEngageSDKDelegate = [[AppsfireEngageSDKDelegate alloc] initWithContext:context];
    }
    
    [AppsfireEngageSDK setDelegate:appsfireEngageSDKDelegate];
    
    return nil;
}

#pragma mark - C Interface (Appsfire Ad SDK)

DEFINE_ANE_FUNCTION(afadsdk_areAdsLoaded) {
    return AFANE_BOOLToFREObject([AppsfireAdSDK areAdsLoaded]);
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
    
    // Getting the requested modal type.
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
    
    // Getting the use of the delegate.
    BOOL shouldUseDelegate = AFANE_FREObjectToBoolean(argv[1]);
    
    if (shouldUseDelegate) {
        appsfireAdSDKModalDelegate = [[AppsfireAdSDKModalDelegate alloc] initWithContext:context];
    }
    
    [AppsfireAdSDK requestModalAd:modalType withController:ROOT_VIEW_CONTROLLER withDelegate:appsfireAdSDKModalDelegate];
    
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

    appsfireAdSDKDelegate = nil;
    BOOL shouldUseDelegate = AFANE_FREObjectToBoolean(argv[0]);
    
    if (shouldUseDelegate) {
        appsfireAdSDKDelegate = [[AppsfireAdSDKDelegate alloc] initWithContext:context];
    }
    
    [AppsfireAdSDK setDelegate:appsfireAdSDKDelegate];
    
    return nil;
}

#pragma mark - ANE setup

void AppsfireANEContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet) {
    NSDictionary *functions = @{
                                
                                // Appsfire SDK (Common)
                                @"afsdk_connectWithParameters": [NSValue valueWithPointer:&afsdk_connectWithParameters],
                                @"afsdk_isInitialized" : [NSValue valueWithPointer:&afsdk_isInitialized],
                                @"afsdk_versionDescription" : [NSValue valueWithPointer:&afsdk_versionDescription],
                                
                                // Appsfire Engage SDK
                                @"afesdk_registerPushTokenString" : [NSValue valueWithPointer:&afesdk_registerPushTokenString],
                                @"afesdk_handleBadgeCountLocally" : [NSValue valueWithPointer:&afesdk_handleBadgeCountLocally],
                                @"afesdk_handleBadgeCountLocallyAndRemotely" : [NSValue valueWithPointer:&afesdk_handleBadgeCountLocallyAndRemotely],
                                @"afesdk_presentPanel" : [NSValue valueWithPointer:&afesdk_presentPanel],
                                @"afesdk_dismissPanel" : [NSValue valueWithPointer:&afesdk_dismissPanel],
                                @"afesdk_isDisplayed" : [NSValue valueWithPointer:&afesdk_isDisplayed],
                                @"afesdk_openSDKNotificationID" : [NSValue valueWithPointer:&afesdk_openSDKNotificationID],
                                @"afesdk_setColors" : [NSValue valueWithPointer:&afesdk_setColors],
                                @"afesdk_setUserEmail" : [NSValue valueWithPointer:&afesdk_setUserEmail],
                                @"afesdk_setShowFeedbackButton" : [NSValue valueWithPointer:&afesdk_setShowFeedbackButton],
                                @"afesdk_numberOfPendingNotifications" : [NSValue valueWithPointer:&afesdk_numberOfPendingNotifications],
                                @"afesdk_setUseDelegate" : [NSValue valueWithPointer:&afesdk_setUseDelegate],
                                
                                // Appsfire Ad SDK
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