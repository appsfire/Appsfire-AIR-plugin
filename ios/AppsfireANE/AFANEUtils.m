//
//  AFANEUtils.m
//  AppsfireANE
//
//  Created by Ali Karagoz on 25/03/14.
//  Copyright (c) 2014 Appsfire. All rights reserved.
//

#import "AFANEUtils.h"

#pragma mark - Dispatch events

void AFANE_DispatchEvent(FREContext context, NSString *eventName) {
    FREDispatchStatusEventAsync(context, (const uint8_t *)[eventName UTF8String], (const uint8_t *)"");
}

void AFANE_DispatchEventWithInfo(FREContext context, NSString *eventName, NSString *eventInfo) {
    FREDispatchStatusEventAsync(context, (const uint8_t *)[eventName UTF8String], (const uint8_t *)[eventInfo UTF8String]);
}

void AFANE_Log(FREContext context, NSString *message) {
    AFANE_DispatchEventWithInfo(context, @"LOGGING", message);
}

#pragma mark - FREObject to Obj-C

NSString * AFANE_FREObjectToNSString(FREObject object) {
    uint32_t stringLength;
    const uint8_t *string;
    FREGetObjectAsUTF8(object, &stringLength, &string);
    return [NSString stringWithUTF8String:(char*)string];
}

BOOL AFANE_FREObjectToBoolean(FREObject object) {
    uint32_t boolInt = 0;
    FREGetObjectAsBool(object, &boolInt);
    return (boolInt != 0);
}

NSArray * AFANE_FREObjectToNSArrayOfNSString(FREObject object) {
    uint32_t arrayLength;
    FREGetArrayLength(object, &arrayLength);
    
    uint32_t stringLength;
    NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:arrayLength];
    for (uint32_t i = 0; i < arrayLength; i++) {
        FREObject itemRaw;
        FREGetArrayElementAt(object, i, &itemRaw);
        
        // Convert item to string. Skip with warning if not possible.
        const uint8_t *itemString;
        if (FREGetObjectAsUTF8(itemRaw, &stringLength, &itemString) != FRE_OK) {
            NSLog(@"Couldn't convert FREObject to NSString at index %u", i);
            continue;
        }
        
        NSString *item = [NSString stringWithUTF8String:(char*)itemString];
        [mutableArray addObject:item];
    }
    
    return [NSArray arrayWithArray:mutableArray];
}

NSDictionary * AFANE_FREObjectsToNSDictionaryOfNSString(FREObject keys, FREObject values) {
    uint32_t numKeys, numValues;
    FREGetArrayLength(keys, &numKeys);
    FREGetArrayLength(values, &numValues);
    
    uint32_t stringLength;
    uint32_t numItems = MIN(numKeys, numValues);
    NSMutableDictionary *mutableDictionary = [NSMutableDictionary dictionaryWithCapacity:numItems];
    for (uint32_t i = 0; i < numItems; i++) {
        FREObject keyRaw, valueRaw;
        FREGetArrayElementAt(keys, i, &keyRaw);
        FREGetArrayElementAt(values, i, &valueRaw);
        
        // Convert key and value to strings. Skip with warning if not possible.
        const uint8_t *keyString, *valueString;
        if (FREGetObjectAsUTF8(keyRaw, &stringLength, &keyString) != FRE_OK || FREGetObjectAsUTF8(valueRaw, &stringLength, &valueString) != FRE_OK) {
            NSLog(@"Couldn't convert FREObject to NSString at index %u", i);
            continue;
        }
        
        NSString *key = [NSString stringWithUTF8String:(char*)keyString];
        NSString *value = [NSString stringWithUTF8String:(char*)valueString];
        [mutableDictionary setObject:value forKey:key];
    }
    
    return [NSDictionary dictionaryWithDictionary:mutableDictionary];
}

#pragma mark - Obj-C to FREObject

FREObject AFANE_NSUIntegerToFREObject(uint32_t integer) {
    FREObject result;
    FRENewObjectFromUint32(integer, &result);
    return result;
}

FREObject AFANE_BOOLToFREObject(BOOL boolean) {
    FREObject result;
    FRENewObjectFromBool(boolean, &result);
    return result;
}

FREObject AFANE_NSStringToFREObject(NSString *string) {
    FREObject result;
    FRENewObjectFromUTF8((uint8_t)string.length, (const uint8_t *)[string UTF8String], &result);
    return result;
}

#pragma mark - UIColor Utils

UIColor * colorFromHexString(NSString *hexString) {
    if (![hexString isKindOfClass:NSString.class]) {
        return nil;
    }
    
    uint32_t rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    
    // Skip '#' character.
    [scanner setScanLocation:1];
    
    // Scanning.
    BOOL foundHex = [scanner scanHexInt:&rgbValue];
    if (foundHex) {
        CGFloat r = ((rgbValue & 0xFF0000) >> 16) / 255.0;
        CGFloat g = ((rgbValue & 0xFF00) >> 8) / 255.0;
        CGFloat b = (rgbValue & 0xFF) / 255.0;
        return [UIColor colorWithRed:r green:g blue:b alpha:1.0];
    } else {
        return nil;
    }
}