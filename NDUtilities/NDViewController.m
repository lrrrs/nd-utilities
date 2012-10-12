//
//  NDViewController.m
//  NDUtilities
//
//  Created by Lars Gerckens on 17.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NDViewController.h"
#import "NDStandardLabel.h"
#import "NDLayoutHelper.h"
#import "NDTweener.h"

@interface NDViewController ()

@end

@implementation NDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NDStandardLabel *label = [[NDStandardLabel alloc] initWithText:@"Simple Text"];
    [self.view addSubview:label];
    
    NDStandardLabel *label2 = [[NDStandardLabel alloc] initWithText:@"Simple Text that is multiline I guess" andMaxWidth:200.0];
    [self.view addSubview:label2];
    
    [NDLayoutHelper placeUnder:label bottom:label2 gap:10.0];
    
    NDStandardLabel *label3 = [[NDStandardLabel alloc] initWithText:@"Truncated text is also here of course" andMaxWidthSingleLine:200.0];
    [self.view addSubview:label3];
    
    [NDLayoutHelper placeUnder:label2 bottom:label3 gap:10.0];
    
    UIView *testView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 10.0, 10.0)];
    testView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:testView];
    
    NDTweener *tweener = [NDTweener sharedNDTweener];

    [tweener tweenFrame:label3
                  frame:CGRectMake(10.0, 10.0, label3.frame.size.width, label3.frame.size.height)
               duration:1.0
             transition:tweenCircEaseIn];

    [[[tweener tweenFrame:testView
                   frame:CGRectMake(200.0, 30.0, 100.0, 50.0)
                duration:2.0
              transition:tweenQuadEaseOut] addViewFinishBlock:^(UIView *view) {
        NSLog(@"finished!!!");
    }] addDelay:1.0];
    
    [[tweener tweenFrame:testView
                   frame:CGRectMake(200.0, 100.0, 100.0, 50.0)
                duration:0.5
              transition:tweenExpoEaseOut] addDelay:4.0];
   
    blah = 10.0;
    [[[tweener tweenFloat:&blah
              finishValue:20.0
                 duration:1.0
               transition:tweenQuadEaseIn]
      addFloatUpdateBlock:^(CGFloat value)
    {
        NSLog(@"float update: %f", value);
    }]
     addFloatFinishBlock:^(CGFloat value)
    {
        NSLog(@"float finished: %f", value);
        [self checkFloat];
    }];
}

-(void) checkFloat
{
    NSLog(@"checkFloat: %f", blah);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
