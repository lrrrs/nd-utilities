//
//  CGContextHelper.h
//
//  Created by Lars Gerckens on 31.05.12.
//  Copyright (c) 2012 lars@nulldesign.de. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NDCGContextHelper : NSObject

+(void) makeRoundedRectPath:(CGRect)rect
                 withRadius:(CGFloat)radius
                 forContext:(CGContextRef)context;

+(void) drawRoundedRectWithColor:(UIColor *) color
                          inRect:(CGRect) rect
                     withContext:(CGContextRef)context
                       andRadius:(CGFloat)radius;

+(void) drawRoundedRectWithColors:(NSArray *) colors
                           inRect:(CGRect) rect
                      withContext:(CGContextRef)context
                        andRadius:(CGFloat)radius
                    gradientStart:(CGPoint)gradientStart
                      gradientEnd:(CGPoint)gradientEnd;

+(void) drawRectWithColor:(UIColor *) color
                   inRect:(CGRect) rect
              withContext:(CGContextRef)context;

+(void) drawRectWithColors:(NSArray *) colors
                    inRect:(CGRect) rect
               withContext:(CGContextRef)context
             gradientStart:(CGPoint)gradientStart
               gradientEnd:(CGPoint)gradientEnd;

@end
