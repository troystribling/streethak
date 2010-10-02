//
//  InventoryViewController.h
//  streethak
//
//  Created by Troy Stribling on 9/19/10.
//  Copyright 2010 planBresearch. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import <UIKit/UIKit.h>
#import "NavigationLauncherView.h"

//-----------------------------------------------------------------------------------------------------------------------------------

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface InventoryViewController : UIViewController <NavigationLauncherViewDelegate> {
    UIWindow* containerWindow;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) UIWindow* containerWindow;

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inWindow:(UIWindow*)_containerWindow;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil inWindow:(UIWindow*)_containerWindow;

@end
