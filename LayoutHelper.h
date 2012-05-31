//
//  LayoutHelper.h
//
//  Created by Lars Gerckens on 19.03.12.
//  Copyright (c) 2012 lars@nulldesign.de. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    LayoutHelperAlignModeTopLeft = 0,
    LayoutHelperAlignModeTopCenter = 1,
    LayoutHelperAlignModeTopRight = 2,
    
    LayoutHelperAlignModeRightTop = 3,
    LayoutHelperAlignModeRightCenter = 4,
    LayoutHelperAlignModeRightBottom = 5,
    
    LayoutHelperAlignModeBottomRight = 6,
    LayoutHelperAlignModeBottomCenter = 7,
    LayoutHelperAlignModeBottomLeft = 8,
    
    LayoutHelperAlignModeLeftBottom = 9,
    LayoutHelperAlignModeLeftCenter = 10,
    LayoutHelperAlignModeLeftTop = 11
} 
LayoutHelperAlignMode;

@interface LayoutHelper : NSObject

+(void) setPosition:(UIView*) view
                  x:(CGFloat) x
                  y:(CGFloat) y;

+(void) placeUnder:(UIView *) top
            bottom:(UIView *) bottom
               gap:(CGFloat) gap;

+(void) placeNext:(UIView *) left
            right:(UIView *) right
              gap:(CGFloat) gap;

+(void) center:(UIView *) center
          back:(UIView *) back;

+(void) align:(UIView*) front
         back:(UIView*) back
    alignment:(LayoutHelperAlignMode) alignment;

+(UIImageView *) getImage:(NSString *) file;

@end