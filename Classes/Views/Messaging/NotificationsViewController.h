//
//  NotificationsViewController.h
//  streethak
//
//  Created by Troy Stribling on 10/24/10.
//  Copyright 2010 planBresearch. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import <UIKit/UIKit.h>
#import "NavigationLauncherView.h"
#import "NotificationsTopLauncherView.h"

//-----------------------------------------------------------------------------------------------------------------------------------
@class AccountModel;
@class UserModel;
@class EventsMessageCache;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface NotificationsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, NavigationLauncherViewDelegate, LauncherViewDelegate> {
    IBOutlet UITableView* notificationsView;
    EventsMessageCache* notifications;
    UIView* containerView;
    AccountModel* account;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) UITableView* notificationsView;
@property (nonatomic, retain) UIView* containerView;
@property (nonatomic, retain) EventsMessageCache* notifications;
@property (nonatomic, retain) AccountModel* account;

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_view;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil inView:(UIView*)_containerView;

@end
