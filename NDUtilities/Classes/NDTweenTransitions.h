//
//  NDTweenTransitions.h
//  NDUtilities
//
//  Created by Lars Gerckens on 11.10.12.
//  Copyright (c) 2012 lars@nulldesign.de All rights reserved.
//

#import <Foundation/Foundation.h>

typedef CGFloat (^TweenTransitionBlock)(CGFloat t, CGFloat d, CGFloat b, CGFloat c);
typedef void (^TweenFinishedBlock)(UIView* view);
typedef void (^TweenUpdateBlock)(UIView* view);
typedef void (^TweenFloatFinishedBlock)(CGFloat value);
typedef void (^TweenFloatUpdateBlock)(CGFloat value);

typedef struct
{
    NSTimeInterval timeBegin;
    NSTimeInterval timeDelta;
    NSTimeInterval timeDuration;

    CGRect begin;
    CGRect finish;
    CGRect change;
    
    CGFloat floatBeginValue;
    CGFloat floatFinishValue;
    CGFloat floatChangeValue;
}
NDTweenData;

static inline NDTweenData TweenDataMake(NSTimeInterval timeBegin,
                                        NSTimeInterval timeDelta,
                                        NSTimeInterval timeDuration,
                                        CGRect begin,
                                        CGRect finish,
                                        CGRect change,
                                        CGFloat floatBeginValue,
                                        CGFloat floatFinishValue,
                                        CGFloat floatChangeValue)
{
    return (NDTweenData) { timeBegin, timeDelta, timeDuration, begin, finish, change, floatBeginValue, floatFinishValue, floatChangeValue };
}

static TweenTransitionBlock tweenLinear = ^(CGFloat t, CGFloat d, CGFloat b, CGFloat c)
{
    return c * t / d + b;
};


static TweenTransitionBlock tweenBackEaseIn = ^(CGFloat t, CGFloat d, CGFloat b, CGFloat c)
{
    CGFloat s = 1.70158f;

    return c * (t /= d) * t * ((s + 1.0f) * t - s) + b;
};

static TweenTransitionBlock tweenBackEaseOut = ^(CGFloat t, CGFloat d, CGFloat b, CGFloat c)
{
    CGFloat s = 1.70158f;

    return c * ((t = t / d - 1.0f) * t * ((s + 1.0f) * t + s) + 1.0f) + b;
};

static TweenTransitionBlock tweenBackEaseInOut = ^(CGFloat t, CGFloat d, CGFloat b, CGFloat c)
{
    CGFloat s = 1.70158f;

    if ((t /= d / 2.0f) < 1.0f)
    {
        return c / 2.0f * (t * t * (((s *= (1.525f)) + 1.0f) * t - s)) + b;
    }
    else
    {
        return c / 2.0f * ((t -= 2.0f) * t * (((s *= (1.525f)) + 1.0f) * t + s) + 2.0f) + b;
    }
};

static TweenTransitionBlock tweenBounceEaseOut = ^(CGFloat t, CGFloat d, CGFloat b, CGFloat c)
{
    if ((t /= d) < (1.0f / 2.75f))
    {
        return c * (7.5625f * t * t) + b;
    }
    else if (t < (2.0f / 2.75f))
    {
        return c * (7.5625f * (t -= (1.5f / 2.75f)) * t + 0.75f) + b;
    }
    else if (t < (2.5f / 2.75f))
    {
        return c * (7.5625f * (t -= (2.25f / 2.75f)) * t + 0.9375f) + b;
    }
    else
    {
        return c * (7.5625f * (t -= (2.625f / 2.75f)) * t + 0.984375f) + b;
    }
};

static TweenTransitionBlock tweenBounceEaseIn = ^(CGFloat t, CGFloat d, CGFloat b, CGFloat c)
{
    return c - tweenBounceEaseOut(d - t, d, 0.0f, c) + b;
};

static TweenTransitionBlock tweenBounceEaseInOut = ^(CGFloat t, CGFloat d, CGFloat b, CGFloat c)
{
    if (t < d / 2.0f)
    {
        return (CGFloat)(tweenBounceEaseIn(t * 2.0f, d, 0.0f, c) * 0.5f + b);
    }
    else
    {
        return (CGFloat)(tweenBounceEaseOut(t * 2.0f - d, d, 0.0f, c) * 0.5f + c * 0.5f + b);
    }
};

static TweenTransitionBlock tweenCircEaseIn = ^(CGFloat t, CGFloat d, CGFloat b, CGFloat c)
{
    return (CGFloat)(-c * (sqrt(1.0f - (t /= d) * t) - 1.0f) + b);
};

static TweenTransitionBlock tweenCircEaseOut = ^(CGFloat t, CGFloat d, CGFloat b, CGFloat c)
{
    return (CGFloat)(c * sqrt(1.0f - (t = t / d - 1.0f) * t) + b);
};

static TweenTransitionBlock tweenCircEaseInOut = ^(CGFloat t, CGFloat d, CGFloat b, CGFloat c)
{
    if ((t /= d / 2.0f) < 1.0f)
    {
        return (CGFloat)(-c / 2.0f * (sqrt(1.0f - t * t) - 1.0f) + b);
    }
    else
    {
        return (CGFloat)(c / 2.0f * (sqrt(1.0f - (t -= 2.0f) * t) + 1.0f) + b);
    }
};

static TweenTransitionBlock tweenCubicEaseIn = ^(CGFloat t, CGFloat d, CGFloat b, CGFloat c)
{
    return (CGFloat)(c * (t /= d) * t * t + b);
};

static TweenTransitionBlock tweenCubicEaseOut = ^(CGFloat t, CGFloat d, CGFloat b, CGFloat c)
{
    return (CGFloat)(c * ((t = t / d - 1.0f) * t * t + 1.0f) + b);
};

static TweenTransitionBlock tweenCubicEaseInOut = ^(CGFloat t, CGFloat d, CGFloat b, CGFloat c)
{
    if ((t /= d / 2.0f) < 1.0f)
    {
        return c / 2.0f * t * t * t + b;
    }
    else
    {
        return c / 2.0f * ((t -= 2.0f) * t * t + 2.0f) + b;
    }
};

static TweenTransitionBlock tweenElasticEaseIn = ^(CGFloat t, CGFloat d, CGFloat b, CGFloat c)
{
    CGFloat p = d * 0.3f;
    CGFloat a = c;
    CGFloat s = p / (2.0f * M_PI) * asin(c / a);

    if (t == 0.0f)
    {
        return b;
    }
    if ((t /= d) == 1.0f)
    {
        return b + c;
    }

    return (CGFloat)(-(a * pow(2.0f, 10.0f * (t -= 1.0f)) * sin( (t * d - s) * (2.0f * M_PI) / p)) + b);
};

static TweenTransitionBlock tweenElasticEaseOut = ^(CGFloat t, CGFloat d, CGFloat b, CGFloat c)
{
    CGFloat p = d * 0.3f;
    CGFloat a = c;
    CGFloat s = p / (2.0f * M_PI) * asin(c / a);

    if (t == 0.0f)
    {
        return b;
    }
    if ((t /= d) == 1.0f)
    {
        return b + c;
    }

    return (CGFloat)(a * pow(2.0f, -10.0f * t) * sin( (t * d - s) * (2.0f * M_PI) / p) + c + b);
};

static TweenTransitionBlock tweenElasticEaseInOut = ^(CGFloat t, CGFloat d, CGFloat b, CGFloat c)
{
    CGFloat p = d * 0.3f;
    CGFloat a = c;
    CGFloat s = p / (2.0f * M_PI) * asin(c / a);

    if (t == 0.0f)
    {
        return b;
    }
    if ((t /= d / 2.0f) == 2.0f)
    {
        return b + c;
    }

    if (t < 1.0f)
    {
        return (CGFloat)(-0.5f * (a * pow(2.0f, 10.0f * (t -= 1.0f)) * sin( (t * d - s) * (2.0f * M_PI) / p)) + b);
    }
    else
    {
        return (CGFloat)(a * pow(2.0f, -10.0f * (t -= 1.0f)) * sin( (t * d - s) * (2.0f * M_PI) / p) * 0.5f + c + b);
    }
};

static TweenTransitionBlock tweenExpoEaseIn = ^(CGFloat t, CGFloat d, CGFloat b, CGFloat c)
{
    return (t == 0.0f) ? b : (CGFloat)(c * pow(2.0f, 10.0f* (t / d - 1.0f)) + b);
};

static TweenTransitionBlock tweenExpoEaseOut = ^(CGFloat t, CGFloat d, CGFloat b, CGFloat c)
{
    return (t == d) ? b + c : (CGFloat)(c * (-pow(2.0f, -10.0f * t / d) + 1.0f) + b);
};

static TweenTransitionBlock tweenExpoEaseInOut = ^(CGFloat t, CGFloat d, CGFloat b, CGFloat c)
{
    if (t == 0.0f)
    {
        return b;
    }
    if (t == d)
    {
        return b + c;
    }

    if ((t /= d / 2.0f) < 1.0f)
    {
        return (CGFloat)(c / 2.0f * pow(2.0f, 10.0f * (t - 1.0f)) + b);
    }
    else
    {
        return (CGFloat)(c / 2.0f * (-pow(2.0f, -10.0f * --t) + 2.0f) + b);
    }
};

static TweenTransitionBlock tweenQuadEaseIn = ^(CGFloat t, CGFloat d, CGFloat b, CGFloat c)
{
    return c * (t /= d) * t + b;
};

static TweenTransitionBlock tweenQuadEaseOut = ^(CGFloat t, CGFloat d, CGFloat b, CGFloat c)
{
    return -c * (t /= d) * (t - 2.0f) + b;
};

static TweenTransitionBlock tweenQuadEaseInOut = ^(CGFloat t, CGFloat d, CGFloat b, CGFloat c)
{
    if ((t /= d / 2.0f) < 1.0f)
    {
        return c / 2.0f * t * t + b;
    }
    else
    {
        return -c / 2.0f * ((--t) * (t - 2.0f) - 1.0f) + b;
    }
};

static TweenTransitionBlock tweenQuartEaseIn = ^(CGFloat t, CGFloat d, CGFloat b, CGFloat c)
{
    return c * (t /= d) * t * t * t + b;
};

static TweenTransitionBlock tweenQuartEaseOut = ^(CGFloat t, CGFloat d, CGFloat b, CGFloat c)
{
    return -c * ((t = t / d - 1.0f) * t * t * t - 1.0f) + b;
};

static TweenTransitionBlock tweenQuartEaseInOut = ^(CGFloat t, CGFloat d, CGFloat b, CGFloat c)
{
    if ((t /= d / 2.0f) < 1.0f)
    {
        return c / 2.0f * t * t * t * t + b;
    }
    else
    {
        return -c / 2.0f * ((t -= 2.0f) * t * t * t - 2.0f) + b;
    }
};

static TweenTransitionBlock tweenQuintEaseIn = ^(CGFloat t, CGFloat d, CGFloat b, CGFloat c)
{
    return c * (t /= d) * t * t * t * t + b;
};

static TweenTransitionBlock tweenQuintEaseOut = ^(CGFloat t, CGFloat d, CGFloat b, CGFloat c)
{
    return c * ((t = t / d - 10.f) * t * t * t * t + 1.0f) + b;
};

static TweenTransitionBlock tweenQuintEaseInOut = ^(CGFloat t, CGFloat d, CGFloat b, CGFloat c)
{
    if ((t /= d / 2.0f) < 1.0f)
    {
        return c / 2.0f * t * t * t * t * t + b;
    }
    else
    {
        return c / 2.0f * ((t -= 2.0f) * t * t * t * t + 2.0f) + b;
    }
};

static TweenTransitionBlock tweenSineEaseIn = ^(CGFloat t, CGFloat d, CGFloat b, CGFloat c)
{
    return (CGFloat)(-c * cos(t / d* (M_PI / 2.0f)) + c + b);
};

static TweenTransitionBlock tweenSineEaseOut = ^(CGFloat t, CGFloat d, CGFloat b, CGFloat c)
{
    return (CGFloat)(c * sin(t / d * (M_PI / 2.0f)) + b);
};

static TweenTransitionBlock tweenSineEaseInOut = ^(CGFloat t, CGFloat d, CGFloat b, CGFloat c)
{
    return (CGFloat)(-c / 2.0f * (cos(M_PI * t / d) - 1.0f) + b);
};