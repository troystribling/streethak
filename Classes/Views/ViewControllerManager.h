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
@class InventoryViewController;
@class ContactsViewController;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface ViewControllerManager : NSObject {
    ContactsViewController* contactsViewController;
    InventoryViewController* inventoryViewController;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) InventoryViewController* inventoryViewController;
@property (nonatomic, retain) ContactsViewController* contactsViewController;

//-----------------------------------------------------------------------------------------------------------------------------------
+ (ViewControllerManager*)instance;

//-----------------------------------------------------------------------------------------------------------------------------------
- (InventoryViewController*)showInventoryView:(UIView*)containerView;
- (void)removeInventoryView;

- (ContactsViewController*)showContactsViewController:(UIView*)containerView;
- (void)removeContactsViewController;

@end
