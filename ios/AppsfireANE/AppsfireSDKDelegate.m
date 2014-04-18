//
//  AppsfireSDKDelegate.m
//  AppsfireANE
//
//  Created by Ali Karagoz on 18/04/14.
//  Copyright (c) 2014 Appsfire. All rights reserved.
//

#import "AppsfireSDKDelegate.h"
#import "AFANEUtils.h"

#define AFSDK_OPEN_NOTIFICATION_DID_FINISH                @"AFSDK_OPEN_NOTIFICATION_DID_FINISH"

@interface AppsfireSDKDelegate ()

@property (nonatomic, assign) FREContext context;

@end

@implementation AppsfireSDKDelegate

#pragma mark - Init

- (id)initWithContext:(FREContext)context {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _context = context;
    
    return self;
}

#pragma mark - AppsfireSDKDelegate

- (void)openNotificationDidFinish:(BOOL)succeeded withError:(NSError *)error {
    AFANE_DispatchEventWithInfo(_context, AFSDK_OPEN_NOTIFICATION_DID_FINISH, error.description);
    AFANE_Log(_context, [NSString stringWithFormat:@"openNotificationDidFinishWithError : %@", error.description]);
}

@end
