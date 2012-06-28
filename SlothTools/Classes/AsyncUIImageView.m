//
//  AsyncUIImageView.m
//
//  Created by Lars Gerckens on 30.10.11.
//  Copyright (c) 2012lars@nulldesign.de All rights reserved.
//

#import "AsyncUIImageView.h"

@implementation AsyncUIImageView

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self)
	{
		self.backgroundColor = [UIColor lightGrayColor];
		self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
		//self.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
	}
	return self;
}



- (void)loadImageFromURL:(NSURL *)url
{
	connection = nil;
	data = nil;

	NSURLRequest *request = [NSURLRequest requestWithURL:url
	                                         cachePolicy:NSURLRequestUseProtocolCachePolicy
	                                     timeoutInterval:30.0];

	connection = [[NSURLConnection alloc]
	              initWithRequest:request delegate:self];
}



- (void)connection:(NSURLConnection *)theConnection
    didReceiveData:(NSData *)incrementalData
{
	if (data == nil)
	{
		data = [[NSMutableData alloc] initWithCapacity:2048];
	}
	[data appendData:incrementalData];
}



- (void)connectionDidFinishLoading:(NSURLConnection *)theConnection
{
	self.image = [UIImage imageWithData:data];
    if(self.frame.size.width < 1.0 || self.frame.size.height < 1.0)
    {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.image.size.width, self.image.size.height);
    }
	
    data = nil;
	connection = nil;
}

-(void) dealloc
{
	[connection cancel];
    data = nil;
}


@end