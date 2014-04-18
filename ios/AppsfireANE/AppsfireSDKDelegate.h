//
//  AppsfireSDKDelegate.h
//  AppsfireANE
//
//  Created by Ali Karagoz on 18/04/14.
//  Copyright (c) 2014 Appsfire. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlashRuntimeExtensions.h"
#import "AppsfireSDK.h"

@interface AppsfireSDKDelegate : NSObject <AppsfireSDKDelegate>

- (id)initWithContext:(FREContext)context;

@end
