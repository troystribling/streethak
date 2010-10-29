//
//  StoreViewController.h
//  streethak
//
//  Created by Troy Stribling on 10/28/10.
//  Copyright 2010 planBresearch. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import <UIKit/UIKit.h>
#import "NavigationLauncherView.h"
#import "StoreTopLauncherView.h"

//-----------------------------------------------------------------------------------------------------------------------------------
@class AccountModel;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface StoreViewController : UIViewController <NavigationLauncherViewDelegate, LauncherViewDelegate> {
    UIView* containerView;
    AccountModel* account;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) UIView* containerView;
@property (nonatomic, retain) AccountModel* account;

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_view;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil inView:(UIView*)_containerView;

@end
