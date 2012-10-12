//
//  StandardButton.m
//
//  Created by Lars Gerckens on 14.05.12.
//  Copyright (c) 2012 lars@nulldesign.de. All rights reserved.
//

#import "NDStandardButton.h"
#import "NDCGContextHelper.h"

@implementation NDStandardButton

@synthesize isToggleButton;

-(id)initWithImage:(UIImage *) image
{
	self = [super initWithFrame:CGRectMake(0.0, 0.0, image.size.width, image.size.height)];
	if (self)
	{
		self.isToggleButton = NO;
		self.selected = NO;
		[self setImage:image forState:UIControlStateNormal];
		self.adjustsImageWhenHighlighted = YES;
	}
	return self;
}


-(id)initWithBackgroundImage:(UIImage *) image
                     andText:(NSString*) text
{
   	self = [super initWithFrame:CGRectMake(0.0, 0.0, image.size.width, image.size.height)];
	if (self)
	{
		self.isToggleButton = NO;
		self.selected = NO;
		[self setBackgroundImage:image forState:UIControlStateNormal];
		self.adjustsImageWhenHighlighted = YES;
        
        [self setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
		[self setTitle:text forState:UIControlStateNormal];
		self.titleLabel.textAlignment = UITextAlignmentCenter;
		self.titleLabel.font = [UIFont boldSystemFontOfSize:12.0];
		self.titleLabel.shadowColor = UIColorFromRGB(0x000000);
		self.titleLabel.shadowOffset = CGSizeMake(0.0, -1.0);
	}
	return self; 
}


-(id)initAsToggleButton:(UIImage *) selectedImage
        unselectedImage:(UIImage *) unselectedImage
{
	self = [super initWithFrame:CGRectMake(0.0, 0.0, selectedImage.size.width, selectedImage.size.height)];
	if (self)
	{
		self.isToggleButton = YES;
		self.selected = NO;
		[self setBackgroundImage:unselectedImage forState:UIControlStateNormal];
		[self setBackgroundImage:selectedImage forState:UIControlStateSelected | UIControlStateHighlighted];
		self.adjustsImageWhenHighlighted = YES;

		[self addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown];
		[self addTarget:self action:@selector(touchUp:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
	}
	return self;
}



-(id)initWithBackgroundColor:(UIColor *) color
                     andText:(NSString *) text
{
	backgroundColor = color;

	self = [super initWithFrame:CGRectMake(0.0, 0.0, 100.0, 10.0)];
	if (self)
	{
        [self setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
		[self setTitle:text forState:UIControlStateNormal];
		self.titleLabel.textAlignment = UITextAlignmentCenter;
		self.titleLabel.font = [UIFont boldSystemFontOfSize:20.0];
		self.titleLabel.shadowColor = UIColorFromRGB(0x000000);
		self.titleLabel.shadowOffset = CGSizeMake(0.0, -1.0);

		CGSize textSize = [text sizeWithFont:self.titleLabel.font];
		self.frame = CGRectMake(0.0, 0.0, textSize.width + 50.0, textSize.height + 20.0);

		[self addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown];
		[self addTarget:self action:@selector(touchUp:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
	}
	return self;
}

-(void) setPosition:(CGPoint)newPosition
{
	self.frame = CGRectMake(newPosition.x, newPosition.y, self.frame.size.width, self.frame.size.height);
}

-(void) setHighlighted:(BOOL)highlighted
{
    if(self.selected)
    {
        highlighted = YES;
    }

    [super setHighlighted:highlighted];
}

-(void) setSelected:(BOOL)selected
{
    [super setSelected:selected];
    self.highlighted = selected;
}

-(void) touchDown:(id) sender
{
	[self setNeedsDisplay];
}



-(void) touchUp:(id) sender
{
	if (isToggleButton)
	{
		self.selected = !self.selected;
	}

	[self setNeedsDisplay];
}



-(void) drawRect:(CGRect)rect
{
	[super drawRect:rect];

    CGContextRef context = UIGraphicsGetCurrentContext();
    
	if (backgroundColor)
	{
		UIColor *col = backgroundColor;

		if (self.isTouchInside)
		{
			col = [backgroundColor colorWithAlphaComponent:0.8];
		}

        [NDCGContextHelper drawRoundedRectWithColor:col inRect:rect withContext:context andRadius:5.0];
	}
}


@end