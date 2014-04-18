//
//  AFANEUtils.h
//  AppsfireANE
//
//  Created by Ali Karagoz on 25/03/14.
//  Copyright (c) 2014 Appsfire. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FlashRuntimeExtensions.h"

#define DEFINE_ANE_FUNCTION(fn) FREObject fn(FREContext context, void* functionData, uint32_t argc, FREObject argv[])

#define ROOT_VIEW_CONTROLLER [[[UIApplication sharedApplication] keyWindow] rootViewController]

void AFANE_DispatchEvent(FREContext context, NSString *eventName);
void AFANE_DispatchEventWithInfo(FREContext context, NSString *eventName, NSString *eventInfo);
void AFANE_Log(FREContext context, NSString *message);

NSString * AFANE_FREObjectToNSString(FREObject object);
BOOL AFANE_FREObjectToBoolean(FREObject object);
NSArray * AFANE_FREObjectToNSArrayOfNSString(FREObject object);
NSDictionary * AFANE_FREObjectsToNSDictionaryOfNSString(FREObject keys, FREObject values);

FREObject AFANE_NSUIntegerToFREObject(uint32_t integer);
FREObject AFANE_BOOLToFREObject(BOOL boolean);
FREObject AFANE_NSStringToFREObject(NSString *string);
UIColor * colorFromHexString(NSString *hexString);