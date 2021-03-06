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
#import "NotificationsViewController.h"
#import "ConfigurationViewController.h"
#import "StoreViewController.h"
#import "StatsViewController.h"
#import "GoldViewController.h"

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
@synthesize notificationsViewController;
@synthesize configurationViewController;
@synthesize storeViewController;
@synthesize statsViewController;
@synthesize goldViewController;

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
- (void)inventoryViewWillAppear {
    [self.inventoryViewController viewWillAppear:NO];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)inventoryViewWillDisappear {
    [self.inventoryViewController viewWillDisappear:NO];
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
- (void)contactsViewWillAppear {
    [self.contactsViewController viewWillAppear:NO];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)contactsViewWillDisappear {
    [self.contactsViewController viewWillDisappear:NO];
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
- (void)addContactViewWillAppear {
    [self.addContactViewController viewWillAppear:NO];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)addContactViewWillDisappear {
    [self.addContactViewController viewWillDisappear:NO];
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
- (void)contactMessagesViewWillAppear {
    [self.contactMessagesViewController viewWillAppear:NO];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)contactMessagesViewWillDisappear {
    [self.contactMessagesViewController viewWillDisappear:NO];
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
- (void)sendMessageViewWillAppear {
    [self.sendMessageViewController viewWillAppear:NO];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)sendMessageViewWillDisappear {
    [self.sendMessageViewController viewWillDisappear:NO];
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
- (void)shoutsViewWillAppear {
    [self.shoutsViewController viewWillAppear:NO];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)shoutsViewWillDisappear {
    [self.shoutsViewController viewWillDisappear:NO];
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

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)sendEventViewWillAppear {
    [self.sendEventViewController viewWillAppear:NO];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)sendEventViewWillDisappear {
    [self.sendEventViewController viewWillDisappear:NO];
}

//-----------------------------------------------------------------------------------------------------------------------------------
// NotificationsViewController
//-----------------------------------------------------------------------------------------------------------------------------------
- (NotificationsViewController*)showNotificationsView:(UIView*)containerView {
    if (self.notificationsViewController == nil) {
        self.notificationsViewController = [NotificationsViewController inView:containerView];
    }
    [containerView addSubview:self.notificationsViewController.view];
    [self.notificationsViewController viewWillAppear:NO];
    return self.notificationsViewController;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)removeNotificationsView {
    if (self.notificationsViewController) {
        [self.notificationsViewController viewWillDisappear:NO];
        [self.notificationsViewController.view removeFromSuperview];
    }
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)notificationsViewWillAppear {
    [self.notificationsViewController viewWillAppear:NO];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)notificationsViewWillDisappear {
    [self.notificationsViewController viewWillDisappear:NO];
}

//-----------------------------------------------------------------------------------------------------------------------------------
// ConfigurationViewController
//-----------------------------------------------------------------------------------------------------------------------------------
- (ConfigurationViewController*)showConfigurationView:(UIView*)containerView {
    if (self.configurationViewController == nil) {
        self.configurationViewController = [ConfigurationViewController inView:containerView];
    }
    [containerView addSubview:self.configurationViewController.view];
    [self.configurationViewController viewWillAppear:NO];
    return self.configurationViewController;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)removeConfigurationView {
    if (self.configurationViewController) {
        [self.configurationViewController viewWillDisappear:NO];
        [self.configurationViewController.view removeFromSuperview];
    }
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)configurationViewWillAppear {
    [self.configurationViewController viewWillAppear:NO];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)configurationViewWillDisappear {
    [self.configurationViewController viewWillDisappear:NO];
}

//-----------------------------------------------------------------------------------------------------------------------------------
// StoreViewController
//-----------------------------------------------------------------------------------------------------------------------------------
- (StoreViewController*)showStoreView:(UIView*)containerView {
    if (self.storeViewController == nil) {
        self.storeViewController = [StoreViewController inView:containerView];
    }
    [containerView addSubview:self.storeViewController.view];
    [self.storeViewController viewWillAppear:NO];
    return self.storeViewController;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)removeStoreView {
    if (self.storeViewController) {
        [self.storeViewController viewWillDisappear:NO];
        [self.storeViewController.view removeFromSuperview];
    }
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)storeViewWillAppear {
    [self.storeViewController viewWillAppear:NO];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)storeViewWillDisappear {
    [self.storeViewController viewWillDisappear:NO];
}

//-----------------------------------------------------------------------------------------------------------------------------------
// StatsViewController
//-----------------------------------------------------------------------------------------------------------------------------------
- (StatsViewController*)showStatsView:(UIView*)containerView {
    if (self.statsViewController == nil) {
        self.statsViewController = [StatsViewController inView:containerView];
    }
    [containerView addSubview:self.statsViewController.view];
    [self.statsViewController viewWillAppear:NO];
    return self.statsViewController;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)removeStatsView {
    if (self.statsViewController) {
        [self.statsViewController viewWillDisappear:NO];
        [self.statsViewController.view removeFromSuperview];
    }
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)statsViewWillAppear {
    [self.statsViewController viewWillAppear:NO];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)statsViewWillDisappear {
    [self.statsViewController viewWillDisappear:NO];
}

//-----------------------------------------------------------------------------------------------------------------------------------
// GoldViewController
//-----------------------------------------------------------------------------------------------------------------------------------
- (GoldViewController*)showGoldView:(UIView*)containerView {
    if (self.goldViewController == nil) {
        self.goldViewController = [GoldViewController inView:containerView];
    }
    [containerView addSubview:self.goldViewController.view];
    [self.goldViewController viewWillAppear:NO];
    return self.goldViewController;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)removeGoldView {
    if (self.goldViewController) {
        [self.goldViewController viewWillDisappear:NO];
        [self.goldViewController.view removeFromSuperview];
    }
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)goldViewWillAppear {
    [self.goldViewController viewWillAppear:NO];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)goldViewWillDisappear {
    [self.goldViewController viewWillDisappear:NO];
}

@end
