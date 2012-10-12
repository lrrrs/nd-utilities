//
//  BackgroundView.h
//
//  Created by Lars Gerckens on 16.05.12.
//  Copyright (c) 2012 lars@nulldesign.de All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NDBackgroundView : UIView
{
    UIColor *color1;
    UIColor *color2;
    CGFloat radius;
    BOOL isGlossy;
}

- (id)initWithFrame:(CGRect)frame
             color1:(UIColor *)col1
             radius:(CGFloat)rad;

- (id)initWithFrame:(CGRect)frame
             color1:(UIColor *)col1;

- (id)initWithFrame:(CGRect)frame
             color1:(UIColor *)col1
             color2:(UIColor *)col2;

- (id)initWithFrame:(CGRect)frame
             color1:(UIColor *)col1
             color2:(UIColor *)col2
             radius:(CGFloat)rad;

-(void) enableShadow;

-(void) enableGlossy;

@end
