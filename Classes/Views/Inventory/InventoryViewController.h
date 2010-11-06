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
#import "LauncherView.h"

//-----------------------------------------------------------------------------------------------------------------------------------
@class InventoryTopLauncherView;
@class TouchAreaView;
@class TouchImageView;
@class AccountModel;

//-----------------------------------------------------------------------------------------------------------------------------------
typedef enum equipMode {
    EquipModeEquipped,
    EquipModeUnequipped,
} EquipModeType;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface InventoryViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NavigationLauncherViewDelegate, LauncherViewDelegate> {
    IBOutlet UITableView* itemsView;
    IBOutlet UILabel* goldLabel;
    IBOutlet UILabel* healthPotionLabel;
    UIImage* equippedImage;
    UIImage* unequippedImage;
    TouchImageView* equipButtonView;
    TouchAreaView* goldView;
    TouchAreaView* healthPotionView;
    UIView* containerView;
    EquipModeType equipMode;
    NSMutableArray* items;
    AccountModel* account;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) UIView* containerView;
@property (nonatomic, retain) UIImage* equippedImage;
@property (nonatomic, retain) UIImage* unequippedImage;
@property (nonatomic, retain) UILabel* goldLabel;
@property (nonatomic, retain) UILabel* healthPotionLabel;
@property (nonatomic, retain) TouchImageView* equipButtonView;
@property (nonatomic, retain) TouchAreaView* goldView;
@property (nonatomic, retain) TouchAreaView* healthPotionView;
@property (nonatomic, retain) UITableView* itemsView;
@property (nonatomic, assign) EquipModeType equipMode;
@property (nonatomic, retain) NSMutableArray* items;
@property (nonatomic, retain) AccountModel* account;

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_containerView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil inView:(UIView*)_containerView;

@end
