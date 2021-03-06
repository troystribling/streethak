//
//  ShoutsViewController.h
//  webgnosus
//
//  Created by Troy Stribling on 9/7/09.
//  Copyright 2009 Plan-B Research. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import <UIKit/UIKit.h>
#import "NavigationLauncherView.h"
#import "ShoutsTopLauncherView.h"

//-----------------------------------------------------------------------------------------------------------------------------------
@class AccountModel;
@class EventsMessageCache;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface ShoutsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, NavigationLauncherViewDelegate, LauncherViewDelegate> {
    IBOutlet UITableView* shoutsView;
    EventsMessageCache* shouts;
    UIView* containerView;
    AccountModel* account;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) UITableView* shoutsView;
@property (nonatomic, retain) UIView* containerView;
@property (nonatomic, retain) EventsMessageCache* shouts;
@property (nonatomic, retain) AccountModel* account;

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_view;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil inView:(UIView*)_containerView;

@end
