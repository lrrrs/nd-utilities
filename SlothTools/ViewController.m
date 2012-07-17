//
//  ViewController.m
//  SlothTools
//
//  Created by Lars Gerckens on 01.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "StandardLabel.h"
#import "LayoutHelper.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    StandardLabel *label = [[StandardLabel alloc] initWithText:@"Simple Text"];
    [self.view addSubview:label];
    
    StandardLabel *label2 = [[StandardLabel alloc] initWithText:@"Simple Text that is multiline I guess" andMaxWidth:200.0];
    [self.view addSubview:label2];
    
    [LayoutHelper placeUnder:label bottom:label2 gap:10.0];

    StandardLabel *label3 = [[StandardLabel alloc] initWithText:@"Truncated text is also here of course" andMaxWidthSingleLine:200.0];
    [self.view addSubview:label3];
    
    [LayoutHelper placeUnder:label2 bottom:label3 gap:10.0];
    
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
