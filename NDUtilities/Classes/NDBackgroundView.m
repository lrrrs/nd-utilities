//
//  BackgroundView.m
//
//  Created by Lars Gerckens on 16.05.12.
//  Copyright (c) 2012 lars@nulldesign.de All rights reserved.
//

#import "NDBackgroundView.h"
#import <QuartzCore/QuartzCore.h>
#import "NDCGContextHelper.h"

@implementation NDBackgroundView

- (id)initWithFrame:(CGRect)frame
             color1:(UIColor *)col1
             radius:(CGFloat)rad
{
	self = [super initWithFrame:frame];
	if (self)
	{
		color1 = col1;
		color2 = nil;
		radius = rad;
        isGlossy = NO;
	}
	return self;
}



- (id)initWithFrame:(CGRect)frame
             color1:(UIColor *)col1
{
	self = [super initWithFrame:frame];
	if (self)
	{
		color1 = col1;
		color2 = nil;
		radius = 0.0;
        isGlossy = NO;
	}
	return self;
}



- (id)initWithFrame:(CGRect)frame
             color1:(UIColor *)col1
             color2:(UIColor *)col2
{
	self = [super initWithFrame:frame];
	if (self)
	{
		color1 = col1;
		color2 = col2;
		radius = 0.0;
        isGlossy = NO;
	}
	return self;
}



- (id)initWithFrame:(CGRect)frame
             color1:(UIColor *)col1
             color2:(UIColor *)col2
             radius:(CGFloat)rad
{
	self = [super initWithFrame:frame];
	if (self)
	{
		color1 = col1;
		color2 = col2;
		radius = rad;
        isGlossy = NO;
	}
	return self;
}



- (void)drawRect:(CGRect)rect
{
	CGContextRef c = UIGraphicsGetCurrentContext();

	if ((color2 == nil) || [color1 isEqual:color2])
	{
		if (radius == 0.0)
		{
			[NDCGContextHelper drawRectWithColor:color1 inRect:rect withContext:c];
		}
		else
		{
			[NDCGContextHelper drawRoundedRectWithColor:color1 inRect:rect withContext:c andRadius:radius];
		}
	}
	else
	{
		if (radius == 0.0)
		{
			[NDCGContextHelper drawRectWithColors:[NSArray arrayWithObjects:color1, color2, nil]
			                             inRect:rect
			                        withContext:c
			                      gradientStart:CGPointMake(0.5, 0.0)
			                        gradientEnd:CGPointMake(0.5, 1.0)];
		}
		else
		{
			[NDCGContextHelper drawRoundedRectWithColors:[NSArray arrayWithObjects:color1, color2, nil]
			                                    inRect:rect
			                               withContext:c
			                                 andRadius:radius
			                             gradientStart:CGPointMake(0.5, 0.0)
			                               gradientEnd:CGPointMake(0.5, 1.0)];
		}
	}
    
    if(isGlossy)
    {
        CGRect glossyRect = rect;
        glossyRect.origin.y += 1.0;
        glossyRect.size.height *= 0.5;
        [NDCGContextHelper drawRectWithColors:[NSArray arrayWithObjects:UIColorFromRGBWithAlpha(0xFFFFFF, 0.2), UIColorFromRGBWithAlpha(0xFFFFFF, 0.1), nil] 
                                     inRect:glossyRect 
                                withContext:c 
                              gradientStart:CGPointMake(0.5, 0.0) 
                                gradientEnd:CGPointMake(0.5, 1.0)]; 
    }
}



-(void) enableShadow
{
	[self setClipsToBounds:NO];
	[self.layer setShadowColor:UIColorFromRGB(0x000000).CGColor];
	[self.layer setShadowOpacity:0.8];
	[self.layer setShadowOffset:CGSizeMake(5.0, 5.0)];
	[self.layer setShadowRadius:5];
	self.layer.rasterizationScale = [[UIScreen mainScreen] scale];
	self.layer.shouldRasterize = YES;
}


-(void) enableGlossy
{
    isGlossy = YES;
    [self setNeedsDisplay];
}


@end