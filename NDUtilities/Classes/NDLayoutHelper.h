//
//  LayoutHelper.h
//
//  Created by Lars Gerckens on 19.03.12.
//  Copyright (c) 2012 lars@nulldesign.de. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>

typedef enum
{
    NDLayoutHelperAlignModeTopLeft = 0,
    NDLayoutHelperAlignModeTopCenter = 1,
    NDLayoutHelperAlignModeTopRight = 2,
    
    NDLayoutHelperAlignModeRightTop = 3,
    NDLayoutHelperAlignModeRightCenter = 4,
    NDLayoutHelperAlignModeRightBottom = 5,
    
    NDLayoutHelperAlignModeBottomRight = 6,
    NDLayoutHelperAlignModeBottomCenter = 7,
    NDLayoutHelperAlignModeBottomLeft = 8,
    
    NDLayoutHelperAlignModeLeftBottom = 9,
    NDLayoutHelperAlignModeLeftCenter = 10,
    NDLayoutHelperAlignModeLeftTop = 11
} 
NDLayoutHelperAlignMode;

@interface NDLayoutHelper : NSObject

+(void) setPosition:(UIView*) view
                  x:(CGFloat) x
                  y:(CGFloat) y;

+(void) placeUnder:(UIView *) top
            bottom:(UIView *) bottom
               gap:(CGFloat) gap;

+(void) placeBefore:(UIView *) left
              right:(UIView *) right
                gap:(CGFloat) gap;

+(void) placeNext:(UIView *) left
            right:(UIView *) right
              gap:(CGFloat) gap;

+(void) center:(UIView *) center
          back:(UIView *) back;

+(void) align:(UIView*) front
         back:(UIView*) back
    alignment:(NDLayoutHelperAlignMode) alignment
          gap:(CGFloat) gap;

+(UIImageView *) getImage:(NSString *) file;

+ (CGSize) getTextSize:(NSString*)text font:(UIFont*)font bounds:(CGSize) bounds;

@end