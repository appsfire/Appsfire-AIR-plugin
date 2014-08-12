//
//  AppsfireAdSDKModalDelegate.m
//  AppsfireANE
//
//  Created by Ali Karagoz on 11/08/14.
//  Copyright (c) 2014 Appsfire. All rights reserved.
//

#import "AppsfireAdSDKModalDelegate.h"
#import "AFANEUtils.h"

#define AFADSDK_MODAL_AD_REQUEST_DID_FAIL_WITH_ERROR @"AFADSDK_MODAL_AD_REQUEST_DID_FAIL_WITH_ERROR"
#define AFADSDK_MODAL_AD_WILL_APPEAR @"AFADSDK_MODAL_AD_WILL_APPEAR"
#define AFADSDK_MODAL_AD_DID_APPEAR @"AFADSDK_MODAL_AD_DID_APPEAR"
#define AFADSDK_MODAL_AD_WILL_DISAPPEAR @"AFADSDK_MODAL_AD_WILL_DISAPPEAR"
#define AFADSDK_MODAL_AD_DID_DISAPPEAR @"AFADSDK_MODAL_AD_DID_DISAPPEAR"

@interface AppsfireAdSDKModalDelegate ()

@property (nonatomic, assign) FREContext context;

@end

@implementation AppsfireAdSDKModalDelegate

#pragma mark - Init

- (id)initWithContext:(FREContext)context {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _context = context;
    
    return self;
}

#pragma mark - AppsfireAdSDKModalDelegate

- (void)modalAdRequestDidFailWithError:(NSError *)error {
    AFANE_DispatchEventWithInfo(self.context, AFADSDK_MODAL_AD_REQUEST_DID_FAIL_WITH_ERROR, error.description);
    AFANE_Log(self.context, [NSString stringWithFormat:@"modalAdRequestDidFailWithError : %@", error.description]);
}

- (void)modalAdWillAppear {
    AFANE_DispatchEvent(self.context, AFADSDK_MODAL_AD_WILL_APPEAR);
    AFANE_Log(self.context, @"modalAdWillAppear");
}

- (void)modalAdDidAppear {
    AFANE_DispatchEvent(self.context, AFADSDK_MODAL_AD_DID_APPEAR);
    AFANE_Log(self.context, @"modalAdDidAppear");
}

- (void)modalAdWillDisappear {
    AFANE_DispatchEvent(self.context, AFADSDK_MODAL_AD_WILL_DISAPPEAR);
    AFANE_Log(self.context, @"modalAdWillDisappear");
}

- (void)modalAdDidDisappear {
    AFANE_DispatchEvent(self.context, AFADSDK_MODAL_AD_DID_DISAPPEAR);
    AFANE_Log(self.context, @"modalAdDidDisappear");
}

@end
