//
//  ViewControllerManager.h
//  streethak
//
//  Created by Troy Stribling on 8/25/10.
//  Copyright 2010 planBresearch. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import <UIKit/UIKit.h>

//-----------------------------------------------------------------------------------------------------------------------------------
@class CreateAccountViewController;
@class InventoryViewController;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface ViewControllerManager : NSObject {
    CreateAccountViewController* createAccountViewController;
    InventoryViewController* inventoryViewController;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) CreateAccountViewController* createAccountViewController;
@property (nonatomic, retain) InventoryViewController* inventoryViewController;

//-----------------------------------------------------------------------------------------------------------------------------------
+ (ViewControllerManager*)instance;

//-----------------------------------------------------------------------------------------------------------------------------------
- (CreateAccountViewController*)showCreateAccountView:(UIView*)containeView;
//- (InventoryViewController*)showInventoryView:(UIView*)containeView;

@end
