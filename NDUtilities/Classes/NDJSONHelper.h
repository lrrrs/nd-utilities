//
//  JSONHelper.h
//
//  Created by Lars Gerckens on 15.10.12.
//  Copyright (c) 2012 lars@nulldesign.de. All rights reserved.
//

#import <Foundation/Foundation.h>

static inline BOOL GetBoolFromDict(NSDictionary *dict, NSString *key)
{
    return [[dict objectForKey:key] isKindOfClass:[NSNull class]] ? NO :[[dict objectForKey:key] boolValue];
}



static inline NSInteger GetIntFromDict(NSDictionary *dict, NSString *key)
{
    return (((NSNumber*) [dict objectForKey:key]).intValue);
}



static inline NSString* GetStringOrNilFromDict(NSDictionary *dict, NSString *key)
{
    return [[dict objectForKey:key] isKindOfClass:[NSNull class]] ||
           [dict objectForKey:key] == nil ||
           ((NSString*) [dict objectForKey:key]).length <= 0 ? nil :[dict objectForKey:key];
}



static inline NSDate* GetDateFromJSON(NSString *dateString)
{
    int startPos = [dateString rangeOfString:@"("].location + 1;
    int endPos = [dateString rangeOfString:@")"].location;
    NSRange range = NSMakeRange(startPos, endPos - startPos);
    unsigned long long milliseconds = [[dateString substringWithRange:range] longLongValue];

    NSTimeInterval interval = milliseconds / 1000;
    NSDate *dateFromJson = [NSDate dateWithTimeIntervalSince1970:interval];

    return dateFromJson;
}


