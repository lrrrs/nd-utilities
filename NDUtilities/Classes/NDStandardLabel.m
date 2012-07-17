//
//  StandardLabel.m
//
//  Created by Lars Gerckens on 13.03.12.
//  Copyright (c) 2012 lars@nulldesign.de. All rights reserved.
//

#import "NDStandardLabel.h"

@implementation NDStandardLabel

@synthesize position;
@synthesize fontSize;
@synthesize fontType;

-(CGRect)getLabelSizeFromText:(NSString *)txt
{
	CGSize textSize;
/*
	if (self.numberOfLines == 0)
	{
		textSize = [txt  sizeWithFont:self.font
		            constrainedToSize:CGSizeMake(maxWidth, MAXFLOAT)
		                lineBreakMode:self.lineBreakMode];
	}
	else
	{
		textSize = [txt sizeWithFont:self.font];
	}
*/
    textSize = [self sizeThatFits:CGSizeMake(maxWidth, MAXFLOAT)];
    
	return CGRectMake(0.0, 0.0, textSize.width, textSize.height);
}



-(void) updateFrame
{
	CGRect labelSize = [self getLabelSizeFromText:self.text];

	if ((maxWidth > 0.0) && (maxWidth < labelSize.size.width))
	{
		labelSize.size.width = maxWidth;
	}

	CGRect newFrame = CGRectMake(self.frame.origin.x, self.frame.origin.y, labelSize.size.width, labelSize.size.height);

	self.frame = newFrame;
}



-(void) setPosition:(CGPoint)newPosition
{
	self.frame = CGRectMake(newPosition.x, newPosition.y, self.frame.size.width, self.frame.size.height);
}



-(CGPoint) position
{
	return self.frame.origin;
}



- (void)setup
{
	maxWidth = 0.0;
	fontType = StandardLabelFontTypeRegular;
	self.fontSize = StandardLabelFontSizeHeadline;
	self.backgroundColor = [UIColor clearColor];
	self.textColor = [UIColor whiteColor];
	self.opaque = YES;
	self.clipsToBounds = NO;
	self.userInteractionEnabled = NO;
}



-(void) setText:(NSString *)text
{
	[super setText:[text copy]];
	[self updateFrame];
}



-(void) setFontSize:(StandardLabelFontSize)newFontSize
{
	fontSize = newFontSize;
	[self setFontType:self.fontType];
	[self setNeedsLayout];
	[self setNeedsDisplay];
}



-(void) setFontType:(StandardLabelFontType)newFontType
{
	fontType = newFontType;

	switch (fontType)
	{
	 case StandardLabelFontTypeRegular:
		 self.font = [UIFont systemFontOfSize:fontSize];
		 break;

	 case StandardLabelFontTypeBold:
		 self.font = [UIFont boldSystemFontOfSize:fontSize];
		 break;
	}
	[self updateFrame];
}



- (id)init
{
	self = [super init];
	if (self)
	{
		[self setup];
	}
	return self;
}



- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self)
	{
		[self setup];
	}
	return self;
}



-(id)initWithText:(NSString *)txt
      andMaxWidth:(CGFloat) width
{
	self = [super initWithFrame:CGRectZero];
	if (self)
	{
		[self setup];

		self.text = txt;
		self.numberOfLines = 0;
		maxWidth = width;

		[self updateFrame];
	}
	return self;
}



-(id)initWithText:(NSString *)txt andMaxWidthSingleLine:(CGFloat) width
{
	self = [super initWithFrame:CGRectZero];
	if (self)
	{
		[self setup];

		self.text = txt;
		maxWidth = width;

		[self updateFrame];
	}
	return self;
}



-(id)initWithText:(NSString *)txt
{
	self = [super initWithFrame:CGRectZero];
	if (self)
	{
		[self setup];

		self.text = txt;

		[self updateFrame];
	}
	return self;
}



-(void)enableShadow:(BOOL)shadow
{
	self.shadowColor = UIColorFromRGB(0x000000);
	self.shadowOffset = CGSizeMake(0.0, -1.0);
}



-(void) layoutSubviews
{
	[self updateFrame];
	[super layoutSubviews];
}



@end