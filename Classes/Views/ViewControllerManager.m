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
#import "AddContactViewController.h"
#import "ContactMessagesViewController.h"
#import "SendMessageViewController.h"

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
@synthesize addContactViewController;
@synthesize contactMessagesViewController;
@synthesize sendMessageViewController;

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
// InventoryViewController
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
// ContactsViewController
//-----------------------------------------------------------------------------------------------------------------------------------
- (ContactsViewController*)showContactsView:(UIView*)containerView {
    if (self.contactsViewController == nil) {
        self.contactsViewController = [ContactsViewController inView:containerView];
    } else {
        [containerView addSubview:self.contactsViewController.view];
    }
    [self.contactsViewController viewWillAppear:NO];
    return self.contactsViewController;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)removeContactsView {
    if (self.contactsViewController) {
        [self.contactsViewController viewWillDisappear:NO];
        [self.contactsViewController.view removeFromSuperview];
    }
}

//-----------------------------------------------------------------------------------------------------------------------------------
// AddContactViewController
//-----------------------------------------------------------------------------------------------------------------------------------
- (AddContactViewController*)showAddContactView:(UIView*)containerView {
    if (self.addContactViewController == nil) {
        self.addContactViewController = [AddContactViewController inView:containerView];
    } else {
        [containerView addSubview:self.addContactViewController.view];
    }
    [self.addContactViewController viewWillAppear:NO];
    return self.addContactViewController;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)removeAddContactView {
    if (self.addContactViewController) {
        [self.addContactViewController viewWillDisappear:NO];
        [self.addContactViewController.view removeFromSuperview];
    }
}

//-----------------------------------------------------------------------------------------------------------------------------------
// ContactMessagesViewController
//-----------------------------------------------------------------------------------------------------------------------------------
- (ContactMessagesViewController*)showContactMessagesView:(UIView*)containerView {
    if (self.contactMessagesViewController == nil) {
        self.contactMessagesViewController = [ContactMessagesViewController inView:containerView];
    } else {
        [containerView addSubview:self.contactMessagesViewController.view];
    }
    [self.contactMessagesViewController viewWillAppear:NO];
    return self.contactMessagesViewController;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)removeContactMessagesView {
    if (self.contactMessagesViewController) {
        [self.contactMessagesViewController viewWillDisappear:NO];
        [self.contactMessagesViewController.view removeFromSuperview];
    }
}

//-----------------------------------------------------------------------------------------------------------------------------------
// SendMessageViewController
//-----------------------------------------------------------------------------------------------------------------------------------
- (SendMessageViewController*)showSendMessageView:(UIView*)containerView {
    if (self.sendMessageViewController == nil) {
        self.sendMessageViewController = [SendMessageViewController inView:containerView];
    } else {
        [containerView addSubview:self.sendMessageViewController.view];
    }
    [self.sendMessageViewController viewWillAppear:NO];
    return self.sendMessageViewController;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)removeSendMessageView {
    if (self.sendMessageViewController) {
        [self.sendMessageViewController viewWillDisappear:NO];
        [self.sendMessageViewController.view removeFromSuperview];
    }
}

@end
