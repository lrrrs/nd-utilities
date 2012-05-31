//
//  CGContextHelper.m
//  wywy
//
//  Created by Lars Gerckens on 31.05.12.
//  Copyright (c) 2012 lars@nulldesign.de. All rights reserved.
//

#import "CGContextHelper.h"

@implementation CGContextHelper


+(void) drawRoundedRectWithColor:(UIColor *) color
                          inRect:(CGRect) rect
                     withContext:(CGContextRef)context
                       andRadius:(CGFloat)radius
{
	CGContextSetAllowsAntialiasing(context, true);
	CGContextSetFillColorWithColor(context, color.CGColor);

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

	CGContextDrawPath(context, kCGPathFill);
}



@end