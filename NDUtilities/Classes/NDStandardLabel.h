//
//  StandardLabel.h
//
//  Created by Lars Gerckens on 13.03.12.
//  Copyright (c) 2012 lars@nulldesign.de. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
	StandardLabelFontSizeHeadlineBig = 20,
    StandardLabelFontSizeHeadline = 16,
	StandardLabelFontSizeCopy = 15,
	StandardLabelFontSizeCopySmall = 12
}
StandardLabelFontSize;


typedef enum
{
	StandardLabelFontTypeRegular = 2,
	StandardLabelFontTypeBold = 4
}
StandardLabelFontType;

@interface NDStandardLabel : UILabel
{
	CGFloat maxWidth;
	StandardLabelFontSize fontSize;
	StandardLabelFontType fontType;
}

@property (nonatomic) CGPoint position;
@property (nonatomic) StandardLabelFontSize fontSize;
@property (nonatomic) StandardLabelFontType fontType;

-(id)initWithText:(NSString *)txt;

-(id)initWithText:(NSString *)txt andMaxWidth:(CGFloat) width;

-(id)initWithText:(NSString *)txt andMaxWidthSingleLine:(CGFloat) width;

-(void)enableShadow:(BOOL)shadow;

-(CGRect)getLabelSizeFromText:(NSString *)txt;

@end