//
//  StandardButton.h
//
//  Created by Lars Gerckens on 14.05.12.
//  Copyright (c) 2012 lars@nulldesign.de. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StandardButton : UIButton
{
    UIColor *backgroundColor;
}

@property (nonatomic) BOOL isToggleButton;

-(id)initWithBackgroundColor:(UIColor*) color
                     andText:(NSString*) text;

-(id)initWithBackgroundImage:(UIImage *) image;

-(id)initWithBackgroundImage:(UIImage *) image
                     andText:(NSString*) text;

-(id)initAsToggleButton:(UIImage*) selectedImage
        unselectedImage:(UIImage*) unselectedImage;

@end
