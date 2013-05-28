//
//  NDObject.m
//
//  Created by Lars Gerckens on 28.08.12.
//  Copyright (c) 2012. All rights reserved.
//

#import "NDObject.h"

@implementation NDObject

- (id)init
{
    self = [super init];
    if(self) {
        invocations = [[NSMutableArray alloc] init];
        invocationControlEvents = [[NSMutableArray alloc] init];
    }
    return self;
}


- (void)addTarget:(id)target action:(SEL)action forControlEvent:(NSInteger)controlEvent
{
    // check if the event exists already and remove it... no duplicates
    [self removeTarget:target action:action forControlEvent:controlEvent];

    NSMethodSignature *sig = [[target class] instanceMethodSignatureForSelector:action];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:sig];

    // weak ref
    NSObject *selfRef = self;

    [invocation setTarget:target];
    [invocation setSelector:action];

    if(sig.numberOfArguments == 3) {
        [invocation setArgument:&selfRef atIndex:2];
    }

    [invocations addObject:invocation];
    [invocationControlEvents addObject:[NSNumber numberWithInt:controlEvent]];
}


- (void)removeTarget:(id)target action:(SEL)action forControlEvent:(NSInteger)controlEvent
{
    for(int i = 0; i < invocationControlEvents.count; i++) {
        NSNumber *storedControlEvent = [invocationControlEvents objectAtIndex:i];
        NSInvocation *invocation = [invocations objectAtIndex:i];

        if((storedControlEvent.integerValue == controlEvent) && (invocation.target == target) && (invocation.selector == action)) {
            [invocationControlEvents removeObjectAtIndex:i];
            [invocations removeObjectAtIndex:i];
            return;
        }
    }
}

- (void)removeTarget:(id)target forControlEvent:(NSInteger)controlEvent
{
    for(int i = 0; i < invocationControlEvents.count; i++) {
        NSNumber *storedControlEvent = [invocationControlEvents objectAtIndex:i];
        NSInvocation *invocation = [invocations objectAtIndex:i];

        if((storedControlEvent.integerValue == controlEvent) && (invocation.target == target)) {
            [invocationControlEvents removeObjectAtIndex:i];
            [invocations removeObjectAtIndex:i];
            --i;
        }
    }
}

- (void)removeTarget:(id)target
{
    for(int i = 0; i < invocationControlEvents.count; i++) {
        NSInvocation *invocation = [invocations objectAtIndex:i];

        if(invocation.target == target) {
            [invocationControlEvents removeObjectAtIndex:i];
            [invocations removeObjectAtIndex:i];
            --i;
        }
    }
}

- (void)invokeControlEvent:(NSInteger)controlEvent
{
    [self invokeControlEvent:controlEvent withData:nil];
}


- (void)invokeControlEvent:(NSInteger)controlEvent withData:(NSObject *)data
{
    for(int i = 0; i < invocationControlEvents.count; i++) {
        NSNumber *storedControlEvent = [invocationControlEvents objectAtIndex:i];
        if(storedControlEvent.integerValue == controlEvent) {
            NSInvocation *invocation = [invocations objectAtIndex:i];
            NSMethodSignature *sig = [[invocation.target class] instanceMethodSignatureForSelector:invocation.selector];

            if(sig.numberOfArguments == 4) {
                [invocation setArgument:&data atIndex:3];
            }

            [invocation invoke];
        }
    }
}


@end