//
//  UUIDGenerator.m
//  wywy
//
//  Created by Lars Gerckens on 10.05.12.
//  Copyright (c) 2012 lars@nulldesign.de. All rights reserved.
//

#define kDeviceUUIDKey    @"uniqueIDKey"

#import "UUIDGenerator.h"

@implementation UUIDGenerator

+(NSString *)getDeviceUUID
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSString *tempUniqueID = nil;

	if (![defaults objectForKey:kDeviceUUIDKey])
	{
		CFUUIDRef theUUID = CFUUIDCreate(kCFAllocatorDefault);

		if (theUUID)
		{
			tempUniqueID = (__bridge NSString *)CFUUIDCreateString(kCFAllocatorDefault, theUUID);
			CFRelease(theUUID);

			[defaults setObject:tempUniqueID forKey:kDeviceUUIDKey];
			[defaults synchronize];
		}
	}
	else
	{
		tempUniqueID = [defaults objectForKey:kDeviceUUIDKey];
	}

	return tempUniqueID;
}



@end