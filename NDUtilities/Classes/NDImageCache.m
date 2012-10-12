//
//  NDImageCache.m
//
//
//  Created by Lars Gerckens on 30.10.11.
//  Copyright (c) 2012 lars@nulldesign.de All rights reserved.
//

#import "NDImageCache.h"

@interface NDImageCache ()
{
	NSMutableDictionary *_imageEntries;
	NSMutableDictionary *_accessTimeEntries;
}

@end

enum {
	kImageCacheSize = 50
};

inline static NSNumber *makeCurrentTime()
{
	time_t t = time(NULL);
	NSNumber *num = [[NSNumber alloc] initWithInteger:t];
	return num;
}


@implementation NDImageCache

+ (NSMutableDictionary *) cacheRealms
{
    static NSMutableDictionary *kCacheRealms = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        kCacheRealms = [NSMutableDictionary dictionaryWithCapacity:4];
    });

    return kCacheRealms;
}

- (id)init
{
    if (self = [super init])
    {
        _imageEntries = [NSMutableDictionary dictionaryWithCapacity:kImageCacheSize];
		_accessTimeEntries = [NSMutableDictionary dictionaryWithCapacity:kImageCacheSize];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clear) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (UIImage *)imageForURLString:(NSString *)urlString
{
	UIImage *img = [_imageEntries objectForKey:urlString];
	
	if (img != nil)
    {
		NSNumber *timeStamp = makeCurrentTime();
		[_accessTimeEntries setObject:timeStamp forKey:urlString];
	}
	
	return img;
}

- (void)setImage:(UIImage*)image forURLString:(NSString *)urlString
{
	if ([_imageEntries count] + 1 > kImageCacheSize)
    {
		NSArray *sortedDates = [_accessTimeEntries keysSortedByValueUsingSelector:@selector(compare:)];
		
		if ([sortedDates count] > 0)
        {
			NSString *oldestKey = [sortedDates objectAtIndex:0];
			[_imageEntries removeObjectForKey:oldestKey];
			[_accessTimeEntries removeObjectForKey:oldestKey];
		}
	}
	
    [_imageEntries setObject:image forKey:urlString];

	NSNumber *timeStamp = makeCurrentTime();
	[_accessTimeEntries setObject:timeStamp forKey:urlString];
}


- (void)clear
{
    _imageEntries = [NSMutableDictionary dictionaryWithCapacity:kImageCacheSize];
    _accessTimeEntries = [NSMutableDictionary dictionaryWithCapacity:kImageCacheSize];
}

+ (NDImageCache *)imageCacheForRealm:(id)realm
{
    @synchronized (self)
    {
        NDImageCache *cache = [[NDImageCache cacheRealms] objectForKey:realm];
        if (cache == nil)
        {
            cache = [NDImageCache imageCache];
            [[NDImageCache cacheRealms] setObject:cache forKey:realm];
        }
        return cache;
    }
}

+ (NDImageCache *)imageCache
{
    return [[NDImageCache alloc] init];
}


@end
