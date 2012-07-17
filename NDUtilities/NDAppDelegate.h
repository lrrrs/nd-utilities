//
//  NDAppDelegate.h
//  NDUtilities
//
//  Created by Lars Gerckens on 17.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NDViewController;

@interface NDAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NDViewController *viewController;

@end
