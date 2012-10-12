//
//  NDTweener.m
//  NDUtilities
//
//  Created by Lars Gerckens on 11.10.12.
//  Copyright (c) 2012 lars@nulldesign.de All rights reserved.
//

#import "NDTweener.h"

@implementation NDTweenInstance

@synthesize view;
@synthesize floatPointer;
@synthesize properties;
@synthesize transition;
@synthesize finishBlock;
@synthesize updateBlock;
@synthesize floatFinishBlock;
@synthesize floatUpdateBlock;

-(NDTweenInstance*) addViewFinishBlock:(TweenFinishedBlock) block
{
    self.finishBlock = block;
    return self;   
}

-(NDTweenInstance*) addViewUpdateBlock:(TweenUpdateBlock) block;
{
    self.updateBlock = block;
    return self;
}

-(NDTweenInstance*) addFloatFinishBlock:(TweenFloatFinishedBlock) block
{
    self.floatFinishBlock = block;
    return self;
}

-(NDTweenInstance*) addFloatUpdateBlock:(TweenFloatUpdateBlock) block
{
    self.floatUpdateBlock = block;
    return self;
}

-(NDTweenInstance*) addDelay:(NSTimeInterval)delay
{
    NDTweenData data = self.properties;
    data.timeBegin += delay;
    
    self.properties = data;
    
    return self;
}

@end

@implementation NDTweener

static NDTweener *sharedInstance;

+ (id) sharedNDTweener
{
    if (sharedInstance == nil)
    {
        sharedInstance = [[super allocWithZone:NULL] init];
    }

    return sharedInstance;
}

- (id) init
{
    self = [super init];
    if (self)
    {
        tweenInstances = [NSMutableArray array];
    }
    return self;
}

-(void) scheduleTimerIfNeeded
{
    if(!tickTimer)
    {
        tickTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 / 60.0 target:self selector:@selector(updateTween) userInfo:nil repeats:YES];
    }
}

- (NDTweenInstance*) tweenFloat:(CGFloat*)floatPointer finishValue:(CGFloat)finishValue duration:(NSTimeInterval)duration transition:(TweenTransitionBlock)transition
{
    NDTweenData data = TweenDataMake([[NSDate date] timeIntervalSince1970],
                                     0.0,
                                     duration,
                                     CGRectZero,
                                     CGRectZero,
                                     CGRectZero,
                                     *floatPointer,
                                     finishValue,
                                     finishValue - *floatPointer);
    
    NDTweenInstance *tweenInstance = [[NDTweenInstance alloc] init];
    tweenInstance.floatPointer = floatPointer;
    tweenInstance.properties = data;
    tweenInstance.transition = transition;
    
    [tweenInstances addObject:tweenInstance];
    [self scheduleTimerIfNeeded];
    
    return tweenInstance;
}

- (NDTweenInstance*) tweenFrame:(UIView*)view frame:(CGRect)frame duration:(NSTimeInterval)duration transition:(TweenTransitionBlock)transition
{
    NDTweenData data = TweenDataMake([[NSDate date] timeIntervalSince1970],
                                     0.0,
                                     duration,
                                     CGRectZero,
                                     frame,
                                     CGRectZero,
                                     0.0f,
                                     0.0f,
                                     0.0f);
    
    NDTweenInstance *tweenInstance = [[NDTweenInstance alloc] init];
    tweenInstance.view = view;
    tweenInstance.properties = data;
    tweenInstance.transition = transition;
    
    [tweenInstances addObject:tweenInstance];
    [self scheduleTimerIfNeeded];
    
    return tweenInstance;
}

-(void) removeTween:(NSInteger) idx
{
    [tweenInstances removeObjectAtIndex:idx];
    
    if(tweenInstances.count == 0)
    {
        [tickTimer invalidate];
        tickTimer = nil;
    }
}

- (void) updateTween
{
//    float (*transitionMethod)(float t, float d, float b, float c);

    for (int i = 0; i < tweenInstances.count; i++)
    {
        NDTweenInstance *tweenInstance = [tweenInstances objectAtIndex:i];
        
        NDTweenData props = tweenInstance.properties;
        UIView *view = tweenInstance.view;
        TweenTransitionBlock transition = tweenInstance.transition;
        
        props.timeDelta = fmin([[NSDate date] timeIntervalSince1970] - props.timeBegin, props.timeDuration);
        
        if (props.timeDelta >= 0.0)
        {
            if(tweenInstance.floatPointer)
            {
                CGFloat newValue = transition(props.timeDelta, props.timeDuration, props.floatBeginValue, props.floatChangeValue);
                *tweenInstance.floatPointer = newValue;

                if(tweenInstance.floatUpdateBlock)
                {
                    tweenInstance.floatUpdateBlock(*tweenInstance.floatPointer);
                }
            }
            else
            {   
                if(CGRectEqualToRect(props.begin, CGRectZero))
                {
                    props.begin = view.frame;
                    props.change = CGRectMake(props.finish.origin.x - view.frame.origin.x,
                                              props.finish.origin.y - view.frame.origin.y,
                                              props.finish.size.width - view.frame.size.width,
                                              props.finish.size.height - view.frame.size.height);
                    tweenInstance.properties = props;
                }
                
                CGFloat x = transition(props.timeDelta, props.timeDuration, props.begin.origin.x, props.change.origin.x);
                CGFloat y = transition(props.timeDelta, props.timeDuration, props.begin.origin.y, props.change.origin.y);
                CGFloat w = transition(props.timeDelta, props.timeDuration, props.begin.size.width, props.change.size.width);
                CGFloat h = transition(props.timeDelta, props.timeDuration, props.begin.size.height, props.change.size.height);
                
                view.frame = CGRectMake(x, y, w, h);
                
                if(tweenInstance.updateBlock)
                {
                    tweenInstance.updateBlock(view);
                }
            }
        }

        if (props.timeDelta >= props.timeDuration)
        {
            if(tweenInstance.finishBlock)
            {
                tweenInstance.finishBlock(view);
            }
            
            if(tweenInstance.floatFinishBlock)
            {
                tweenInstance.floatFinishBlock(*tweenInstance.floatPointer);
            }
            
            view.frame = props.finish;
            [self removeTween:i];
        }
    }
}

@end
