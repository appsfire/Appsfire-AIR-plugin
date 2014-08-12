//
//  AppsfireAdSDKDelegate.m
//  AppsfireANE
//
//  Created by Ali Karagoz on 17/04/14.
//  Copyright (c) 2014 Appsfire. All rights reserved.
//

#import "AppsfireAdSDKDelegate.h"
#import "AFANEUtils.h"

#define AFADSDK_MODAL_ADS_REFRESHED_AND_AVAILABLE @"AFADSDK_MODAL_ADS_REFRESHED_AND_AVAILABLE"
#define AFADSDK_MODAL_ADS_REFRESHED_AND_NOT_AVAILABLE @"AFADSDK_MODAL_ADS_REFRESHED_AND_NOT_AVAILABLE"

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

- (void)modalAdsRefreshedAndAvailable {
    AFANE_DispatchEvent(self.context, AFADSDK_MODAL_ADS_REFRESHED_AND_AVAILABLE);
    AFANE_Log(self.context, @"modalAdsRefreshedAndAvailable");
}

- (void)modalAdsRefreshedAndNotAvailable {
    AFANE_DispatchEvent(self.context, AFADSDK_MODAL_ADS_REFRESHED_AND_NOT_AVAILABLE);
    AFANE_Log(self.context, @"modalAdsRefreshedAndNotAvailable");
}

@end
