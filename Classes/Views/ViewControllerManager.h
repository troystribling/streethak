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
@class AddContactViewController;
@class ContactMessagesViewController;
@class SendMessageViewController;
@class ShoutsViewController;
@class SendEventViewController;
@class NotificationsViewController;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface ViewControllerManager : NSObject {
    ContactsViewController* contactsViewController;
    InventoryViewController* inventoryViewController;
    AddContactViewController* addContactViewController;
    ContactMessagesViewController* contactMessagesViewController;
    SendMessageViewController* sendMessageViewController;
    ShoutsViewController* shoutsViewController;
    SendEventViewController* sendEventViewController;
    NotificationsViewController* notificationsViewController;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) InventoryViewController* inventoryViewController;
@property (nonatomic, retain) ContactsViewController* contactsViewController;
@property (nonatomic, retain) AddContactViewController* addContactViewController;
@property (nonatomic, retain) ContactMessagesViewController* contactMessagesViewController;
@property (nonatomic, retain) SendMessageViewController* sendMessageViewController;
@property (nonatomic, retain) ShoutsViewController* shoutsViewController;
@property (nonatomic, retain) SendEventViewController* sendEventViewController;
@property (nonatomic, retain) NotificationsViewController* notificationsViewController;

//-----------------------------------------------------------------------------------------------------------------------------------
+ (ViewControllerManager*)instance;

//-----------------------------------------------------------------------------------------------------------------------------------
- (InventoryViewController*)showInventoryView:(UIView*)containerView;
- (void)removeInventoryView;
- (void)inventoryViewWillAppear;
- (void)inventoryViewWillDisappear;

- (ContactsViewController*)showContactsView:(UIView*)containerView;
- (void)removeContactsView;
- (void)contactsViewWillAppear;
- (void)contactsViewWillDisappear;

- (AddContactViewController*)showAddContactView:(UIView*)containerView;
- (void)removeAddContactView;
- (void)addContactViewWillAppear;
- (void)addContactViewWillDisappear;

- (ContactMessagesViewController*)showContactMessagesView:(UIView*)containerView;
- (void)removeContactMessagesView;
- (void)contactMessagesViewWillAppear;
- (void)contactMessagesViewWillDisappear;

- (SendMessageViewController*)showSendMessageView:(UIView*)containerView;
- (void)removeSendMessageView;
- (void)sendMessageViewWillAppear;
- (void)sendMessageViewWillDisappear;

- (ShoutsViewController*)showShoutsView:(UIView*)containerView;
- (void)removeShoutsView;
- (void)shoutsViewWillAppear;
- (void)shoutsViewWillDisappear;

- (SendEventViewController*)showSendEventView:(UIView*)containerView;
- (void)removeSendEventView;
- (void)sendEventViewWillAppear;
- (void)sendEventViewWillDisappear;

- (NotificationsViewController*)showNotificationsView:(UIView*)containerView;
- (void)removeNotificationsView;
- (void)notificationsViewWillAppear;
- (void)notificationsViewWillDisappear;

@end
