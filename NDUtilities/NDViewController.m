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
