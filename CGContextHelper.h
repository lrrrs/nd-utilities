//
//  CGContextHelper.h
//  wywy
//
//  Created by Lars Gerckens on 31.05.12.
//  Copyright (c) 2012 lars@nulldesign.de. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGContextHelper : NSObject

+(void) drawRoundedRectWithColor:(UIColor *) color
                          inRect:(CGRect) rect
                     withContext:(CGContextRef)context
                       andRadius:(CGFloat)radius;

@end
