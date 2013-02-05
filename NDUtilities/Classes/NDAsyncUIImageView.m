//
//  AsyncUIImageView.m
//
//  Created by Lars Gerckens on 30.10.11.
//  Copyright (c) 2012 lars@nulldesign.de All rights reserved.
//

#import "NDAsyncUIImageView.h"

@implementation NDAsyncUIImageView

@synthesize delegate;
@synthesize cacheImage;

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self)
	{
		self.backgroundColor = [UIColor clearColor];
		self.contentMode = UIViewContentModeScaleAspectFill;
		self.clipsToBounds = YES;
		self.image = nil;
		self.cacheImage = YES;

		imageCache = [NDImageCache imageCacheForRealm:@"AsyncUIImageView"];
	}
	return self;
}



- (void)loadImageFromURL:(NSURL *)url andFadeIn:(BOOL)fadeIn
{
	if (cacheImage)
	{
		UIImage *cachedImage = [imageCache imageForURLString:url.absoluteString];

		if (cachedImage)
		{
			self.image = cachedImage;
            doFadeIn = NO;
			[self finishLoading];
			return;
		}
	}

	currentImageURL = url;
	self.image = nil;
	doFadeIn = fadeIn;

	NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLCacheStorageAllowedInMemoryOnly timeoutInterval:30];

	imgData = [NSMutableData data];

	// cancel a previous request... if there is one...
	[currentURLConnection cancel];
	currentURLConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
	[currentURLConnection scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
	[currentURLConnection start];
}



- (void)loadImageFromURL:(NSURL *)url
{
	[self loadImageFromURL:url andFadeIn:NO];
}



#pragma NSUrlConnectionDelegate


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	[imgData setLength:0];
}



- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[imgData appendData:data];
}



- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	UIImage *loadedImage = [UIImage imageWithData:imgData];

	if (cacheImage && loadedImage)
	{
		[imageCache setImage:loadedImage forURLString:currentImageURL.absoluteString];
	}

	self.image = loadedImage;
	imgData = nil;
	[self finishLoading];
}



- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	imgData = nil;
	self.image = nil;
	[self finishLoading];
}



-(void) finishLoading
{
	if ((self.frame.size.width < 1.0) || (self.frame.size.height < 1.0))
	{
		self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.image.size.width, self.image.size.height);
	}

	if (delegate && [delegate respondsToSelector:@selector(asyncUIImageViewLoaded:)])
	{
		[delegate asyncUIImageViewLoaded:self];
	}

	if (doFadeIn)
	{
		self.alpha = 0.0f;
		[UIView animateWithDuration:0.3f animations:^{
		    self.alpha = 1.0f;
        }];
	}
}



@end