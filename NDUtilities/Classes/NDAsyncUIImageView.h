//
//  AsyncUIImageView.h
//
//  Loads an image asynchroniously. If you specify a frame, the AsyncUIImageView will not alter the frame after loading and stay at that size
//  
//  Created by Lars Gerckens on 30.10.11.
//  Copyright (c) 2012 lars@nulldesign.de All rights reserved.
//

#import "NDImageCache.h"

@protocol AsyncUIImageViewDelegate;

@interface NDAsyncUIImageView : UIImageView <NSURLConnectionDataDelegate>
{
    id<AsyncUIImageViewDelegate> __unsafe_unretained delegate;
    NSURL *currentImageURL;
    NSURLConnection *currentURLConnection;
    BOOL doFadeIn;
    NSMutableData *imgData;
    NDImageCache *imageCache;
}

@property (nonatomic, unsafe_unretained) id<AsyncUIImageViewDelegate> delegate;
@property (nonatomic) BOOL cacheImage;

- (void)loadImageFromURL:(NSURL *)url;
- (void)loadImageFromURL:(NSURL *)url andFadeIn:(BOOL)fadeIn;

@end

@protocol AsyncUIImageViewDelegate <NSObject>
@optional
    -(void)asyncUIImageViewLoaded:(NDAsyncUIImageView*)imageView;
@end