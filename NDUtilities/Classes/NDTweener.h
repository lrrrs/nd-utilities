//
//  NDTweener.h
//  NDUtilities
//
//  Created by Lars Gerckens on 11.10.12.
//  Copyright (c) 2012 lars@nulldesign.de All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NDTweenTransitions.h"

@interface NDTweenInstance : NSObject
{
}

@property (nonatomic, strong) UIView* view;
@property (nonatomic) CGFloat *floatPointer;
@property (nonatomic) NDTweenData properties;
@property (nonatomic, copy) TweenTransitionBlock transition;
@property (nonatomic, copy) TweenFinishedBlock finishBlock;
@property (nonatomic, copy) TweenUpdateBlock updateBlock;
@property (nonatomic, copy) TweenFloatFinishedBlock floatFinishBlock;
@property (nonatomic, copy) TweenFloatUpdateBlock floatUpdateBlock;

-(NDTweenInstance*) addViewFinishBlock:(TweenFinishedBlock) block;
-(NDTweenInstance*) addViewUpdateBlock:(TweenUpdateBlock) block;
-(NDTweenInstance*) addFloatFinishBlock:(TweenFloatFinishedBlock) block;
-(NDTweenInstance*) addFloatUpdateBlock:(TweenFloatUpdateBlock) block;
-(NDTweenInstance*) addDelay:(NSTimeInterval)delay;

@end

@interface NDTweener : NSObject
{
    NSMutableArray* tweenInstances;
    NSTimer *tickTimer;
}

+ (id) sharedNDTweener;
- (NDTweenInstance*) tweenFrame:(UIView*)view frame:(CGRect)frame duration:(NSTimeInterval)duration transition:(TweenTransitionBlock)transition;
- (NDTweenInstance*) tweenFloat:(CGFloat*)floatPointer finishValue:(CGFloat)finishValue duration:(NSTimeInterval)duration transition:(TweenTransitionBlock)transition;

@end