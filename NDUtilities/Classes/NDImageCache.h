//
//  NDImageCache.h
//
//
//  Created by Lars Gerckens on 30.10.11.
//  Copyright (c) 2012 lars@nulldesign.de All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NDImageCache : NSObject

- (UIImage *)imageForURLString:(NSString *)urlString;
- (void)setImage:(UIImage*)image forURLString:(NSString *)urlString;
- (void)clear;

+ (NDImageCache *)imageCacheForRealm:(id)realm;
+ (NDImageCache *)imageCache;

@end
