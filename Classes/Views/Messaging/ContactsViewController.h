//
//  ContactsViewController.h
//  webgnosus
//
//  Created by Troy Stribling on 1/19/09.
//  Copyright 2009 Plan-B Research. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import <UIKit/UIKit.h>
#import "NavigationLauncherView.h"

//-----------------------------------------------------------------------------------------------------------------------------------
@class AccountModel;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface ContactsViewController : UITableViewController <UITableViewDataSource, NavigationLauncherViewDelegate> {
    UIView* containerView;
	NSMutableArray* contacts;
    AccountModel* account;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) UIView* containerView;
@property (nonatomic, retain) NSMutableArray* contacts;
@property (nonatomic, retain) AccountModel* account;

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_view;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil inView:(UIView*)_containerView;

@end
