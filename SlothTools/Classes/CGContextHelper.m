//
//  CGContextHelper.m
//
//  Created by Lars Gerckens on 31.05.12.
//  Copyright (c) 2012 lars@nulldesign.de. All rights reserved.
//

#import "CGContextHelper.h"

@implementation CGContextHelper

+(void) makeRoundedRectPath:(CGRect)rect
                 withRadius:(CGFloat)radius
                 forContext:(CGContextRef)context
{
    CGFloat minx = CGRectGetMinX(rect);
	CGFloat midx = CGRectGetMidX(rect);
	CGFloat maxx = CGRectGetMaxX(rect);
	CGFloat miny = CGRectGetMinY(rect);
	CGFloat midy = CGRectGetMidY(rect);
	CGFloat maxy = CGRectGetMaxY(rect);
	CGContextMoveToPoint(context, minx, midy);
	CGContextAddArcToPoint(context, minx, miny, midx, miny, radius);
	CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius);
	CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
	CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius);
	CGContextClosePath(context);
}

+(void) drawRoundedRectWithColor:(UIColor *) color
                          inRect:(CGRect) rect
                     withContext:(CGContextRef)context
                       andRadius:(CGFloat)radius
{
	CGContextSetAllowsAntialiasing(context, true);
	CGContextSetFillColorWithColor(context, color.CGColor);

    [self makeRoundedRectPath:rect withRadius:radius forContext:context];

	CGContextDrawPath(context, kCGPathFill);
}



+(void) drawRoundedRectWithColors:(NSArray *) colors
                           inRect:(CGRect) rect
                      withContext:(CGContextRef)context
                        andRadius:(CGFloat)radius
                    gradientStart:(CGPoint)gradientStart
                      gradientEnd:(CGPoint)gradientEnd
{
	CGFloat locations[colors.count];
    NSMutableArray *cgColors = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < colors.count; i++)
    {
        locations[i] = (CGFloat)i / (CGFloat)(colors.count - 1);
        [cgColors addObject:(id)((UIColor*)[colors objectAtIndex:i]).CGColor];
    }

	CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
	CGGradientRef gradient = CGGradientCreateWithColors(space, (__bridge CFArrayRef)cgColors, locations);
	CGColorSpaceRelease(space);

    [self makeRoundedRectPath:rect withRadius:radius forContext:context];
    
    CGContextClip(context);
    
	CGPoint point1 = CGPointMake(rect.size.width * gradientStart.x, rect.size.height * gradientStart.y);
	CGPoint point2 = CGPointMake(rect.size.width * gradientEnd.x, rect.size.height * gradientEnd.y);
	CGContextDrawLinearGradient(context, gradient, point1, point2, (kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation));
	CGGradientRelease(gradient);
}



@end