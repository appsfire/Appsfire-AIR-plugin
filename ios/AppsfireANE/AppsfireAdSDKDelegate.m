//
//  AppsfireAdSDKDelegate.m
//  AppsfireANE
//
//  Created by Ali Karagoz on 17/04/14.
//  Copyright (c) 2014 Appsfire. All rights reserved.
//

#import "AppsfireAdSDKDelegate.h"
#import "AFANEUtils.h"

#define AFADSDK_ADUNIT_DID_INITIALIZE                @"AFADSDK_ADUNIT_DID_INITIALIZE"
#define AFADSDK_MODAL_AD_IS_READY_FOR_REQUEST        @"AFADSDK_MODAL_AD_IS_READY_FOR_REQUEST"
#define AFADSDK_MODAL_AD_REQUEST_DID_FAIL_WITH_ERROR @"AFADSDK_MODAL_AD_REQUEST_DID_FAIL_WITH_ERROR"
#define AFADSDK_MODAL_AD_WILL_APPEAR                 @"AFADSDK_MODAL_AD_WILL_APPEAR"
#define AFADSDK_MODAL_AD_DID_APPEAR                  @"AFADSDK_MODAL_AD_DID_APPEAR"
#define AFADSDK_MODAL_AD_WILL_DISAPPEAR              @"AFADSDK_MODAL_AD_WILL_DISAPPEAR"
#define AFADSDK_MODAL_AD_DID_DISAPPEAR               @"AFADSDK_MODAL_AD_DID_DISAPPEAR"

@interface AppsfireAdSDKDelegate ()

@property (nonatomic, assign) FREContext context;

@end

@implementation AppsfireAdSDKDelegate

#pragma mark - Init

- (id)initWithContext:(FREContext)context {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _context = context;
    
    return self;
}

#pragma mark - AppsfireAdSDKDelegate

- (void)adUnitDidInitialize {
    AFANE_DispatchEvent(_context, AFADSDK_ADUNIT_DID_INITIALIZE);
    AFANE_Log(_context, @"adUnitDidInitialize");
}

- (void)modalAdIsReadyForRequest {
    AFANE_DispatchEvent(_context, AFADSDK_MODAL_AD_IS_READY_FOR_REQUEST);
    AFANE_Log(_context, @"modalAdIsReadyForRequest");
}

- (void)modalAdRequestDidFailWithError:(NSError *)error {
    AFANE_DispatchEventWithInfo(_context, AFADSDK_MODAL_AD_REQUEST_DID_FAIL_WITH_ERROR, error.description);
    AFANE_Log(_context, [NSString stringWithFormat:@"modalAdRequestDidFailWithError : %@", error.description]);
}

- (void)modalAdWillAppear {
    AFANE_DispatchEvent(_context, AFADSDK_MODAL_AD_WILL_APPEAR);
    AFANE_Log(_context, @"modalAdWillAppear");
}

- (void)modalAdDidAppear {
    AFANE_DispatchEvent(_context, AFADSDK_MODAL_AD_DID_APPEAR);
    AFANE_Log(_context, @"modalAdDidAppear");
}

- (void)modalAdWillDisappear {
    AFANE_DispatchEvent(_context, AFADSDK_MODAL_AD_WILL_DISAPPEAR);
    AFANE_Log(_context, @"modalAdWillDisappear");
}

- (void)modalAdDidDisappear {
    AFANE_DispatchEvent(_context, AFADSDK_MODAL_AD_DID_DISAPPEAR);
    AFANE_Log(_context, @"modalAdDidDisappear");
}

@end
