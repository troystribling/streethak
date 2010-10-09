//
//  ViewControllerManager.m
//  streethak
//
//  Created by Troy Stribling on 8/25/10.
//  Copyright 2010 planBresearch. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "ViewControllerManager.h"
#import "InventoryViewController.h"
#import "ContactsViewController.h"

//-----------------------------------------------------------------------------------------------------------------------------------
static ViewControllerManager* thisViewControllerManager = nil;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface ViewControllerManager (PrivateAPI)

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation ViewControllerManager

//-----------------------------------------------------------------------------------------------------------------------------------
@synthesize inventoryViewController;
@synthesize contactsViewController;

//===================================================================================================================================
#pragma mark ViewControllerManager PrivateApi

//===================================================================================================================================
#pragma mark ViewControllerManager

//-----------------------------------------------------------------------------------------------------------------------------------
+ (ViewControllerManager*)instance {	
    @synchronized(self) {
        if (thisViewControllerManager == nil) {
            thisViewControllerManager = [[self alloc] init]; 
        }
    }
    return thisViewControllerManager;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (InventoryViewController*)showInventoryView:(UIView*)containerView {
    if (self.inventoryViewController == nil) {
        self.inventoryViewController = [InventoryViewController inView:containerView];
    } else {
        [containerView addSubview:self.inventoryViewController.view];
    }
    [self.inventoryViewController viewWillAppear:NO];
    return self.inventoryViewController;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)removeInventoryView {
    if (self.inventoryViewController) {
        [self.inventoryViewController viewWillDisappear:NO];
        [self.inventoryViewController.view removeFromSuperview];
    }
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (ContactsViewController*)showContactsViewController:(UIView*)containerView {
    if (self.contactsViewController == nil) {
        self.contactsViewController = [ContactsViewController inView:containerView];
    } else {
        [containerView addSubview:self.inventoryViewController.view];
    }
    [self.contactsViewController viewWillAppear:NO];
    return self.contactsViewController;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)removeContactsViewController {
    if (self.contactsViewController) {
        [self.contactsViewController viewWillDisappear:NO];
        [self.contactsViewController.view removeFromSuperview];
    }
}

@end
