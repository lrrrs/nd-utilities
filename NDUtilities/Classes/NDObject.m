//
//  NDObject.m
//  GTG-CS
//
//  Created by Lars Gerckens on 28.08.12.
//  Copyright (c) 2012 3M GTG. All rights reserved.
//

#import "NDObject.h"

@implementation NDObject

- (id)init
{
	self = [super init];
	if (self)
	{
		invocations = [[NSMutableArray alloc] init];
		invocationControlEvents = [[NSMutableArray alloc] init];
	}
	return self;
}



- (void)addTarget:(id)target action:(SEL)action forControlEvents:(NSInteger)controlEvents
{
    // check if the event exists already and remove it... no duplicates
    [self removeTarget:target action:action forControlEvents:controlEvents];
    
    NSMethodSignature *sig = [[target class] instanceMethodSignatureForSelector:action];
	NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:sig];

	// weak ref
	NSObject *selfRef = self;

	[invocation setTarget:target];
	[invocation setSelector:action];

	if (sig.numberOfArguments == 3)
	{
		[invocation setArgument:&selfRef atIndex:2];
	}

	[invocations addObject:invocation];
	[invocationControlEvents addObject:[NSNumber numberWithInt:controlEvents]];
}



- (void)removeTarget:(id)target action:(SEL)action forControlEvents:(NSInteger)controlEvents
{
	for (int i = 0; i < invocationControlEvents.count; i++)
	{
		NSNumber *storedControlEvent = [invocationControlEvents objectAtIndex:i];
		NSInvocation *invocation = [invocations objectAtIndex:i];

		if ((storedControlEvent.integerValue == controlEvents) && (invocation.target == target) && (invocation.selector == action))
		{
            [invocationControlEvents removeObject:storedControlEvent];
            [invocations removeObject:invocation];
            return;
		}
	}
}



- (void)invokeControlEvent:(NSInteger)controlEvent
{
	[self invokeControlEvent:controlEvent withData:nil];
}



- (void)invokeControlEvent:(NSInteger)controlEvent withData:(NSObject *) data
{
	for (int i = 0; i < invocationControlEvents.count; i++)
	{
		NSNumber *storedControlEvent = [invocationControlEvents objectAtIndex:i];
		if (storedControlEvent.integerValue == controlEvent)
		{
			NSInvocation *invocation = [invocations objectAtIndex:i];
			NSMethodSignature *sig = [[invocation.target class] instanceMethodSignatureForSelector:invocation.selector];
            
			if (sig.numberOfArguments == 4)
			{
				[invocation setArgument:&data atIndex:3];
			}

            if(sig)
            {
                [invocation invoke];
            }
            else
            {
                // delete invalid events... targets might have been deallocated
                [invocationControlEvents removeObject:storedControlEvent];
                [invocations removeObject:invocation];
            }
		}
	}
}



@end