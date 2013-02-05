//
//  LayoutHelper.m
//
//  Created by Lars Gerckens on 19.03.12.
//  Copyright (c) 2012 lars@nulldesign.de. All rights reserved.
//

#import "NDLayoutHelper.h"

@implementation NDLayoutHelper

+ (void) setPosition:(UIView*)view
                   x:(CGFloat)x
                   y:(CGFloat)y
{
    view.frame = CGRectMake(x, y, view.frame.size.width, view.frame.size.height);
}



+ (void) placeUnder:(UIView*)top
             bottom:(UIView*)bottom
                gap:(CGFloat)gap
{
    bottom.frame = CGRectMake(top.frame.origin.x,
                              top.frame.origin.y + top.frame.size.height + gap,
                              bottom.frame.size.width,
                              bottom.frame.size.height);
}



+ (void) placeBefore:(UIView*)left
               right:(UIView*)right
                 gap:(CGFloat)gap
{
    left.frame = CGRectMake(right.frame.origin.x - left.frame.size.width - gap,
                            right.frame.origin.y,
                            left.frame.size.width,
                            left.frame.size.height);
}



+ (void) placeNext:(UIView*)left
             right:(UIView*)right
               gap:(CGFloat)gap
{
    right.frame = CGRectMake(left.frame.origin.x + left.frame.size.width + gap,
                             left.frame.origin.y,
                             right.frame.size.width,
                             right.frame.size.height);
}



+ (void) center:(UIView*)center
           back:(UIView*)back
{
    center.frame = CGRectMake(back.frame.origin.x + back.frame.size.width * 0.5 - center.frame.size.width * 0.5,
                              back.frame.origin.y + back.frame.size.height * 0.5 - center.frame.size.height * 0.5,
                              center.frame.size.width,
                              center.frame.size.height);
}



+ (void) align:(UIView*)front
          back:(UIView*)back
     alignment:(NDLayoutHelperAlignMode)alignment
           gap:(CGFloat)gap
{
    switch (alignment)
    {
        case NDLayoutHelperAlignModeTopLeft:
        case NDLayoutHelperAlignModeLeftTop:
            front.frame = CGRectMake(gap,
                                     gap,
                                     front.frame.size.width,
                                     front.frame.size.height);
            break;

        case NDLayoutHelperAlignModeTopCenter:
            front.frame = CGRectMake(roundf(back.frame.size.width * 0.5 - front.frame.size.width * 0.5),
                                     gap,
                                     front.frame.size.width,
                                     front.frame.size.height);
            break;

        case NDLayoutHelperAlignModeTopRight:
        case NDLayoutHelperAlignModeRightTop:
            front.frame = CGRectMake(roundf(back.frame.size.width - front.frame.size.width - gap),
                                     gap,
                                     front.frame.size.width,
                                     front.frame.size.height);
            break;

        case NDLayoutHelperAlignModeRightCenter:
            front.frame = CGRectMake(roundf(back.frame.size.width - front.frame.size.width - gap),
                                     roundf(back.frame.size.height * 0.5 - front.frame.size.height * 0.5),
                                     front.frame.size.width,
                                     front.frame.size.height);
            break;

        case NDLayoutHelperAlignModeRightBottom:
        case NDLayoutHelperAlignModeBottomRight:
            front.frame = CGRectMake(roundf(back.frame.size.width - front.frame.size.width - gap),
                                     roundf(back.frame.size.height - front.frame.size.height - gap),
                                     front.frame.size.width,
                                     front.frame.size.height);
            break;

        case NDLayoutHelperAlignModeBottomCenter:
            front.frame = CGRectMake(roundf(back.frame.size.width * 0.5 - front.frame.size.width * 0.5),
                                     roundf(back.frame.size.height - front.frame.size.height - gap),
                                     front.frame.size.width,
                                     front.frame.size.height);
            break;

        case NDLayoutHelperAlignModeBottomLeft:
        case NDLayoutHelperAlignModeLeftBottom:
            front.frame = CGRectMake(gap,
                                     roundf(back.frame.size.height - front.frame.size.height - gap),
                                     front.frame.size.width,
                                     front.frame.size.height);
            break;

        case NDLayoutHelperAlignModeLeftCenter:
            front.frame = CGRectMake(gap,
                                     roundf(back.frame.size.height * 0.5 - front.frame.size.height * 0.5),
                                     front.frame.size.width,
                                     front.frame.size.height);
            break;
    }
}



+ (UIImageView*) getImage:(NSString*)file
{
    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:file]];
}



+ (CGSize) getTextSize:(NSString*)text font:(UIFont*)font bounds:(CGSize) bounds;
{
    CTFontRef ctFont = CTFontCreateWithName((__bridge CFStringRef) font.fontName, font.pointSize, NULL);
    
    //  When you create an attributed string the default paragraph style has a leading
    //  of 0.0. Create a paragraph style that will set the line adjustment equal to
    //  the leading value of the font.
    CGFloat leading = font.lineHeight - font.ascender + font.descender;
    CTParagraphStyleSetting paragraphSettings[1] = { kCTParagraphStyleSpecifierLineSpacingAdjustment, sizeof(CGFloat), &leading };
    
    CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(paragraphSettings, 1);
    CFRange textRange = CFRangeMake(0, text.length);
    
    //  Create an empty mutable string big enough to hold our test
    CFMutableAttributedStringRef string = CFAttributedStringCreateMutable(kCFAllocatorDefault, text.length);
    
    //  Inject our text into it
    CFAttributedStringReplaceString(string, CFRangeMake(0, 0), (CFStringRef) text);
    
    //  Apply our font and line spacing attributes over the span
    CFAttributedStringSetAttribute(string, textRange, kCTFontAttributeName, ctFont);
    CFAttributedStringSetAttribute(string, textRange, kCTParagraphStyleAttributeName, paragraphStyle);
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(string);
    CFRange fitRange;
    
    CGSize frameSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, textRange, NULL, bounds, &fitRange);
    
    CFRelease(framesetter);
    CFRelease(paragraphStyle);
    CFRelease(string);
    CFRelease(ctFont);
    
    return frameSize;
}

@end