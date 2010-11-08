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
#import "GoldViewController.h"

//-----------------------------------------------------------------------------------------------------------------------------------
@class AccountModel;
@class StoreTopLauncherView;
@class TouchImageView;
@class TouchAreaView;

//-----------------------------------------------------------------------------------------------------------------------------------
typedef enum storeMode {
    StoreModeSell,
    StoreModeBuy,
} StoreModeType;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface StoreViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NavigationLauncherViewDelegate, LauncherViewDelegate, GoldViewDelegate> {
    IBOutlet UITableView* itemsView;
    IBOutlet UILabel* goldLabel;
    TouchImageView* modeView;
    TouchAreaView* goldView;
    TouchAreaView* buyGoldView;    
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
@property (nonatomic, retain) TouchImageView* modeView;
@property (nonatomic, retain) TouchAreaView* goldView;
@property (nonatomic, retain) TouchAreaView* buyGoldView;
@property (nonatomic, retain) UILabel* goldLabel;
@property (nonatomic, retain) UIView* containerView;
@property (nonatomic, retain) StoreTopLauncherView* storeTopLauncherView;;
@property (nonatomic, assign) StoreModeType storeMode;
@property (nonatomic, retain) NSMutableArray* items;
@property (nonatomic, retain) AccountModel* account;

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_view;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil inView:(UIView*)_containerView;

@end
