//
//  AppsfireAdSDKModalDelegate.h
//  AppsfireANE
//
//  Created by Ali Karagoz on 11/08/14.
//  Copyright (c) 2014 Appsfire. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlashRuntimeExtensions.h"
#import "AppsfireAdSDK.h"

@interface AppsfireAdSDKModalDelegate : NSObject <AFAdSDKModalDelegate>

- (id)initWithContext:(FREContext)context;

@end
