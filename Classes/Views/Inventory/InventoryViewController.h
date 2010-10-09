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
#import "TopLauncherView.h"

//-----------------------------------------------------------------------------------------------------------------------------------
@class InventoryTopLauncherView;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface InventoryViewController : UIViewController <NavigationLauncherViewDelegate, TopLauncherViewDelegate> {
    UIView* containerView;
    NavigationLauncherView* navigationLauncherView;
    InventoryTopLauncherView* inventoryTopLauncherView;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) UIView* containerView;
@property (nonatomic, retain) NavigationLauncherView* navigationLauncherView;
@property (nonatomic, retain) InventoryTopLauncherView* inventoryTopLauncherView;

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_containerView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil inView:(UIView*)_containerView;

@end
