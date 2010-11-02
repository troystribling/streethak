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
@class StoreTopLauncherView;

//-----------------------------------------------------------------------------------------------------------------------------------
typedef enum storeMode {
    StoreModeSell,
    StoreModeBuy,
} StoreModeType;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface StoreViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NavigationLauncherViewDelegate, LauncherViewDelegate> {
    IBOutlet UITableView* itemsView;
    UIImage* sellImage;
    UIImage* buyImage;
    UIView* containerView;
    StoreTopLauncherView* storeTopLauncherView;
    StoreModeType storeMode;
    NSMutableArray* items;
    AccountModel* account;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) UITableView* itemsView;
@property (nonatomic, retain) UIImage* sellImage;
@property (nonatomic, retain) UIImage* buyImage;
@property (nonatomic, retain) UIView* containerView;
@property (nonatomic, retain) StoreTopLauncherView* storeTopLauncherView;;
@property (nonatomic, assign) StoreModeType storeMode;
@property (nonatomic, retain) NSMutableArray* items;
@property (nonatomic, retain) AccountModel* account;

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_view;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil inView:(UIView*)_containerView;

@end
