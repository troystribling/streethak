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
#import "ShoutsViewController.h"
#import "SendEventViewController.h"

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
@synthesize shoutsViewController;
@synthesize sendEventViewController;

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
    } 
    [containerView addSubview:self.inventoryViewController.view];
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
    } 
    [containerView addSubview:self.contactsViewController.view];
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
    }
    [containerView addSubview:self.addContactViewController.view];
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
    }
    [containerView addSubview:self.contactMessagesViewController.view];
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
    }
    [containerView addSubview:self.sendMessageViewController.view];
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

//-----------------------------------------------------------------------------------------------------------------------------------
// ShoutsViewController
//-----------------------------------------------------------------------------------------------------------------------------------
- (ShoutsViewController*)showShoutsView:(UIView*)containerView {
    if (self.shoutsViewController == nil) {
        self.shoutsViewController = [ShoutsViewController inView:containerView];
    }
    [containerView addSubview:self.shoutsViewController.view];
    [self.shoutsViewController viewWillAppear:NO];
    return self.shoutsViewController;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)removeShoutsView {
    if (self.shoutsViewController) {
        [self.shoutsViewController viewWillDisappear:NO];
        [self.shoutsViewController.view removeFromSuperview];
    }
}

//-----------------------------------------------------------------------------------------------------------------------------------
// SendEventViewController
//-----------------------------------------------------------------------------------------------------------------------------------
- (SendEventViewController*)showSendEventView:(UIView*)containerView {
    if (self.sendEventViewController == nil) {
        self.sendEventViewController = [SendEventViewController inView:containerView];
    }
    [containerView addSubview:self.sendEventViewController.view];
    [self.sendEventViewController viewWillAppear:NO];
    return self.sendEventViewController;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)removeSendEventView {
    if (self.sendEventViewController) {
        [self.sendEventViewController viewWillDisappear:NO];
        [self.sendEventViewController.view removeFromSuperview];
    }
}

@end
