//
//  NDObject.m
//
//  Created by Lars Gerckens on 28.08.12.
//  Copyright (c) 2012. All rights reserved.
//

#import "NDObject.h"

#define IGNORE_EVENT_ID -99999

@implementation NDInvocationStorage

@end

@implementation NDObject

- (id)init
{
    self = [super init];
    if(self) {
        _invocationListByTarget = [[NSMapTable alloc] initWithKeyOptions:NSMapTableWeakMemory
                                                            valueOptions:NSMapTableStrongMemory
                                                                capacity:10];
    }
    return self;
}

- (void)cleanUpHashMap
{
    NSMapTable *newInvocationListByTarget = [[NSMapTable alloc] initWithKeyOptions:NSMapTableWeakMemory
                                                                      valueOptions:NSMapTableStrongMemory
                                                                          capacity:10];

    NSEnumerator *enumerator = [_invocationListByTarget keyEnumerator];
    id storedTarget;

    while((storedTarget = [enumerator nextObject])) {
        if(storedTarget != nil) {
            [newInvocationListByTarget setObject:[_invocationListByTarget objectForKey:storedTarget] forKey:storedTarget];
        }
    }

    [_invocationListByTarget removeAllObjects];
    _invocationListByTarget = newInvocationListByTarget;
}

- (void)addTarget:(id)target action:(SEL)action forControlEvent:(NSInteger)controlEvent
{
    if(_invocationListByTarget.count > 10) {
        [self cleanUpHashMap];
    }

    // check if the event exists already and remove it... no duplicates
    [self removeTarget:target action:action forControlEvent:controlEvent];

    NSMethodSignature *sig = [[target class] instanceMethodSignatureForSelector:action];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:sig];

    __weak NSObject *selfRef = self;

    [invocation setTarget:target];
    [invocation setSelector:action];

    if(sig.numberOfArguments >= 3) {
        [invocation setArgument:&selfRef atIndex:2];
    }

    NSMutableArray *invocationList = [_invocationListByTarget objectForKey:target];

    if(!invocationList) {
        invocationList = [NSMutableArray array];
        [_invocationListByTarget setObject:invocationList forKey:target];
    }

    NDInvocationStorage *invocationStorage = [[NDInvocationStorage alloc] init];
    invocationStorage.invocation = invocation;
    invocationStorage.controlEvent = controlEvent;
    [invocationList addObject:invocationStorage];
}

- (void)removeTarget:(id)target action:(SEL)action forControlEvent:(NSInteger)controlEvent
{
    NSMutableArray *invocationList = [_invocationListByTarget objectForKey:target];

    for(NSUInteger i = 0; i < invocationList.count; i++) {
        NDInvocationStorage *invocationStorage = invocationList[i];

        if((invocationStorage.controlEvent == controlEvent || controlEvent == IGNORE_EVENT_ID) && (invocationStorage.invocation.selector == action || !action)) {
            [invocationList removeObjectAtIndex:i];
            --i;
        }
    }
}

- (void)removeTarget:(id)target forControlEvent:(NSInteger)controlEvent
{
    [self removeTarget:target action:nil forControlEvent:controlEvent];
}

- (void)removeTarget:(id)target
{
    [self removeTarget:target action:nil forControlEvent:IGNORE_EVENT_ID];
}

- (void)invokeControlEvent:(NSInteger)controlEvent
{
    [self invokeControlEvent:controlEvent withData:nil];
}

- (void)invokeControlEvent:(NSInteger)controlEvent withData:(NSObject *)data
{
    NSEnumerator *enumerator = [_invocationListByTarget keyEnumerator];
    id storedTarget;

    NSMutableArray *invocationsToInvoke = [NSMutableArray array];

    while((storedTarget = [enumerator nextObject])) {
        NSMutableArray *invocationList = [_invocationListByTarget objectForKey:storedTarget];

        for(NSUInteger i = 0; i < invocationList.count; i++) {
            NDInvocationStorage *invocationStorage = invocationList[i];

            if(invocationStorage.controlEvent == controlEvent) {
                NSInvocation *invocation = invocationStorage.invocation;
                NSMethodSignature *sig = [[invocation.target class] instanceMethodSignatureForSelector:invocation.selector];

                if(sig.numberOfArguments == 4) {
                    [invocation setArgument:&data atIndex:3];
                }

                [invocationsToInvoke addObject:invocation];
            }
        }
    }

    // fire the invocation

    for(NSInvocation *invocation in invocationsToInvoke) {
        [invocation invoke];
    }

    [invocationsToInvoke removeAllObjects];
}

@end