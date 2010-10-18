//
//  EventsViewController.h
//  webgnosus
//
//  Created by Troy Stribling on 9/7/09.
//  Copyright 2009 Plan-B Research. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import <UIKit/UIKit.h>
#import "NavigationLauncherView.h"
#import "EventsTopLauncherView.h"

//-----------------------------------------------------------------------------------------------------------------------------------
@class AccountModel;
@class UserModel;
@class MessageCache;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface EventsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, NavigationLauncherViewDelegate, LauncherViewDelegate> {
    IBOutlet UITableView* eventsView;
    MessageCache* events;
    UIView* containerView;
    AccountModel* account;
    NSString* service;
    NSString* node;
    NSString* name;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) UITableView* eventsView;
@property (nonatomic, retain) MessageCache* events;
@property (nonatomic, retain) AccountModel* account;
@property (nonatomic, retain) NSString* service;
@property (nonatomic, retain) NSString* node;
@property (nonatomic, retain) NSString* name;

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_view;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil inView:(UIView*)_containerView;

@end
