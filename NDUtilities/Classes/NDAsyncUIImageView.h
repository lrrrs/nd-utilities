//
//  AsyncUIImageView.h
//
//  Loads an image asynchroniously. If you specify a frame, the AsyncUIImageView will not alter the frame after loading and stay at that size
//  
//  Created by Lars Gerckens on 30.10.11.
//  Copyright (c) 2012lars@nulldesign.de All rights reserved.
//

@protocol AsyncUIImageViewDelegate;

@interface NDAsyncUIImageView : UIImageView
{
    id<AsyncUIImageViewDelegate> __unsafe_unretained delegate;
    NSURL *currentImageURL;
}

@property (nonatomic, unsafe_unretained) id<AsyncUIImageViewDelegate> delegate;

- (void)loadImageFromURL:(NSURL *)url;

@end

@protocol AsyncUIImageViewDelegate <NSObject>

@optional
-(void)asyncUIImageViewLoaded:(NDAsyncUIImageView*)imageView;
@end