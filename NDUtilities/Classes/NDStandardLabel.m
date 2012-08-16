//
//  StandardLabel.m
//
//  Created by Lars Gerckens on 13.03.12.
//  Copyright (c) 2012 lars@nulldesign.de. All rights reserved.
//

#import "NDStandardLabel.h"

@implementation NDStandardLabel

@synthesize position = _position;
@synthesize fontSize = _fontSize;
@synthesize fixedWidth = _fixedWidth;
@synthesize fixedHeight = _fixedHeight;
@synthesize maxHeight = _maxHeight;
@synthesize maxWidth = _maxWidth;

- (void)setFixedHeight:(CGFloat)fixedHeight
{
	_fixedHeight = fixedHeight;
	[self updateFrame];
}

- (void)setFixedWidth:(CGFloat)fixedWidth
{
	_fixedWidth = fixedWidth;
	[self updateFrame];
}



-(CGRect)getLabelSizeFromText:(NSString *)txt
{
	CGSize textSize;

	if (self.numberOfLines == 0)
	{
		textSize = [txt  sizeWithFont:self.font
		            constrainedToSize:CGSizeMake(_maxWidth, _maxHeight)
		                lineBreakMode:self.lineBreakMode];
	}
	else
	{
		textSize = [txt sizeWithFont:self.font];
	}

	return CGRectMake(0.0, 0.0, textSize.width, textSize.height);
}



-(void) updateFrame
{
	CGRect labelSize = [self getLabelSizeFromText:self.text];

	if ((_maxWidth > 0.0f) && (_maxWidth < labelSize.size.width))
	{
		labelSize.size.width = _maxWidth;
	}
    if (_fixedWidth > 0.0f)
	{
		labelSize.size.width = _fixedWidth;
	}

	CGRect newFrame = CGRectMake(self.frame.origin.x,
                                 self.frame.origin.y,
                                 labelSize.size.width,
                                 (self.fixedHeight != 0.0f) ? self.fixedHeight : labelSize.size.height);

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
	_maxWidth = 0.0f;
	_maxHeight = MAXFLOAT;
    _fixedWidth = 0.0f;
	_fixedHeight = 0.0f;
	_fontSize = 12.0f;
	self.backgroundColor = [UIColor clearColor];
	self.textColor = [UIColor whiteColor];
	self.opaque = YES;
	self.clipsToBounds = NO;
	self.userInteractionEnabled = NO;
}



-(void) setMaxHeight:(CGFloat)maxHeight
{
	_maxHeight = maxHeight;
	[self updateFrame];
}



-(void) setMaxWidth:(CGFloat)maxWidth
{
	_maxWidth = maxWidth;
	[self updateFrame];
}



-(void) setText:(NSString *)text
{
	[super setText:[text copy]];
	[self updateFrame];
}



-(void) setFontSize:(CGFloat)newFontSize
{
	_fontSize = newFontSize;
	[self setNeedsLayout];
	[self setNeedsDisplay];
}



-(void) setFont:(UIFont *)font
{
	[super setFont:font];
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


-(id)initWithText:(NSString *)txt andFixedWidth:(CGFloat)width
{
    self = [super initWithFrame:CGRectZero];
	if (self)
	{
		[self setup];
        
		self.text = txt;
		_fixedWidth = width;
        self.textAlignment = UITextAlignmentCenter;
        
		[self updateFrame];
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
		_maxWidth = width;
		self.lineBreakMode = UILineBreakModeWordWrap;

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
		_maxWidth = width;

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



-(id)initWithText:(NSString *)txt andMaxSize:(CGSize)size
{
	self = [super initWithFrame:CGRectZero];
	if (self)
	{
		[self setup];

		self.text = txt;
		self.numberOfLines = 0;
		self.lineBreakMode = UILineBreakModeTailTruncation;
		_maxWidth = size.width;
		_maxHeight = size.height;

		[self updateFrame];
	}
	return self;
}



-(void) layoutSubviews
{
	[self updateFrame];
	[super layoutSubviews];
}



@end