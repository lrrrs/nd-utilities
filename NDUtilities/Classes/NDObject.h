//
//  NDObject.h
//  GTG-CS
//
//  Created by Lars Gerckens on 28.08.12.
//  Copyright (c) 2012 3M GTG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NDObject : NSObject
{
    NSMutableArray *invocations;
	NSMutableArray *invocationControlEvents;
}

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(NSInteger)controlEvents;
- (void)removeTarget:(id)target action:(SEL)action forControlEvents:(NSInteger)controlEvents;
- (void)invokeControlEvent:(NSInteger)controlEvent withData:(NSObject*)data;
- (void)invokeControlEvent:(NSInteger)controlEvent;

@end
