//
//  AsyncUIImageView.m
//
//  Created by Lars Gerckens on 30.10.11.
//  Copyright (c) 2012lars@nulldesign.de All rights reserved.
//

#import "NDAsyncUIImageView.h"

@implementation NDAsyncUIImageView

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self)
	{
		self.backgroundColor = [UIColor clearColor];
		self.contentMode = UIViewContentModeScaleAspectFill;
		self.clipsToBounds = YES;
		self.image = nil;
	}
	return self;
}



- (void)loadImageFromURL:(NSURL *)url
{
    if([currentImageURL isEqual:url] && self.image != nil)
    {
        return;
    }
	
    currentImageURL = url;
    self.image = nil;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);

	dispatch_async(queue, ^{
		
        NSData *imgData = [NSData dataWithContentsOfURL:url];
        UIImage *loadedImage = [UIImage imageWithData:imgData];
        
        if([currentImageURL isEqual:url])
        {
            dispatch_async(dispatch_get_main_queue(), ^{
            
                self.image = loadedImage;
            
                if (self.frame.size.width < 1.0 || self.frame.size.height < 1.0)
                {
                    self.frame = CGRectMake (self.frame.origin.x, self.frame.origin.y, self.image.size.width, self.image.size.height);
                }
            
                if (delegate && [delegate respondsToSelector:@selector(asyncUIImageViewLoaded:)])
                {
                    [delegate asyncUIImageViewLoaded:self];
                }
            });
        }
    });
}


@end