//
//  LayoutHelper.m
//
//  Created by Lars Gerckens on 19.03.12.
//  Copyright (c) 2012 lars@nulldesign.de. All rights reserved.
//

#import "LayoutHelper.h"

@implementation LayoutHelper

+(void) setPosition:(UIView *) view
                  x:(CGFloat) x
                  y:(CGFloat) y
{
	view.frame = CGRectMake(x, y, view.frame.size.width, view.frame.size.height);
}



+(void) placeUnder:(UIView *) top
            bottom:(UIView *) bottom
               gap:(CGFloat) gap
{
	bottom.frame = CGRectMake(top.frame.origin.x,
				top.frame.origin.y + top.frame.size.height + gap,
				bottom.frame.size.width,
				bottom.frame.size.height);
}



+(void) placeNext:(UIView *) left
            right:(UIView *) right
              gap:(CGFloat) gap
{
	right.frame = CGRectMake(left.frame.origin.x + left.frame.size.width + gap,
				left.frame.origin.y,
				right.frame.size.width,
				right.frame.size.height);
}



+(void) center:(UIView *) center
          back:(UIView *) back
{
	center.frame = CGRectMake(back.frame.origin.x + back.frame.size.width * 0.5 - center.frame.size.width * 0.5,
				back.frame.origin.y + back.frame.size.height * 0.5 - center.frame.size.height * 0.5,
				center.frame.size.width,
				center.frame.size.height);
}



+(void) align:(UIView *) front
         back:(UIView *) back
    alignment:(LayoutHelperAlignMode) alignment
{
	switch (alignment)
	{
	 case LayoutHelperAlignModeTopLeft:
	 case LayoutHelperAlignModeLeftTop:
		 front.frame = CGRectMake(0.0,
					 0.0,
					 front.frame.size.width,
					 front.frame.size.height);
		 break;

	 case LayoutHelperAlignModeTopCenter:
		 front.frame = CGRectMake(back.frame.size.width * 0.5 - front.frame.size.width * 0.5,
					 0.0,
					 front.frame.size.width,
					 front.frame.size.height);
		 break;

	 case LayoutHelperAlignModeTopRight:
	 case LayoutHelperAlignModeRightTop:
		 front.frame = CGRectMake(back.frame.size.width - front.frame.size.width,
					 0.0,
					 front.frame.size.width,
					 front.frame.size.height);
		 break;

	 case LayoutHelperAlignModeRightCenter:
		 front.frame = CGRectMake(back.frame.size.width - front.frame.size.width,
					 back.frame.size.height * 0.5 - front.frame.size.height * 0.5,
					 front.frame.size.width,
					 front.frame.size.height);
		 break;

	 case LayoutHelperAlignModeRightBottom:
	 case LayoutHelperAlignModeBottomRight:
		 front.frame = CGRectMake(back.frame.size.width - front.frame.size.width,
					 back.frame.size.height - front.frame.size.height,
					 front.frame.size.width,
					 front.frame.size.height);
		 break;

	 case LayoutHelperAlignModeBottomCenter:
		 front.frame = CGRectMake(back.frame.size.width * 0.5 - front.frame.size.width * 0.5,
					 back.frame.size.height - front.frame.size.height,
					 front.frame.size.width,
					 front.frame.size.height);
		 break;

	 case LayoutHelperAlignModeBottomLeft:
	 case LayoutHelperAlignModeLeftBottom:
		 front.frame = CGRectMake(0.0,
					 back.frame.size.height - front.frame.size.height,
					 front.frame.size.width,
					 front.frame.size.height);
		 break;

	 case LayoutHelperAlignModeLeftCenter:
		 front.frame = CGRectMake(0.0,
					 back.frame.size.height * 0.5 - front.frame.size.height * 0.5,
					 front.frame.size.width,
					 front.frame.size.height);
		 break;
	}
}



+(UIImageView *) getImage:(NSString *) file
{
	return [[UIImageView alloc] initWithImage:[UIImage imageNamed:file]];
}



@end