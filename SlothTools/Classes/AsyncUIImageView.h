//
//  AsyncUIImageView.h
//
//  Loads an image asynchroniously. If you specify a frame, the AsyncUIImageView will not alter the frame after loading and stay at that size
//  
//  Created by Lars Gerckens on 30.10.11.
//  Copyright (c) 2012lars@nulldesign.de All rights reserved.
//


@interface AsyncUIImageView : UIImageView
{
	NSURLConnection *connection;
	NSMutableData *data;
}

- (void)loadImageFromURL:(NSURL *)url;

@end