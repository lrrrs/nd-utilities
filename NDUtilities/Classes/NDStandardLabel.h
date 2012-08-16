//
//  StandardLabel.h
//
//  Created by Lars Gerckens on 13.03.12.
//  Copyright (c) 2012 lars@nulldesign.de. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NDStandardLabel : UILabel
{

}

@property (nonatomic) CGPoint position;
@property (nonatomic) CGFloat fontSize;
@property (nonatomic) CGFloat fixedWidth;
@property (nonatomic) CGFloat fixedHeight;
@property (nonatomic) CGFloat maxWidth;
@property (nonatomic) CGFloat maxHeight;

-(id)initWithText:(NSString *)txt;
-(id)initWithText:(NSString *)txt andFixedWidth:(CGFloat)width;
-(id)initWithText:(NSString *)txt andMaxWidth:(CGFloat) width;
-(id)initWithText:(NSString *)txt andMaxWidthSingleLine:(CGFloat) width;
-(id)initWithText:(NSString *)txt andMaxSize:(CGSize)size;

-(CGRect)getLabelSizeFromText:(NSString *)txt;

@end